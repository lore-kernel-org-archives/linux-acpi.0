From: Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCH 1/4] nvdimm: Add wrapper for IOCTL pass thru.
Date: Tue, 10 Nov 2015 17:44:25 -0700
Message-ID: <20151111004425.GG47666@tevye.fc.hp.com>
References: <cover.1446684001.git.jerry.hoemann@hpe.com>
 <cover.1446684001.git.jerry.hoemann@hpe.com>
 <5411049831df211c8280e3239aaf344af033fa25.1446684001.git.jerry.hoemann@hpe.com>
 <x49d1vhlp34.fsf@segfault.boston.devel.redhat.com>
 <20151110194938.GA47666@tevye.fc.hp.com>
 <x49oaf1k3cx.fsf@segfault.boston.devel.redhat.com>
Reply-To: Jerry.Hoemann@hpe.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <x49oaf1k3cx.fsf@segfault.boston.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: ross.zwisler@linux.intel.com, rjw@rjwysocki.net, lenb@kernel.org, dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@ml01.01.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Nov 10, 2015 at 03:26:38PM -0500, Jeff Moyer wrote:
> >
> > The definition for the IOCTLs are in a user space application.
> > These aren't required in the kernel as the kernel is only a
> > pass thru.
> 
> OK, I don't see the harm in including it in the kernel headers, but I'm
> not going to insist on it.
> 

The IOCTL are defined in terms of the data structures representing
the dsm functions.  Since I'm not supposed to share the definitions
of the DSM at this point, I can't share the IOCTL definitions.

When this restriction is lifted, I would be interested in pushing
these definitions to the appropriate header file.



> > As the DSM I'm working with isn't yet finalized, I've been told that
> > i can't share the user space portion yet.
> 
> That's OK, I don't think providing the userspace code is necessary for
> this patch set to make progress.  (I didn't actually ask for it, to be
> clear.)


Understood.  But it is sometimes nice to have a concrete example(s)
of an interfaces usage.


...

> >> > +struct ndn_pkg {
> >> > +	struct {
> >> > +		__u8	dsm_uuid[16];
> >> > +		__u32	dsm_in;			/* size of _DSM input    */
> >> > +		__u32	dsm_out;		/* size of user buffer   */
> >> > +		__u32	dsm_rev;		/* revision of dsm call  */
> >> > +		__u32	res[8];			/* reserved must be zero */
> >> > +		__u32	dsm_size;		/* size _DSM would write */
> >> > +	} h;
> >> > +	unsigned char buf[];
> >> 
> >> Please change that to:
> >> 	__u8 *buf;
> >> since acpi_object.buffer.pointer is a u8 *.
> >
> > buf isn't being passed to acpi_evaluate_dsm.  its just being used for pointer offset
> > in acpi_nfit_ctl_passthru.  The "payload" that will be passed to acpi_evaluate_dsm
> > follows.
> 
> +	in_buf.buffer.pointer = (void *) &pkg->buf;
> 
> I see.  I misread that, because you didn't actually make buf a zero
> length array (see the structure definition quoted above).  I guess you
> meant to write this:
> 
>     unsigned char buf[0];
> 

The ndn_pkg.buf struct uses a flexible array definition.  This is in C99.
An explicit zero length array is a gcc extension that has been around much
longer.  They behave in a similar fashion, but aren't identical.   In my
limited use they behave the same.

-- 

-----------------------------------------------------------------------------
Jerry Hoemann            Software Engineer      Hewlett-Packard Enterprise
-----------------------------------------------------------------------------
