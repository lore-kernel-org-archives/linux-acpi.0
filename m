From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [RFC] [PATCH] ACPI :Modify timer override connection in Some
 NVIDIA systems
Date: Mon, 15 Oct 2007 12:30:13 -0400
Message-ID: <47139595.2040505@redhat.com>
References: <1192172655.27194.29.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:42377 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758776AbXJOQa0 (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Mon, 15 Oct 2007 12:30:26 -0400
In-Reply-To: <1192172655.27194.29.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Linux-acpi@vger.kernel.org, lenb@kernel.org, Andi Kleen <ak@suse.de>, Thomas Gleixner <tglx@linutronix.de>

On 10/12/2007 03:04 AM, Zhao Yakui wrote:
> Hi, All
>     The BIOS of some systems using NVIDIA chipset gives the uncorrect
> timer override connection, which will cause that I/O APIC and timer
> can't be connected and kernel panic.
>     There are two ways to fix this bug. One is to use the following patch and 
> the other is to add a new boot option of acpi_force_timer_override. 
> 
> 1. Use the following patch.
> The basic flowchart of patch is that:(unnecessary to add new boot option)
>     a. When NVIDIA chipset is detected and hpet timer exist, 
> acpi_use_timer_override will be set.
>     (Skip this when boot option of acpi_use_timer_override is given).
>     b. Check whether uncorrect timer connection(IRQ0, Pin0) exists when 
> acpi_use_timer_override is set and HPET timer exists. 
>       If error exists, timer will be forced to route to the Pin2.
> 
> 2. Add a new boot option of acpi_force_timer_override
>     The basic flowchart of this method is that:
>     a. When NVIDIA chipset is detected and HPET timer exists, 
> acpi_force_timer_override will be set.
>        (skip this when boot option of acpi_force_timer_override is given)
>     b. Check whether uncorrect timer connection(IRQ0,Pin0) exists when 
> acpi_force_timer_override is set.
>        If the error exists, modify the timer override connection.
> 
> Welcome the comments.
> Thanks.
> 
> Subject: ACPI :Modify timer override connection in Some NVIDIA systems
>>From : Zhao Yakui <yakui.zhao@intel.com>
> 
> BIOS defines the uncorrect timeroverride connection in some NVIDIA
> systems
> on which HPET timer exists. When the uncorrect connection is deteced, 
> the timer will be forced to route to the Pin 2 of I/O APIC instead of
> Pin 0.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=8956
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
>  arch/i386/kernel/acpi/boot.c       |   17 +++++++++++++++++
>  arch/i386/kernel/acpi/earlyquirk.c |    7 ++++++-
>  arch/x86_64/kernel/early-quirks.c  |    2 ++
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.23-rc9/arch/i386/kernel/acpi/boot.c
> ===================================================================
> --- linux-2.6.23-rc9.orig/arch/i386/kernel/acpi/boot.c
> +++ linux-2.6.23-rc9/arch/i386/kernel/acpi/boot.c
> @@ -351,6 +351,11 @@ static void __init acpi_sci_ioapic_setup
>  	return;
>  }
>  
> +static int __init acpi_hpet_check(struct acpi_table_header *header)
> +{
> +	return 0;
> +}
> +
>  static int __init
>  acpi_parse_int_src_ovr(struct acpi_subtable_header * header,
>  		       const unsigned long end)
> @@ -371,6 +376,18 @@ acpi_parse_int_src_ovr(struct acpi_subta
>  		return 0;
>  	}
>  
> +	if (acpi_use_timer_override &&
> +	   intsrc->source_irq == 0 && intsrc->global_irq == 0 &&
> +	   !acpi_table_parse(ACPI_SIG_HPET, acpi_hpet_check)) {
> +		mp_override_legacy_irq(intsrc->source_irq,
> +			intsrc->inti_flags & ACPI_MADT_POLARITY_MASK,
> +			(intsrc->inti_flags & ACPI_MADT_TRIGGER_MASK) >> 2,
> +			2);
> +		printk(PREFIX "BIOS IRQ0 pin0 override ignored."
> +				"Force to use IRQ0 pin2 \n");
> +		return 0;
> +	}
> +
>  	if (acpi_skip_timer_override &&
>  	    intsrc->source_irq == 0 && intsrc->global_irq == 2) {
>  		printk(PREFIX "BIOS IRQ0 pin2 override ignored.\n");
> Index: linux-2.6.23-rc9/arch/i386/kernel/acpi/earlyquirk.c
> ===================================================================
> --- linux-2.6.23-rc9.orig/arch/i386/kernel/acpi/earlyquirk.c
> +++ linux-2.6.23-rc9/arch/i386/kernel/acpi/earlyquirk.c
> @@ -26,7 +26,8 @@ static int __init check_bridge(int vendo
>  	/* According to Nvidia all timer overrides are bogus unless HPET
>  	   is enabled. */
>  	if (!acpi_use_timer_override && vendor == PCI_VENDOR_ID_NVIDIA) {
> -		if (!warned && acpi_table_parse(ACPI_SIG_HPET,
> +		if (!warned) {
> +		if (acpi_table_parse(ACPI_SIG_HPET,
>  						nvidia_hpet_check)) {
>  			warned = 1;
>  			acpi_skip_timer_override = 1;
> @@ -36,6 +37,10 @@ static int __init check_bridge(int vendo
>                  printk(KERN_INFO "If you got timer trouble "
>  			 	 "try acpi_use_timer_override\n");
>  
> +			} else {
> +			warned = 1;
> +			acpi_use_timer_override = 1;
> +			}
>  		}
>  	}
>  #endif
> Index: linux-2.6.23-rc9/arch/x86_64/kernel/early-quirks.c
> ===================================================================
> --- linux-2.6.23-rc9.orig/arch/x86_64/kernel/early-quirks.c
> +++ linux-2.6.23-rc9/arch/x86_64/kernel/early-quirks.c
> @@ -57,6 +57,8 @@ static void __init nvidia_bugs(void)
>  		       "timer override.\n");
>  		printk(KERN_INFO "If you got timer trouble "
>  			"try acpi_use_timer_override\n");
> +	} else {
> +		acpi_use_timer_override = 1;
>  	}
>  #endif
>  	/* RED-PEN skip them on mptables too? */

cc: added
