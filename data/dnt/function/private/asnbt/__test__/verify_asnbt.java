import java.nio.file.*;
import java.util.*;
import java.util.regex.*;
import com.mojang.brigadier.StringReader;
import com.mojang.brigadier.exceptions.CommandSyntaxException;
import net.minecraft.nbt.*;
import net.minecraft.network.chat.*;
import net.minecraft.commands.arguments.NbtPathArgument;
import net.minecraft.commands.arguments.NbtPathArgument.NbtPath;

// Executes the new mcfunction files against Minecraft's actual NBT path/parser APIs.
// The existing dnt:concat is stubbed with literal concatenation; entity rendering uses
// TextComponentTagVisitor. This is an offline check, not a running-server integration test.
class VerifyAsnbt {
  static Path root;
  static Map<String,CompoundTag> stores=new HashMap<>();
  static Map<String,Integer> scores=new HashMap<>();
  static List<String> errors=new ArrayList<>();
  static int commands, expansions;
  record R(int value, boolean success) {}
  static R ok(int v){return new R(v,true);}
  static class Ret extends RuntimeException { R r; Ret(R r){super(null,null,false,false);this.r=r;} }
  static String word(StringReader r){r.skipWhitespace();int st=r.getCursor();while(r.canRead()&&!Character.isWhitespace(r.peek()))r.skip();return r.getString().substring(st,r.getCursor());}
  static NbtPath path(StringReader r)throws Exception{r.skipWhitespace();return new NbtPathArgument().parse(r);}
  static CompoundTag storage(String id){return stores.computeIfAbsent(id,k->new CompoundTag());}
  static Tag parse(String s)throws Exception{return TagParser.create(NbtOps.INSTANCE).parseFully(s);}
  static Tag one(String id,String p)throws Exception{return NbtPath.of(p).get(storage(id)).getFirst();}
  static void put(String id,String p,Tag t)throws Exception{NbtPath.of(p).set(storage(id),t);}
  static String text(Tag t){return t instanceof StringTag s?s.value():t.toString();}
  static String scoreKey(StringReader r){return word(r)+" "+word(r);}
  static int score(StringReader r){return scores.getOrDefault(scoreKey(r),0);}
  static Tag component(Component c) {
    var copy=c.copy();copy.getSiblings().clear();
    String own=copy.getString();
    if(c.getStyle().isEmpty()&&c.getSiblings().isEmpty())return StringTag.valueOf(own);
    var t=new CompoundTag();t.putString("text",own);
    if(c.getStyle().getColor()!=null)t.putString("color",c.getStyle().getColor().serialize());
    if(!c.getSiblings().isEmpty()){var l=new ListTag();for(var sub:c.getSiblings())l.add(component(sub));t.put("extra",l);}
    return t;
  }
  static R call(String name,CompoundTag args)throws Exception{
    if(name.equals("dnt:concat")){
      StringBuilder b=new StringBuilder();for(Tag t:(ListTag)one("dnt:ram","in")){if(!(t instanceof StringTag))throw new Error("nonstring concat");b.append(text(t));}
      put("dnt:ram","out",StringTag.valueOf(b.toString()));return ok(1);
    }
    if(name.equals("dnt:private/asnbt/get_parsed")){
      Component c=new TextComponentTagVisitor("").visit(one("dnt:ram","asnbt.source"));
      ListTag tokens=new ListTag();for(Component sub:c.getSiblings())tokens.add(component(sub));
      put("dnt:ram","asnbt.tokens",tokens);return ok(1);
    }
    if(name.equals("dnt:private/asnbt/array/expand"))expansions++;
    var lines=Files.readAllLines(root.resolve("data/dnt/function/"+name.substring(4)+".mcfunction"));
    try{
      for(String line:lines){if(line.isBlank()||line.startsWith("#"))continue;
        if(line.startsWith("$")){
          var matcher=Pattern.compile("\\$\\(([^)]+)\\)").matcher(line.substring(1));var sb=new StringBuilder();
          while(matcher.find()){Tag v=args.get(matcher.group(1));if(v==null)return new R(0,false);matcher.appendReplacement(sb,Matcher.quoteReplacement(text(v)));}
          matcher.appendTail(sb);line=sb.toString();
        }
        command(line);
      }
    }catch(Ret ret){return ret.r;}
    return ok(1);
  }
  static R command(String line)throws Exception{
    commands++;
    try{return eval(new StringReader(line));}
    catch(CommandSyntaxException ex){errors.add(line.substring(0,Math.min(line.length(),160))+" -> "+ex.getMessage());return new R(0,false);}
  }
  static R eval(StringReader r)throws Exception{
    String op=word(r);
    if(op.equals("return")){
      String n=word(r);if(n.equals("run"))throw new Ret(command(r.getRemaining().stripLeading()));
      throw new Ret(ok(Integer.parseInt(n)));
    }
    if(op.equals("function")){
      String name=word(r);CompoundTag a=null;
      if(r.canRead()){if(!word(r).equals("with")||!word(r).equals("storage"))throw new Error("function args");String id=word(r);a=(CompoundTag)path(r).get(storage(id)).getFirst();}
      return call(name,a);
    }
    if(op.equals("scoreboard")){
      String kind=word(r);String action=word(r);
      if(kind.equals("objectives")){String obj=word(r);if(action.equals("remove"))scores.keySet().removeIf(k->k.endsWith(" "+obj));return ok(1);}
      String key=scoreKey(r);int n=Integer.parseInt(word(r));int v=action.equals("add")?scores.getOrDefault(key,0)+n:n;scores.put(key,v);return ok(v);
    }
    if(op.equals("execute")){
      record Sink(boolean success,String score,String id,NbtPath path){}
      List<Sink>sinks=new ArrayList<>();
      while(true){String part=word(r);
        if(part.equals("run")){R out=command(r.getRemaining().stripLeading());for(var sink:sinks){int v=sink.success?(out.success?1:0):out.value;if(sink.score!=null)scores.put(sink.score,v);else sink.path.set(storage(sink.id),IntTag.valueOf(v));}return out;}
        if(part.equals("summon")){word(r);continue;}
        if(part.equals("store")){
          boolean success=word(r).equals("success");String type=word(r);
          if(type.equals("score"))sinks.add(new Sink(success,scoreKey(r),null,null));
          else {String id=word(r);NbtPath p=path(r);word(r);word(r);sinks.add(new Sink(success,null,id,p));}continue;
        }
        if(part.equals("if")||part.equals("unless")){
          boolean cond;String type=word(r);
          if(type.equals("data")){word(r);String id=word(r);cond=path(r).countMatching(storage(id))>0;}
          else if(type.equals("score")){int left=score(r);String cmp=word(r);if(cmp.equals("matches")){String range=word(r);String[] b=range.split("\\.\\.",-1);cond=b.length==1?left==Integer.parseInt(range):(b[0].isEmpty()||left>=Integer.parseInt(b[0]))&&(b[1].isEmpty()||left<=Integer.parseInt(b[1]));}else{int right=score(r);cond=cmp.equals("<")?left<right:left==right;}}
          else throw new Error("condition "+type);
          if(part.equals("unless"))cond=!cond;
          if(!cond)return new R(0,false);continue;
        }
        throw new Error("execute "+part);
      }
    }
    if(op.equals("data")){
      String action=word(r);if(!word(r).equals("storage"))throw new Error("storage");String id=word(r);NbtPath p=path(r);
      if(action.equals("remove")){int v=p.remove(storage(id));return new R(v,v>0);}
      if(action.equals("get")){Tag t=p.get(storage(id)).getFirst();int n=t instanceof CollectionTag c?c.size():t instanceof CompoundTag c?c.size():t instanceof StringTag s?s.value().length():t.asNumber().orElseThrow().intValue();return ok(n);}
      String method=word(r);String from=word(r);List<Tag> values;
      if(from.equals("value"))values=List.of(parse(r.getRemaining().stripLeading()));
      else{
        word(r);String sid=word(r);NbtPath sp=path(r);values=sp.get(storage(sid));
        if(from.equals("string")){
          Tag t=values.getFirst();if(!(t instanceof PrimitiveTag))throw new Error("nonprimitive");
          String s=text(t);if(r.canRead()){String a=word(r);if(!a.isEmpty()){int start=Integer.parseInt(a);int end=s.length();if(r.canRead())end=Integer.parseInt(word(r));s=s.substring(start<0?s.length()+start:start,end<0?s.length()+end:end);}}
          values=List.of(StringTag.valueOf(s));
        }
      }
      int n=method.equals("set")?p.set(storage(id),values.getLast().copy()):p.insert(-1,storage(id),values.stream().map(Tag::copy).toList());return new R(n,n>0);
    }
    throw new Error("unknown "+op);
  }
  public static void main(String[] args)throws Exception{
    root=Path.of(args[0]);int tested=0;List<String> failures=new ArrayList<>();
    try(var files=Files.walk(root.resolve("data/dnt/function/private/asnbt/__test__/cases"))){
      for(Path file:files.filter(p->p.toString().endsWith(".mcfunction")).sorted().toList()){
        for(String line:Files.readAllLines(file)){
          String marker="tests append value ";int at=line.indexOf(marker);if(at<0)continue;
          CompoundTag fixture=(CompoundTag)parse(line.substring(at+marker.length()));Tag input=fixture.get("input");if(input==null)continue;
          String name=fixture.getString("name").orElseThrow();stores.clear();scores.clear();errors.clear();commands=0;
          put("dnt:ram","in",input.copy());R result=call("dnt:get_snbt_array_safe",null);String out=text(one("dnt:ram","out"));
          boolean pass=false;try{pass=result.value==1&&input.equals(parse(out));}catch(Exception ignored){}
          tested++;System.out.println((pass?"PASS ":"FAIL ")+name+" commands="+commands+" chars="+out.length());
          if(!pass){failures.add(name);System.out.println(out.substring(0,Math.min(400,out.length())));errors.stream().limit(8).forEach(System.out::println);}
        }
      }
    }
    // No reset here: verify cleanup and repeat calls against the previous state.
    put("dnt:ram","in",parse("{after:[I;1,2,3],text:\"<...>\"}"));
    Tag repeatInput=one("dnt:ram","in").copy();
    if(call("dnt:get_snbt_array_safe",null).value!=1||!repeatInput.equals(parse(text(one("dnt:ram","out")))))failures.add("repeat_call");
    if(NbtPath.of("asnbt").countMatching(storage("dnt:ram"))!=0)failures.add("scratch_cleanup");
    NbtPath.of("in").remove(storage("dnt:ram"));
    if(call("dnt:get_snbt_array_safe",null).value!=0||!text(one("dnt:ram","out")).equals("DNT ERROR: INVALID INPUT"))failures.add("missing_input");
    System.out.println("TOTAL "+tested+" fixtures + repeat/cleanup/missing-input checks; failures="+failures+" truncations repaired="+expansions);
    if(!failures.isEmpty())System.exit(1);
  }
}
