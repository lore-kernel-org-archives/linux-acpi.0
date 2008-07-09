From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/2] ACPI Check for backlight support via ACPI video.ko otherwise use vendor ACPI drivers
Date: Wed, 9 Jul 2008 18:00:23 +0200
Message-ID: <200807091800.27608.trenn@suse.de>
References: <200807031809.03172.trenn@suse.de> <200807091649.52605.trenn@suse.de> <20080709145758.GA22147@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53887 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757922AbYGIQAc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Jul 2008 12:00:32 -0400
In-Reply-To: <20080709145758.GA22147@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: ak@linux.intel.com, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, malattia@linux.it, stelian@popies.net, linux-next@vger.kernel.org, Corentin CHARY <corentincj@iksaif.net>, Lennart Poettering <mzxreary@0pointer.de>, Julia Jomantaite <julia.jomantaite@gmail.com>, corsac@debian.org, dannybaumann@web.de, marcus@better.se, Zhang Rui <rui.zhang@intel.com>, Hong Liu <hong.liu@intel.com>

...
> For this to work, the ACPI video driver needs to work as it currently
> does. It is not correct for it to disable itself on IGD systems.
Right, now I got it. It is only the T61/Lenovo you must have the opregion 
driver ready or you better fallback to thinkpad_acpi...
Is that correct?
I will add a dmi check for Lenovo in video_detect.c.
That would be:
  - If ACPI Appendix B video brightness functions are found
  |     -> use video.ko
  |     |
  |     -> If it's a ThinkPad, check for Opregion BIOS support
  |           -> Use video.ko if IGD parts are implemented (and the one
  |           |   ThinkPad specific func you had the 750ms delay is available)
  |           -> otherwise go back to thinkpad_acpi
  |
  ->  Use vendor specific driver

FWIW, the IGD part to switch to vendor specific drivers can be deleted anyway 
if you say the IGD parts are working with your upcoming patches.

This would then be to use video.ko when detecting general brightness functions 
and otherwise let vendor specific drivers do it. No IGD check is necessary at 
all anymore.
The check for IGD was because ThinkPads did not work with video.ko then and 
this blocked the "check for physical graphics device" patch fixing a lot 
others.

Please also provide an OSI string with your video opregion code parts, so that 
BIOS can check whether the kernel is capable of serving IGD devices. Just 
choose a random string you like, e.g. let OSI("Opregion Video Support") 
return true.

    Thomas
