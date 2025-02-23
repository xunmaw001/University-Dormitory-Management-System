package com.dao;

import com.entity.WeishengjianchaEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.entity.view.WeishengjianchaView;

/**
 * 卫生检查 Dao 接口
 *
 * @author 
 * @since 2021-04-23
 */
public interface WeishengjianchaDao extends BaseMapper<WeishengjianchaEntity> {

   List<WeishengjianchaView> selectListView(Pagination page,@Param("params")Map<String,Object> params);

}
