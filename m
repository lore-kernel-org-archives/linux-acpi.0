From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v3 02/17] ARM64 / ACPI: Get RSDP and ACPI boot-time
 tables
Date: Wed, 10 Sep 2014 22:37:57 +0100
Message-ID: <20140910213757.C7B8CC40E5E@trevor.secretlab.ca>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
	<1409583475-6978-3-git-send-email-hanjun.guo@linaro.org>
	<20140909162648.GE2910@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140909162648.GE2910@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>, Olof Johansson <olof@lixom.net>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Will Deacon <Will.Deacon@arm.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-ar>
List-Id: linux-acpi@vger.kernel.org

On Tue, 9 Sep 2014 17:26:49 +0100, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Sep 01, 2014 at 03:57:40PM +0100, Hanjun Guo wrote:
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index c96172a..fb7cc0e 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -43,6 +43,7 @@
> >  #include <linux/of_fdt.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/efi.h>
> > +#include <linux/acpi.h>
> >  
> >  #include <asm/fixmap.h>
> >  #include <asm/cpu.h>
> > @@ -385,6 +386,9 @@ void __init setup_arch(char **cmdline_p)
> >  	efi_init();
> >  	arm64_memblock_init();
> >  
> > +	/* Parse the ACPI tables for possible boot-time configuration */
> > +	acpi_boot_table_init();
> 
> Is there any dummy acpi_boot_table_init() when !CONFIG_ACPI? I couldn't
> see one in this patch, so I don't see how this would compile when ACPI
> is disabled.

It's in include/linux/acpi.h in the !CONFIG_ACPI section.

g.
