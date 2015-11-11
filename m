From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH 2/4] nvdimm: Add IOCTL pass thru
Date: Wed, 11 Nov 2015 10:41:37 -0500
Message-ID: <x49twoslf0u.fsf@segfault.boston.devel.redhat.com>
References: <cover.1446684001.git.jerry.hoemann@hpe.com>
	<cover.1446684001.git.jerry.hoemann@hpe.com>
	<4f81a8b6fa24723c808c72888290e2368fcdbca0.1446684001.git.jerry.hoemann@hpe.com>
	<x494mgtlogv.fsf@segfault.boston.devel.redhat.com>
	<20151110221352.GE47666@tevye.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53150 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751826AbbKKPlk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Nov 2015 10:41:40 -0500
In-Reply-To: <20151110221352.GE47666@tevye.fc.hp.com> (Jerry Hoemann's message
	of "Tue, 10 Nov 2015 15:13:52 -0700")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerry.Hoemann@hpe.com
Cc: ross.zwisler@linux.intel.com, rjw@rjwysocki.net, lenb@kernel.org, dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@ml01.01.org

Jerry Hoemann <jerry.hoemann@hpe.com> writes:

> On Tue, Nov 10, 2015 at 01:05:20PM -0500, Jeff Moyer wrote:
>> Jerry Hoemann <jerry.hoemann@hpe.com> writes:
>> 
>> > Add internal data structure for ndctl_passthru call.
>> >
>> > Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
>> > ---
>> >  include/linux/libnvdimm.h | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
>> > index 3f021dc..01117e1 100644
>> > --- a/include/linux/libnvdimm.h
>> > +++ b/include/linux/libnvdimm.h
>> > @@ -72,6 +72,7 @@ struct nvdimm_bus_descriptor {
>> >  	unsigned long dsm_mask;
>> >  	char *provider_name;
>> >  	ndctl_fn ndctl;
>> > +	ndctl_fn ndctl_passthru;
>> 
>> I don't think this is necessary.  Vector off inside of __nd_ioctl.  That
>> especially makes sense if you do switch to passthrough as a command
>> instead of a type, but it can work either way.
>> 
>
> In an earlier version, I added a "type" argument to ndctl_fn and switched
> internally based upon that.  I just came to the conclusion that I'd rather
> have two separate acpi_nfit_ctl functions than one trying to do both sets
> of argument marshaling.  This is quite different both internally and
> to the caller.
>
> So, I thought it would be less confusing to the next engineer, and that
> this was a good logical separation point.

I'll leave this up to Dan.  To me, it doesn't make sense to add a new
ioctl function for every new type of ioctl that get's added (assuming
more types will follow).

Cheers,
Jeff
