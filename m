From: Thomas Renninger <trenn@suse.de>
Subject: Re: Buggy BIOS on the HP TX2500-series
Date: Thu, 9 Oct 2008 11:52:14 +0200
Message-ID: <200810091152.15784.trenn@suse.de>
References: <331496.52627.qm@web23007.mail.ird.yahoo.com> <alpine.LFD.1.10.0810082203280.8572@localhost.localdomain> <1223534216.2735.106.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:47417 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754890AbYJIJwT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Oct 2008 05:52:19 -0400
In-Reply-To: <1223534216.2735.106.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Gandalf Kristensen <gandkri@yahoo.no>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Lin, Ming M" <ming.m.lin@intel.com>, "Moore, Robert" <robert.moore@intel.com>

On Thursday 09 October 2008 08:36:56 Zhang Rui wrote:
> On Wed, 2008-10-08 at 19:04 -0700, Len Brown wrote:
> > On Thu, 9 Oct 2008, Matthew Garrett wrote:
> > > On Thu, Oct 09, 2008 at 08:59:15AM +0800, Zhang Rui wrote:
> > > > On Wed, 2008-10-08 at 12:26 -0700, Matthew Garrett wrote:
> > > > > A patch went into the kernel earlier this year to ignore critical
> > > > > trip points that were below 0.
> > > >
> > > > well, I think this patch is wrong.
> > > > a critical trip point below 0 Celsius doesn't mean it's invalid.
> > >
> > > I think it's pretty clear that a critical trip point below 0 celsius
> > > means that the critical trip point is invalid,
>
> well, I agree that this workaround can work here.
> But I think the proper way to fix this issue is that,
> ACPICA returns some error code(AE_BAD_DATA) like it did before,
> and the thermal driver knows that it got an invalid value and
> should take it carefully.
> or else we may still get potential problems, e.g. what if there
> is no return value of _PSV method.
>
> > though I agree that
> >
> > > ignoring the entire thermal zone as a result is somewhat unfortunate.
> > >
> > > > windows can work well on this laptop.
> > > > please look at:
> > > > http://bugzilla.kernel.org/show_bug.cgi?id=10686#c13
> > > > IMO, we need to fix the ACPICA code first of all.
> > > >
> > > > Ming, what do you think of the patch in comment #15 and #16?
> > >
> > > We could quibble over the technical correctness of this approach, but
> > > it seems to behave in exactly the same way - ie, Linux will ignore the
> > > thermal zone? The existing code seems fine, other than the fact that a
> > > bad _CRT will result everything failing. I think we'd be better off
> > > just losing the return -ENODEV there and try to use as much of the
> > > thermal information as we can.
> >
> > right, when we put in the workaround we observed that a bad _CRT
> > would delete an entire thermal zone, and that could be a big
> > problem on a box with active cooling on that thermal zone.
>
> Hmm, I think a patch like this is enough to fix this problem.
>
>
> ignore invalid critical trip point.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/thermal.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> Index: linux-2.6/drivers/acpi/thermal.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/thermal.c
> +++ linux-2.6/drivers/acpi/thermal.c
> @@ -373,9 +373,8 @@ static int acpi_thermal_trips_update(str
>  		if (ACPI_FAILURE(status) ||
>  				tz->trips.critical.temperature <= 2732) {
>  			tz->trips.critical.flags.valid = 0;
> -			ACPI_EXCEPTION((AE_INFO, status,
> +			ACPI_DEBUG_PRINT((ACPI_DB_WARN,
>  					"No or invalid critical threshold"));
> -			return -ENODEV;
I agree with not returning -ENODEV which I expect to only invalidate the
critical trip point and still let the thermal zone do it's (possibly 
important) job.

I DO NOT AGREE with removing the exception!
These corner cases will always break again and again sooner or later. Totally 
hiding this message will cause a lot grief to people who are going to debug 
thermal issues on their machine two kernel versions later when some bad side 
effect exposes caused by this crappy BIOS and people will lose precious time, 
because this was hidden.

Also this BIOS should never get a Novell or whatever Linux distro certified 
sticker. Our certification people try hard to identify such BIOS bugs and 
reject such BIOSes and force the vendors to fix it. Guessing Windows behavior 
and try to support it is not an option, because history showed that such 
Windows compatibility efforts can take years until things are adopted/guessed 
in the right way.

I am going to resend my [Firmware Bug] interface using this one as a first 
instance to use it. It's the classic example why it's urgently needed.
Once it's in, I promise to adopt other parts, so that it's meaningful to do:
dmesg |grep "[Firmware Bug]"

Have you seen that Len?
Hmm, I forgot to add the acpi list on the latest version, I only added the 
cpufreq list. I am going to resend them. On the cpufreq list it was:
Subject: Resend: Introduce interface to report BIOS bugs (reworked: FW_BUG 
simple solution, large description)

Thanks,

     Thomas
