From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v5 5/6] clocksource/drivers/arm_arch_timer: Simplify ACPI
 support code.
Date: Wed, 1 Jun 2016 11:03:41 -0500
Message-ID: <574F075D.1010007@codeaurora.org>
References: <1464096633-9309-1-git-send-email-fu.wei@linaro.org>
 <1464096633-9309-6-git-send-email-fu.wei@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53205 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970AbcFAQDt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jun 2016 12:03:49 -0400
In-Reply-To: <1464096633-9309-6-git-send-email-fu.wei@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: fu.wei@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de, marc.zyngier@arm.com, hanjun.guo@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rruigrok@codeaurora.org, harba@codeaurora.org, cov@codeaurora.org, graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com, wei@redhat.com, arnd@arndb.de, wim@iguana.be, catalin.marinas@arm.com, will.deacon@arm.com, Suravee.Suthikulpanit@amd.com, leo.duran@amd.com

fu.wei@linaro.org wrote:
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 47352d2..5a5baa1 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -8,6 +8,7 @@ config CLKSRC_OF
>   config CLKSRC_ACPI
>   	bool
>   	select CLKSRC_PROBE
> +	select ACPI_GTDT

I think this should be under the ARM64 Kconfig option 
(arch/arm64/Kconfig), perhaps like this:

	select ACPI_SPCR_TABLE if ACPI
+	select ACPI_GTDT if ACPI

We want GTDT to be parsed on ARM64 if we have ACPI, even if we don't 
have CLKSRC enabled.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation collaborative project.
