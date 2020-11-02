using Eatery.Business.Interface;
using Eatery.Common;
using Eatery.DAL.Interface;
using Eatery.DAL.Repository.Interface;
using Eatery.DataContracts;
using Eatery.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Business
{
    public class OperationTimingBL : IOperationTimingBL
    {
        private readonly IOperationTimingRepository _operationTimingRepository;
        private readonly IUnitOfWork _unitOfWork;

        public OperationTimingBL(
            IOperationTimingRepository operationTimingRepository,
            IUnitOfWork unitOfWork)
        {
            this._operationTimingRepository = operationTimingRepository;
            this._unitOfWork = unitOfWork;
        }

        public bool Add(OperationTimingDTO operationTimingDTO, int userID)
        {
            if (operationTimingDTO != null)
            {
                using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
                {
                    OperationTiming operationTiming = ObjectTypeConverter.Convert<OperationTimingDTO, OperationTiming>(operationTimingDTO);
                    operationTiming.CreatedBy = userID;
                    operationTiming.CreatedDate = DateTime.Now;

                    this._operationTimingRepository.Add(context, operationTiming);
                    _unitOfWork.Commit(context);

                    return true;
                }
            }
            return false;
        }
    }
}
