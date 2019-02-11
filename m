From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC 2/3] arm_pmu: acpi: spe: Add initial MADT/SPE probing
Date: Mon, 11 Feb 2019 15:34:42 +0000
Message-ID: <20190211153442.GA4792@e107155-lin>
References: <20190209004718.3292087-1-jeremy.linton@arm.com>
 <20190209004718.3292087-3-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190209004718.3292087-3-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, catalin.marinas@arm.com, rafael.j.wysocki@intel.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, robert.moore@intel.com, linux-acpi@vger.kernel.org, lenb@kernel.org, Sudeep Holla <sudeep.holla@arm.com>, erik.schmauss@intel.com, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Feb 08, 2019 at 06:47:17PM -0600, Jeremy Linton wrote:
> ACPI 6.3 adds additional fields to the MADT GICC
> structure to describe SPE PPI's. We pick these out
> of the cached reference to the madt_gicc structure
> similarly to the core PMU code. We then create a platform
> device referring to the IRQ and let the user/module loader
> decide whether to load the SPE driver.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/include/asm/acpi.h |  3 ++
>  drivers/perf/arm_pmu_acpi.c   | 67 +++++++++++++++++++++++++++++++++++
>  2 files changed, 70 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 2def77ec14be..f9f9f2eb5d54 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -40,6 +40,9 @@
>  	(!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
>  	(unsigned long)(entry) + (entry)->header.length > (end))
>  
> +#define ACPI_MADT_GICC_SPE  (ACPI_OFFSET(struct acpi_madt_generic_interrupt, \
> +	spe_overflow_interrupt) + sizeof(u16))
> +

[Nit] Does it make sense to add _OFFSET in the name ? Otherwise it may
sound like the actual interrupt number than the offset.

Other than that, this looks good to me:

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Regards,
Sudeep
