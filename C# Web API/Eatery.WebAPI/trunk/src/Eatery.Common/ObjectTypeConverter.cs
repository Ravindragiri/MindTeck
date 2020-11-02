using AutoMapper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Common
{
    /// <summary>
    /// Class used to convert from source type object to target type object.
    /// </summary>
    public class ObjectTypeConverter
    {
        /// <summary>
        /// Convert from soruce type to target type.
        /// </summary>
        /// <typeparam name="S">Source Type</typeparam>
        /// <typeparam name="T">Target type</typeparam>
        /// <param name="s">Source type object </param>
        /// <returns>Target type object returned.</returns>
        public static T Convert<S, T>(S s)
        {
            try
            {
                Mapper.CreateMap<S, T>();
                return Mapper.Map<S, T>(s);
            }
            catch (Exception ex)
            {
                //AppLogManager.LogError(ex);
                throw ex;
            }
        }

        /// <summary>
        /// Convert from soruce type to target type.
        /// </summary>
        /// <typeparam name="S">Source Type</typeparam>
        /// <typeparam name="T">Target type</typeparam>
        /// <param name="s">Source type object list</param>
        /// <returns>Target type object list returned.</returns>
        public static IEnumerable<T> ConvertList<S, T>(IEnumerable<S> list)
        {
            IList<T> returnList = null;
            try
            {
                if (list != null)
                {
                    returnList = new List<T>();
                    Mapper.CreateMap<S, T>();
                    using (IEnumerator<S> listEnum = list.GetEnumerator())
                    {
                        while (listEnum.MoveNext())
                            returnList.Add(Mapper.Map<S, T>((S)listEnum.Current));
                    }
                }
                return returnList;
            }
            catch (Exception ex)
            {
                //AppLogManager.LogError(ex);
                throw ex;
            }
            //return list == null ? null
            //    : ((List<S>)list).ConvertAll<T>(delegate(S s) { return ObjectTypeConverter.Convert<S, T>(s); });
        }
    }
}
