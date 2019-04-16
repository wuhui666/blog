package com.pojo;

import java.util.HashMap;
import java.util.Map;

/**
 * @author: wuhui
 * @time: 2019/3/31 16:34
 * @desc:
 */
public class Result {

    public boolean success;

    public String message;

    public  Map<String,Object> content;

    public static Result success(){
        Result result=new Result();
        result.success=true;
        result.message="成功";
        result.content=new HashMap<>();
        return result;
    }
    public static Result success(String message){
        Result result=new Result();
        result.success=true;
        result.message=message;
        result.content=new HashMap<>();
        return result;
    }
    public static Result failure(String message){
        Result result=new Result();
        result.success=false;
        result.message=message;
        result.content=new HashMap<>();
        return result;
    }
    public static Result failure(){
        Result result=new Result();
        result.success=false;
        result.message="失败";
        result.content=new HashMap<>();
        return result;
    }
    public Result add(String k,Object o){
        Result result=this;
        this.content.put(k, o);
        return result;
    }
}
