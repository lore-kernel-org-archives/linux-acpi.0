From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [intel/acpi] backlight - T61
Date: Mon, 01 Dec 2008 09:32:56 +0800
Message-ID: <1228095176.2713.18.camel@rzhang-dt>
References: <1227854824.3477.9.camel@hidalgo>
	 <alpine.LFD.2.00.0811281316390.3204@localhost.localdomain>
	 <1227912656.17845.5.camel@hidalgo>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29515 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627AbYLABee (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 30 Nov 2008 20:34:34 -0500
In-Reply-To: <1227912656.17845.5.camel@hidalgo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>, "jbarnes@virtuousgeek.org" <jbarnes@virtuousgeek.org>, Thomas Renninger <trenn@suse.de>, Matthew Garrett <mjg@redhat.com>, Keith Packard <keithp@keithp.com>

On Sat, 2008-11-29 at 06:50 +0800, Yves-Alexis Perez wrote:
> On ven, 2008-11-28 at 14:18 -0500, Len Brown wrote:
> > On Fri, 28 Nov 2008, Yves-Alexis Perez wrote:
> > 
> > > I'm running linux 2.6.28-rc6-00007-ged31348 on my Thinkpad T61, with
> > > Intel GM965. Under X, brightness keys work fine most of the time, but in
> > > some case it fails (for example after a dpms force off, but not always).
> > > Switching to console and back to X fix the problem for a time.
> > 
> > How to you invoke DPMS?
> 
> xorg.conf:
> Section "ServerFlags"
>   Option  "StandbyTime" "0"
>   Option  "SuspendTime" "0"
>   Option  "OffTime"   "5"
> EndSection
> > 
> > I'm running the latest 2.6.28 on top of FC9, and I find that
> > if I use the hot keys to dim the screen all the way,
> > and then I'm idle for a period, the screen pretends to go black.
> > (X foolishly paits the pixels black, but keeps the backlight on)
> > Then when I touch the mouse to wake it up, my screen unlock
> > prompt is at full brightness, and so is my screen when I unlock.
> > So it seems that X forgot that I set the brightness.
> > (though clicking the brightness hotkey shows the widget still
> >  thinks I'm at minimum brightness, so that part remembered...)
> > 
> > Now the backlight is totally screwed up.
> > I use the hotkeys to get to minimum brightness,
> > but something thinks I'm still at maximum brightness,
> > because after some idle time, the screen all by itself
> > goes bright.
> 
> Well I think that gnome-power-manager might be in your way, not sure.
> > 
> > > Another weird stuff is that, in single user, I have no way to control
> > > the backlight. Using brightness key doesn't work,
> > > and /sys/class/backlight/acpi_video0 doesn't do anything.
> > 
> > There are actually two text consoles -- CTRL-ALT-F1 while X is running
> > and single-user mode.
> > 
> > The hot keys have never worked for either of these modes.
> 
> Yes I know, that's why I'm asking here. They are not supposed to work
> atm because OpRegion needs X support. What I was asking is if there was
> something in cooking for that. But what puzzles me is that even
> the /sys/class/backlight/acpi_video0 doesn't work.
when poking the /sys/class/backlight/acpi_video0/, ACPI will do nothing
but notifying the graphics, only the i915 driver can change the
backlight if it's loaded.

> > 
> > I would hope that X (i915) should be able to handle brightness
> > in CTRL-ALT-F1 mode the same way that it does in GUI mode,
> > but that doesn't seem to be working.
> > 
> > Then there is single-user-mode, where X never ran
> > and the i915 may not even be loaded...
> > 
> > We used to have /sys/class/backlight and /proc/acpi/video
> > available and they used to work in single-user mode
> > (as well as in CTRL-ALT-F1) mode.  This was due to
> > there being two video devices.  Unfortunately, we deleted
> > the one what works in this scenario.
> > 
> > Try this patch, which brings it back.
> 
this (both X and ACPI cam control the backlight, in different ways) is
dangerous as we know,
and IMO, removing such interfaces and controlling backlight only in the
native graphics driver is what the IGD OpRegion designed for.

> No, I don't want to revert those patches, they are there for a reason.
> But yeah there is some console support missing, which may be working on.
> 
IMO, after loading i915 driver, the ACPI backlight I/F can work again,
right?
If this is true, why not always loading i915 both in X and console mode?
the kernel mode setting should not only work for X mode.

thanks,
rui

