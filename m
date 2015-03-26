From: Will Deacon <will.deacon@arm.com>
Subject: Re: [patch v11 12/23] ARM64 / ACPI: Parse MADT for SMP initialization
Date: Thu, 26 Mar 2015 15:15:10 +0000
Message-ID: <20150326151510.GI2805@arm.com>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-13-git-send-email-hanjun.guo@linaro.org>
 <20150325171735.GI14585@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:53749 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476AbbCZPPQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Mar 2015 11:15:16 -0400
Content-Disposition: inline
In-Reply-To: <20150325171735.GI14585@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, Ashwin Chaugule <ashwinc@codeaurora.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Robert Richter <rric@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>, "msalter@redhat.com" <msalter@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Mark Brown <broonie@kernel.org>, "suravee.suthikulpanit@amd.com" <suravee.>

On Wed, Mar 25, 2015 at 05:17:35PM +0000, Catalin Marinas wrote:
> On Tue, Mar 24, 2015 at 10:02:45PM +0800, Hanjun Guo wrote:
> > +/**
> > + * acpi_map_gic_cpu_interface - generates a logical cpu number
> > + * and map to MPIDR represented by GICC structure
> > + * @mpidr: CPU's hardware id to register, MPIDR represented in MADT
> > + * @enabled: this cpu is enabled or not
> > + *
> > + * Returns the logical cpu number which maps to MPIDR
> > + */
> > +static int __init acpi_map_gic_cpu_interface(u64 mpidr, u8 enabled)
> 
> So here we have an u8 enabled.
> 
> > +static int __init
> > +acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
> > +				const unsigned long end)
> > +{
> > +	struct acpi_madt_generic_interrupt *processor;
> > +
> > +	processor = (struct acpi_madt_generic_interrupt *)header;
> > +
> > +	if (BAD_MADT_ENTRY(processor, end))
> > +		return -EINVAL;
> > +
> > +	acpi_table_print_madt_entry(header);
> > +
> > +	acpi_map_gic_cpu_interface(processor->arm_mpidr & MPIDR_HWID_BITMASK,
> > +		processor->flags & ACPI_MADT_ENABLED);
> 
> and here processor->flags is u32. Luckily, ACPI_MADT_ENABLED is 1 and we
> don't lose any information. So either make the enabled above a bool or
> simply pass the flags with the check in acpi_map_gic_cpu_interface()
> (personal preference for the latter).

I've applied the following patch on top of the series.

Will

--->8

commit 8ef320319592693f4a6286d80df210fd47b3e356
Author: Will Deacon <will.deacon@arm.com>
Date:   Thu Mar 26 15:09:20 2015 +0000

    ARM64 / ACPI: fix usage of acpi_map_gic_cpu_interface
    
    acpi_parse_gic_cpu_interface calls acpi_map_gic_cpu_interface by both
    passing a 32-bit value in the u8 enabled parameter and then subsequently
    ignoring its return value.
    
    Sort it out.
    
    Reported-by: Catalin Marinas <catalin.marinas@arm.com>
    Signed-off-by: Will Deacon <will.deacon@arm.com>

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index cd60329da8c4..07649e413244 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -103,9 +103,12 @@ void __init __acpi_unmap_table(char *map, unsigned long size)
  *
  * Returns the logical cpu number which maps to MPIDR
  */
-static int __init acpi_map_gic_cpu_interface(u64 mpidr, u8 enabled)
+static int __init
+acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
 {
 	int i;
+	u64 mpidr = processor->arm_mpidr & MPIDR_HWID_BITMASK;
+	bool enabled = !!(processor->flags & ACPI_MADT_ENABLED);
 
 	if (mpidr == INVALID_HWID) {
 		pr_info("Skip MADT cpu entry with invalid MPIDR\n");
@@ -178,11 +181,7 @@ acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
 		return -EINVAL;
 
 	acpi_table_print_madt_entry(header);
-
-	acpi_map_gic_cpu_interface(processor->arm_mpidr & MPIDR_HWID_BITMASK,
-		processor->flags & ACPI_MADT_ENABLED);
-
-	return 0;
+	return acpi_map_gic_cpu_interface(processor);
 }
 
 /* Parse GIC cpu interface entries in MADT for SMP init */
