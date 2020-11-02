using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DTO
{
    public class PagingSortingParamsDTO
    {
        public string SortColumn{get; set;}
        public string Order{get; set;}
        public int PageIndex {get; set;}
        public int PageSize { get; set; }
    }
}
