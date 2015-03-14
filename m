From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v10 16/21] irqchip: Add GICv2 specific ACPI boot support
Date: Sat, 14 Mar 2015 18:44:20 +0000
Message-ID: <20150314184420.GT21998@io.lakedaemon.net>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <1426077587-1561-17-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aso-006-i438.relay.mailchannels.net ([23.91.64.119]:12934 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751491AbbCNSol (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 14 Mar 2015 14:44:41 -0400
Content-Disposition: inline
In-Reply-To: <1426077587-1561-17-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Mar 11, 2015 at 08:39:42PM +0800, Hanjun Guo wrote:
> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> 
> ACPI kernel uses MADT table for proper GIC initialization. It needs to
> parse GIC related subtables, collect CPU interface and distributor
> addresses and call driver initialization function (which is hardware
> abstraction agnostic). In a similar way, FDT initialize GICv1/2.
> 
> NOTE: This commit allow to initialize GICv1/2 basic functionality.
> While now simple GICv2 init call is used, any further GIC features
> require generic infrastructure for proper ACPI irqchip initialization.
> That mechanism and stacked irqdomains to support GICv2 MSI/virtualization
> extension, GICv3/4 and its ITS are considered as next steps.
> 
> CC: Jason Cooper <jason@lakedaemon.net>
> CC: Marc Zyngier <marc.zyngier@arm.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Tested-by: Yijing Wang <wangyijing@huawei.com>
> Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
> Tested-by: Jon Masters <jcm@redhat.com>
> Tested-by: Timur Tabi <timur@codeaurora.org>
> Tested-by: Robert Richter <rrichter@cavium.com>
> Acked-by: Robert Richter <rrichter@cavium.com>
> Reviewed-by: Grant Likely <grant.likely@linaro.org>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  arch/arm64/include/asm/acpi.h        |   2 +
>  arch/arm64/include/asm/irq.h         |  13 +++++
>  arch/arm64/kernel/acpi.c             |  25 +++++++++
>  drivers/irqchip/irq-gic.c            | 102 +++++++++++++++++++++++++++++++++++
>  drivers/irqchip/irqchip.c            |   3 ++
>  include/linux/acpi_irq.h             |  10 ++++
>  include/linux/irqchip/arm-gic-acpi.h |  31 +++++++++++
>  7 files changed, 186 insertions(+)
>  create mode 100644 include/linux/acpi_irq.h
>  create mode 100644 include/linux/irqchip/arm-gic-acpi.h

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
