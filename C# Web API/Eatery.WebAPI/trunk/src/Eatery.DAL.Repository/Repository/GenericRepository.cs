using Eatery.DAL.Interface;
using Eatery.DAL.Repository.Interface;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DAL.Repository
{
    public abstract class GenericRepository<T> : IGenericRepository<T> where T : class
    {
        public virtual T Add(IEateryDbContext dataContext, T entity)
        {
            ((IDbContext)dataContext).Set<T>().Add(entity);
            ((IDbContext)dataContext).Entry(entity).State = EntityState.Added;
            return entity;
        }

        public virtual T Update(IEateryDbContext dataContext, T entity)
        {
            ((IDbContext)dataContext).Set<T>().Add(entity);
            ((IDbContext)dataContext).Entry(entity).State = EntityState.Modified;
            return entity;
        }

        public virtual bool Delete(IEateryDbContext dataContext, T entity)
        {
            ((IDbContext)dataContext).Set<T>().Attach(entity);
            ((IDbContext)dataContext).Set<T>().Remove(entity);
            ((IDbContext)dataContext).Entry(entity).State = EntityState.Deleted;
            return true;
        }
        public virtual bool DeleteAll(IEateryDbContext dataContext, Func<T, Boolean> where)
        {
            bool status = false;
            if (where != null)
            {
                IList<T> objects = ((IDbContext)dataContext).Set<T>().Where<T>(where).ToList();
                if (objects != null)
                {
                    foreach (T obj in objects)
                    {
                        ((IDbContext)dataContext).Set<T>().Remove(obj);
                        ((IDbContext)dataContext).Entry(obj).State = EntityState.Deleted;
                    }
                }
                status = true;
            }
            return status;
        }

        public virtual T GetById(IEateryDbContext dataContext, dynamic id)
        {
            return ((IDbContext)dataContext).Set<T>().Find(id);
        }

        public virtual IQueryable<T> GetAllQuery(IEateryDbContext dataContext)
        {
            return ((IDbContext)dataContext).Set<T>().AsQueryable();
        }     
    }
}
