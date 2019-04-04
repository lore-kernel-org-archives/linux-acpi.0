From: "Darrick J. Wong" <darrick.wong-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Qemu-devel] [PATCH v4 5/5] xfs: disable map_sync for async flush
Date: Thu, 4 Apr 2019 08:00:25 -0700
Message-ID: <20190404150025.GN5147@magnolia>
References: <20190403104018.23947-1-pagupta@redhat.com>
 <20190403104018.23947-6-pagupta@redhat.com>
 <20190403220912.GB26298@dastard> <20190403223921.GM5147@magnolia>
 <1508883801.17367965.1554358418550.JavaMail.zimbra@redhat.com>
 <651986267.17402634.1554368950178.JavaMail.zimbra@redhat.com>
 <20190404094029.GD16131@quack2.suse.cz>
 <527416483.17415178.1554372524196.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <527416483.17415178.1554372524196.JavaMail.zimbra-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Pankaj Gupta <pagupta-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Jan Kara <jack-AlSwsSmVLrQ@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Dave Chinner <david-FqsqvQoI3Ljby3iVrkZq2A@public.gmane.org>, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, adilger kernel <adilger.kernel-m1MBpc4rdrD3fQ9qLvQP4Q@public.gmane.org>, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, david-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-ext4-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, riel-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org, stefanha-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lcapitulino-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kwolf-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, nilal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tytso-3s7WtUTddSA@public.gmane.org, xiaoguangrong eric <xiaoguangrong.eric-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, cohuck-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, imammedo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Apr 04, 2019 at 06:08:44AM -0400, Pankaj Gupta wrote:
