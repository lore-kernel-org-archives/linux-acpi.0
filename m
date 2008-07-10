From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 2/2] ACPI Check for backlight support via ACPI video.ko otherwise use vendor ACPI drivers
Date: Thu, 10 Jul 2008 12:09:41 +0100
Message-ID: <20080710110941.GC5017@srcf.ucam.org>
References: <200807031809.03172.trenn@suse.de> <200807091800.27608.trenn@suse.de> <20080710100709.GA5017@srcf.ucam.org> <200807101300.37586.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200807101300.37586.trenn@suse.de>
Sender: linux-next-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, malattia@linux.it, stelian@popies.net, linux-next@vger.kernel.org, Corentin CHARY <corentincj@iksaif.net>, Lennart Poettering <mzxreary@0pointer.de>, Julia Jomantaite <julia.jomantaite@gmail.com>, corsac@debian.org, dannybaumann@web.de, marcus@better.se, Zhang Rui <rui.zhang@intel.com>, Hong Liu <hong.liu@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jul 10, 2008 at 01:00:34PM +0200, Thomas Renninger wrote:
> On Thursday 10 July 2008 12:07:09 Matthew Garrett wrote:
> > This is unnecessary logic. Let's just follow the spec. There's no need
> > to use thinkpad_acpi here.
> That is what will be the next version.
> But two days ago, there was no IGD working driver and ThinkPads did not work 
> with an IGD graphics device and video.ko without your dri extensions. In fact 
> this was the "regression" (in fact it never worked) that blocked the "do not 
> let the video driver poke on graphics devices for which no graphics card is 
> plugged in" (Patch 1/2).

And now there is, so...

> So there was a need for this.
> In fact, my next version will still use thinkpad_acpi by default.
> But this one will be based on a dmi blacklist. You mentioned ThinkPad BIOSes 
> which are missing a specific function and cannot work with IGD? Please adjust 
> the blacklist then to match those.

No I didn't. Please don't do this - we have all the code needed to do it 
properly, so there's no need to use the thinkpad_acpi driver for 
backlight control on this hardware.

> > No. The DRM can be (and usually is) built as a module and OSI strings
> > are going to be checked at ACPI init time. This can't be made to work
> > correctly. Vendors can choose whether to use the opregion or old-style
> > support based on whether the driver has enabled the support.
> This has nothing to do with OS.
> Just give vendors/BIOS developers the possibility to check whether the OS is 
> capable of Opregion video support.

We can't. There's no way of telling whether the OS is capable of 
opregion video support until the drm module has been loaded, and any 
BIOS is going to have done its OSI checks at boot time.

> This is not necessary as long as Linux returns true for Windows strings.
> There we cannot differ for  individual OSI features anyway.
> But if we do not do it correct now, we will close the door to be spec 
> compatible forever.

The spec doesn't require an OSI string for this. Firmware that wants to 
know whether the OS is able to respond to opregion requests should do so 
by checking the specced opregion flags that the OS will set when it 
loads the driver.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
