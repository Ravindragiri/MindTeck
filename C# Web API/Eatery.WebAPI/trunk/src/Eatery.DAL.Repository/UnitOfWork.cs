using Eatery.DAL.Interface;
using Eatery.DAL.Repository.Interface;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DAL.Repository
{
    public class UnitOfWork : IUnitOfWork, IDisposable
    {
        private EateryDbContext dbContext = null;
        public IEateryDbContext GetEateryDbContext()
        {
            dbContext = new EateryDbContext();
            return dbContext;
        }

        public void Commit(IEateryDbContext context)
        {
            ((IDbContext)context).Commit();
        }
        //public void Rollback(IEateryDbContext context)
        //{
        //    ((IDbContext)context).Rollback();
        //}

        private bool disposed = false;

        protected virtual void Dispose(bool disposing)
        {
            if (!this.disposed)
            {
                if (disposing)
                {
                    dbContext.Dispose();
                }
            }
            this.disposed = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}
