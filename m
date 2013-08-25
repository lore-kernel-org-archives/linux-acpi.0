From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI/Thermal: Add check of "_TZD" availability and evaluating result
Date: Sun, 25 Aug 2013 15:22:26 +0200
Message-ID: <1863720.XffA2N3zI8@vostro.rjw.lan>
References: <1377334888-6384-1-git-send-email-tianyu.lan@intel.com> <3673570.IB0e6CCT7B@vostro.rjw.lan> <CAOLK0pwoyYd+E6L-TkJdvErCg3G0qGruM1VvBPnNaEyAJ+WZoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:33015 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752946Ab3HYNLs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 25 Aug 2013 09:11:48 -0400
In-Reply-To: <CAOLK0pwoyYd+E6L-TkJdvErCg3G0qGruM1VvBPnNaEyAJ+WZoA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <lantianyu1986@gmail.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Sunday, August 25, 2013 02:39:30 PM Lan Tianyu wrote:
> Hi Rafael:
>            Thanks for review.
> 
> 2013/8/24 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Saturday, August 24, 2013 05:01:28 PM tianyu.lan@intel.com wrote:
> >> From: Lan Tianyu <tianyu.lan@intel.com>
> >>
> >> Some machines don't provide _TZD. So add check of "_TZD" availability
> >> before doing futher operations. This patch also adds the check of
> >> evaluating result.
> >>
> >> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> >> ---
> >>  drivers/acpi/thermal.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> >> index 09f9340..6809fbd 100644
> >> --- a/drivers/acpi/thermal.c
> >> +++ b/drivers/acpi/thermal.c
> >> @@ -492,11 +492,12 @@ static int acpi_thermal_trips_update(struct acpi_thermal *tz, int flag)
> >>                       break;
> >>       }
> >>
> >> -     if (flag & ACPI_TRIPS_DEVICES) {
> >> +     if ((flag & ACPI_TRIPS_DEVICES)
> >> +                     && acpi_has_method(tz->device->handle, "_TZD")) {
> >
> > Please arrange the whitespace here like this:
> >
> >         if ((flag & ACPI_TRIPS_DEVICES)
> >             && acpi_has_method(tz->device->handle, "_TZD")) {
> >
> 
> Ok. I will update.
> 
> >
> >>               memset(&devices, 0, sizeof(struct acpi_handle_list));
> >>               status = acpi_evaluate_reference(tz->device->handle, "_TZD",
> >>                                               NULL, &devices);
> >> -             if (memcmp(&tz->devices, &devices,
> >> +             if (ACPI_SUCCESS(status) && memcmp(&tz->devices, &devices,
> >>                               sizeof(struct acpi_handle_list))) {
> >
> > I wonder why you can't use "tz->device == devices" here instead of the memcmp?
> 
> After changing like this, compiling failed with the following warning.
> 
> drivers/acpi/thermal.c: In function 'acpi_thermal_trips_update':
> drivers/acpi/thermal.c:500:43: error: invalid operands to binary ==
> (have 'struct acpi_handle_list' and 'struct acpi_handle_list')
>    if (ACPI_SUCCESS(status) && tz->devices == devices) {
>                                                                     ^

OK, so please use memcmp(&tz->devices, &devices, sizeof(devices)).

> 
> >
> > And also "tz->devices = devices" below for that matter.
> >
> 
> This change is ok.

Thanks,
Rafael

