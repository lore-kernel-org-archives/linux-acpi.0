From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 2/7] irqchip/acpi: Add probing infrastructure for
 ACPI-based irqchips
Date: Tue, 29 Sep 2015 11:19:57 +0100
Message-ID: <20150929101956.GC30504@e104818-lin.cambridge.arm.com>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
 <1443451758-22717-3-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54383 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222AbbI2KUD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Sep 2015 06:20:03 -0400
Content-Disposition: inline
In-Reply-To: <1443451758-22717-3-git-send-email-marc.zyngier@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org

On Mon, Sep 28, 2015 at 03:49:13PM +0100, Marc Zyngier wrote:
> DT enjoys a rather nice probing infrastructure for irqchips, while
> ACPI is so far stuck into a very distant past.
> 
> This patch introduces a declarative API, allowing irqchips to be
> self-contained and be called when a particular entry is matched
> in the MADT table.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/irq.h      | 11 -----------
>  drivers/irqchip/irqchip.c         |  8 +++++---
>  include/asm-generic/vmlinux.lds.h |  1 +
>  include/linux/acpi_irq.h          | 10 ----------
>  include/linux/irqchip.h           | 17 +++++++++++++++++
>  5 files changed, 23 insertions(+), 24 deletions(-)
>  delete mode 100644 include/linux/acpi_irq.h

For the arm64 part:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
