From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI : do not use Lid and Sleep button for S5 wakeup
Date: Mon, 10 Dec 2012 15:44:17 +0100
Message-ID: <11815633.2CKGZS0MxY@vostro.rjw.lan>
References: <1354522506.3063.9.camel@rzhang1-mobl4> <1354637206.2411.5.camel@rzhang1-mobl4> <20121210145123.0a9b76fe@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:52256 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753869Ab2LJOjR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Dec 2012 09:39:17 -0500
In-Reply-To: <20121210145123.0a9b76fe@destiny.ordissimo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

On Monday, December 10, 2012 02:51:23 PM Anisse Astier wrote:
> On Wed, 05 Dec 2012 00:06:46 +0800, Zhang Rui <rui.zhang@intel.com> wrote :
> 
> > On Tue, 2012-12-04 at 01:02 +0100, Rafael J. Wysocki wrote:
> > > On Monday, December 03, 2012 04:15:06 PM Zhang Rui wrote:
> > > > From 3e7b4da3783d200f35568f72b3b25f16df546ffe Mon Sep 17 00:00:00 2001
> > > > From: Zhang Rui <rui.zhang@intel.com>
> > > > Date: Fri, 30 Nov 2012 14:35:43 +0800
> > > > Subject: [PATCH] ACPI : do not use Lid and Sleep button for S5 wakeup
> > > > 
> > > > When system enters power off, the _PSW of Lid device is enabled.  
> > > > But this may cause the system to reboot instead of power off.
> > > > 
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=35262
> > > > 
> > > > A proper way to fix this is to always disable lid wakeup capability
> > > > for S5.
> > > 
> > > While I understand the motivation, quite frankly I don't understand the patch. :-)
> > > 
> > > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > > ---
> > > >  drivers/acpi/scan.c |    7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > > > index d1ecca2..f20020a 100644
> > > > --- a/drivers/acpi/scan.c
> > > > +++ b/drivers/acpi/scan.c
> > > > @@ -807,8 +807,8 @@ acpi_bus_extract_wakeup_device_power_package(acpi_handle handle,
> > > >  static void acpi_bus_set_run_wake_flags(struct acpi_device *device)
> > > >  {
> > > >  	struct acpi_device_id button_device_ids[] = {
> > > > -		{"PNP0C0D", 0},
> > > >  		{"PNP0C0C", 0},
> > > > +		{"PNP0C0D", 0},
> > > >  		{"PNP0C0E", 0},
> > > >  		{"", 0},
> > > >  	};
> > > > @@ -820,6 +820,11 @@ static void acpi_bus_set_run_wake_flags(struct acpi_device *device)
> > > >  	/* Power button, Lid switch always enable wakeup */
> > > >  	if (!acpi_match_device_ids(device, button_device_ids)) {
> > > >  		device->wakeup.flags.run_wake = 1;
> > > > +		if (!acpi_match_device_ids(device, &button_device_ids[1])) {
> > > > +			/* Do not use Lid/sleep button for S5 wakeup */
> > > > +			if (device->wakeup.gpe_number == 5)
> > > > +				device->wakeup.gpe_number = 4;
> > > 
> > > Why do you want to change the wakeup GPE number for those devices?  It appears
> > > to be based on some extra knowledge that should be documented.
> > > 
> > > Moreover, this doesn't look like the right thing to do anyway.  Shouldn't we
> > > just change device->wakeup.sleep_state to ACPI_STATE_S4 (if it was S5) instead?
> > 
> > oops, this is really embarrassing.
> > I made a stupid mistake in this patch, and you are right that I was
> > trying to override the device->wakeup.sleep_state to ACPI_STATE_S4.
> > 
> > refreshed patch attached.
> > Patch has been test by faking a lid device in custom DSDT table.
> > But I still prefer to get the test result in the bug report,
> > before pushing it upstream.
> > 
> > From 64e16e442b7d33801b5c1a41cf5c87d4d8ff1e10 Mon Sep 17 00:00:00 2001
> > From: Zhang Rui <rui.zhang@intel.com>
> > Date: Fri, 30 Nov 2012 14:35:43 +0800
> > Subject: [PATCH 1/2] ACPI : do not use Lid and Sleep button for S5 wakeup
> > 
> > When system enters power off, the _PSW of Lid device is enabled.  
> > But this may cause the system to reboot instead of power off.
> > 
> > A proper way to fix this is to always disable lid wakeup capability for S5.
> > https://bugzilla.kernel.org/show_bug.cgi?id=35262
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> 
> It works ! (On a Toshiba C870-12N, which exhibits the problem).
> 
> Tested-by: Anisse Astier <anisse@astier.eu>
> 

The patch has been queued up for v3.8 and -stable.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
