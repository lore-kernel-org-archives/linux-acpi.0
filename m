From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] ACPI Check for backlight support via ACPI video.ko otherwise use vendor ACPI drivers
Date: Thu, 10 Jul 2008 13:00:34 +0200
Message-ID: <200807101300.37586.trenn@suse.de>
References: <200807031809.03172.trenn@suse.de> <200807091800.27608.trenn@suse.de> <20080710100709.GA5017@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:36176 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753451AbYGJLBQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Jul 2008 07:01:16 -0400
In-Reply-To: <20080710100709.GA5017@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, malattia@linux.it, stelian@popies.net, linux-next@vger.kernel.org, Corentin CHARY <corentincj@iksaif.net>, Lennart Poettering <mzxreary@0pointer.de>, Julia Jomantaite <julia.jomantaite@gmail.com>, corsac@debian.org, dannybaumann@web.de, marcus@better.se, Zhang Rui <rui.zhang@intel.com>, Hong Liu <hong.liu@intel.com>

On Thursday 10 July 2008 12:07:09 Matthew Garrett wrote:
> On Wed, Jul 09, 2008 at 06:00:23PM +0200, Thomas Renninger wrote:
> > ...
> >
> > > For this to work, the ACPI video driver needs to work as it currently
> > > does. It is not correct for it to disable itself on IGD systems.
> >
> > Right, now I got it. It is only the T61/Lenovo you must have the opregion
> > driver ready or you better fallback to thinkpad_acpi...
> > Is that correct?
> > I will add a dmi check for Lenovo in video_detect.c.
> > That would be:
> >   - If ACPI Appendix B video brightness functions are found
> >
> >   |     -> use video.ko
> >   |
> >   |     -> If it's a ThinkPad, check for Opregion BIOS support
> >   |           -> Use video.ko if IGD parts are implemented (and the one
> >   |
> >   |           |   ThinkPad specific func you had the 750ms delay is
> >   |           | available)
> >   |
> >   |           -> otherwise go back to thinkpad_acpi
>
> This is unnecessary logic. Let's just follow the spec. There's no need
> to use thinkpad_acpi here.
That is what will be the next version.
But two days ago, there was no IGD working driver and ThinkPads did not work 
with an IGD graphics device and video.ko without your dri extensions. In fact 
this was the "regression" (in fact it never worked) that blocked the "do not 
let the video driver poke on graphics devices for which no graphics card is 
plugged in" (Patch 1/2).

So there was a need for this.
In fact, my next version will still use thinkpad_acpi by default.
But this one will be based on a dmi blacklist. You mentioned ThinkPad BIOSes 
which are missing a specific function and cannot work with IGD? Please adjust 
the blacklist then to match those.

> > Please also provide an OSI string with your video opregion code parts, so
> > that BIOS can check whether the kernel is capable of serving IGD devices.
> > Just choose a random string you like, e.g. let OSI("Opregion Video
> > Support") return true.
>
> No. The DRM can be (and usually is) built as a module and OSI strings
> are going to be checked at ACPI init time. This can't be made to work
> correctly. Vendors can choose whether to use the opregion or old-style
> support based on whether the driver has enabled the support.
This has nothing to do with OS.
Just give vendors/BIOS developers the possibility to check whether the OS is 
capable of Opregion video support.
This is not necessary as long as Linux returns true for Windows strings.
There we cannot differ for  individual OSI features anyway.
But if we do not do it correct now, we will close the door to be spec 
compatible forever.

Thanks,

      Thomas
