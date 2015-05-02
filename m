From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH] drivers: acpi: make ACPI_PROCFS_POWER X86 only
Date: Sat, 02 May 2015 21:09:35 +0800
Message-ID: <5544CC8F.70203@linaro.org>
References: <1430476021-12247-1-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35104 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbEBNJn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 May 2015 09:09:43 -0400
Received: by pabtp1 with SMTP id tp1so117025024pab.2
        for <linux-acpi@vger.kernel.org>; Sat, 02 May 2015 06:09:43 -0700 (PDT)
In-Reply-To: <1430476021-12247-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 2015=E5=B9=B405=E6=9C=8801=E6=97=A5 18:27, Lorenzo Pieralisi wrote:
> The ACPI procfs power interface is initialized by compilation units
> that are only selectable on X86 platforms. Since its usage is
> deprecated and it cannot even be used on platforms other than X86
> it should be compiled in only on X86 platforms.
>
> This patch makes CONFIG_ACPI_PROCFS_POWER dependent on X86, so
> that other architectures are prevented from compiling it in for
> no purpose.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Lan Tianyu <tianyu.lan@intel.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>

I think this proc fs was not used for IA64 (it is
for server platform) too.

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

> ---
> Lan, Rafael,
>
> I do not see any reason why this option is allowed to be selected
> on platforms other than X86, so let's make it X86 only. Please let
> me know what you think, thanks.
>
> Lorenzo
>
>   drivers/acpi/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index ab2cbb5..16da185 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -62,7 +62,7 @@ config ACPI_SLEEP
>
>   config ACPI_PROCFS_POWER
>   	bool "Deprecated power /proc/acpi directories"
> -	depends on PROC_FS
> +	depends on X86 && PROC_FS
>   	help
>   	  For backwards compatibility, this option allows
>             deprecated power /proc/acpi/ directories to exist, even w=
hen
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
