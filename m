From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 1/4] nvdimm: Add wrapper for IOCTL pass thru.
Date: Tue, 10 Nov 2015 15:26:38 -0500
Message-ID: <x49oaf1k3cx.fsf@segfault.boston.devel.redhat.com>
References: <cover.1446684001.git.jerry.hoemann@hpe.com>
	<cover.1446684001.git.jerry.hoemann@hpe.com>
	<5411049831df211c8280e3239aaf344af033fa25.1446684001.git.jerry.hoemann@hpe.com>
	<x49d1vhlp34.fsf@segfault.boston.devel.redhat.com>
	<20151110194938.GA47666@tevye.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151110194938.GA47666@tevye.fc.hp.com> (Jerry Hoemann's message
	of "Tue, 10 Nov 2015 12:49:38 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Jerry.Hoemann@hpe.com
Cc: ross.zwisler@linux.intel.com, rjw@rjwysocki.net, lenb@kernel.org, dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@ml01.01.org
List-Id: linux-acpi@vger.kernel.org

Jerry Hoemann <jerry.hoemann@hpe.com> writes:

> On Tue, Nov 10, 2015 at 12:51:59PM -0500, Jeff Moyer wrote:
>> Jerry Hoemann <jerry.hoemann@hpe.com> writes:
>> 
>> > Add IOCTL type 'P' to denote NVDIMM_TYPE_PASSTHRU.
>> 
>> Can't you just make passthrough a separate command?  If you actually add
>
> There are multiple conflicting NVDIMM _DSM running around, they
> are "device specific".  So, we should plan in general and not just
> for the example DSM that Intel added support for.  These DSM have
> over lapping and incompatible function ids.
>
> The Intel example is an example,  not standard. They are free to
> change it at will. So, we can't be certain there won't be a
> conflict some time in the future if we try to use their number space.
>
> I'm trying to create a generic pass thru that any vendors can use.  Putting
> this in the Intel function number space doesn't make a lot of sense to me.

OK, I see your point.

>> the ioctl definition for passthrough (which you didn't do for some
>> reason?), it looks odd:
>
> The definition for the IOCTLs are in a user space application.
> These aren't required in the kernel as the kernel is only a
> pass thru.

OK, I don't see the harm in including it in the kernel headers, but I'm
not going to insist on it.

> As the DSM I'm working with isn't yet finalized, I've been told that
> i can't share the user space portion yet.

That's OK, I don't think providing the userspace code is necessary for
this patch set to make progress.  (I didn't actually ask for it, to be
clear.)

>> #define ND_IOCTL_PASSTHRU        _IOWR(NVDIMM_TYPE_PASSTHRU,, ND_CMD_PASSTHRU, \
>>                                  struct ndn_package)
>> 
>> Care to comment on why you chose a different type instead of specifying
>> a new command?
>> 
>> > +struct ndn_pkg {
>> > +	struct {
>> > +		__u8	dsm_uuid[16];
>> > +		__u32	dsm_in;			/* size of _DSM input    */
>> > +		__u32	dsm_out;		/* size of user buffer   */
>> > +		__u32	dsm_rev;		/* revision of dsm call  */
>> > +		__u32	res[8];			/* reserved must be zero */
>> > +		__u32	dsm_size;		/* size _DSM would write */
>> > +	} h;
>> > +	unsigned char buf[];
>> 
>> Please change that to:
>> 	__u8 *buf;
>> since acpi_object.buffer.pointer is a u8 *.
>
> buf isn't being passed to acpi_evaluate_dsm.  its just being used for pointer offset
> in acpi_nfit_ctl_passthru.  The "payload" that will be passed to acpi_evaluate_dsm
> follows.

+	in_buf.buffer.pointer = (void *) &pkg->buf;

I see.  I misread that, because you didn't actually make buf a zero
length array (see the structure definition quoted above).  I guess you
meant to write this:

    unsigned char buf[0];

Cheers,
Jeff
