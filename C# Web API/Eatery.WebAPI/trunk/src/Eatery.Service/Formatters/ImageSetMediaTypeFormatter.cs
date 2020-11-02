using Eatery.DTO;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;

namespace Eatery.Service.Formatters
{
    //public class ImageSetMediaTypeFormatter : MediaTypeFormatter
    //{
    //    public ImageSetMediaTypeFormatter()
    //    {
    //        SupportedMediaTypes.Add(new MediaTypeHeaderValue("multipart/form-data"));
    //    }

    //    public override bool CanReadType(Type type)
    //    {
    //        return type == typeof(IMediaType);
    //    }

    //    public override bool CanWriteType(Type type)
    //    {
    //        return false;
    //    }

    //    public async override Task<object> ReadFromStreamAsync(
    //        Type type,
    //        Stream readStream,
    //        HttpContent content,
    //        IFormatterLogger formatterLogger)
    //    {

            
    //        return imageSet;
    //    }
    //}

    //public static class StringExtenstions
    //{
    //    public static string NormalizeName(this string text)
    //    {
    //        return text.Replace("\"", "");
    //    }

    //    public static bool Matches(this string text, string pattern)
    //    {
    //        return Regex.IsMatch(text, pattern);
    //    }
    //}
}