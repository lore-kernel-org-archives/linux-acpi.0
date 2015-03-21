From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v10 15/21] ARM64 / ACPI: Introduce ACPI_IRQ_MODEL_GIC and
 register device's gsi
Date: Sat, 21 Mar 2015 21:38:59 +0000
Message-ID: <20150321213859.GH22354@red-moon>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <1426077587-1561-16-git-send-email-hanjun.guo@linaro.org>
 <20150318184114.GL10863@arm.com>
 <550A465F.50701@huawei.com>
 <20150319101205.GB24556@red-moon>
 <20150319193724.GF4751@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150319193724.GF4751@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "guohanjun@huawei.com" <guohanjun@huawei.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Marc Zyngier <Marc.Zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-kernel@vger.kernel.or
List-Id: linux-acpi@vger.kernel.org

On Thu, Mar 19, 2015 at 07:37:24PM +0000, Will Deacon wrote:
> On Thu, Mar 19, 2015 at 10:12:05AM +0000, Lorenzo Pieralisi wrote:
> > On Thu, Mar 19, 2015 at 03:45:35AM +0000, Hanjun Guo wrote:
> > > >> +	if (trigger == ACPI_EDGE_SENSITIVE &&
> > > >> +				polarity == ACPI_ACTIVE_LOW)
> > > >> +		irq_type = IRQ_TYPE_EDGE_FALLING;
> > > >> +	else if (trigger == ACPI_EDGE_SENSITIVE &&
> > > >> +				polarity == ACPI_ACTIVE_HIGH)
> > > >> +		irq_type = IRQ_TYPE_EDGE_RISING;
> > > >> +	else if (trigger == ACPI_LEVEL_SENSITIVE &&
> > > >> +				polarity == ACPI_ACTIVE_LOW)
> > > >> +		irq_type = IRQ_TYPE_LEVEL_LOW;
> > > >> +	else if (trigger == ACPI_LEVEL_SENSITIVE &&
> > > >> +				polarity == ACPI_ACTIVE_HIGH)
> > > >> +		irq_type = IRQ_TYPE_LEVEL_HIGH;
> > > >> +	else
> > > >> +		irq_type = IRQ_TYPE_NONE;
> > > >> +
> > > >> +	/*
> > > >> +	 * Since only one GIC is supported in ACPI 5.0, we can
> > > >> +	 * create mapping refer to the default domain
> > > >> +	 */
> > > >> +	irq = irq_create_mapping(NULL, gsi);
> > > >> +	if (!irq)
> > > >> +		return irq;
> > > >> +
> > > >> +	/* Set irq type if specified and different than the current one */
> > > >> +	if (irq_type != IRQ_TYPE_NONE &&
> > > >> +		irq_type != irq_get_trigger_type(irq))
> > > >> +		irq_set_irq_type(irq, irq_type);
> > > >> +	return irq;
> > > >> +}
> > > >> +EXPORT_SYMBOL_GPL(acpi_register_gsi);
> > > > I see you've still got this buried in the arch code. Is there any plan to
> > > > move it out, as I moaned about this in the last version of the series and
> > > > nothing seems to have changed?
> > > 
> > > Ah, sorry. Last time when I was in Hongkong for LCA this Feb, I
> > > discussed with Lorenzo and he had a look into that too, he also met some
> > > obstacles to do that, so Lorenzo said that he will talk to you about
> > > this (Lorenzo, correct me if I'm wrong due to hearing problems of much
> > > noise in that room where we were talking).
> > > 
> > > Anyway, if we move those functions to core code, such as irqdomain code,
> > > which will be compiled for x86 too, we can only set those functions as
> > > _weak, or we guard with them as #ifdef CONFIG_ARM64 ... #endif, so for
> > > me, it's really not a big deal to move those code out of arch/arm64, but
> > > I'm still open for suggestions if you can do that in a proper way.
> > 
> > You heard me clear and sound in HK, Will has a point and I looked into
> > this. Code is generic but not enough to be useful on other arches at
> > the moment, I need more time to look into this and see if we can move
> > this code to acpi core in a way that makes sense, to have, as you say,
> > a "default" implementation.
> 
> Yeah, just something guarded by a CONFIG option (probably not ARM64
> though) would be enough, I think. Nothing too fancy.

I had a decent look and on x86/ia64 ACPI gsi mappings
(PIC/IOAPIC/IOSAPIC) are buried in arch code (not saying it is nice,
it is what it is at present).

We can try either to move this code to ACPI layer and make it
depend on CONFIG_ARM_GIC somehow, or move it to the GIC driver altogether.

I have to think about this, certainly it is not generic code at
present (or better it looks generic but can only work on ARM64 with
GIC IRQ model).

Lorenzo
