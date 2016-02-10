From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH V3 02/10] irqchip / GICv3: Add ACPI support for GICv3+
 initialization
Date: Wed, 10 Feb 2016 09:55:46 +0000
Message-ID: <56BB0922.3040507@arm.com>
References: <1453209083-3358-1-git-send-email-tn@semihalf.com>
 <1453209083-3358-3-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453209083-3358-3-git-send-email-tn@semihalf.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, guohanjun@huawei.com, Suravee.Suthikulpanit@amd.com
Cc: mw@semihalf.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com
List-Id: linux-acpi@vger.kernel.org

On 19/01/16 13:11, Tomasz Nowicki wrote:
> With the refator of gic_of_init(), GICv3/4 can be initialized
> by gic_init_bases() with gic distributor base address and gic
> redistributor region(s).
> 
> So get the redistributor region base addresses from MADT GIC
> redistributor subtable, and the distributor base address from
> GICD subtable to init GICv3 irqchip in ACPI way.
> 
> Note: GIC redistributor base address may also be provided in
> GICC structures on systems supporting GICv3 and above if the GIC
> Redistributors are not in the always-on power domain, this
> patch didn't implement such feature yet.
> Also, ACPI ITS initialization will be added in the following patches.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
