From: "Roy Franz (HPE)" <roy.lists@gmail.com>
Subject: Re: [PATCH 3/3] arm64: defconfig: Enable ACPI
Date: Fri, 15 Apr 2016 09:17:15 -0700
Message-ID: <CAK-u0QkjH-UgPJ0C4UKePQQ-En+XgZigqJROwMFVfd0cQrbEkg@mail.gmail.com>
References: <1460706823-16566-1-git-send-email-broonie@kernel.org>
	<1460706823-16566-3-git-send-email-broonie@kernel.org>
Reply-To: roy.franz@hpe.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35402 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbcDOQRR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Apr 2016 12:17:17 -0400
Received: by mail-lf0-f66.google.com with SMTP id o124so17455827lfb.2
        for <linux-acpi@vger.kernel.org>; Fri, 15 Apr 2016 09:17:16 -0700 (PDT)
In-Reply-To: <1460706823-16566-3-git-send-email-broonie@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Len Brown <lenb@kernel.org>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>, Steve Capper <steve.capper@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, arm@kernel.org

On Fri, Apr 15, 2016 at 12:53 AM, Mark Brown <broonie@kernel.org> wrote:
> Enable ACPI by default to support testing of ACPI only systems and
> ensure that defconfig will boot on anything, for arm64 this is not done
> in Kconfig since a very large proportion of arm64 systems have no ACPI
> at all.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Roy Franz <roy.franz@hpe.com>

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index a44ef995d8ae..c5e0132eec57 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -264,6 +264,7 @@ CONFIG_PHY_RCAR_GEN3_USB2=y
>  CONFIG_PHY_HI6220_USB=y
>  CONFIG_PHY_XGENE=y
>  CONFIG_ARM_SCPI_PROTOCOL=y
> +CONFIG_ACPI=y
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT3_FS=y
>  CONFIG_FANOTIFY=y
> --
> 2.8.0.rc3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
