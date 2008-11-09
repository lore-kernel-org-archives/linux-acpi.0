From: Thomas Renninger <trenn@suse.de>
Subject: Re: Can video_detect be made __init?
Date: Sun, 9 Nov 2008 13:20:04 +0100
Message-ID: <200811091320.05415.trenn@suse.de>
References: <200811081655.08226.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:40922 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754476AbYKIMUK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Nov 2008 07:20:10 -0500
In-Reply-To: <200811081655.08226.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, preining@logic.at

Hi,

First, thanks Len for adjusing the patches and taking them into your test 
tree.
Norbert: I tried your .config you sent recently and it compiles fine with
Len's ACPI test tree which now includes the patchset.

On Saturday 08 November 2008 02:55:07 pm Andrey Borzenkov wrote:
> I would add DMI entries to force vendor backlight for my system,
Why? video.ko is the way to go. Do you see regressions with that?

> but I'd really prefer they are not remain in memory forever.
You mean video.ko should give up access to the backlight interface and
e.g. toshiba.ko takes over at runtime?
Theoretically that may be possible, but practically this should not be 
implemented.
You must make sure all brightness functions got processed and unregister the 
backlight interface in video.ko, before you could re-register with a vendor 
specific driver. Rather complex without much gain.

> Is there any 
> reason for the whole detection to not happen exactly once? After all,
> ACPI cannot change after boot, can it?
It should only happen once:
acpi_video_backlight_support()
and
acpi_video_display_switch_support()
the funcs called from the brightness supporting drivers checks for:
        if (!acpi_video_caps_checked)
                acpi_video_get_capabilities(NULL);
which should do the real checking only once.
If you see that checking is done several times, it's a bug.
>
> Hmm ... actually DSDT can be loaded from initrd, so it can change ...
Checking is done after the DSDT got chosen, even if provided via initrd.
DSDT overriding is done far before entering userspace when the real
initrd tasks are processed (in userspace) and also far before video_detect.c 
gets active. That also is the reason why the DSDT override patch is not 
mainline, because it uses the initrd in a way it should not.

> in this case we actually are just interested in DMI matching which says
> whether vendor driver is preferred or not. What would be the the best
> place to call it from?
I do not understand this. Why are you only interested in dmi checking if
you override the DSDT?
DSDT overriding is for debugging only. Let's say you debug brightness
functionality, then you pass the boot param to either choose vendor.ko or
acpi_xy.ko brightness. Then you change DSDT again, you have to reboot anyway
and adjust the boot param again.
The dmi blacklist should stay empty in mainline as long as we find really 
broken _BCM, _BQC implementations.

Thanks (that I am not the only one looking at this),

     Thomas
