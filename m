From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 1/2] ACPI Video: Ignore devices that aren't present in hardware
Date: Fri, 4 Jul 2008 12:08:02 +0200
Message-ID: <200807041208.04466.trenn@suse.de>
References: <200807031805.52883.trenn@suse.de> <200807031815.13291.trenn@suse.de> <20080703161643.GB29110@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:55772 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754616AbYGDKII (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 Jul 2008 06:08:08 -0400
In-Reply-To: <20080703161643.GB29110@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Julia Jomantaite <julia.jomantaite@gmail.com>, marcus@better.se, dannybaumann@web.de, corsac@debian.org

On Thursday 03 July 2008 18:16:43 you wrote:
> On Thu, Jul 03, 2008 at 06:15:11PM +0200, Thomas Renninger wrote:
> > On Thursday 03 July 2008 18:08:22 Matthew Garrett wrote:
> > > On Thu, Jul 03, 2008 at 06:05:51PM +0200, Thomas Renninger wrote:
> > > > Can these two go to linux-next or -mm, pls.
> > >
> > > Not until the opregion code is merged, no.
> >
> > Why?
>
> Because it's entirely plausible that it'll break existing systems.
In fact it is fixing a lot systems. Toshiba and Lenovo are not the only one
declaring a dummy ACPI graphics device.

In fact only T61 can work by accident on the wrong graphics device (given
the fact that vendors use the same name for graphics devices, Toshiba at
least does this):

/* a hack to fix the duplicate name "VID" problem on T61 */
        if (!strcmp(device->pnp.bus_id, "VID")) {
                if (instance)
                        device->pnp.bus_id[3] = '0' + instance;
                instance ++;
        }

All others which init two graphics devices with the same name (like on 
Toshiba) already try to set up identical proc entries.

So it is not entirely plausible that it'll break existing systems, it is very 
unlikely that any other system than T61 break (given the fact I didn't 
introduce a bug, which is not that unlikely).

Hmm, there might be IGD devices that could just work with the default 
backlight functions...
Your hint in the other mail to check for tche flag is  a good one..
Also there should be a switch to provide both directions via boot param:
 - force to use video.ko
 - force to use vendor specific
-> will not acpi_vendor=backlight,display_switching boot param but:
acpi_display_output=video/vendor_specific
acpi_backlight=video/vendor_specific

> > Try the next patch, it works for the T61.
> > These IGD parts could take quite a while still, while Toshibas and others
> > remain broken (and T61 poke on wrong hardware which could cause
> > all kind of badness).
>
> The code's written and works, it just has a 750ms latency for reasons I
> don't understand.
We have a broken situation for 2 kernel version now.
It looks like it could take some more time and then it's quite likely that 
there are systems with other issues.

As soon as your parts are finished we can easily remove the
ACPI_VIDEO_IGD
and add these graphics devices to the one which should be served by your 
modifications.

My patch(es) provide the possibility to do backlight switching in the old 
fashion which always worked. A switch that provides:
 - force to use video.ko
 - force to use vendor specific
should definitely go in with or before your modifications, because they much 
more likely will break systems and people do want to have a switch then.

Please explain me again why this should not go in before/with your patches.
If we agree that this one (or a similar solution) makes sense I am going to 
post a 2nd version soon and then I can help a bit with the 750 ms issue...

Even we only see this with graphics cards right now, the check whether a PCI 
device exists for an ACPI device declaration, should probably go into a more 
general place later. When an ACPI driver registers and _STA is evaluated, 
acpi_get_physical_pci_device() should be invoked for pci devices without _STA 
function.

    Thomas
