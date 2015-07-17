From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [RFCv2 PATCH 0/8] Introducing ACPI support for GICv2m
Date: Fri, 17 Jul 2015 16:46:34 +0100
Message-ID: <55A9235A.6010505@arm.com>
References: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49544 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbbGQPqi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Jul 2015 11:46:38 -0400
In-Reply-To: <1436778864-17645-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, "tglx@linutronix.de" <tglx@linutronix.de>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "tomasz.nowicki@linaro.org" <tomasz.nowicki@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "al.stone@linaro.org" <al.stone@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, "msalter@redhat.com" <msalter@redhat.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "leo.duran@amd.com" <leo.duran@amd.com>, "sherry.hurwitz@amd.com" <sherry.hurwitz@amd.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi Suravee,

On 13/07/15 10:14, Suravee Suthikulpanit wrote:
> ACPI core patches for ARM64 are now upstreamed in 4.1. The PCI support
> patches for ARM64 ACPI are also in progress. I am sending out this RFC to
> introduce ACPI support for GICv2m. This would allow MSI to work when
> booting ACPI.
> 
> There are some modifications to the irq_domain and acpi/gsi code.
> 
> Due to a large number of prerequisite patches, I have put together a branch
> on GitHub for review and testing:
> 
> 	https://github.com/ssuthiku/linux.git acpi-pci-msi-rfc2
> 
> This branch has been tested on AMD Seattle Platform. Any feedback and
> comments are appreciated.

I've had a look at this, and mostly the init_alloc_info method you
introduce. I have a few issues with the concept:

- The first thing that annoys me a tiny bit is that the bottom irqchip
(the GIC in your case) is allocating memory on the behalf of all the
others in the stack, while the actual users are sitting on top. It feels
really backward. Why can't this allocation be performed at the top of
the stack? The order of the request goes from top to bottom anyway, so
what am I missing?

- This gic_irq_alloc_info structure is completely GIC specific, and
contains things that don't make much sense to most domains. Here, it is
only useful to the GICv2m driver, but not to the top MSI layer. So why
should this structure be passed around across domains that don't care?

So I'd like to get back to the intent: why do you need to turn the logic
around? I understand that of_phandle_args is not ideal for ACPI, and I'm
happy to find ways around its limitations. But why do we need to reverse
the allocation logic and make this structure global along the stack,
rather than keeping it for local interaction at the frontier of two domains?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
