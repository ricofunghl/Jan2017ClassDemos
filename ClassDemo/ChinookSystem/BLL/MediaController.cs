﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additional Namespaces
using Chinook.Data.Enitities;
using Chinook.Data.POCOs;
using ChinookSystem.DAL;
using System.ComponentModel;
#endregion

namespace ChinookSystem.BLL
{
    [DataObject]
    public class MediaController
    {
        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public List<SelectionList> List_MediaTypes()
        {
            using (var context = new ChinookContext())
            {
                var results = from x in context.MediaTypes
                              orderby x.Name
                              select new SelectionList
                              {
                                  IDValueField = x.MediaTypeId,
                                  DisplayText = x.Name
                              };
                return results.ToList();
            }
        }
    }
}
