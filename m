From: Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCH 1/4] nvdimm: Add wrapper for IOCTL pass thru.
Date: Tue, 10 Nov 2015 12:49:38 -0700
Message-ID: <20151110194938.GA47666@tevye.fc.hp.com>
References: <cover.1446684001.git.jerry.hoemann@hpe.com>
 <cover.1446684001.git.jerry.hoemann@hpe.com>
 <5411049831df211c8280e3239aaf344af033fa25.1446684001.git.jerry.hoemann@hpe.com>
 <x49d1vhlp34.fsf@segfault.boston.devel.redhat.com>
Reply-To: Jerry.Hoemann@hpe.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <x49d1vhlp34.fsf@segfault.boston.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: ross.zwisler@linux.intel.com, rjw@rjwysocki.net, lenb@kernel.org, dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@ml01.01.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 10, 2015 at 12:51:59PM -0500, Jeff Moyer wrote:
> Jerry Hoemann <jerry.hoemann@hpe.com> writes:
> 
> > Add IOCTL type 'P' to denote NVDIMM_TYPE_PASSTHRU.
> 
> Can't you just make passthrough a separate command?  If you actually add

There are multiple conflicting NVDIMM _DSM running around, they
are "device specific".  So, we should plan in general and not just
for the example DSM that Intel added support for.  These DSM have
over lapping and incompatible function ids.

The Intel example is an example,  not standard. They are free to
change it at will. So, we can't be certain there won't be a
conflict some time in the future if we try to use their number space.

I'm trying to create a generic pass thru that any vendors can use.  Putting
this in the Intel function number space doesn't make a lot of sense to me.

> the ioctl definition for passthrough (which you didn't do for some
> reason?), it looks odd:

The definition for the IOCTLs are in a user space application.
These aren't required in the kernel as the kernel is only a
pass thru.

As the DSM I'm working with isn't yet finalized, I've been told that
i can't share the user space portion yet.


> 
> #define ND_IOCTL_PASSTHRU        _IOWR(NVDIMM_TYPE_PASSTHRU,, ND_CMD_PASSTHRU, \
>                                  struct ndn_package)
> 
> Care to comment on why you chose a different type instead of specifying
> a new command?
> 
> > +struct ndn_pkg {
> > +	struct {
> > +		__u8	dsm_uuid[16];
> > +		__u32	dsm_in;			/* size of _DSM input    */
> > +		__u32	dsm_out;		/* size of user buffer   */
> > +		__u32	dsm_rev;		/* revision of dsm call  */
> > +		__u32	res[8];			/* reserved must be zero */
> > +		__u32	dsm_size;		/* size _DSM would write */
> > +	} h;
> > +	unsigned char buf[];
> 
> Please change that to:
> 	__u8 *buf;
> since acpi_object.buffer.pointer is a u8 *.

buf isn't being passed to acpi_evaluate_dsm.  its just being used for pointer offset
in acpi_nfit_ctl_passthru.  The "payload" that will be passed to acpi_evaluate_dsm
follows.

> 
> Note that the size of this structure will be different for 32 vs. 64
> bit, but I don't think it matters since offsets won't change (the
> pointer is at the end of the structure).

  I assume you mean size of struct changes if I use the pointer as
  substitute for the zero sized array?  or are you saying that the
  packed attribute doesn't affect the layout of the anonymous struct?

-- 

-----------------------------------------------------------------------------
Jerry Hoemann            Software Engineer      Hewlett-Packard Enterprise

3404 E Harmony Rd. MS 36                        phone:  (970) 898-1022
Ft. Collins, CO 80528                           FAX:    (970) 898-0707
                                                email:  jerry.hoemann@hpe.com
-----------------------------------------------------------------------------
