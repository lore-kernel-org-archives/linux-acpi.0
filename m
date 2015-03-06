From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v9 16/21] irqchip: Add GICv2 specific ACPI boot support
Date: Fri, 06 Mar 2015 01:42:33 +0100
Message-ID: <2059307.pqvrarRxyo@vostro.rjw.lan>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org> <5921774.hkUTDjxi3A@vostro.rjw.lan> <20150305115322.GC7712@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59931 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752391AbbCFAS5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Mar 2015 19:18:57 -0500
In-Reply-To: <20150305115322.GC7712@e104818-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Mark Rutland <mark.rutland@arm.com>, linaro-acpi@lists.linaro.org, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Timur Tabi <timur@codeaurora.org>, linux-acpi@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Graeme Gregory <graeme.gregory@linaro.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com, Sudeep Holla <Sudeep.Holla@arm.com>, Olof Johansson <olof@lixom.net>

On Thursday, March 05, 2015 11:53:22 AM Catalin Marinas wrote:
> On Wed, Mar 04, 2015 at 11:50:36PM +0100, Rafael J. Wysocki wrote:
> > On Wednesday, February 25, 2015 04:39:56 PM Hanjun Guo wrote:

[cut]

> > > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > > index c03d8d1..e27117a 100644
> > > --- a/include/linux/acpi.h
> > > +++ b/include/linux/acpi.h
> > > @@ -557,6 +557,20 @@ static inline int acpi_device_modalias(struct device *dev,
> > >  
> > >  #endif	/* !CONFIG_ACPI */
> > >  
> > > +#if defined(CONFIG_ACPI) && defined(CONFIG_ARM64)
> > > +static inline void acpi_irq_init(void)
> > > +{
> > > +	/*
> > > +	 * Hardcode ACPI IRQ chip initialization to GICv2 for now.
> > > +	 * Proper irqchip infrastructure will be implemented along with
> > > +	 * incoming  GICv2m|GICv3|ITS bits.
> > > +	 */
> > > +	acpi_gic_init();
> > > +}
> > > +#else
> > > +static inline void acpi_irq_init(void) { }
> > > +#endif
> > 
> > I don't want this in a common header.
> 
> I don't like it either. What about adding it to a new header,
> linux/acpi_irq.h just for the dummy acpi_irq_init()? This would be
> similar to the DT equivalent, of_irq_init() in linux/of_irq.h and at
> some point it will gain more macros for declaring interrupt controllers
> in the ACPI context.
> 
> What we objected to previously was calling acpi_gic_init() directly from
> the core irqchip_init() and asked for something similar to the more
> generic of_irq_init(). The arm64-specific patch above is clearly a
> temporary hack until full support for multiple interrupt controllers is
> added (we asked for this several times in the past, but the ARM ACPI
> guys thought it's too much hassle ;). I don't fully get it since one of
> the platforms they target needs GICv2m support anyway).
> 
> Anyway, if we are to keep the temporary hack, I think we could define
> something like below (possibly in a new linux/acpi_irq.h which includes
> asm/irq.h):
> 
> #ifndef acpi_irq_init
> static inline void acpi_irq_init(void)
> {
> }
> #endif
> 
> And in the arm64 asm/irq.h:
> 
> static inline void acpi_irq_init(void)
> {
> 	/*
> 	 * Hardcode ACPI IRQ chip initialization to GICv2 for now.
> 	 * Proper irqchip infrastructure will be implemented along with
> 	 * incoming  GICv2m|GICv3|ITS bits.
> 	 */
> 	acpi_gic_init();
> }
> #define acpi_irq_init acpi_irq_init
> 
> When the new infrastructure is in place, we can get rid of the #ifndef
> and arm64-specific acpi_irq_init().

Well, that sounds much better than the original patch.

Rafael

