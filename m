From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v3 6/7] ACPI: enable ACPI_DBG2_TABLE on ARM64
Date: Tue, 1 Mar 2016 06:52:43 -0800
Message-ID: <56D5ACBB.50408@hurleysoftware.com>
References: <1456749726-30261-1-git-send-email-aleksey.makarov@linaro.org>
 <1456749726-30261-7-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36077 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746AbcCAOwr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2016 09:52:47 -0500
Received: by mail-pf0-f177.google.com with SMTP id l6so16634573pfl.3
        for <linux-acpi@vger.kernel.org>; Tue, 01 Mar 2016 06:52:47 -0800 (PST)
In-Reply-To: <1456749726-30261-7-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-acpi@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Matthias Brugger <mbrugger@suse.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>

On 02/29/2016 04:42 AM, Aleksey Makarov wrote:
> SBBR mentions DBG2 as a mandatory ACPI table.
> So enable it for ARM64

Why does this have to be opted-in per-arch?


> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> ---
>  arch/arm64/Kconfig       | 1 +
>  arch/arm64/kernel/acpi.c | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 9dc5209..0b614d4 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -3,6 +3,7 @@ config ARM64
>  	select ACPI_CCA_REQUIRED if ACPI
>  	select ACPI_GENERIC_GSI if ACPI
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
> +	select ACPI_DBG2_TABLE if ACPI
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
>  	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
>  	select ARCH_HAS_ELF_RANDOMIZE
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index d1ce8e2..3370046 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -208,6 +208,8 @@ void __init acpi_boot_table_init(void)
>  		pr_err("Failed to init ACPI tables\n");
>  		if (!param_acpi_force)
>  			disable_acpi();
> +	} else {
> +		acpi_probe_device_table(dbg2);
>  	}
>  }
>  
> 

