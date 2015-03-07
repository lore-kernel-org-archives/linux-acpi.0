From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v9 19/21] ARM64 / ACPI: Enable ARM64 in Kconfig
Date: Sat, 07 Mar 2015 23:17:03 +0000
Message-ID: <20150307231703.AB8E5C40C6A@trevor.secretlab.ca>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org>
	<1424853601-6675-20-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34737 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203AbbCGXRI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Mar 2015 18:17:08 -0500
Received: by wiwl15 with SMTP id l15so10913942wiw.1
        for <linux-acpi@vger.kernel.org>; Sat, 07 Mar 2015 15:17:07 -0800 (PST)
In-Reply-To: <1424853601-6675-20-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <al.stone@linaro.org>, Hanjun Guo <hanjun.guo@linaro.org>

On Wed, 25 Feb 2015 16:39:59 +0800
, Hanjun Guo <hanjun.guo@linaro.org>
 wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
> 
> Add Kconfigs to build ACPI on ARM64, and make ACPI available on ARM64.
> 
> acpi_idle driver is x86/IA64 dependent now, so make CONFIG_ACPI_PROCESSOR
> depend on X86 || IA64, and implement it on ARM64 in the future.
> 
> CC: Rafael J. Wysocki <rjw@rjwysocki.net>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> Reviewed-by: Grant Likely <grant.likely@linaro.org>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Grant Likely <grant.likely@linaro.org>

> ---
>  arch/arm64/Kconfig   | 2 ++
>  drivers/acpi/Kconfig | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index d00ab9a..e5aa081 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -713,6 +713,8 @@ source "drivers/Kconfig"
>  
>  source "drivers/firmware/Kconfig"
>  
> +source "drivers/acpi/Kconfig"
> +
>  source "fs/Kconfig"
>  
>  source "arch/arm64/kvm/Kconfig"
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index e6c3ddd..7aa3288 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -5,7 +5,7 @@
>  menuconfig ACPI
>  	bool "ACPI (Advanced Configuration and Power Interface) Support"
>  	depends on !IA64_HP_SIM
> -	depends on IA64 || X86
> +	depends on IA64 || X86 || (ARM64 && EXPERT)
>  	depends on PCI
>  	select PNP
>  	default y
> @@ -163,6 +163,7 @@ config ACPI_PROCESSOR
>  	tristate "Processor"
>  	select THERMAL
>  	select CPU_IDLE
> +	depends on X86 || IA64
>  	default y
>  	help
>  	  This driver installs ACPI as the idle handler for Linux and uses
> -- 
> 1.9.1
> 

