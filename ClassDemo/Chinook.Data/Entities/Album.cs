using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additional Namespaces
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
#endregion

namespace Chinook.Data.Entities
{
    [Table("Albums")]
    public class Album
    {
        [Key]
        public int AlbumId { get; set; }
        [Required(ErrorMessage ="Title is required")]
        [StringLength(160, ErrorMessage ="Title is limited to 160 characters")]
        public string Title { get; set; }
        public int ArtistId { get; set; }
        public int ReleaseYear { get; set; }
        
        public string ReleaseLabel { get; set; }

        //navigational properties (pointing to a parent)
        //the virtual Artist property points to a single parent
        public virtual Artist Artist { get; set; }

    }
}
