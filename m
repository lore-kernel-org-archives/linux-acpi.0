From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Check for ACPI backlight support otherwise use vendor
	ACPIdrivers - version 4
Date: Tue, 5 Aug 2008 10:37:48 -0300
Message-ID: <20080805133748.GC32675@khazad-dum.debian.net>
References: <1217605083-31003-1-git-send-email-trenn@suse.de> <1217812580.2969.184.camel@rzhang-dt> <1217830192.4580.8.camel@hidalgo> <200808041220.29892.trenn@suse.de> <20080805000151.GJ24927@khazad-dum.debian.net> <1217915753.8381.9.camel@hidalgo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58646 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755235AbYHENhx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Aug 2008 09:37:53 -0400
Content-Disposition: inline
In-Reply-To: <1217915753.8381.9.camel@hidalgo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Thomas Renninger <trenn@suse.de>, Zhang Rui <rui.zhang@intel.com>, ak@linux.intel.com, nokos@gmx.net, linux-acpi@vger.kernel.org, mjg59@srcf.ucam.org

On Tue, 05 Aug 2008, Yves-Alexis Perez wrote:
> On lun, 2008-08-04 at 21:01 -0300, Henrique de Moraes Holschuh wrote:
> > On Mon, 04 Aug 2008, Thomas Renninger wrote:
> > > On Monday 04 August 2008 08:09:52 Yves-Alexis Perez wrote:
> > > > When booting to single user with acpi_backlight=vendor, thinkpad-acpi
> > > > takes over backlight:
> > > >
> > > > Aug  4 07:54:38 hidalgo kernel:
> > > > thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
> > 
> > See that one?
> 
> Hmhm yeah but then I have:
> Aug  4 07:54:38 hidalgo kernel: thinkpad_acpi: Standard ACPI backlight interface not available, thinkpad_acpi driver will take over control

Two different subdrivers.  It would be better if I added subdriver
identification to all messages, I think.  hotkey is telling you it is not
issue brightness events.  brightness is telling you it is going to take over
control of brightness.

> > > > But when in user mode, brightness keys doesn't do anything either.
> > > > Echo'ing to /proc/acpi/ibm/brightness doesn't work, but echoing
> > > > to /sys/class/backlight/thinkpad_screen/brightness works.
> > > That /proc/acpi/ibm/brightness does not and
> > > /sys/class/backlight/thinkpad_screen/brightness 
> > > works is strange, this should be a bug?
> > 
> > No.  It is just that the driver expects ACPI video to be sending the events,
> > and it isn't, so you need to change some code in hotkey_init to stop
> > disabling brightness events in the (ACPI video support in DSDT, ACPI video
> > disabled and thinkpad-acpi is to handle the backlight) case.
> 
> Hmhm ok, so the thinkpad-acpi related patch miss some case handling
> anyway?

Yes.

> > Please check if updating hotkey_init doesn't solve the issue.  I am sorry I
> > didn't recall that detail to remind you about it when I looked your patches
> > over.
> 
> How should I update hotkey_init? Check for acpi_backlight=vendor and not
> disable brightness event?

Yes.  But Thomas will need to update his patch to do this, I think.  Unless
ACPI video is left active enough to pass on the ACPI video change events
(but I have no idea if the DSDT will still issue those events, etc).

Thomas?

> > > > Cat'ing /proc/acpi/events still gives:
> > > > video LCD0 00000086 00000000
> > > > video LCD0 00000087 00000000
> > > >
> > > > At one time I get the 750ms delay, but I don't have the
> > > > ibm/hotkey HKEY 00000080 00005010 at all.
> > 
> > This is caused by EC+ACPI DSDT access.  Switch thinkpad-acpi brightness_mode
> > to use only ACPI DSDT ("CMOS" mode), and it should go away.  This should be
> > the default on all Lenovo, though.
> 
> Hmmh, that's weird because I don't think I'm messing with the
> brightness_mode options. But I can force it to use only CMOS mode and
> test.

Well, please check it anyway.  I doubt it is that, but it can't hurt to
force brightness_mode to CMOS only.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
