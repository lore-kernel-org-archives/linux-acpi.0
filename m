From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH 10/11] thinkpad_acpi: fingers off backlight if video.ko
	is serving this functionality
Date: Wed, 16 Jul 2008 09:40:44 -0300
Message-ID: <20080716124044.GA3329@khazad-dum.debian.net>
References: <1216205553-8486-1-git-send-email-trenn@suse.de> <1216205553-8486-11-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:52287 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753794AbYGPMks (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 08:40:48 -0400
Content-Disposition: inline
In-Reply-To: <1216205553-8486-11-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, corsac@debian.org, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it

On Wed, 16 Jul 2008, Thomas Renninger wrote:
> @@ -2337,6 +2341,28 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
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

NAK.   Sorry I didn't look it over in detail the last time you posted
this.

As per my golden rule for thinkpad-acpi (always have some way to let the
user disable such stuff, because it WILL break in some thinkpad), these
need to be configurable as a module parameter.

Extending brightness_mode (it is a bitmap) to let one force igd_mode
on and off would solve this detail.

Also, usually I would veto such automatic hotkey handling in the driver,
but since the firmware ALREADY does it on every IBM thinkpad anyway (and
I can't fix it since hotpatching DSDT in code is absolutely forbidden),
the driver has all facilities needed to deal with it.

One question: is there a good reason to actually have the hotkey
handling for IGD mode directly in thinkpad-acpi?  We don't do it for
Vista BIOS, video.ko doesn't do it either (anymore)... and I would make
it configurable for IBM firmware if I could.

Anyway, that means hotkey-driven igd_mode brightness change, if handled
by thinkpad-acpi without going through userspace, HAS to mask off the
relevant hotkeys in hotkey_init and set to KEY_RESERVED the relevant
keymap entries.   The code is there already, but it does mean you
need to factor out brightness_mode autodetection into a function
of its own, and have it run BEFORE hotkey_init and brightness_init
have a chance to run, because both will have to be in sync.

If you'd rather not have all that work, just add minimal support for igd
and the video stuff to thinkpad-acpi so that it doesn't get in the way
of your work, and I will follow up with whatever else enhancements are
needed.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
