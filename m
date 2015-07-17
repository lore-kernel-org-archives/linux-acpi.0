From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [Linaro-acpi] [PATCH v3 0/8] Add self-probe infrastructure and
 stacked irqdomain support for ACPI based GICv2/3 init
Date: Fri, 17 Jul 2015 18:09:59 -0500
Message-ID: <CAOZdJXXxJxxc9KAQK1VY9iTTVdj-FbpFpoWcexGMrqOS0TgDEQ@mail.gmail.com>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33681 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbbGQXKD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jul 2015 19:10:03 -0400
In-Reply-To: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wei Huang <wei@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linaro-acpi@lists.linaro.org, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jul 10, 2015 at 5:45 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> This patch set introduce self-probe infrastructure to init IRQ
> controllers and stacked irqdomain support for ACPI based GICv2/3
> init.
>
> This patch set add its support for GIC verion which is introduced
> in ACPI 6.0, based on that, we introduce the self-probe infrastructure,
> the self-probe infrastructure for ACPI GIC init is similar as
> IRQCHIP_DECLARE() and based on the GIC version support in ACPI
> MADT table. we match the GIC version and GIC driver and load
> it.
>
> After the self-probe infrastructure is ready, I cleanuped the GICv2
> code to use the framework.
>
> Patch 4 implement the stacked irqdomain support for GICv2 based on
> the model of mapping interrupt and device in ACPI.
>
> Patch 5~8 are ACPI based GICv3 init.

All eight patches:

Tested-by: Timur Tabi <timur@codeaurora.org>
