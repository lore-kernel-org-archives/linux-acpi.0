From: Lukas Wunner <lukas@wunner.de>
Subject: Re: Notifications about ACPI events in userspace?
Date: Sun, 14 May 2017 10:11:05 +0200
Message-ID: <20170514081105.GB1255@wunner.de>
References: <71a48bf5-54b5-6d7b-d574-e0aa6c1acb80@butterbrot.org>
 <20170512100652.GA22013@wunner.de>
 <22eb7eab-21b0-aa5b-a989-0e4e80c707fb@butterbrot.org>
 <20170513121824.GA685@wunner.de>
 <35eb95e2-5876-5ed8-e8e9-6811fd656618@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:55387 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbdENILJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 14 May 2017 04:11:09 -0400
Content-Disposition: inline
In-Reply-To: <35eb95e2-5876-5ed8-e8e9-6811fd656618@butterbrot.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org, Henrik Rydberg <rydberg@bitmath.org>, Nicolas Boichat <nicolas@boichat.ch>

On Sat, May 13, 2017 at 06:47:16PM +0200, Florian Echtler wrote:
> On 13.05.2017 14:18, Lukas Wunner wrote:
> > 
> > So to sum it up, the built-in panel on the iMac can be driven by a
> > separate machine and we can switch between the two sources via the SMC.
> >
> > [...]
> >
> > I guess you could register a vga_switcheroo handler which controls
> > switching via the SMC.  You'd also have to register a vga_switcheroo
> > client whenever you detect hotplug of an external source (and unregister
> > on unplug).  The client is normally a DRM driver but would in this case
> > just be a pseudo device.
> > 
> > Then you could switch back and forth via the vga_switcheroo interface.
> 
> Hm... since there's no power switching of any kind involved, would that
> still make sense?

The handler's ->power_state hook would be a no-op.  Obviously not pretty,
but we just don't have a better abstraction yet.  We represent an egress
connector on a graphics card as a drm_connector in sysfs.  What we might
need is a representation of a sink (display) in sysfs with symlinks to the
sources.  Such a source could be a drm_connector or something else
entirely (a GPU on another machine in your case).


> > > Since I need to modify the applesmc.c driver anyway, it would probably
> > > make sense to integrate the notify handler there?
> > 
> > Sounds reasonable to me.
> 
> AFAICT, the alternative (which maybe would be more sensible, the more I
> think about it) would be to export applesmc_{read,write}_key as public
> symbols and just access them from a standalone driver for the APP000C
> ACPI device. Since that should only be present on a Mac that actually
> supports TDM, there's also no risk of writing to arbitrary SMC keys on
> unsupported devices.

That might make sense if you feel the driver will grow large enough to
make applesmc.c look messy, or if you feel it just doesn't fit there.

I guess the only reason why Apple integrated the functionality into the
SMC is because they wanted to support TDM when the machine is powered off.
The SMC is powered even in S5 (if the iMac is connected to AC), it just
needs to monitor HPD on the external port and turn on the backlight if
something is plugged in.  (I'm not sure if TDM is actually supported
during poweroff but technically it would seem to be supported.)

Otherwise I've got no opinion on that, adding Nicolas Boichat and Henrik
Rydberg to cc in case they have one.


> > Which iMac model are you developing this on exactly, a 2009/2010 model
> > (without Thunderbolt) or a newer one?  The newer ones can only be driven
> > via DP-over-Thunderbolt tunnels, so the HPD pin is coming from the
> > Thunderbolt controller, not the socket.  We don't have support for
> > setting up DP-over-Thunderbolt tunnels in thunderbolt.ko yet, only
> > PCIe-over-Thunderbolt is supported.  If the external source is already
> > present on boot, the tunnel may be established by the Thunderbolt EFI
> > driver but will be gone after unplug.
> 
> I have a 2009/2010 model, so no Thunderbolt.

Good!  Makes everything a lot simpler.

Thanks,

Lukas

> If someone is feeling adventurous
> with a Thunderbolt iMac, feel free to poke the SMC. I've written a short blog
> post that should be sufficient as background information for some initial
> experiments: http://floe.butterbrot.org/matrix/hacking/tdm/ and
> https://github.com/floe/smc_util (in particular, look at tdm_{on,off}.sh).
> 
> Best, Florian
> -- 
> SENT FROM MY DEC VT50 TERMINAL
> 
