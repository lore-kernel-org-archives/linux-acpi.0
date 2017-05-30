From: Lukas Wunner <lukas@wunner.de>
Subject: Re: iMac 10,1 with Ubuntu 16.04: black screen after suspend
Date: Tue, 30 May 2017 12:54:04 +0200
Message-ID: <20170530105404.GA29865@wunner.de>
References: <30380cb3-0f26-8aea-2689-d4886879129c@butterbrot.org>
 <20170526210340.GA5114@wunner.de>
 <1e60811b-a8ac-017c-d350-8a40e4323870@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:45707 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750867AbdE3KyG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 30 May 2017 06:54:06 -0400
Content-Disposition: inline
In-Reply-To: <1e60811b-a8ac-017c-d350-8a40e4323870@butterbrot.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org

On Tue, May 30, 2017 at 11:34:17AM +0200, Florian Echtler wrote:
> On 26.05.2017 23:03, Lukas Wunner wrote:
> > On Fri, May 26, 2017 at 02:13:29PM +0200, Florian Echtler wrote:
> >> I'm running Ubuntu 16.04.2 on a 27" unibody iMac 10,1 from 2009. However, even
> >> with the most recent HWE stack (kernel 4.8), the display stays black after
> >> suspend. I can ssh into the machine, so wakeup is OK, but the display is
> >> entirely black (backlight stays off).
> >>
> > The ATI card has MXM_PNL_PWR_EN and MXM_PNL_BL_EN pins.  Those must be
> > enabled for the panel to light up.  Perhaps radeon needs to be extended
> > to do that.  One theory is that this is done via ACPI, but perhaps
> > only if a certain operating system is running.  Dump the ACPI tables
> > and search DSDT and SSDT* tables for methods relating to the ATI card
> > and/or backlight.  If you find checks for OSDW there (e.g. in _PS0,
> > i.e. on resume), it means the AML code is only executed on Darwin.
> I've already had a look at the ACPI tables; there seem to be no references to
> the "official" backlight/display control functions (no _BL? or _DO? methods).
> 
> > Conversely !OSDW means the code is only executed on Windows (Boot Camp).
> > Linux masquerades as Darwin, but this can be disabled with
> > acpi_osi=!Darwin on the command line.  It's worth trying if that changes
> > the behaviour.  If it does, then macOS likely sets those pins on resume
> > and we need to do the same in radeon.
> There are OSDW checks present, however, booting with acpi_osi=!Darwin doesn't
> make a difference to the backlight behaviour.

So, just to confirm, if you never plug in an external DP source and the iMac
comes out of sleep, the display stays black?

If you log in via ssh and look at dmesg, was radeon able to train the DP
link again?  No error messages, nothing?

Is the panel off or is it on but merely with 0% brightness?

There's a block of pins on the GPU for "system management" which contains
a bunch of GPIO, OEM and reserved pins.  Three of these are used to control
the panel when it's switched to the radeon card:
pin 23	   PNL_PWR_EN
pin 25	   PNL_BL_EN
pin 27	   PNL_BL_PWM

Basically you'd need to know what these are set to before and after sleep.
I don't know how to access them, presumably via a BAR register.  A quick
look at the RV730-specific registers in drivers/gpu/drm/radeon/*.h did not
yield anything useful, but someone at AMD may be able to find this out.

Maybe these registers are supposed to be modified by the OS when coming
out of sleep, or they're modified by video BIOS but the OS has to trigger
this somehow.

HTH,

Lukas
