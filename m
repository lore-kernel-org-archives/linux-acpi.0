From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v3 7/7] clocksource: cosmetic: Drop OF 'dependency' from
 symbols
Date: Tue, 29 Sep 2015 23:14:54 +0800
Message-ID: <560AAAEE.3060406@linaro.org>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com> <1443451758-22717-8-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35067 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932445AbbI2PPD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Sep 2015 11:15:03 -0400
Received: by pacfv12 with SMTP id fv12so9169638pac.2
        for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2015 08:15:03 -0700 (PDT)
In-Reply-To: <1443451758-22717-8-git-send-email-marc.zyngier@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 09/28/2015 10:49 PM, Marc Zyngier wrote:
> Seeing the 'of' characters in a symbol that is being called from
> ACPI seems to freak out people. So let's do a bit of pointless
> renaming so that these folks do feel at home.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm/kernel/time.c                              | 2 +-
>   arch/arm/mach-omap2/timer.c                         | 4 ++--
>   arch/arm/mach-rockchip/rockchip.c                   | 2 +-
>   arch/arm/mach-shmobile/setup-r8a7779.c              | 2 +-
>   arch/arm/mach-shmobile/setup-rcar-gen2.c            | 2 +-
>   arch/arm/mach-spear/spear13xx.c                     | 2 +-
>   arch/arm/mach-sunxi/sunxi.c                         | 2 +-
>   arch/arm/mach-u300/core.c                           | 2 +-
>   arch/arm/mach-ux500/timer.c                         | 2 +-
>   arch/arm/mach-zynq/common.c                         | 2 +-
>   arch/arm64/kernel/time.c                            | 2 +-
>   arch/microblaze/kernel/setup.c                      | 2 +-
>   arch/mips/pistachio/time.c                          | 2 +-
>   arch/mips/ralink/clk.c                              | 2 +-
>   arch/nios2/kernel/time.c                            | 2 +-
>   arch/xtensa/kernel/time.c                           | 2 +-
>   drivers/clocksource/Makefile                        | 2 +-
>   drivers/clocksource/{clksrc-of.c => clksrc-probe.c} | 2 +-
>   include/linux/clocksource.h                         | 4 ++--
>   19 files changed, 21 insertions(+), 21 deletions(-)
>   rename drivers/clocksource/{clksrc-of.c => clksrc-probe.c} (97%)

Thanks for fixing my worrying of making ACPI depends on OF
in previous version, for patch 4/7 to patch 7/7,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
