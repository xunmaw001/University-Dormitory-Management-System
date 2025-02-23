package com.service;

import com.baomidou.mybatisplus.service.IService;
import com.utils.PageUtils;
import com.entity.ShuibiaoEntity;
import java.util.Map;

/**
 * 水表 服务类
 * @author 
 * @since 2021-04-23
 */
public interface ShuibiaoService extends IService<ShuibiaoEntity> {

    /**
    * @param params 查询参数
    * @return 带分页的查询出来的数据
    */
     PageUtils queryPage(Map<String, Object> params);
}