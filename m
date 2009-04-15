From: Niel Lambrechts <niel.lambrechts@gmail.com>
Subject: Re: 2.6.30-rc1 (latest git): thinkpad-acpi: cannot control brightness
 with hotkeys (BISECTED)
Date: Wed, 15 Apr 2009 21:55:55 +0200
Message-ID: <49E63BCB.9090801@gmail.com>
References: <49E10684.5090101@gmail.com> <20090411150555.8b13ed18.akpm@linux-foundation.org> <20090412161448.GC26502@khazad-dum.debian.net> <49E234ED.5010105@gmail.com> <1239585695.5564.5.camel@localhost.localdomain> <49E3575A.60204@gmail.com> <20090413203450.GC16152@khazad-dum.debian.net> <49E5234E.5070303@gmail.com> <20090415164939.GA27807@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:53293 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360AbZDOT4T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Apr 2009 15:56:19 -0400
In-Reply-To: <20090415164939.GA27807@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, yakui_zhao <yakui.zhao@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "linux.kernel" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 04/15/2009 06:49 PM, Matthew Garrett wrote:
> Does this help?
>
> diff --git a/drivers/gpu/drm/i915/i915_opregion.c b/drivers/gpu/drm/i915/i915_opregion.c
> index 6942772..8dc1fd3 100644
> --- a/drivers/gpu/drm/i915/i915_opregion.c
> +++ b/drivers/gpu/drm/i915/i915_opregion.c
> @@ -370,11 +370,8 @@ int intel_opregion_init(struct drm_device *dev, int resume
>   
Hi Matthew,

Yes please, after your patch the brightness can be adjusted again. :)

The behaviour seems slightly different from before your 74a365b3f354
commit in that /sys/class/backlight remains empty until i915 gets loaded
for the first time, the contents then persist even if i915 is unloaded.
Perhaps the directory was populated by a different kernel module, since
when I did the bisect yesterday the directory would be there on boot
before I started X or loaded i915.

 I'm not sure if that matters to any other user-space app. (or if
ideally one is supposed to be able to control brightness in the console
without having to load i915), but it's fine for controlling brightness
in Xorg.

Thanks,
Niel
