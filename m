From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 2/4] ACPI: Use mwait for C1 idle
Date: Thu, 7 Feb 2008 02:38:17 -0500
Message-ID: <200802070238.18004.lenb@kernel.org>
References: <20080201013502.750627000@intel.com> <20080201013629.328571000@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34830 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754507AbYBGHid (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Feb 2008 02:38:33 -0500
In-Reply-To: <20080201013629.328571000@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: venkatesh.pallipadi@intel.com
Cc: linux-acpi@vger.kernel.org

applied.

thanks,
-len

On Thursday 31 January 2008 20:35, venkatesh.pallipadi@intel.com wrote:
> Add mwait idle for C1 state instead of halt, on platforms that support
> C1 state with mwait.
> 
> Renames cx->space_id to something more appropriate.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> Index: linux-2.6.25-rc/drivers/acpi/processor_idle.c
> ===================================================================
> --- linux-2.6.25-rc.orig/drivers/acpi/processor_idle.c
> +++ linux-2.6.25-rc/drivers/acpi/processor_idle.c
> @@ -265,7 +265,7 @@ static atomic_t c3_cpu_count;
>  /* Common C-state entry for C2, C3, .. */
>  static void acpi_cstate_enter(struct acpi_processor_cx *cstate)
>  {
> -	if (cstate->space_id == ACPI_CSTATE_FFH) {
> +	if (cstate->entry_method == ACPI_CSTATE_FFH) {
>  		/* Call into architectural FFH based C-state */
>  		acpi_processor_ffh_cstate_enter(cstate);
>  	} else {
> @@ -904,20 +904,20 @@ static int acpi_processor_get_power_info
>  		cx.address = reg->address;
>  		cx.index = current_count + 1;
>  
> -		cx.space_id = ACPI_CSTATE_SYSTEMIO;
> +		cx.entry_method = ACPI_CSTATE_SYSTEMIO;
>  		if (reg->space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
>  			if (acpi_processor_ffh_cstate_probe
>  					(pr->id, &cx, reg) == 0) {
> -				cx.space_id = ACPI_CSTATE_FFH;
> -			} else if (cx.type != ACPI_STATE_C1) {
> +				cx.entry_method = ACPI_CSTATE_FFH;
> +			} else if (cx.type == ACPI_STATE_C1) {
>  				/*
>  				 * C1 is a special case where FIXED_HARDWARE
>  				 * can be handled in non-MWAIT way as well.
>  				 * In that case, save this _CST entry info.
> -				 * That is, we retain space_id of SYSTEM_IO for
> -				 * halt based C1.
>  				 * Otherwise, ignore this info and continue.
>  				 */
> +				cx.entry_method = ACPI_CSTATE_HALT;
> +			} else {
>  				continue;
>  			}
>  		}
> @@ -1351,12 +1351,16 @@ static inline void acpi_idle_update_bm_r
>  /**
>   * acpi_idle_do_entry - a helper function that does C2 and C3 type entry
>   * @cx: cstate data
> + *
> + * Caller disables interrupt before call and enables interrupt after return.
>   */
>  static inline void acpi_idle_do_entry(struct acpi_processor_cx *cx)
>  {
> -	if (cx->space_id == ACPI_CSTATE_FFH) {
> +	if (cx->entry_method == ACPI_CSTATE_FFH) {
>  		/* Call into architectural FFH based C-state */
>  		acpi_processor_ffh_cstate_enter(cx);
> +	} else if (cx->entry_method == ACPI_CSTATE_HALT) {
> +		acpi_safe_halt();
>  	} else {
>  		int unused;
>  		/* IO port based C-state */
> @@ -1389,7 +1393,7 @@ static int acpi_idle_enter_c1(struct cpu
>  	if (pr->flags.bm_check)
>  		acpi_idle_update_bm_rld(pr, cx);
>  
> -	acpi_safe_halt();
> +	acpi_idle_do_entry(cx);
>  
>  	local_irq_enable();
>  	cx->usage++;
> Index: linux-2.6.25-rc/include/acpi/processor.h
> ===================================================================
> --- linux-2.6.25-rc.orig/include/acpi/processor.h
> +++ linux-2.6.25-rc/include/acpi/processor.h
> @@ -34,6 +34,7 @@
>  
>  #define ACPI_CSTATE_SYSTEMIO	(0)
>  #define ACPI_CSTATE_FFH		(1)
> +#define ACPI_CSTATE_HALT	(2)
>  
>  /* Power Management */
>  
> @@ -64,7 +65,7 @@ struct acpi_processor_cx {
>  	u8 valid;
>  	u8 type;
>  	u32 address;
> -	u8 space_id;
> +	u8 entry_method;
>  	u8 index;
>  	u32 latency;
>  	u32 latency_ticks;
> 
