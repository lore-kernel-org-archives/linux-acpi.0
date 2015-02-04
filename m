From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
Date: Wed, 4 Feb 2015 11:25:08 +0000
Message-ID: <20150204112508.GB26006@e104818-lin.cambridge.arm.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-3-git-send-email-hanjun.guo@linaro.org>
 <2422968.Es7R0p3loO@vostro.rjw.lan>
 <1422984576.18187.82.camel@deneb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:41030 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbbBDLZV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2015 06:25:21 -0500
Content-Disposition: inline
In-Reply-To: <1422984576.18187.82.camel@deneb.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <Mark.Rutland@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaur>

On Tue, Feb 03, 2015 at 05:29:36PM +0000, Mark Salter wrote:
> On Mon, 2015-02-02 at 23:14 +0100, Rafael J. Wysocki wrote:
> > On Monday, February 02, 2015 08:45:30 PM Hanjun Guo wrote:
> > > From: Mark Salter <msalter@redhat.com>
> > > 
> > > The acpi_os_ioremap() function may be used to map normal RAM or IO
> > > regions. The current implementation simply uses ioremap_cache(). This
> > > will work for some architectures, but arm64 ioremap_cache() cannot be
> > > used to map IO regions which don't support caching. So for arm64, use
> > > ioremap() for non-RAM regions.
> > > 
> > > CC: Rafael J Wysocki <rjw@rjwysocki.net>
> > > Signed-off-by: Mark Salter <msalter@redhat.com>
> > > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > > ---
> > >  include/acpi/acpi_io.h | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
> > > index 444671e..9d573db 100644
> > > --- a/include/acpi/acpi_io.h
> > > +++ b/include/acpi/acpi_io.h
> > > @@ -1,11 +1,17 @@
> > >  #ifndef _ACPI_IO_H_
> > >  #define _ACPI_IO_H_
> > >  
> > > +#include <linux/mm.h>
> > >  #include <linux/io.h>
> > >  
> > >  static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> > >  					    acpi_size size)
> > >  {
> > > +#ifdef CONFIG_ARM64
> > > +	if (!page_is_ram(phys >> PAGE_SHIFT))
> > > +		return ioremap(phys, size);
> > > +#endif
> > 
> > I don't want to see #ifdef CONFIG_ARM64 in this file.
> 
> How about something like:
> 
> From: Mark Salter <msalter@redhat.com>
> Date: Tue, 3 Feb 2015 10:51:16 -0500
> Subject: [PATCH] acpi: fix acpi_os_ioremap for arm64
> 
> The acpi_os_ioremap() function may be used to map normal RAM or IO
> regions. The current implementation simply uses ioremap_cache(). This
> will work for some architectures, but arm64 ioremap_cache() cannot be
> used to map IO regions which don't support caching. So for arm64, use
> ioremap() for non-RAM regions.
> 
> CC: Rafael J Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Mark Salter <msalter@redhat.com>
> ---
>  arch/arm64/include/asm/acpi.h | 14 ++++++++++++++
>  include/acpi/acpi_io.h        |  3 +++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index ea4d2b3..db82bc3 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -14,6 +14,7 @@
>  
>  #include <linux/irqchip/arm-gic-acpi.h>
>  
> +#include <linux/mm.h>
>  #include <asm/smp_plat.h>
>  
>  /* Basic configuration for ACPI */
> @@ -100,4 +101,17 @@ static inline bool acpi_psci_use_hvc(void) { return false; }
>  static inline void acpi_init_cpus(void) { }
>  #endif /* CONFIG_ACPI */
>  
> +/*
> + * ACPI table mapping
> + */
> +static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> +					    acpi_size size)
> +{
> +	if (!page_is_ram(phys >> PAGE_SHIFT))
> +		return ioremap(phys, size);
> +
> +       return ioremap_cache(phys, size);
> +}
> +#define acpi_os_ioremap acpi_os_ioremap

That's one way of doing this, I'm not too bothered with the approach
(define the function name, an ARCH_HAS macro or a Kconfig option, it's
up to Rafael).

But a question I already asked is what we need ioremap_cache() for? We
don't use NVS on arm64 yet, so is there anything else requiring
cacheable mapping?

-- 
Catalin
