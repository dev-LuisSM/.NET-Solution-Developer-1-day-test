using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MVC_Web_API_REST.Models
{
    public class Photos
    {
        public int id { get; set; }
        public int albumId { get; set; } 
        public string title { get; set; }
        public string url { get; set; }
        public string thumbnailUrl { get; set; }
    }
}
