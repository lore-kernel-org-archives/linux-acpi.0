From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v3 part1 03/11] ARM64 : Add dummy asm/cpu.h
Date: Tue, 29 Apr 2014 10:40:55 +0100
Message-ID: <20140429094055.2FCBEC4095B@trevor.secretlab.ca>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
	<1398432017-8506-4-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:41474 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814AbaD2JlC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2014 05:41:02 -0400
Received: by mail-ee0-f53.google.com with SMTP id b57so94292eek.40
        for <linux-acpi@vger.kernel.org>; Tue, 29 Apr 2014 02:41:01 -0700 (PDT)
In-Reply-To: <1398432017-8506-4-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, Charles.Garcia-Tobin@arm.com, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>

On Fri, 25 Apr 2014 21:20:09 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> ACPI core requires a cpu.h, add a dummy one here temporarily.
> This file will be updated in the future to add definitions for
> arch_(un)register_cpu which are required for ACPI based physical
> CPU hotplug when these standards have be ratified by the ASWG.
> 
> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/include/asm/cpu.h |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 arch/arm64/include/asm/cpu.h

I think we're trying to get away from these empty header stubs by
putting them in asm-generic. Arnd, care to comment here?

g.

> 
> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
> new file mode 100644
> index 0000000..cee7d3f
> --- /dev/null
> +++ b/arch/arm64/include/asm/cpu.h
> @@ -0,0 +1,11 @@
> +/*
> + *  Copyright (C) 2013-2014 ARM Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#ifndef __ASM_CPU_H
> +#define __ASM_CPU_H
> +
> +#endif
> -- 
> 1.7.9.5
> 

