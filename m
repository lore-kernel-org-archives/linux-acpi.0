From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/2] ACPI Check for backlight support via ACPI video.ko otherwise use vendor ACPI drivers
Date: Thu, 10 Jul 2008 11:07:09 +0100
Message-ID: <20080710100709.GA5017@srcf.ucam.org>
References: <200807031809.03172.trenn@suse.de> <200807091649.52605.trenn@suse.de> <20080709145758.GA22147@srcf.ucam.org> <200807091800.27608.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54082 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991AbYGJKHf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jul 2008 06:07:35 -0400
Content-Disposition: inline
In-Reply-To: <200807091800.27608.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, malattia@linux.it, stelian@popies.net, linux-next@vger.kernel.org, Corentin CHARY <corentincj@iksaif.net>, Lennart Poettering <mzxreary@0pointer.de>, Julia Jomantaite <julia.jomantaite@gmail.com>, corsac@debian.org, dannybaumann@web.de, marcus@better.se, Zhang Rui <rui.zhang@intel.com>, Hong Liu <hong.liu@intel.com>

On Wed, Jul 09, 2008 at 06:00:23PM +0200, Thomas Renninger wrote:
> ...
> > For this to work, the ACPI video driver needs to work as it currently
> > does. It is not correct for it to disable itself on IGD systems.
> Right, now I got it. It is only the T61/Lenovo you must have the opregion 
> driver ready or you better fallback to thinkpad_acpi...
> Is that correct?
> I will add a dmi check for Lenovo in video_detect.c.
> That would be:
>   - If ACPI Appendix B video brightness functions are found
>   |     -> use video.ko
>   |     |
>   |     -> If it's a ThinkPad, check for Opregion BIOS support
>   |           -> Use video.ko if IGD parts are implemented (and the one
>   |           |   ThinkPad specific func you had the 750ms delay is available)
>   |           -> otherwise go back to thinkpad_acpi

This is unnecessary logic. Let's just follow the spec. There's no need 
to use thinkpad_acpi here.

> Please also provide an OSI string with your video opregion code parts, so that 
> BIOS can check whether the kernel is capable of serving IGD devices. Just 
> choose a random string you like, e.g. let OSI("Opregion Video Support") 
> return true.

No. The DRM can be (and usually is) built as a module and OSI strings 
are going to be checked at ACPI init time. This can't be made to work 
correctly. Vendors can choose whether to use the opregion or old-style 
support based on whether the driver has enabled the support.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
