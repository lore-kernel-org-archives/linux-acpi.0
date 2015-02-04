From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
Date: Wed, 04 Feb 2015 14:22:10 +0100
Message-ID: <1918367.3D21c7WuYp@vostro.rjw.lan>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org> <8901765.mLfPOCUyAN@vostro.rjw.lan> <20150204104832.GF8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58898 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965549AbbBDM7Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2015 07:59:16 -0500
In-Reply-To: <20150204104832.GF8656@n2100.arm.linux.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Salter <msalter@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Mark Langsdorf <mlangsdo@redhat.com>, linaro-acpi@lists.linaro.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, wangyijing@huawei.com, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-acpi@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org, Ashwin Chaugule <ashwinc@codeaurora.org>, Graeme Gregory <graeme.gregory@linaro>

On Wednesday, February 04, 2015 10:48:32 AM Russell King - ARM Linux wrote:
> On Tue, Feb 03, 2015 at 11:04:27PM +0100, Rafael J. Wysocki wrote:
> > On Tuesday, February 03, 2015 12:29:36 PM Mark Salter wrote:
> > > On Mon, 2015-02-02 at 23:14 +0100, Rafael J. Wysocki wrote:
> > > > On Monday, February 02, 2015 08:45:30 PM Hanjun Guo wrote:
> > > > > From: Mark Salter <msalter@redhat.com>
> > > > > 
> > > > > The acpi_os_ioremap() function may be used to map normal RAM or IO
> > > > > regions. The current implementation simply uses ioremap_cache(). This
> > > > > will work for some architectures, but arm64 ioremap_cache() cannot be
> > > > > used to map IO regions which don't support caching. So for arm64, use
> > > > > ioremap() for non-RAM regions.
> > > > > 
> > > > > CC: Rafael J Wysocki <rjw@rjwysocki.net>
> > > > > Signed-off-by: Mark Salter <msalter@redhat.com>
> > > > > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > > > > ---
> > > > >  include/acpi/acpi_io.h | 6 ++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > > 
> > > > > diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
> > > > > index 444671e..9d573db 100644
> > > > > --- a/include/acpi/acpi_io.h
> > > > > +++ b/include/acpi/acpi_io.h
> > > > > @@ -1,11 +1,17 @@
> > > > >  #ifndef _ACPI_IO_H_
> > > > >  #define _ACPI_IO_H_
> > > > >  
> > > > > +#include <linux/mm.h>
> > > > >  #include <linux/io.h>
> > > > >  
> > > > >  static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> > > > >  					    acpi_size size)
> > > > >  {
> > > > > +#ifdef CONFIG_ARM64
> > > > > +	if (!page_is_ram(phys >> PAGE_SHIFT))
> > > > > +		return ioremap(phys, size);
> > > > > +#endif
> > > > 
> > > > I don't want to see #ifdef CONFIG_ARM64 in this file.
> > > > 
> > > 
> > > How about something like:
> > > 
> > > From: Mark Salter <msalter@redhat.com>
> > > Date: Tue, 3 Feb 2015 10:51:16 -0500
> > > Subject: [PATCH] acpi: fix acpi_os_ioremap for arm64
> > > 
> > > The acpi_os_ioremap() function may be used to map normal RAM or IO
> > > regions. The current implementation simply uses ioremap_cache(). This
> > > will work for some architectures, but arm64 ioremap_cache() cannot be
> > > used to map IO regions which don't support caching. So for arm64, use
> > > ioremap() for non-RAM regions.
> > > 
> > > CC: Rafael J Wysocki <rjw@rjwysocki.net>
> > > Signed-off-by: Mark Salter <msalter@redhat.com>
> > > ---
> > >  arch/arm64/include/asm/acpi.h | 14 ++++++++++++++
> > >  include/acpi/acpi_io.h        |  3 +++
> > >  2 files changed, 17 insertions(+)
> > > 
> > > diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> > > index ea4d2b3..db82bc3 100644
> > > --- a/arch/arm64/include/asm/acpi.h
> > > +++ b/arch/arm64/include/asm/acpi.h
> > > @@ -14,6 +14,7 @@
> > >  
> > >  #include <linux/irqchip/arm-gic-acpi.h>
> > >  
> > > +#include <linux/mm.h>
> > >  #include <asm/smp_plat.h>
> > >  
> > >  /* Basic configuration for ACPI */
> > > @@ -100,4 +101,17 @@ static inline bool acpi_psci_use_hvc(void) { return false; }
> > >  static inline void acpi_init_cpus(void) { }
> > >  #endif /* CONFIG_ACPI */
> > >  
> > > +/*
> > > + * ACPI table mapping
> > > + */
> > > +static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> > > +					    acpi_size size)
> > > +{
> > > +	if (!page_is_ram(phys >> PAGE_SHIFT))
> > > +		return ioremap(phys, size);
> > > +
> > > +       return ioremap_cache(phys, size);
> > > +}
> > > +#define acpi_os_ioremap acpi_os_ioremap
> > 
> > If you want to do it this way, use __weak.  You won't need the #define then.
> > Otherwise, please use a proper CONFIG_ARCH_ symbol.
> 
> How does __weak work with inline functions?  I don't believe it does.

It doesn't work with inline funtions, but the function here doesn't have to be
inline.

> Moreover, __weak is positively harmful when you consider it adds bloat
> and dead code - the overriden __weak function is left behind in the
> resulting final image.

Fair enough.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
