From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH v10 7/7] ACPI : enable ACPI_PROCESSOR_IDLE on ARM64
Date: Fri, 29 Jul 2016 15:05:02 -0400
Message-ID: <579BA8DE.3050802@codeaurora.org>
References: <1468950779-21745-1-git-send-email-sudeep.holla@arm.com>
 <1468950779-21745-8-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44653 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbcG2TFK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Jul 2016 15:05:10 -0400
In-Reply-To: <1468950779-21745-8-git-send-email-sudeep.holla@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, ACPI List <linux-acpi@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Prashanth Prakash <pprakash@codeaurora.org>, Al Stone <al.stone@linaro.org>, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, ALKML <linux-arm-kernel@lists.infradead.org>, Sunil <sunil.vl@hpe.com>

Hi Sudeep,

On 07/19/2016 01:52 PM, Sudeep Holla wrote:
> Now that ACPI processor idle driver supports LPI(Low Power Idle), lets
> enable ACPI_PROCESSOR_IDLE for ARM64 too.
> 
> This patch just removes the IA64 and X86 dependency on ACPI_PROCESSOR_IDLE
> 
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1358fb7d7a68..d74275c0f374 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -238,7 +238,7 @@ config ACPI_CPPC_LIB
>  config ACPI_PROCESSOR
>  	tristate "Processor"
>  	depends on X86 || IA64 || ARM64
> -	select ACPI_PROCESSOR_IDLE if X86 || IA64
> +	select ACPI_PROCESSOR_IDLE
>  	select ACPI_CPU_FREQ_PSS if X86 || IA64
>  	default y
>  	help
> 

This causes a boot hang on QDF2432. cpuidle.off=1 works around the
problem. I understand you're working on a fix to the problem in GICv3
code. If there's anything I can do to help, please let me know.

Thanks,
Christopher Covington

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
