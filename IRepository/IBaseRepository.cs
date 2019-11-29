﻿using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;
using Model;
using Model.EntityModel.BaseRole;
using SqlSugar;
using Common;

namespace IRepository
{
    public interface IBaseRepository<TEntity> where TEntity : class
    {
        /// <summary>
        /// 获取单个实体（不分页）
        /// </summary>
        /// <returns></returns>
        Task<List<TEntity>> GetEntity();

        /// <summary>
        /// 获取单个实体（分页）
        /// </summary>
        /// <returns></returns>
        Task<List<TEntity>> GetEntityPage(Model.PageModel pm);

        /// <summary>
        /// 保存、 新增、逻辑删除单个实体
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        Task<ReturnModel> SaveEntityInfo(TEntity entity);

        /// <summary>
        /// 通过ID物理删除单个实体
        /// </summary>
        /// <param name="entity"></param>
        /// <returns></returns>
        Task<ReturnModel> DeleteTEntityById(object Id);

        /// <summary>
        /// 执行存储过程
        /// </summary>
        /// <param name="procName"></param>
        /// <param name="pm"></param>
        /// <returns></returns>
        Task<System.Data.DataTable> ExecStoredProcedure(string procName, Model.PageModel pm);

        /// <summary>
        /// 执行SQL语句
        /// </summary>
        /// <param name="sqlStr">SQL语句</param>
        /// <param name="option">SQL语句操作类型（0：查询，1：其他）</param>
        /// <param name="paras">参数</param>
        /// <returns></returns>
        Task<object> ExecSqlText(string sqlStr, Option option, params SugarParameter[] paras);

        /// <summary>
        /// 批量保存、更新、逻辑删除实体详情
        /// </summary>
        /// <param name="entities">实体详情</param>
        /// <param name="batchSave">编辑类型</param>
        /// <returns></returns>
        Task<ReturnModel> BatchSaveEntityInfo(List<TEntity> entities, BatchSave batchSave = 0);
    }
}
