From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Check for ACPI backlight support otherwise use vendor
	ACPIdrivers - version 4
Date: Mon, 4 Aug 2008 21:01:52 -0300
Message-ID: <20080805000151.GJ24927@khazad-dum.debian.net>
References: <1217605083-31003-1-git-send-email-trenn@suse.de> <1217812580.2969.184.camel@rzhang-dt> <1217830192.4580.8.camel@hidalgo> <200808041220.29892.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:56432 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755790AbYHEAB6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Aug 2008 20:01:58 -0400
Content-Disposition: inline
In-Reply-To: <200808041220.29892.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Yves-Alexis Perez <corsac@debian.org>, Zhang Rui <rui.zhang@intel.com>, ak@linux.intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

On Mon, 04 Aug 2008, Thomas Renninger wrote:
> On Monday 04 August 2008 08:09:52 Yves-Alexis Perez wrote:
> > On lun, 2008-08-04 at 09:16 +0800, Zhang Rui wrote:
> > > I think you're using the laptop that this patch does break.
> > > Please try acpi_backlight=vendor.
> >
> > When booting to single user with acpi_backlight=vendor, thinkpad-acpi
> > takes over backlight:
> >
> > Aug  4 07:54:38 hidalgo kernel:
> > thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...

See that one?

> > But when in user mode, brightness keys doesn't do anything either.
> > Echo'ing to /proc/acpi/ibm/brightness doesn't work, but echoing
> > to /sys/class/backlight/thinkpad_screen/brightness works.
> That /proc/acpi/ibm/brightness does not and
> /sys/class/backlight/thinkpad_screen/brightness 
> works is strange, this should be a bug?

No.  It is just that the driver expects ACPI video to be sending the events,
and it isn't, so you need to change some code in hotkey_init to stop
disabling brightness events in the (ACPI video support in DSDT, ACPI video
disabled and thinkpad-acpi is to handle the backlight) case.

> I wonder whether /proc/acpi/ibm/brightness can be removed soon, people had
> some time to make use of the generic interface.

It will go when everything else in /proc/acpi/ibm goes.  Which will happen
when /proc/acpi goes, or when it is intolerable to keep supporting it for
some good reason.

> Attached patch might help you (with acpi_backlight=vendor)?
> You should be able to apply this on my latest patchset, but use this patch
> instead of the thinkpad_acpi one.

HEAVY NAK on the thinkpad-acpi hunks in this one.  It is good for testing,
but I don't want any automated handling of the brightness hotkeys in
thinkpad-acpi unless we absolutely HAVE to emulate the older non-Vista
firmware for some weird reason.  More on this at the end of this post.

Please check if updating hotkey_init doesn't solve the issue.  I am sorry I
didn't recall that detail to remind you about it when I looked your patches
over.

> > Cat'ing /proc/acpi/events still gives:
> > video LCD0 00000086 00000000
> > video LCD0 00000087 00000000
> >
> > At one time I get the 750ms delay, but I don't have the
> > ibm/hotkey HKEY 00000080 00005010 at all.

This is caused by EC+ACPI DSDT access.  Switch thinkpad-acpi brightness_mode
to use only ACPI DSDT ("CMOS" mode), and it should go away.  This should be
the default on all Lenovo, though.

Of course, this also mean you have nothing in userspace messing with the
RTC NVRAM's brightness bits, because if you do, you will still get bugs.

> @@ -2391,6 +2395,28 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
>  		case 1:
>  			/* 0x1000-0x1FFF: key presses */
>  			scancode = hkey & 0xfff;
> +			if (tp_features.bright_igdmode) {
> +				/* ToDo:
> +				 * Is there an already defined key?
> +				 */
> +				if (hkey == 0x1011) {
> +					if (ibm_backlight_device->
> +					    props.brightness > 0) {
> +						ibm_backlight_device->
> +							props.brightness--;
> +					}
> +				} else if (hkey == 0x1010) {
> +					if (ibm_backlight_device->
> +					    props.brightness <
> +					    ibm_backlight_device->
> +					    props.max_brightness) {
> +						ibm_backlight_device->
> +							props.brightness++;
> +					}
> +				}
> +				brightness_update_status(ibm_backlight_device);
> +			}
> +
>  			if (scancode > 0 && scancode < 0x21) {
>  				scancode--;
>  				if (!(hotkey_source_mask & (1 << scancode))) {

As I said, the above is NAK'd, except for the call to
brightness_update_status(ibm_backlight_device), which you should keep if it
is really needed.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