> 
> > On Thu 04-04-19 05:09:10, Pankaj Gupta wrote:
> > > 
> > > > > On Thu, Apr 04, 2019 at 09:09:12AM +1100, Dave Chinner wrote:
> > > > > > On Wed, Apr 03, 2019 at 04:10:18PM +0530, Pankaj Gupta wrote:
> > > > > > > Virtio pmem provides asynchronous host page cache flush
> > > > > > > mechanism. we don't support 'MAP_SYNC' with virtio pmem
> > > > > > > and xfs.
> > > > > > > 
> > > > > > > Signed-off-by: Pankaj Gupta <pagupta-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> > > > > > > ---
> > > > > > >  fs/xfs/xfs_file.c | 8 ++++++++
> > > > > > >  1 file changed, 8 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > > > > > index 1f2e2845eb76..dced2eb8c91a 100644
> > > > > > > --- a/fs/xfs/xfs_file.c
> > > > > > > +++ b/fs/xfs/xfs_file.c
> > > > > > > @@ -1203,6 +1203,14 @@ xfs_file_mmap(
> > > > > > >  	if (!IS_DAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
> > > > > > >  		return -EOPNOTSUPP;
> > > > > > >  
> > > > > > > +	/* We don't support synchronous mappings with DAX files if
> > > > > > > +	 * dax_device is not synchronous.
> > > > > > > +	 */
> > > > > > > +	if (IS_DAX(file_inode(filp)) && !dax_synchronous(
> > > > > > > +		xfs_find_daxdev_for_inode(file_inode(filp))) &&
> > > > > > > +					(vma->vm_flags & VM_SYNC))
> > > > > > > +		return -EOPNOTSUPP;
> > > > > > > +
> > > > > > >  	file_accessed(filp);
> > > > > > >  	vma->vm_ops = &xfs_file_vm_ops;
> > > > > > >  	if (IS_DAX(file_inode(filp)))
> > > > > > 
> > > > > > All this ad hoc IS_DAX conditional logic is getting pretty nasty.
> > > > > > 
> > > > > > xfs_file_mmap(
> > > > > > ....
> > > > > > {
> > > > > > 	struct inode	*inode = file_inode(filp);
> > > > > > 
> > > > > > 	if (vma->vm_flags & VM_SYNC) {
> > > > > > 		if (!IS_DAX(inode))
> > > > > > 			return -EOPNOTSUPP;
> > > > > > 		if (!dax_synchronous(xfs_find_daxdev_for_inode(inode))
> > > > > > 			return -EOPNOTSUPP;
> > > > > > 	}
> > > > > > 
> > > > > > 	file_accessed(filp);
> > > > > > 	vma->vm_ops = &xfs_file_vm_ops;
> > > > > > 	if (IS_DAX(inode))
> > > > > > 		vma->vm_flags |= VM_HUGEPAGE;
> > > > > > 	return 0;
> > > > > > }
> > > > > > 
> > > > > > 
> > > > > > Even better, factor out all the "MAP_SYNC supported" checks into a
> > > > > > helper so that the filesystem code just doesn't have to care about
> > > > > > the details of checking for DAX+MAP_SYNC support....
> > > > > 
> > > > > Seconded, since ext4 has nearly the same flag validation logic.
> > > > 
> > > 
> > > Only issue with this I see is we need the helper function only for
> > > supported
> > > filesystems ext4 & xfs (right now). If I create the function in "fs.h" it
> > > will be compiled for every filesystem, even for those don't need it.
> > > 
> > > Sample patch below, does below patch is near to what you have in mind?
> > 
> > So I would put the helper in include/linux/dax.h and have it like:
> > 
> > bool daxdev_mapping_supported(struct vm_area_struct *vma,

Should this be static inline if you're putting it in the header file?

A comment ought to be added to describe what this predicate function
does.

> > 			      struct dax_device *dax_dev)
> > {
> > 	if (!(vma->vm_flags & VM_SYNC))
> > 		return true;
> > 	if (!IS_DAX(file_inode(vma->vm_file)))
> > 		return false;
> > 	return dax_synchronous(dax_dev);
> > }
> 
> Sure. This is much better. I was also not sure what to name the helper function.
> I will go ahead with this unless 'Dave' & 'Darrick' have anything to add.

Jan's approach (modulo that one comment) looks good to me.

--D

> Thank you very much.
> 
> Best regards,
> Pankaj 
> 
> > 
> > 								Honza
> > > 
> > > =================
> > > 
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index 1f2e2845eb76..614995170cac 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -1196,12 +1196,17 @@ xfs_file_mmap(
> > >         struct file     *filp,
> > >         struct vm_area_struct *vma)
> > >  {
> > > +       struct dax_device *dax_dev =
> > > xfs_find_daxdev_for_inode(file_inode(filp));
> > > +
> > >         /*
> > > -        * We don't support synchronous mappings for non-DAX files. At
> > > least
> > > -        * until someone comes with a sensible use case.
> > > +        * We don't support synchronous mappings for non-DAX files and
> > > +        * for DAX files if underneath dax_device is not synchronous.
> > >          */
> > > -       if (!IS_DAX(file_inode(filp)) && (vma->vm_flags & VM_SYNC))
> > > -               return -EOPNOTSUPP;
> > > +       if (vma->vm_flags & VM_SYNC) {
> > > +               int err = is_synchronous(filp, dax_dev);
> > > +               if (err)
> > > +                       return err;
> > > +       }
> > >  
> > >         file_accessed(filp);
> > >         vma->vm_ops = &xfs_file_vm_ops;
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 8b42df09b04c..add017de3dd7 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -2162,6 +2162,20 @@ static inline void file_accessed(struct file *file)
> > >                 touch_atime(&file->f_path);
> > >  }
> > >  
> > > +struct dax_device;
> > > +extern bool dax_synchronous(struct dax_device *dax_dev);
> > > +static inline int is_synchronous(struct file *filp, struct dax_device
> > > *dax_dev)
> > > +{
> > > +       struct inode *inode = file_inode(filp);
> > > +
> > > +       if (!IS_DAX(inode))
> > > +               return -EOPNOTSUPP;
> > > +       if (!dax_synchronous(dax_dev))
> > > +               return -EOPNOTSUPP;
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  int sync_inode(struct inode *inode, struct writeback_control *wbc);
> > >  int sync_inode_metadata(struct inode *inode, int wait);
> > >  
> > > ---------
> > > 
> > > Thanks,
> > > Pankaj
> > > 
> > > 
> > > 
> > --
> > Jan Kara <jack-IBi9RG/b67k@public.gmane.org>
> > SUSE Labs, CR
> > 
> > 
