From: nokos@gmx.net
Subject: Re: [PATCH 5/9] fujitsu-laptop: fingers off backlight if video.ko
Date: Wed, 16 Jul 2008 16:30:11 +0200
Message-ID: <1216218611.15766.15.camel@earth.gruber.myown>
References: <200807152355.m6FNtMO7026981@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:57795 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751087AbYGPOaS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 10:30:18 -0400
In-Reply-To: <200807152355.m6FNtMO7026981@turbo.physics.adelaide.edu.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, jwoithe@physics.adelaide.edu.au, linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>

Am Mittwoch, den 16.07.2008, 09:25 +0930 schrieb Jonathan Woithe:
> > > It is likely that everything works out with video.ko then.
> > > If not, with a patch I sent recently you should switch off Windows osi strings 
> > > with:
> > > acpi_osi=windows_false   (preferred)
> > > or (already works)
> > > acpi_osi="!Windows 2006"
> > 
> > disabling windows_osi disables backlight through video.ko and everything
> > works fine with fujitsu_laptop (also brightness-buttons since ACPI then
> > generates events on the fujitsu device) but some other ACPI stuff is
> > disabled too (extended battery status etc...)
> 
> As per my previous email, the fact that this works is probably because in
> this instance acpi_video_backlight_support() returns false and allows
> fujitsu-laptop to set up its backlight control functions.
> 
> > > If it still does not work, then there is a driver missing which was  a 
> > > proprietary one on XP and which has not been fully re-engeeniered for Linux.
> > > 
> > > Using ACPI video events and pass them to the Fujitsu driver to change 
> > > backlight (is this how it works? Is this done through userspace?), mixes up 
> > > everything.
> > 
> > without acpi_osi="!Windows 2006" the buttons just produce ACPI video
> > events (recieved by video.ko) and hal does the adjustment through
> > fujitsu_laptop.ko
> 
> I guess video.ko receives them because they are ACPI video events.  However,
> as previously determined it doesn't do anything useful with them.  I'm a
> little surprised that the physical brightness adjustment comes from hal
> though.  On my S7020 the brightness changes brought about by the brightness
> buttons are seemingly done in hardware - the buttons have an effect even
> when fujitsu-laptop isn't loaded.  The brightness control functions in
> fujitsu-laptop were added primarily to allow *software* control of the
> brightness - something which definitely doesn't work without fujitsu-laptop.
> The generation of ACPI video brightness keypress events was added to
> fujitsu-laptop so userspace could keep track of changes instigated by the
> hardware buttons.

This behavior seems to be a recent change to the ACPI BIOS
implementation (its in the VIST table, and only takes effect if
osi("Windows 2006") returns true) ... its only my guess thats its hal
who is doing it (with debug="0xffff" on fujitsu_laptop I can verify that
somebody writes to /sys/class/backlight/fujitsu-laptop/brightness and
since it also happens without running windowing environment I suspect
hal). On the S6410 the acpi_osi="!Windows 2006" case probably resembled
the S7020 behavior.

> > The Problem is that video.ko only touches an otherwise unused ACPI
> > register but does not change the brightness... (you can just store a
> > number between 0 and 7 there)
> 
> Yes, which is why I'm fairly sure there's no risk of double-touching the
> hardware.  video.ko and fujitsu-laptop.ko are driving different hardware.
> 
> > Perhaps there is a way to disable the dysfunctional backlight stuff in 
> > video.ko but retain the ACPI video event handling?!
> 
> The problem with doing this is that it's only the platform-specific drivers
> which have the knowledge as to whether this is necessary or not.  video.ko
> would therefore have to query each loaded platform-specific module which
> seems messy to me.  If video.ko was loaded before the relevant
> platform-specific module it gets even messier.  I guess we could add a
> video.ko function like acpi_video_backlight_disable() which platform modules
> could call if they choose to handle the backlight.  However, this seems
> suboptimal to since it means video.ko sets up a backlight interface only to
> have to tear it down again soon after.  I guess it's no worse than setting
> up a backlight interface which never gets used though.

perhaps this can be done with a DMI based blacklist in video.ko, which
dis/enables the different parts of the module (backlight control, video
events ...)

Peter

