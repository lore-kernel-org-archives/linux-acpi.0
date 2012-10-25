From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/5] cpuidle / ACPI : remove pointless headers
Date: Fri, 26 Oct 2012 01:36:18 +0200
Message-ID: <1993708.2VhgMUSPIE@vostro.rjw.lan>
References: <1350640292-22468-1-git-send-email-daniel.lezcano@linaro.org> <1350640292-22468-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:37917 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab2JYXcV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Oct 2012 19:32:21 -0400
In-Reply-To: <1350640292-22468-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org

On Friday, October 19, 2012 11:51:29 AM Daniel Lezcano wrote:
> These different headers are not needed.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

The kernel doesn't build for me with this patch applied (presumably
because the #defines from the previous patch were necessary after all).

Thanks,
Rafael


> ---
>  drivers/acpi/processor_idle.c |   13 -------------
>  1 files changed, 0 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 1f536a3..9aac69b 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -28,19 +28,10 @@
>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   */
>  
> -#include <linux/kernel.h>
>  #include <linux/module.h>
> -#include <linux/init.h>
> -#include <linux/cpufreq.h>
> -#include <linux/slab.h>
> -#include <linux/acpi.h>
>  #include <linux/dmi.h>
> -#include <linux/moduleparam.h>
> -#include <linux/sched.h>	/* need_resched() */
> -#include <linux/pm_qos.h>
>  #include <linux/clockchips.h>
>  #include <linux/cpuidle.h>
> -#include <linux/irqflags.h>
>  
>  /*
>   * Include the apic definitions for x86 to have the APIC timer related defines
> @@ -52,12 +43,8 @@
>  #include <asm/apic.h>
>  #endif
>  
> -#include <asm/io.h>
> -#include <asm/uaccess.h>
> -
>  #include <acpi/acpi_bus.h>
>  #include <acpi/processor.h>
> -#include <asm/processor.h>
>  
>  #define PREFIX "ACPI: "
>  ACPI_MODULE_NAME("processor_idle");
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
