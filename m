From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 1/3] ACPI / ARM64: Don't enable ACPI by default on ARM64
Date: Sat, 16 Apr 2016 18:11:44 +0300
Message-ID: <57125630.9080305@cogentembedded.com>
References: <1460706823-16566-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35965 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbcDPPLr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Apr 2016 11:11:47 -0400
Received: by mail-lf0-f44.google.com with SMTP id g184so174976341lfb.3
        for <linux-acpi@vger.kernel.org>; Sat, 16 Apr 2016 08:11:46 -0700 (PDT)
In-Reply-To: <1460706823-16566-1-git-send-email-broonie@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Len Brown <lenb@kernel.org>, Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org, arm@kernel.org, linux-arm-kernel@lists.infradead.org

Hello.

On 4/15/2016 10:53 AM, Mark Brown wrote:

> If ACPI is selectable it is enabled by default.  This is a good choice
> for architectures where the overwhelming majority of systems use ACPI
> like x86 and IA-64 but is less clear for architectures where it's less
> common like ARM64.  Change the default selection so that it's only done
> explicitly on those architectures where ACPI is universally used.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   drivers/acpi/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 82b96ee8624c..2fcf87a6d270 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -8,7 +8,7 @@ menuconfig ACPI
>   	depends on IA64 || X86 || (ARM64 && EXPERT)
>   	depends on PCI
>   	select PNP
> -	default y
> +	default y if (IA64 || X86)

    Parens not needed.

[...]

MBR, Sergei

