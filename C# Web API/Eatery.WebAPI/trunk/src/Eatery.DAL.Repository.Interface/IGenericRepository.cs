using Eatery.DAL.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DAL.Repository.Interface
{
    public interface IGenericRepository<T> where T : class
    {
        T Add(IEateryDbContext dataContext, T entity);

        T Update(IEateryDbContext dataContext, T entity);

        bool Delete(IEateryDbContext dataContext, T entity);

        bool DeleteAll(IEateryDbContext dataContext, Func<T, Boolean> where);

        T GetById(IEateryDbContext dataContext, dynamic id);

        IQueryable<T> GetAllQuery(IEateryDbContext dataContext);
    }
}
