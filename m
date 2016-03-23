From: Linda Knippers <linda.knippers@hpe.com>
Subject: Re: [PATCH v6] acpi: Issue _OSC call for native thermal interrupt
 handling
Date: Wed, 23 Mar 2016 12:43:33 -0400
Message-ID: <56F2C7B5.4000208@hpe.com>
References: <1458706064-4147-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t4623.austin.hp.com ([15.73.212.78]:48031 "EHLO
	g2t4623.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755457AbcCWQnj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2016 12:43:39 -0400
In-Reply-To: <1458706064-4147-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, rjw@rjwysocki.net
Cc: tony.luck@intel.com, bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, lenb@kernel.org, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

I raised a general concern on a previous patch so I found a 1P server
with Skylake and HWP to try.  This doesn't qualify as a tested-by
since all I did was apply the patch and boot the server but hey, it booted.

I do have a question below...

On 3/23/2016 12:07 AM, Srinivas Pandruvada wrote:
> There are several reports of freeze on enabling HWP (Hardware PStates)
> feature on Skylake based systems by Intel P states driver. The root
> cause is identified as the HWP interrupts causing BIOS code to freeze.
> HWP interrupts uses thermal LVT.
> Linux natively handles thermal interrupts, but in Skylake based systems
> SMM will take control of thermal interrupts. This is a problem for several
> reasons:
> - It is freezing in BIOS when tries to handle thermal interrupt, which
> will require BIOS upgrade
> - With SMM handling thermal we loose all the reporting features of
> Linux arch/x86/kernel/cpu/mcheck/therm_throt driver
> - Some thermal drivers like x86-package-temp driver depends on the thermal
> threshold interrupts
> - The HWP interrupts are useful for debugging and tuning performance
> 
> So we need native handling of thermal interrupts. This requires some
> way to inform SMM that OS can handle thermal interrupts. This can be
> done by using _OSC/_PDC under processor scope very early in ACPI
> initialization flow.
> The bit 12 of _OSC/_PDC in processor scope defines whether OS supports
> handling of native interrupts for Collaborative Processor Performance
> Control (CPPC) notifications. Since HWP is a implementation of CPPC,
> setting this bit is equivalent to inform SMM that OS is capable of
> handling thermal interrupts.
> Refer to this document for details on _OSC/_PDC
> http://www.intel.com/content/www/us/en/standards/processor-vendor-
> specific-acpi-specification.html
> 
> This change introduces a new function acpi_early_processor_set_osc(),
> which walks acpi name space and finds acpi processor object and
> set capability via _OSC method.
> 
> Also this change writes HWP status bits to 0 to clear any HWP status
> bits in intel_thermal_interrupt().
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v6:
> Added __init for two functions and moved dummy function to internal.h
> Shortened the name of the function.
> 
> v5:
> No code change. Changed commit message to explain HWP is a implementation
> of CPPC.
> 
> v4:
> Suggestion by Boris for removing use of intermediate variable for
> clearing HWP status and using boot_cpu_has instead of static_cpu_has
> 
> v3:
> - Added CONFIG_X86 around static_cpu_has() to fix compile error on
> ARCH=ia64, reported by kbuild test robot
> - return AE_CTRL_TERMINATE to terminate acpi name walk space, when _OSC
> is set already once.
> v2:
> Unnecessary newline was introduced, removed that in acpi_processor.c
> 
>  arch/x86/kernel/cpu/mcheck/therm_throt.c |  3 +++
>  drivers/acpi/acpi_processor.c            | 44 ++++++++++++++++++++++++++++++++
>  drivers/acpi/bus.c                       |  3 +++
>  drivers/acpi/internal.h                  |  6 +++++
>  4 files changed, 56 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mcheck/therm_throt.c b/arch/x86/kernel/cpu/mcheck/therm_throt.c
> index 2c5aaf8..0553858 100644
> --- a/arch/x86/kernel/cpu/mcheck/therm_throt.c
> +++ b/arch/x86/kernel/cpu/mcheck/therm_throt.c
> @@ -385,6 +385,9 @@ static void intel_thermal_interrupt(void)
>  {
>  	__u64 msr_val;
>  
> +	if (static_cpu_has(X86_FEATURE_HWP))
> +		wrmsrl_safe(MSR_HWP_STATUS, 0);
> +
>  	rdmsrl(MSR_IA32_THERM_STATUS, msr_val);
>  
>  	/* Check for violation of core thermal thresholds*/
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 6979186..ba50f46 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -491,6 +491,50 @@ static void acpi_processor_remove(struct acpi_device *device)
>  }
>  #endif /* CONFIG_ACPI_HOTPLUG_CPU */
>  
> +#ifdef CONFIG_X86
> +static bool acpi_hwp_native_thermal_lvt_set;
> +static acpi_status __init acpi_hwp_native_thermal_lvt_osc(acpi_handle handle,
> +							  u32 lvl,
> +							  void *context,
> +							  void **rv)
> +{
> +	u8 sb_uuid_str[] = "4077A616-290C-47BE-9EBD-D87058713953";
> +	u32 capbuf[2];
> +	struct acpi_osc_context osc_context = {
> +		.uuid_str = sb_uuid_str,
> +		.rev = 1,
> +		.cap.length = 8,
> +		.cap.pointer = capbuf,
> +	};
> +
> +	if (acpi_hwp_native_thermal_lvt_set)
> +		return AE_CTRL_TERMINATE;
> +
> +	capbuf[0] = 0x0000;
> +	capbuf[1] = 0x1000; /* set bit 12 */
> +
> +	if (ACPI_SUCCESS(acpi_run_osc(handle, &osc_context))) {
> +		acpi_hwp_native_thermal_lvt_set = true;
> +		kfree(osc_context.ret.pointer);

There are other boot messages that indicate when something is happening
with _OSC.  Should there be one for this?  Or is there some other obvious
way one can know that this was set?

> +	}
> +
> +	return AE_OK;
> +}
> +
> +void __init acpi_early_processor_set_osc(void)
> +{
> +	if (boot_cpu_has(X86_FEATURE_HWP)) {
> +		acpi_walk_namespace(ACPI_TYPE_PROCESSOR, ACPI_ROOT_OBJECT,
> +				    ACPI_UINT32_MAX,
> +				    acpi_hwp_native_thermal_lvt_osc,
> +				    NULL, NULL, NULL);
> +		acpi_get_devices(ACPI_PROCESSOR_DEVICE_HID,
> +				 acpi_hwp_native_thermal_lvt_osc,
> +				 NULL, NULL);
> +	}
> +}
> +#endif
> +
>  /*
>   * The following ACPI IDs are known to be suitable for representing as
>   * processor devices.
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 891c42d..7e73aea 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1005,6 +1005,9 @@ static int __init acpi_bus_init(void)
>  		goto error1;
>  	}
>  
> +	/* Set capability bits for _OSC under processor scope */
> +	acpi_early_processor_set_osc();
> +
>  	/*
>  	 * _OSC method may exist in module level code,
>  	 * so it must be run after ACPI_FULL_INITIALIZATION
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index 1e6833a..9f34051b 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -138,6 +138,12 @@ void acpi_early_processor_set_pdc(void);
>  static inline void acpi_early_processor_set_pdc(void) {}
>  #endif
>  
> +#ifdef CONFIG_X86
> +void acpi_early_processor_set_osc(void);
> +#else
> +static inline void acpi_early_processor_set_osc(void) {}
> +#endif
> +
>  /* --------------------------------------------------------------------------
>                                    Embedded Controller
>     -------------------------------------------------------------------------- */
> 
