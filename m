From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/3] ACPI / ARM64: Don't enable ACPI by default on ARM64
Date: Thu, 21 Apr 2016 02:10:47 +0200
Message-ID: <9772131.95BO0QMhPX@vostro.rjw.lan>
References: <1460706823-16566-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:59284 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751341AbcDUAH4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Apr 2016 20:07:56 -0400
In-Reply-To: <1460706823-16566-1-git-send-email-broonie@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Len Brown <lenb@kernel.org>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arm@kernel.org

On Friday, April 15, 2016 08:53:41 AM Mark Brown wrote:
> If ACPI is selectable it is enabled by default.  This is a good choice
> for architectures where the overwhelming majority of systems use ACPI
> like x86 and IA-64 but is less clear for architectures where it's less
> common like ARM64.  Change the default selection so that it's only done
> explicitly on those architectures where ACPI is universally used.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/acpi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 82b96ee8624c..2fcf87a6d270 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -8,7 +8,7 @@ menuconfig ACPI
>  	depends on IA64 || X86 || (ARM64 && EXPERT)
>  	depends on PCI
>  	select PNP
> -	default y
> +	default y if (IA64 || X86)
>  	help
>  	  Advanced Configuration and Power Interface (ACPI) support for 
>  	  Linux requires an ACPI-compliant platform (hardware/firmware),
> 

Everyone seems to be fine with the whole series, so I'm going to apply it.

Thanks,
Rafael

