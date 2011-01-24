From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: backlight gone?
Date: Mon, 24 Jan 2011 11:24:50 +0800
Message-ID: <1295839490.1866.798.camel@rui>
References: <20110124025720.GA25734@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3618 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041Ab1AXD0N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 23 Jan 2011 22:26:13 -0500
In-Reply-To: <20110124025720.GA25734@gamma.logic.tuwien.ac.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Norbert Preining <preining@logic.at>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

does this patch help?
https://patchwork.kernel.org/patch/499221/

thanks,
rui

On Mon, 2011-01-24 at 10:57 +0800, Norbert Preining wrote:
> Hi everyone,
> 
> I have seen that on lkml, too, and experience it myself: Suddenly the
> backlight is gone:
> [    2.018622] No ACPI video bus found
> up to 2.6.37 there was one ...
> 
> There are some other things regarding i915/drm in my dmesg:
> [    1.520109] [drm] Initialized drm 1.1.0 20060810
> [    1.520190] i915 0000:00:02.0: power state changed by ACPI to D0
> [    1.520246] i915 0000:00:02.0: power state changed by ACPI to D0
> [    1.520305] i915 0000:00:02.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
> [    1.520363] i915 0000:00:02.0: setting latency timer to 64
> [    1.572889] i915 0000:00:02.0: irq 43 for MSI/MSI-X
> [    1.572895] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
> [    1.572952] [drm] Driver supports precise vblank timestamp query.
> [    1.573312] [drm:intel_dsm_pci_probe] *ERROR* failed to get supported _DSM functions
> [    1.620092] vgaarb: device changed decodes: PCI:0000:00:02.0,olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [    2.015219] Console: switching to colour frame buffer device 200x56
> [    2.018568] fb0: inteldrmfb frame buffer device
> [    2.018590] drm: registered panic notifier
> [    2.018622] No ACPI video bus found
> [    2.018842] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on minor 0
> 
> That is with latest git kernel.
> 
> Anything else needed here?
> 
> Best wishes
> 
> Norbert
> ------------------------------------------------------------------------
> Norbert Preining            preining@{jaist.ac.jp, logic.at, debian.org}
> JAIST, Japan                                 TeX Live & Debian Developer
> DSA: 0x09C5B094   fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
> ------------------------------------------------------------------------
> BOOK	There is a theory which states that if ever anyone discovers
> 	exactly what the Universe is for and why it is here, it will
> 	instantly disappear and be replaced by something even more
> 	bizarrely inexeplicable.
> 	There is another theory which states that this has already happened.
>                  --- Introduction to Fit the Seventh.
>                  --- Douglas Adams, The Hitchhikers Guide to the Galaxy
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


