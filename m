From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v3 3/7] irqchip/gic: Convert the GIC driver to ACPI
 probing
Date: Tue, 29 Sep 2015 11:20:17 +0100
Message-ID: <20150929102017.GD30504@e104818-lin.cambridge.arm.com>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
 <1443451758-22717-4-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54402 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222AbbI2KUW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Sep 2015 06:20:22 -0400
Content-Disposition: inline
In-Reply-To: <1443451758-22717-4-git-send-email-marc.zyngier@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Hanjun Guo <hanjun.guo@linaro.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org

On Mon, Sep 28, 2015 at 03:49:14PM +0100, Marc Zyngier wrote:
> Now that we have a basic infrastructure to register irqchips and
> call them on discovery of a matching entry in MADT, convert the
> GIC driver to this new probing method.
> 
> It ends up being a code deletion party, which is a rather good thing.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/acpi.h        |  1 -
>  arch/arm64/include/asm/irq.h         |  2 --
>  arch/arm64/kernel/acpi.c             | 25 -------------
>  drivers/irqchip/irq-gic.c            | 69 ++++++++++++++++++------------------
>  drivers/irqchip/irqchip.c            |  3 --
>  include/linux/irqchip/arm-gic-acpi.h | 31 ----------------
>  6 files changed, 35 insertions(+), 96 deletions(-)
>  delete mode 100644 include/linux/irqchip/arm-gic-acpi.h

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
