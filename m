From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 6/6] pci, acpi: Share ACPI PCI config space accessors.
Date: Thu, 20 Nov 2014 15:26:50 -0700
Message-ID: <20141120222650.GC7987@google.com>
References: <1416413091-13452-1-git-send-email-tomasz.nowicki@linaro.org>
 <1416413091-13452-7-git-send-email-tomasz.nowicki@linaro.org>
 <2360791.Aj7tQ0nCJ3@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:60634 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756487AbaKTW0z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Nov 2014 17:26:55 -0500
Received: by mail-ie0-f182.google.com with SMTP id x19so3793003ier.27
        for <linux-acpi@vger.kernel.org>; Thu, 20 Nov 2014 14:26:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2360791.Aj7tQ0nCJ3@wuerfel>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, wangyijing@huawei.com, hanjun.guo@linaro.org, Liviu.Dudau@arm.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@rjwysocki.net, linaro-acpi@lists.linaro.org, linux-pci@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, Nov 19, 2014 at 05:19:20PM +0100, Arnd Bergmann wrote:
> On Wednesday 19 November 2014 17:04:51 Tomasz Nowicki wrote:
> > +/*
> > + * raw_pci_read/write - ACPI PCI config space accessors.
> > + *
> > + * ACPI spec defines MMCFG as the way we can access PCI config space,
> > + * so let MMCFG be default (__weak).
> > + *
> > + * If platform needs more fancy stuff, should provides its own implementation.
> > + */
> > +int __weak raw_pci_read(unsigned int domain, unsigned int bus,
> > +                       unsigned int devfn, int reg, int len, u32 *val)
> > +{
> > +       return pci_mmcfg_read(domain, bus, devfn, reg, len, val);
> > +}
> > +
> > +int __weak raw_pci_write(unsigned int domain, unsigned int bus,
> > +                        unsigned int devfn, int reg, int len, u32 val)
> > +{
> > +       return pci_mmcfg_write(domain, bus, devfn, reg, len, val);
> > +}
> > +
> > 
> 
> I think it would be better to avoid __weak functions here, as they tend
> to be hard to follow when trying to understand the code.

That's interesting.  I would have said exactly the opposite -- I think the
extra Kconfiggery is harder to follow than weak/strong functions :)

But consistency is better than my personal opinion.  Is there a consensus
that we should use the Kconfig strategy instead of __weak?

> How about using a Kconfig symbol like this:
> 
> #ifdef CONFIG_ARCH_RAW_PCI_READWRITE
> int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
>                  int reg, int len, u32 *val);
> int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
>                   int reg, int len, u32 val);
> #else
> static inline int raw_pci_read(unsigned int domain, unsigned int bus,
> 	                       unsigned int devfn, int reg, int len, u32 *val)
> {
> 	return pci_mmcfg_read(domain, bus, devfn, reg, len, val);
> }
> 
> static inline int raw_pci_write(unsigned int domain, unsigned int bus,
>              		                unsigned int devfn, int reg, int len, u32 val)
> {
>        return pci_mmcfg_write(domain, bus, devfn, reg, len, val);
> }
> #endif
