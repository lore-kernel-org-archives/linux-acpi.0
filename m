From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] arm64: acpi: Prepare for longer MADTs
Date: Mon, 15 Oct 2018 10:29:19 +0100
Message-ID: <20181015092919.GA1778@e107155-lin>
References: <20181012192937.3819951-1-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181012192937.3819951-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, will.deacon@arm.com, ard.biesheuvel@linaro.org, james.morse@arm.com, rafael.j.wysocki@intel.com, takahiro.akashi@linaro.org, lorenzo.pieralisi@arm.com, ahs3@redhat.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 12, 2018 at 02:29:37PM -0500, Jeremy Linton wrote:
> The BAD_MADT_GICC_ENTRY check is a little too strict because
> it rejects MADT entries that don't match the currently known
> lengths. We should remove this restriction to avoid problems
> if the table length changes. Future code which might depend on
> additional fields should be written to validate those fields
> before using them, rather than trying to globally check
> known MADT version lengths.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/include/asm/acpi.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 709208dfdc8b..4d0946bd485a 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -22,12 +22,12 @@
>  #include <asm/tlbflush.h>
>
>  /* Macros for consistency checks of the GICC subtable of MADT */
> -#define ACPI_MADT_GICC_LENGTH	\
> -	(acpi_gbl_FADT.header.revision < 6 ? 76 : 80)
> +#define ACPI_MADT_GICC_MIN_LENGTH   ACPI_OFFSET(  \
> +	struct acpi_madt_generic_interrupt, efficiency_class)
>

This makes it 76 always which is fine, just that the first user of
efficiency_class should check for the length before accessing it.
No user of efficiency_class yet, so I am fine with this change.

>  #define BAD_MADT_GICC_ENTRY(entry, end)					\
> -	(!(entry) || (entry)->header.length != ACPI_MADT_GICC_LENGTH ||	\
> -	(unsigned long)(entry) + ACPI_MADT_GICC_LENGTH > (end))
> +	(!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
> +	(unsigned long)(entry) + (entry)->header.length > (end))
>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
