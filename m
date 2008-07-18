From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: [PATCH 5/9] fujitsu-laptop: fingers off backlight if video.ko
Date: Fri, 18 Jul 2008 09:37:48 +0930 (CST)
Message-ID: <200807180007.m6I07mxv032431@turbo.physics.adelaide.edu.au>
References: <1216218611.15766.15.camel@earth.gruber.myown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:52506 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758072AbYGRAH7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jul 2008 20:07:59 -0400
In-Reply-To: <1216218611.15766.15.camel@earth.gruber.myown> from "nokos@gmx.net" at Jul 16, 2008 04:30:11 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nokos@gmx.net
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Thomas Renninger <trenn@suse.de>, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

Hi Peter

> Am Mittwoch, den 16.07.2008, 09:25 +0930 schrieb Jonathan Woithe:
> > > > It is likely that everything works out with video.ko then.
> > > > If not, with a patch I sent recently you should switch off Windows osi strings 
> > > > with:
> > > > acpi_osi=windows_false   (preferred)
> > > > or (already works)
> > > > acpi_osi="!Windows 2006"
> > > 
> > > disabling windows_osi disables backlight through video.ko and everything
> > > works fine with fujitsu_laptop (also brightness-buttons since ACPI then
> > > generates events on the fujitsu device) but some other ACPI stuff is
> > > disabled too (extended battery status etc...)
> > 
> > As per my previous email, the fact that this works is probably because in
> > this instance acpi_video_backlight_support() returns false and allows
> > fujitsu-laptop to set up its backlight control functions.
:
> This behavior seems to be a recent change to the ACPI BIOS
> implementation (its in the VIST table, and only takes effect if
> osi("Windows 2006") returns true) ... its only my guess thats its hal
> who is doing it (with debug="0xffff" on fujitsu_laptop I can verify that
> somebody writes to /sys/class/backlight/fujitsu-laptop/brightness and
> since it also happens without running windowing environment I suspect
> hal). On the S6410 the acpi_osi="!Windows 2006" case probably resembled
> the S7020 behavior.

Could you please re-test the S6410 with Thomas' latest patch revision?  I
tested the S7020 overnight and it seems to work fine with this revision but
I suspect the S6410 will still have trouble.  There were some logic fixes in
this latest version though so a retest is probably worth it.

Regards
  jonathan
