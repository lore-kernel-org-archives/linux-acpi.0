From: Lukas Wunner <lukas@wunner.de>
Subject: Re: Notifications about ACPI events in userspace?
Date: Sun, 14 May 2017 15:13:39 +0200
Message-ID: <20170514131339.GA1566@wunner.de>
References: <71a48bf5-54b5-6d7b-d574-e0aa6c1acb80@butterbrot.org>
 <20170512100652.GA22013@wunner.de>
 <22eb7eab-21b0-aa5b-a989-0e4e80c707fb@butterbrot.org>
 <20170513121824.GA685@wunner.de>
 <35eb95e2-5876-5ed8-e8e9-6811fd656618@butterbrot.org>
 <20170514081105.GB1255@wunner.de>
 <be932ef4-fbfb-2555-82b9-ba01b447ae7f@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:49589 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752989AbdENNNn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 14 May 2017 09:13:43 -0400
Content-Disposition: inline
In-Reply-To: <be932ef4-fbfb-2555-82b9-ba01b447ae7f@butterbrot.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, Henrik Rydberg <rydberg@bitmath.org>, Nicolas Boichat <nicolas@boichat.ch>

On Sun, May 14, 2017 at 11:25:48AM +0200, Florian Echtler wrote:
> On 14.05.2017 10:11, Lukas Wunner wrote:
> > On Sat, May 13, 2017 at 06:47:16PM +0200, Florian Echtler wrote:
> >> On 13.05.2017 14:18, Lukas Wunner wrote:
> >>> Then you could switch back and forth via the vga_switcheroo interface.
> >>
> >> Hm... since there's no power switching of any kind involved, would that
> >> still make sense?
> > 
> > The handler's ->power_state hook would be a no-op.  Obviously not pretty,
> > but we just don't have a better abstraction yet.  We represent an egress
> > connector on a graphics card as a drm_connector in sysfs.  What we might
> > need is a representation of a sink (display) in sysfs with symlinks to the
> > sources.  Such a source could be a drm_connector or something else
> > entirely (a GPU on another machine in your case).
> 
> OK, I think it's the closest thing that's already in the kernel, and before
> I add yet another custom sysfs node, vga_switcheroo is probably the easiest
> route to get things up and running.

Okay.  I'm only just now starting to get a vague idea how all this
may be represented properly.  On pre-Thunderbolt MacBook Pros it's
possible to switch the external DP port between GPUs independently
from the panel.  Right now we're switching both in unison, but if
we had a proper "sink with multiple sources" abstraction, we would
be able to support switching them separately.


> >> AFAICT, the alternative (which maybe would be more sensible, the more I
> >> think about it) would be to export applesmc_{read,write}_key as public
> >> symbols and just access them from a standalone driver for the APP000C
> >> ACPI device. Since that should only be present on a Mac that actually
> >> supports TDM, there's also no risk of writing to arbitrary SMC keys on
> >> unsupported devices.
> > 
> > That might make sense if you feel the driver will grow large enough to
> > make applesmc.c look messy, or if you feel it just doesn't fit there.
> 
> Everything else in applesmc.c is hwmon-related, IMHO it would be a kludge.
> So for applesmc, I'd just need a tiny patch to export the main key access
> functions, and everything else can (hopefully) be encapsulated in an
> "apple-tdm" driver.

Sounds reasonable.  You can probably copy/paste a lot of boilerplate
from apple-gmux.c and just bind to APP000C instead of APP000B.

You may need to add APP000C to acpi_pnp_device_ids[] in
drivers/acpi/acpi_pnp.c for the driver to bind to the device.

The vga_switcheroo "switch" file will appear in sysfs as soon as a
handler and 2 clients have registered.  The handler only needs to
implement the ->switchto and ->get_client_id hooks, all others are
optional.  The ->get_client_id hook should probably return
VGA_SWITCHEROO_IGD for the Nvidia GPU built into the iMac and
VGA_SWITCHEROO_DIS for the external port.

The vga_switcheroo_client is normally a PCI device, I guess you
could use the LPC bridge as a placeholder (the grandparent of the
APP000C device).  The ->set_gpu_state hook would be a no-op and
->can_switch could always return true.  If you register that client
whenever something is plugged in and unregister it on unplug, the
"switch" file in sysfs appears only as long as something is plugged in.


> > I guess the only reason why Apple integrated the functionality into the
> > SMC is because they wanted to support TDM when the machine is powered off.
> > The SMC is powered even in S5 (if the iMac is connected to AC), it just
> > needs to monitor HPD on the external port and turn on the backlight if
> > something is plugged in.  (I'm not sure if TDM is actually supported
> > during poweroff but technically it would seem to be supported.)
> 
> Hm, interesting, I hadn't yet thought of that. This would of course be
> excellent, because right now it looks like a waste of power to run the
> whole machine just because of the display.
> 
> Does the SMC have control over the backlight? Do you know which keys are
> responsible? IIRC the apple_bl.c driver didn't work on my iMac anyway...

The panel is attached to power rails which are only active in S0
(PP12V_S0_LCD and PP3V3_S0_VIDEO).

Conceivably, the SMC could sense HPD and bring up those power rails.
However various other things are hanging off of the same rails,
e.g. fan, memory, optical disk drive, and they would be powered up
as well.  Essentially the whole machine would boot, but perhaps
the EFI firmware senses if powerup was only triggered by DP hotplug
and not boot an OS.  Have you tested what happens if you plug
something in while the iMac is off?

Thanks,

Lukas
