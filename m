From: Len Brown <lenb@kernel.org>
Subject: Re: i915 build error if !CONFIG_ACPI
Date: Tue, 28 Oct 2008 00:52:52 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810280052370.24123@localhost.localdomain>
References: <d3f22a0810252040l31613b41s667ca94d8483093e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:34744 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbYJ1Ew4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Oct 2008 00:52:56 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9F000ZIMW71EG1@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 27 Oct 2008 23:52:56 -0500 (CDT)
In-reply-to: <d3f22a0810252040l31613b41s667ca94d8483093e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <lin@minggr.cn>
Cc: mjg@redhat.com, linux-acpi <linux-acpi@vger.kernel.org>

i like the fix i sent friday better,
it used inlines instead of ifdefs.

-len

On Sun, 26 Oct 2008, Lin Ming wrote:

> CC [M]  drivers/gpu/drm/i915/i915_opregion.o
> /usr/src/linux-2.6/drivers/gpu/drm/i915/i915_opregion.c: In function
> 'intel_opregion_init':
> /usr/src/linux-2.6/drivers/gpu/drm/i915/i915_opregion.c:340: error:
> implicit declaration of function 'register_acpi_notifier'
> /usr/src/linux-2.6/drivers/gpu/drm/i915/i915_opregion.c: In function
> 'intel_opregion_free':
> /usr/src/linux-2.6/drivers/gpu/drm/i915/i915_opregion.c:361: error:
> implicit declaration of function 'unregister_acpi_notifier'
> 
> How about below fix?
> ---
> 
>     fix build error if !CONFIG_ACPI
> 
>     Signed-off-by Lin Ming <lin@minggr.cn>
> ---
>  drivers/gpu/drm/i915/i915_opregion.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/i915_opregion.c
> b/drivers/gpu/drm/i915/i915_opregion.c
> index 1787a0c..9e51522 100644
> --- a/drivers/gpu/drm/i915/i915_opregion.c
> +++ b/drivers/gpu/drm/i915/i915_opregion.c
> @@ -25,7 +25,9 @@
>   *
>   */
> 
> +#ifdef CONFIG_ACPI
>  #include <linux/acpi.h>
> +#endif
> 
>  #include "drmP.h"
>  #include "i915_drm.h"
> @@ -280,9 +282,11 @@ int intel_opregion_video_event(struct
> notifier_block *nb, unsigned long val,
>  	return NOTIFY_OK;
>  }
> 
> +#ifdef CONFIG_ACPI
>  static struct notifier_block intel_opregion_notifier = {
>  	.notifier_call = intel_opregion_video_event,
>  };
> +#endif
> 
>  int intel_opregion_init(struct drm_device *dev)
>  {
> @@ -337,7 +341,9 @@ int intel_opregion_init(struct drm_device *dev)
>  	opregion->acpi->drdy = 1;
> 
>  	system_opregion = opregion;
> +#ifdef CONFIG_ACPI
>  	register_acpi_notifier(&intel_opregion_notifier);
> +#endif
> 
>  	return 0;
> 
> @@ -358,7 +364,9 @@ void intel_opregion_free(struct drm_device *dev)
>  	opregion->acpi->drdy = 0;
> 
>  	system_opregion = NULL;
> +#ifdef CONFIG_ACPI
>  	unregister_acpi_notifier(&intel_opregion_notifier);
> +#endif
> 
>  	/* just clear all opregion memory pointers now */
>  	iounmap(opregion->header);
> 
