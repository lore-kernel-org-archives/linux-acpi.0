From: Pankaj Gupta <pagupta@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 6/6] xfs: disable map_sync for async
 flush
Date: Wed, 24 Apr 2019 01:10:28 -0400 (EDT)
Message-ID: <750624039.23167994.1556082628248.JavaMail.zimbra@redhat.com>
References: <20190423080612.15361-1-pagupta@redhat.com> <20190423080612.15361-7-pagupta@redhat.com> <20190423220217.GA29573@dread.disaster.area> <20190423221011.GD178290@magnolia>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190423221011.GD178290@magnolia>
Sender: linux-kernel-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com, jasowang@redhat.com, Dave Chinner <david@fromorbit.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org, aarcange@redhat.com, dave jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org, vishal l verma <vishal.l.verma@intel.com>, david@redhat.com, willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>, stefanha@redhat.com, pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com, kwolf@redhat.com, nilal@redhat.com, tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gma>
List-Id: linux-acpi@vger.kernel.org


> 
> On Wed, Apr 24, 2019 at 08:02:17AM +1000, Dave Chinner wrote:
> > On Tue, Apr 23, 2019 at 01:36:12PM +0530, Pankaj Gupta wrote:
> > > Dont support 'MAP_SYNC' with non-DAX files and DAX files
> > > with asynchronous dax_device. Virtio pmem provides
> > > asynchronous host page cache flush mechanism. We don't
> > > support 'MAP_SYNC' with virtio pmem and xfs.
> > > 
> > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > > ---
> > >  fs/xfs/xfs_file.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> > > index 1f2e2845eb76..0e59be018511 100644
> > > --- a/fs/xfs/xfs_file.c
> > > +++ b/fs/xfs/xfs_file.c
> > > @@ -1196,11 +1196,13 @@ xfs_file_mmap(
> > >  	struct file	*filp,
> > >  	struct vm_area_struct *vma)
> > >  {
> > > -	/*
> > > -	 * We don't support synchronous mappings for non-DAX files. At least
> > > -	 * until someone comes with a sensible use case.
> > > +	struct dax_device *dax_dev = xfs_find_daxdev_for_inode
> > > +						(file_inode(filp));
> 
>     tab separation here ^^^                   ^^^^ and cut
>                                                        down the indent
>                                              while you're at
> 						    it, please:
> 
> 	struct dax_device	*dax_dev;
> 
> 	dax_dev = xfs_find_daxdev_for_inode(file_inode(filp));
> 	if (!dax_is_frobbed(dax))
> 		return -EMEWANTCOOKIE;

Done. 

Thanks,
Pankaj

> 
> --D
> 
> > > +
> > > +	/* We don't support synchronous mappings for non-DAX files and
> > > +	 * for DAX files if underneath dax_device is not synchronous.
> > >  	 */
> > 
> > 	/*
> > 	 * This is the correct multi-line comment format. Please
> > 	 * update the patch to maintain the existing comment format.
> > 	 */
> > 
> > Cheers,
> > 
> > Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com
> 
> 
