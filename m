From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v3 part1 02/11] ARM64 / ACPI: Introduce the skeleton of
 _PDC related for ARM64
Date: Tue, 29 Apr 2014 10:39:40 +0100
Message-ID: <20140429093941.02167C4095B@trevor.secretlab.ca>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
	<1398432017-8506-3-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:53466 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993AbaD2Jjq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2014 05:39:46 -0400
Received: by mail-ee0-f42.google.com with SMTP id d17so93891eek.29
        for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2014 02:39:44 -0700 (PDT)
In-Reply-To: <1398432017-8506-3-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, Charles.Garcia-Tobin@arm.com, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>, Al Stone <al.stone@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>

On Fri, 25 Apr 2014 21:20:08 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> The _PDC (Processor Driver Capabilities) object provides OSPM a
> mechanism to convey to the platform the capabilities supported
> by OSPM for processor power management.
> 
> OSPM evaluates _PDC prior to evaluating any other processor
> power management objects returning configuration information.
> 
> This patch introduces the skeleton of _PDC related file to make
> ACPI core can be compiled on ARM64, and should be revisited when
> implementing CPU power control.
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/include/asm/acpi.h |   37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 arch/arm64/include/asm/acpi.h
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> new file mode 100644
> index 0000000..e3e990e
> --- /dev/null
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -0,0 +1,37 @@
> +/*
> + *  Copyright (C) 2013~2014, Al Stone <al.stone@linaro.org>

Not really a correct copyright assignement. The copyright is held by
Linaro, but the author is Al. It should instead read:

 * Copyright (C0 2013-2014, Linaro Ltd.
 * Author: Al Stone <al.stone@linaro.org>

Acked-by: Grant Likely <grant.likely@linaro.org>

> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + *
> + *  This program is free software; you can redistribute it and/or modify
> + *  it under the terms of the GNU General Public License as published by
> + *  the Free Software Foundation; either version 2 of the License, or
> + *  (at your option) any later version.
> + *
> + *  This program is distributed in the hope that it will be useful,
> + *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *  GNU General Public License for more details.
> + *
> + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> + */
> +
> +#ifndef _ASM_ACPI_H
> +#define _ASM_ACPI_H
> +
> +static inline bool arch_has_acpi_pdc(void)
> +{
> +	/*
> +	 * Always false for now, should be revisited when
> +	 * implementing CPU power management
> +	 */
> +	return false;
> +}
> +
> +static inline void arch_acpi_set_pdc_bits(u32 *buf)
> +{
> +	/* Should be revisited when implementing CPU power management */
> +	return;
> +}
> +
> +#endif /*_ASM_ACPI_H*/
> -- 
> 1.7.9.5
> 

