From: Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] disable SMM access to SpeedStep using ACPI-FADT
	pstate_cnt
Date: 16 Feb 2004 00:29:31 -0500
Sender: cpufreq-bounces@www.linux.org.uk
Message-ID: <1076909364.2512.23.camel@dhcppc4>
References: <20040215105712.GB6105@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk>
In-Reply-To: <20040215105712.GB6105@dominikbrodowski.de>
List-Unsubscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=unsubscribe>
List-Archive: <http://www.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@www.linux.org.uk>
List-Help: <mailto:cpufreq-request@www.linux.org.uk?subject=help>
List-Subscribe: <http://www.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@www.linux.org.uk?subject=subscribe>
Errors-To: cpufreq-bounces+glkc-cpufreq=gmane.org@www.linux.org.uk
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: ACPI Developers <acpi-devel@lists.sourceforge.net>, cpufreq@www.linux.org.uk
List-Id: linux-acpi@vger.kernel.org

On Sun, 2004-02-15 at 05:57, Dominik Brodowski wrote:
> Disable SMM access to SpeedStep
> 
> Often, the BIOS changes the CPU frequency if a notebook is (dis)connected
> from its AC adapter. This interferes with a) an user setting the CPU frequency
> and b) kernel timing code which needs to know loops_per_jiffy, cpu_khz etc.
> 
> So, ACPI 2.0 offers a method to disable such BIOS changes -- writing
> a value contained in the FADT (pstate_cnt) to the smi_cmd port. This patch
> utilizes this method by doing this write in processor.c.
> 
> However, most current notebooks only offer 1.0 ACPI tables, where the
> pstate_cnt entry is marked as "reserved". Whenever there is a _PCT entry
> in the DSDT, though [and this is only a 2.0 object!], we assume the
> "reserved" entry to be the pstate_cnt entry [if it isn't zero].

Yes, it seems bogus that an OEM would implement 2.0 _PCT and have a 1.0
FADT with a non-zero PSTATE_CNT field -- particularly bogus if using
that "reserved" field is necessary to make p-states works.

I think when we detect this situation, we should... 
warning: ACPI 2.0 _PCT and 1.0 FADT with non-zero PSTATE_CNT
Because we're technically out on a limb using this reserved value, and
we should complain -- the OEM should have a 2.0 FADT rather than
requiring us to break spec.

Further, when we add the "acpi_strict" flag (this week) we should not
second guess them when it is set, but follow the letter of the spec and
not use a reserved field.

>  drivers/acpi/processor.c       |   61 +++++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/tables/tbconvrt.c |    5 ++-
>  2 files changed, 64 insertions(+), 2 deletions(-)
> 
> diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/processor.c
> --- linux-original/drivers/acpi/processor.c	2004-02-13 17:09:59.000000000 +0100
> +++ linux/drivers/acpi/processor.c	2004-02-15 11:02:40.103481944 +0100
> @@ -2374,6 +2374,65 @@
>  }
>  
> 
> +#ifdef CONFIG_CPU_FREQ
> +/*
> + * acpi_processor_disable_smm - disable BIOS meddling with SpeedStep settings
> + *
> + * By writing pstate_cnt to smi_cmd the BIOS no longer interferes with
> + * the P-States setting of the processor.
> + */
> +static void acpi_processor_disable_smm(void) {
> +	acpi_status		status;
> +	int			i;
> +
> +	ACPI_FUNCTION_TRACE("acpi_processor_disable_smm");
> +
> +	/* Can't write pstate_cnt to smi_cmd if either value is zero 
> +	 */
> +	if ((!acpi_fadt.smi_cmd) ||
> +	    (!acpi_fadt.pstate_cnt)) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> +			"No SMI port or pstate_cnt\n"));
> +		return_VOID;
> +	}
> +
> +	/* Don't write pstate_cnt to smi_cmd if there is no support for
> +	 * P-States anyway. This is also a safety precaution for ACPI-1.0
> +	 * systems.
> +	 */
> +	for (i=0;i<NR_CPUS;i++) {
> +		struct acpi_processor	*pr = processors[i];
> +		acpi_handle		handle = NULL;
> +
> +		if (!pr || !pr->handle)
> +			continue;
> +
> +		status = acpi_get_handle(pr->handle, "_PCT", &handle);
> +		if (ACPI_FAILURE(status)) {
> +			ACPI_DEBUG_PRINT((ACPI_DB_INFO, 
> +				"No _PCT available, so ignore pstate_cnt"));
> +			return_VOID;
> +		}
> +		break;
> +	}
> +
> +	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Writing pstate_cnt [0x%x] to smi_cmd [0x%x]\n", acpi_fadt.pstate_cnt, acpi_fadt.smi_cmd));
> +
> +	status = acpi_os_write_port (acpi_fadt.smi_cmd,
> +					(u32) acpi_fadt.pstate_cnt, 8);
> +	if (ACPI_FAILURE (status))
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
> +				"Failed to write pstate_cnt [0x%x] to "
> +				"smi_cmd [0x%x]\n", acpi_fadt.pstate_cnt, acpi_fadt.smi_cmd));
> +
> +	return_VOID;
> +}
> +
> +#else
> +static void acpi_processor_disable_smm(void) { return; }
> +#endif

I think the custom is to use a static inline when you want define out a
routine -- but maybe that is just when defined in headers?

> +
>  static int __init
>  acpi_processor_init (void)
>  {
> @@ -2398,6 +2457,8 @@
>  
>  	acpi_processor_ppc_init();
>  
> +	acpi_processor_disable_smm();
> +
>  	return_VALUE(0);
>  }
>  
> diff -ruN linux-original/drivers/acpi/tables/tbconvrt.c linux/drivers/acpi/tables/tbconvrt.c
> --- linux-original/drivers/acpi/tables/tbconvrt.c	2004-02-13 17:09:59.000000000 +0100
> +++ linux/drivers/acpi/tables/tbconvrt.c	2004-02-15 08:12:16.000000000 +0100
> @@ -240,9 +240,10 @@
>  	/*
>  	 * Processor Performance State Control. This is the value OSPM writes to
>  	 * the SMI_CMD register to assume processor performance state control
> -	 * responsibility. There isn't any equivalence in 1.0, leave it zeroed.
> +	 * responsibility. There isn't any equivalence in 1.0, but as many 1.x
> +	 * ACPI tables contain _PCT and _PSS we also keep this value.
>  	 */
> -	local_fadt->pstate_cnt = 0;
> +	/* local_fadt->pstate_cnt = 0 (reserved2) */

If it turns out that this value really is useful, then we should simply
keep it in this routine and not clear it.  Later on when we use it is
when we should complain.  We don't want to bother complaining here
unless we know we have a system with _PCT; b/c it would be noise on real
1.0 systems w/o PCT.

>  
>  	/*
>  	 * Support for the _CST object and C States change notification.
