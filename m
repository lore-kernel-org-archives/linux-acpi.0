From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 03/11] irqchip / GIC: Add GIC version support in ACPI
 MADT
Date: Thu, 21 May 2015 16:39:25 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1505211632180.31710@nanos>
References: <1431953961-22706-1-git-send-email-hanjun.guo@linaro.org> <1431953961-22706-4-git-send-email-hanjun.guo@linaro.org> <alpine.DEB.2.11.1505202157190.4225@nanos> <555DE98A.2000909@linaro.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-5189304-1432219166=:31710"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38823 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309AbbEUOjX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 May 2015 10:39:23 -0400
In-Reply-To: <555DE98A.2000909@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jiang Liu <jiang.liu@linux.intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Grant Likely <grant.likely@linaro.org>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-5189304-1432219166=:31710
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 21 May 2015, Hanjun Guo wrote:
> On 2015年05月21日 04:02, Thomas Gleixner wrote:
> > On Mon, 18 May 2015, Hanjun Guo wrote:
> > > diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> > > index 65d6b93..855ead9 100644
> > > --- a/drivers/acpi/irq.c
> > > +++ b/drivers/acpi/irq.c
> > > @@ -32,6 +32,9 @@ void __init acpi_irqchip_init(void)
> > >   	if (acpi_disabled)
> > >   		return;
> > > 
> > > +	if (acpi_gic_version_init())
> > > +		return;
> > 
> > This looks just wrong. acpi_irqchip_init() is a generic ACPI function
> > and now you stick a GIC specific callback into it?
> 
> For now, acpi_irqchip_init() just introduced for GIC init, not for
> APIC init for x86, and I don't see the usage in the near future.
> 
> > 
> > What calls acpi_irqchip_init?
> 
> I renamed it as acpi_irq_init() in the later patch, which
> is called in irqchip_init() in drivers/irqchip/irqchip.c
> to init irqchip when DT is not available.

Neither of those names is a good choice as they suggest that this is a
generic acpi mechanism while in fact it is a GIC specific ACPI
extension. And its therefor wrong to put that code into drivers/acpi.

It belongs into drivers/irqchip/gic-acpi.c or some other descriptive
name.

Thanks,

	tglx








--8323329-5189304-1432219166=:31710--
