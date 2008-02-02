From: "Zhao, Yakui" <yakui.zhao@intel.com>
Subject: RE: [PATCH 5/5] ACPI: Update the t-state for every affected cpu when t-state is changed
Date: Sat, 2 Feb 2008 21:04:52 +0800
Message-ID: <9D7649D18729DE4BB2BD7B494F7FEDC2E7D5FC@pdsmsx415.ccr.corp.intel.com>
References: <1201499756.17068.27.camel@yakui_zhao.sh.intel.com> <200802020353.02051.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45377 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752692AbYBBNHH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Feb 2008 08:07:07 -0500
Content-class: urn:content-classes:message
In-Reply-To: <200802020353.02051.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org


drivers/acpi/processor_throttling.c:990: warning: 'ret' may be used
uninitialized in this function

-Len
I will eliminate the warning message and refresh the patch. 
Thanks.

> +	for_each_cpu_mask(i, online_throttling_cpus) {
> +		t_state.cpu = i;
> +		acpi_processor_throttling_notifier(THROTTLING_PRECHANGE,
> +							&t_state);
> +	}
> +	/*
> +	 * The function of acpi_processor_set_throttling will be called
> +	 * to switch T-state. If the coordination type is SW_ALL or
HW_ALL,
> +	 * it is necessary to call it for every affected cpu. Otherwise
> +	 * it can be called only for the cpu pointed by pr.
> +	 */
> +	if (p_throttling->shared_type == DOMAIN_COORD_TYPE_SW_ANY) {
> +		set_cpus_allowed(current, cpumask_of_cpu(pr->id));
> +		ret = p_throttling->acpi_processor_set_throttling(pr,
> +						t_state.target_state);
> +	} else {
> +		/*
> +		 * When the T-state coordination is SW_ALL or HW_ALL,
> +		 * it is necessary to set T-state for every affected
> +		 * cpus.
> +		 */
> +		for_each_cpu_mask(i, online_throttling_cpus) {
> +			match_pr = processors[i];
> +			/*
> +			 * If the pointer is invalid, we will report the
> +			 * error message and continue.
> +			 */
> +			if (!match_pr) {
> +				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> +					"Invalid Pointer for CPU %d\n",
i));
> +				continue;
> +			}
> +			/*
> +			 * If the throttling control is unsupported on
CPU i,
> +			 * we will report the error message and
continue.
> +			 */
> +			if (!match_pr->flags.throttling) {
> +				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> +					"Throttling Controll is
unsupported "
> +					"on CPU %d\n", i));
> +				continue;
> +			}
> +			t_state.cpu = i;
> +			set_cpus_allowed(current, cpumask_of_cpu(i));
> +			ret = match_pr->throttling.
> +				acpi_processor_set_throttling(
> +				match_pr, t_state.target_state);
> +		}
> +	}
> +	/*
> +	 * After the set_throttling is called, the
> +	 * throttling notifier is called for every
> +	 * affected cpu to update the T-states.
> +	 * The notifier event is THROTTLING_POSTCHANGE
> +	 */
> +	for_each_cpu_mask(i, online_throttling_cpus) {
> +		t_state.cpu = i;
> +
acpi_processor_throttling_notifier(THROTTLING_POSTCHANGE,
> +							&t_state);
> +	}
>  	/* restore the previous state */
>  	set_cpus_allowed(current, saved_mask);
>  	return ret;
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
