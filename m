From: "R. J. Wysocki" <Rafal.Wysocki@fuw.edu.pl>
Subject: Re: Troubles waking up from suspend (S3) - how to debug?
Date: Mon, 28 Jan 2008 02:39:11 +0100
Message-ID: <200801280239.11581.Rafal.Wysocki@fuw.edu.pl>
References: <200801271842.38007.bonbons@linux-vserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.fuw.edu.pl ([193.0.80.14]:35663 "EHLO mail.fuw.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705AbYA1Ce1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Jan 2008 21:34:27 -0500
In-Reply-To: <200801271842.38007.bonbons@linux-vserver.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bruno =?iso-8859-1?q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sunday, 27 of January 2008, Bruno Pr=E9mont wrote:
> I'm currently trying out suspend (S3) on a few machines but none of t=
hem wakes=20
> up completely/properly (I have a few more hosts I'm planning to try s=
uspend=20
> on once I can get useful information out of those not waking up prope=
rly).
>=20
> Tested kernels: 2.6.24(-rc8), on one 2.6.23.8
>=20
> To suspend I enter the following from console:
>   echo -n mem > /sys/power/state
>=20

Please try s2ram (http://suspend.sf.net/s2ram-support.html).

> Fujitsu-Siemens S7020 laptop (i915GM based):
>   Works fine except backlight that remains asleep and Xorg vesa drive=
r
>   crashing Xorg.
>   It looks like a suspend cycle discards the VideoBIOS shadow copy.
>   Adjusting brightness using hotkeys or acpi-fujitsusiemens does not =
help
>   waking up the backlight.
>   At best backlight comes back when suspending from Xorg with
>   xf86-video-intel-2.2.x but then mode is distorded. Any attempt to f=
ix this
>   using xrandr or switch to/from console puts backlight asleep.

This one is on the s2ram whitelist, should work.

> Acer Travelmate 660 laptop (i855GM based):
>   Laptop suspends as expected but hangs while waking up.

This might work with "s2ram -f --vbe_post --vbe_save", please try.
=20
> Desktop with MSI nforce based mainboard with Athlon CPU, onboard grap=
hics

What kind?

> and hdd on HighPoint RR1640 PCI card (USB mouse & keyboard):
>   Suspends as expected but hangs while waking up.
>   During wakeup I can ping the computer but userspace does not respon=
d (e.g.
>   no answer when trying to connect via ssh)
>   The display remains off if using vga text console, display comes ba=
ck with
>   garbadge when using nvidiafb (no Xorg running), USB is powered but =
triggers
>   no reactions on keyboard/mouse input
>=20
>=20
> I tried using netconsole on the desktop computer to capture eventual =
printks=20
> during resume but I got not a line during wakup. (only suspend progre=
ss=20
> messages before actual suspend)
>=20
> What can I do to get more information out of those two last machines =
and find=20
> out why they don't wake-up properly?

Please apply the patches 01-11 from:
http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.24/patches/
on top of 2.6.24, compile the kernel and install it.  After booting, pl=
ease do:

# echo core > /sys/power/pm_test
# echo mem > /sys/power/state

and see if the boxes survive it (this causes the suspend/resume sequenc=
e to
be executed without acutally suspending, but busy-waiting for 5 sec. in=
stead).

Greetings,
Rafael
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
