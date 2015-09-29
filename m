From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v3 3/7] irqchip/gic: Convert the GIC driver to ACPI probing
Date: Tue, 29 Sep 2015 23:01:31 +0800
Message-ID: <560AA7CB.7020600@linaro.org>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com> <1443451758-22717-4-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33438 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756435AbbI2PBj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Sep 2015 11:01:39 -0400
Received: by pacex6 with SMTP id ex6so8803023pac.0
        for <linux-acpi@vger.kernel.org>; Tue, 29 Sep 2015 08:01:39 -0700 (PDT)
In-Reply-To: <1443451758-22717-4-git-send-email-marc.zyngier@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 09/28/2015 10:49 PM, Marc Zyngier wrote:
> Now that we have a basic infrastructure to register irqchips and
> call them on discovery of a matching entry in MADT, convert the
> GIC driver to this new probing method.
>
> It ends up being a code deletion party, which is a rather good thing.
>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>   arch/arm64/include/asm/acpi.h        |  1 -
>   arch/arm64/include/asm/irq.h         |  2 --
>   arch/arm64/kernel/acpi.c             | 25 -------------
>   drivers/irqchip/irq-gic.c            | 69 ++++++++++++++++++------------------
>   drivers/irqchip/irqchip.c            |  3 --
>   include/linux/irqchip/arm-gic-acpi.h | 31 ----------------
>   6 files changed, 35 insertions(+), 96 deletions(-)
>   delete mode 100644 include/linux/irqchip/arm-gic-acpi.h

I love the code deletion party too :)

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
