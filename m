From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 00/11] Add self-probe infrastructure and stacked irqdomain
 support for ACPI based GICv2/3 init
Date: Tue, 02 Jun 2015 20:24:24 +0800
Message-ID: <556DA078.4020901@linaro.org>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36029 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437AbbFBMYi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Jun 2015 08:24:38 -0400
Received: by pdjm12 with SMTP id m12so48985396pdj.3
        for <linux-acpi@vger.kernel.org>; Tue, 02 Jun 2015 05:24:38 -0700 (PDT)
In-Reply-To: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Grant Likely <grant.likely@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

Hi Marc,

Ping, could you comment on if we are on the right direction
for this patch set? much appreciated.

Thanks
Hanjun

On 2015=E5=B9=B405=E6=9C=8818=E6=97=A5 20:59, Hanjun Guo wrote:
> This patch set introduce self-probe infrastructure to init IRQ
> controllers and stacked irqdomain support for ACPI based GICv2/3
> init.
>
> The self-probe infrastructure for ACPI GIC init is similar as
> IRQCHIP_DECLARE() and based on the GIC version support in ACPI
> MADT table.
>
> We introduce acpi_irq_domain for GICv2/3 core domain to support
> stacked irqdomain, and pass the gsi (global system interrupt) as
> the agument (void *arg) for gic_irq_domain_alloc(), then we can
> alloc virqs via acpi_register_gsi() with stacked irqdomain.
>
> In order to make ACPI related GIC init code slef-contained, I
> consolidated all the GIC init code into drivers/irqchip/irq-gic-acpi.=
c.
>
> update from RFC version:
>   - Consolidate all the GIC init code into drivers/irqchip/irq-gic-ac=
pi.c
>
> Hanjun Guo (8):
>    irqchip / GIC: Add GIC version support in ACPI MADT
>    irqchip / GIC / ACPI: Use IRQCHIP_ACPI_DECLARE to simplify GICv2 i=
nit
>      code
>    irqchip / gic: Add stacked irqdomain support for ACPI based GICv2 =
init
>    ACPI / gsi: Add gsi_mutex to synchronize
>      acpi_register_gsi()/acpi_unregister_gsi()
>    irqchip / GICv3: Add ACPI support for GICv3+ initialization
>    irqchip / GICv3: Add stacked irqdomain support for ACPI based init
>    irqchip / GICv2 / ACPI: Consolidate GICv2 ACPI related init code
>    irqchip / GICv3 / ACPI: Consolidate GICv3 ACPI related init code
>
> Tomasz Nowicki (3):
>    ACPICA: Introduce GIC version for arm based system
>    ACPI / irqchip: Add self-probe infrastructure to initialize IRQ
>      controller
>    irqchip / GICv3: Refactor gic_of_init() for GICv3 driver
>
>   arch/arm64/Kconfig                   |   1 +
>   arch/arm64/include/asm/irq.h         |  13 --
>   arch/arm64/kernel/acpi.c             |  25 ---
>   drivers/acpi/Makefile                |   1 +
>   drivers/acpi/gsi.c                   |  41 +++--
>   drivers/acpi/irq.c                   |  40 +++++
>   drivers/irqchip/Kconfig              |   3 +
>   drivers/irqchip/Makefile             |   1 +
>   drivers/irqchip/irq-gic-acpi.c       | 318 ++++++++++++++++++++++++=
+++++++++++
>   drivers/irqchip/irq-gic-v3.c         | 149 +++++++++-------
>   drivers/irqchip/irq-gic.c            | 129 ++------------
>   drivers/irqchip/irqchip.h            |  12 ++
>   include/acpi/actbl1.h                |  17 +-
>   include/asm-generic/vmlinux.lds.h    |  13 ++
>   include/linux/acpi.h                 |  14 ++
>   include/linux/acpi_irq.h             |   4 +-
>   include/linux/irqchip/arm-gic-acpi.h |  13 +-
>   include/linux/irqchip/arm-gic-v3.h   |  10 ++
>   include/linux/mod_devicetable.h      |   7 +
>   19 files changed, 577 insertions(+), 234 deletions(-)
>   create mode 100644 drivers/acpi/irq.c
>   create mode 100644 drivers/irqchip/irq-gic-acpi.c
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
