package com.controller;


import java.text.SimpleDateFormat;
import com.alibaba.fastjson.JSONObject;
import java.util.*;
import org.springframework.beans.BeanUtils;
import javax.servlet.http.HttpServletRequest;
import org.springframework.web.context.ContextLoader;
import javax.servlet.ServletContext;
import com.service.TokenService;
import com.utils.StringUtil;
import java.lang.reflect.InvocationTargetException;

import com.service.DictionaryService;
import org.apache.commons.lang3.StringUtils;
import com.annotation.IgnoreAuth;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;

import com.entity.ShuibiaoEntity;

import com.service.ShuibiaoService;
import com.entity.view.ShuibiaoView;
import com.service.SusheService;
import com.entity.SusheEntity;

import com.utils.PageUtils;
import com.utils.R;

/**
 * 水表
 * 后端接口
 * @author
 * @email
 * @date 2021-04-23
*/
@RestController
@Controller
@RequestMapping("/shuibiao")
public class ShuibiaoController {
    private static final Logger logger = LoggerFactory.getLogger(ShuibiaoController.class);

    @Autowired
    private ShuibiaoService shuibiaoService;


    @Autowired
    private TokenService tokenService;
    @Autowired
    private DictionaryService dictionaryService;



    //级联表service
    @Autowired
    private SusheService susheService;


    /**
    * 后端列表
    */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params, HttpServletRequest request){
        logger.debug("page方法:,,Controller:{},,params:{}",this.getClass().getName(),JSONObject.toJSONString(params));
     
        String role = String.valueOf(request.getSession().getAttribute("role"));
        if(StringUtil.isNotEmpty(role) && "用户".equals(role)){
            params.put("yonghuId",request.getSession().getAttribute("userId"));
        }
        params.put("orderBy","id");
        PageUtils page = shuibiaoService.queryPage(params);

        //字典表数据转换
        List<ShuibiaoView> list =(List<ShuibiaoView>)page.getList();
        for(ShuibiaoView c:list){
            //修改对应字典表字段
            dictionaryService.dictionaryConvert(c);
        }
        return R.ok().put("data", page);
    }

    /**
    * 后端详情
    */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        logger.debug("info方法:,,Controller:{},,id:{}",this.getClass().getName(),id);
        ShuibiaoEntity shuibiao = shuibiaoService.selectById(id);
        if(shuibiao !=null){
            //entity转view
            ShuibiaoView view = new ShuibiaoView();
            BeanUtils.copyProperties( shuibiao , view );//把实体数据重构到view中

            //级联表
            SusheEntity sushe = susheService.selectById(shuibiao.getSusheId());
            if(sushe != null){
                BeanUtils.copyProperties( sushe , view ,new String[]{ "id", "createDate"});//把级联的数据添加到view中,并排除id和创建时间字段
                view.setSusheId(sushe.getId());
            }
            //修改对应字典表字段
            dictionaryService.dictionaryConvert(view);
            return R.ok().put("data", view);
        }else {
            return R.error(511,"查不到数据");
        }

    }

    /**
    * 后端保存
    */
    @RequestMapping("/save")
    public R save(@RequestBody ShuibiaoEntity shuibiao, HttpServletRequest request){
        logger.debug("save方法:,,Controller:{},,shuibiao:{}",this.getClass().getName(),shuibiao.toString());
        Wrapper<ShuibiaoEntity> queryWrapper = new EntityWrapper<ShuibiaoEntity>()
            .eq("sushe_id", shuibiao.getSusheId())
            .or()
            .eq("shuibiao_number", shuibiao.getShuibiaoNumber())
            ;
        logger.info("sql语句:"+queryWrapper.getSqlSegment());
        ShuibiaoEntity shuibiaoEntity = shuibiaoService.selectOne(queryWrapper);
        if(shuibiaoEntity==null){
            shuibiao.setCreateTime(new Date());
        //  String role = String.valueOf(request.getSession().getAttribute("role"));
        //  if("".equals(role)){
        //      shuibiao.set
        //  }
            shuibiaoService.insert(shuibiao);
            return R.ok();
        }else {
            return R.error(511,"该宿舍已经绑定过水表或水表编号已被使用");
        }
    }

    /**
    * 后端修改
    */
    @RequestMapping("/update")
    public R update(@RequestBody ShuibiaoEntity shuibiao, HttpServletRequest request){
        logger.debug("update方法:,,Controller:{},,shuibiao:{}",this.getClass().getName(),shuibiao.toString());
        //根据字段查询是否有相同数据
        Wrapper<ShuibiaoEntity> queryWrapper = new EntityWrapper<ShuibiaoEntity>()
            .notIn("id",shuibiao.getId())
            .andNew()
            .eq("sushe_id", shuibiao.getSusheId())
            .or()
            .eq("shuibiao_number", shuibiao.getShuibiaoNumber())
            ;
        logger.info("sql语句:"+queryWrapper.getSqlSegment());
        ShuibiaoEntity shuibiaoEntity = shuibiaoService.selectOne(queryWrapper);
        if(shuibiaoEntity==null){
            //  String role = String.valueOf(request.getSession().getAttribute("role"));
            //  if("".equals(role)){
            //      shuibiao.set
            //  }
            shuibiaoService.updateById(shuibiao);//根据id更新
            return R.ok();
        }else {
            return R.error(511,"该宿舍已经绑定过水表或水表编号已被使用");
        }
    }



    /**
    * 删除
    */
    @RequestMapping("/delete")
    public R delete(@RequestBody Integer[] ids){
        logger.debug("delete:,,Controller:{},,ids:{}",this.getClass().getName(),ids.toString());
        shuibiaoService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }






}

