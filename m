From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/5] cpuidle / ACPI : remove unused definition
Date: Fri, 26 Oct 2012 01:31:09 +0200
Message-ID: <1753050.VjvrJt9oL3@vostro.rjw.lan>
References: <1350640292-22468-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:37905 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310Ab2JYX1N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Oct 2012 19:27:13 -0400
In-Reply-To: <1350640292-22468-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org

On Friday, October 19, 2012 11:51:28 AM Daniel Lezcano wrote:
> The different definitions are not used anywhere in the code.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

If you tried to build the kernel with this patch applied, I wonder
what .config you used. :-)

It doesn't build for me, because _COMPONENT is actually used.

And in the future, please check the *code* in addition to build-testing.

Thanks,
Rafael


> ---
>  drivers/acpi/processor_idle.c |    7 -------
>  1 files changed, 0 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index e8086c7..1f536a3 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -60,14 +60,7 @@
>  #include <asm/processor.h>
>  
>  #define PREFIX "ACPI: "
> -
> -#define ACPI_PROCESSOR_CLASS            "processor"
> -#define _COMPONENT              ACPI_PROCESSOR_COMPONENT
>  ACPI_MODULE_NAME("processor_idle");
> -#define PM_TIMER_TICK_NS		(1000000000ULL/PM_TIMER_FREQUENCY)
> -#define C2_OVERHEAD			1	/* 1us */
> -#define C3_OVERHEAD			1	/* 1us */
> -#define PM_TIMER_TICKS_TO_US(p)		(((p) * 1000)/(PM_TIMER_FREQUENCY/1000))
>  
>  static unsigned int max_cstate __read_mostly = ACPI_PROCESSOR_MAX_POWER;
>  module_param(max_cstate, uint, 0000);
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
