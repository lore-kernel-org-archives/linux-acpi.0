From: Lukas Wunner <lukas@wunner.de>
Subject: Re: Notifications about ACPI events in userspace?
Date: Sat, 13 May 2017 14:18:24 +0200
Message-ID: <20170513121824.GA685@wunner.de>
References: <71a48bf5-54b5-6d7b-d574-e0aa6c1acb80@butterbrot.org>
 <20170512100652.GA22013@wunner.de>
 <22eb7eab-21b0-aa5b-a989-0e4e80c707fb@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:46899 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbdEMMRY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 13 May 2017 08:17:24 -0400
Content-Disposition: inline
In-Reply-To: <22eb7eab-21b0-aa5b-a989-0e4e80c707fb@butterbrot.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org

[cc += dri-devel]

On Fri, May 12, 2017 at 01:05:21PM +0200, Florian Echtler wrote:
> On 12.05.2017 12:06, Lukas Wunner wrote:
> > On Fri, May 12, 2017 at 10:37:47AM +0200, Florian Echtler wrote:
> >> I'm currently adding support for the iMac's target display mode (TDM) to
> >> Linux.
> >> However, I'm not seeing anything happening with either acpi_listen or
> >> kacpimon.
> >> Does this require any kernel changes, or could I subscribe to these
> >> events somehow?
> > 
> > You can subscribe to these events by calling acpi_install_notify_handler().
> > See drivers/platform/x86/apple-gmux.c for an example.  That's a driver for
> > APP000B, a custom chip found on dual-GPU MacBook Pros dubbed GMUX which is
> > responsible for multiplexing the panel between the GPUs.
> 
> OK, but this has to happen in a kernel context, correct? No way to see these
> from userspace?

So to sum it up, the built-in panel on the iMac can be driven by a
separate machine and we can switch between the two sources via the SMC.

Essentially this is the same setup as on dual GPU MacBook Pros which
(unlike muxless solutions such as Nvidia Optimus) can fully switch the
panel between GPUs.

I believe we don't have a proper abstraction yet in the DRM subsystem
to control a display which can be driven by multiple sources.  All we
have is the somewhat kludgy vga_switcheroo interface:  It allows manual
switching by writing commands to /sys/kernel/debug/vgaswitcheroo/switch
(see https://www.kernel.org/doc/html/latest/gpu/vga-switcheroo.html
and drivers/gpu/vga/vga_switcheroo.c).

I guess you could register a vga_switcheroo handler which controls
switching via the SMC.  You'd also have to register a vga_switcheroo
client whenever you detect hotplug of an external source (and unregister
on unplug).  The client is normally a DRM driver but would in this case
just be a pseudo device.

Then you could switch back and forth via the vga_switcheroo interface.

As to your question, yes, acpi_install_notify_handler() is called from
kernel space and you could pass through the event to user space e.g.
via udev.  Then the desktop environment could display an icon that an
additional source is present.

On macOS I can't find the "dppt" string in any kernel extension, but
it's present in this user space component:
/System/Library/LoginPlugins/BezelServices.loginPlugin/Contents/MacOS/BezelServices

Disassembling it reveals that it talks to a special Mach port to switch
the display but it's not listening to the Notify() events.  Perhaps this
is only used with BootCamp?

In any case the other end of the Mach port seems to be /usr/libexec/dpd.


> > I'm not sure what APP000C is, could be a similar custom controller, I'd
> > have to do some research first to know what it does.  Surely "DP" stands
> > for DisplayPort, but what does "PT" stand for?
> 
> I'm guessing DPPT is for "DisPlayPorT".

More like DisplayPort Pass-Through.


> As far as I could tell, it's just a stub
> for receiving the Notify() calls; the actual source switching is handled by
> writing to SMC keys.

Yes, the Notify() calls are used to generate some kind of interrupt,
perhaps one for hotplug and the other one for unplug?


> > Perhaps apple-gmux.c could serve as a template for an APP000C driver.
> > The code should be easy to understand, if you have questions just ask away.
> 
> Since I need to modify the applesmc.c driver anyway, it would probably make
> sense to integrate the notify handler there?

Sounds reasonable to me.

Which iMac model are you developing this on exactly, a 2009/2010 model
(without Thunderbolt) or a newer one?  The newer ones can only be driven
via DP-over-Thunderbolt tunnels, so the HPD pin is coming from the
Thunderbolt controller, not the socket.  We don't have support for
setting up DP-over-Thunderbolt tunnels in thunderbolt.ko yet, only
PCIe-over-Thunderbolt is supported.  If the external source is already
present on boot, the tunnel may be established by the Thunderbolt EFI
driver but will be gone after unplug.

Thanks,

Lukas
