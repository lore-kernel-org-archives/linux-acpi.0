From: nokos@gmx.net
Subject: Re: [PATCH 5/9] fujitsu-laptop: fingers off backlight if video.ko
Date: Thu, 24 Jul 2008 02:12:47 +0200
Message-ID: <1216858367.29845.6.camel@earth.gruber.myown>
References: <200807180007.m6I07mxv032431@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:53168 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755129AbYGXAPi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Jul 2008 20:15:38 -0400
In-Reply-To: <200807180007.m6I07mxv032431@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

Hi Jonathan

Am Freitag, den 18.07.2008, 09:37 +0930 schrieb Jonathan Woithe: 
> Hi Peter
> 
> > Am Mittwoch, den 16.07.2008, 09:25 +0930 schrieb Jonathan Woithe:
> > > > > It is likely that everything works out with video.ko then.
> > > > > If not, with a patch I sent recently you should switch off Windows osi strings 
> > > > > with:
> > > > > acpi_osi=windows_false   (preferred)
> > > > > or (already works)
> > > > > acpi_osi="!Windows 2006"
> > > > 
> > > > disabling windows_osi disables backlight through video.ko and everything
> > > > works fine with fujitsu_laptop (also brightness-buttons since ACPI then
> > > > generates events on the fujitsu device) but some other ACPI stuff is
> > > > disabled too (extended battery status etc...)
> > > 
> > > As per my previous email, the fact that this works is probably because in
> > > this instance acpi_video_backlight_support() returns false and allows
> > > fujitsu-laptop to set up its backlight control functions.
> :
> > This behavior seems to be a recent change to the ACPI BIOS
> > implementation (its in the VIST table, and only takes effect if
> > osi("Windows 2006") returns true) ... its only my guess thats its hal
> > who is doing it (with debug="0xffff" on fujitsu_laptop I can verify that
> > somebody writes to /sys/class/backlight/fujitsu-laptop/brightness and
> > since it also happens without running windowing environment I suspect
> > hal). On the S6410 the acpi_osi="!Windows 2006" case probably resembled
> > the S7020 behavior.
> 
> Could you please re-test the S6410 with Thomas' latest patch revision?  I
> tested the S7020 overnight and it seems to work fine with this revision but
> I suspect the S6410 will still have trouble.  There were some logic fixes in
> this latest version though so a retest is probably worth it.

I have tested the lastest patch revision and now it works ... 
acpi_video_backlight_support() returns false and only the fujitsu driver
takes care of manipulating the brightness. Brightness buttons get reported by
video.ko. I don't exactly know if its only the new patchset since I also used 
a fresh pull of the kernel as basis.
Interestingly with acpi debug i get

Jul 21 12:16:27 kernel: nsutils-0454 [00] ns_build_internal_name: Returning [ffff88012d37a4b0] (rel) "_BCL"
Jul 21 12:16:27 kernel: nsaccess-0406 [00] ns_lookup             : Searching relative to prefix scope [LCD_] (ffff88012fc16000)
Jul 21 12:16:27 kernel: nsaccess-0516 [00] ns_lookup             : Simple Pathname (1 segment, Flags=2)
Jul 21 12:16:27 kernel: nsdump-0087 [00] ns_print_pathname     : [_BCL]
Jul 21 12:16:27 kernel: nssearch-0109 [00] ns_search_one_scope   : Searching \_SB_.PCI0.GFX0.LCD_ (ffff88012fc16000) For [_BCL] (Untyped)
Jul 21 12:16:27 kernel: nssearch-0144 [00] ns_search_one_scope   : Name [_BCL] (Method) ffff88012fc4e6c0 found in scope [LCD_] ffff88012fc16000
Jul 21 12:16:27 kernel: nsutils-0454 [00] ns_build_internal_name: Returning [ffff88012d37a4b0] (rel) "_BCM"
Jul 21 12:16:27 kernel: nsaccess-0406 [00] ns_lookup             : Searching relative to prefix scope [LCD_] (ffff88012fc16000)
Jul 21 12:16:27 kernel: nsaccess-0516 [00] ns_lookup             : Simple Pathname (1 segment, Flags=2)
Jul 21 12:16:27 kernel: nsdump-0087 [00] ns_print_pathname     : [_BCM]
Jul 21 12:16:27 kernel: nssearch-0109 [00] ns_search_one_scope   : Searching \_SB_.PCI0.GFX0.LCD_ (ffff88012fc16000) For [_BCM] (Untyped)
Jul 21 12:16:27 kernel: nssearch-0144 [00] ns_search_one_scope   : Name [_BCM] (Method) ffff88012fc4e6e0 found in scope [LCD_] ffff88012fc16000

so acpi somehow finds BCL, BCM etc. but nevertheless does video_detect report no backlight capability.

Peter

> Regards
>   jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

