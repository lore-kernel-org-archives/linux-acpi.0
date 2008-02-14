From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI, CPU_IDLE: Add more information about C-states
Date: Thu, 14 Feb 2008 00:10:21 -0500
Message-ID: <200802140010.22097.lenb@kernel.org>
References: <20080212015036.GC32468@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49645 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934080AbYBNFRP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Feb 2008 00:17:15 -0500
In-Reply-To: <20080212015036.GC32468@linux-os.sc.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Cc: linux-acpi@vger.kernel.org

applied

thanks,
-len

On Monday 11 February 2008 20:50, Venki Pallipadi wrote:
> From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> Add a new sysfs entry under cpuidle states. desc - can be used by driver to
> communicate to userspace any specific information about the state.
> This helps in identifying the exact hardware C-states behind the ACPI C-state
> definition.
> 
> Idea is to export this through powertop, which will help to map the C-state
> reported by powertop to actual hardware C-state.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> Index: linux-2.6.25-rc/arch/x86/kernel/acpi/cstate.c
> ===================================================================
> --- linux-2.6.25-rc.orig/arch/x86/kernel/acpi/cstate.c
> +++ linux-2.6.25-rc/arch/x86/kernel/acpi/cstate.c
> @@ -126,6 +126,8 @@ int acpi_processor_ffh_cstate_probe(unsi
>  		printk(KERN_DEBUG "Monitor-Mwait will be used to enter C-%d "
>  		       "state\n", cx->type);
>  	}
> +	snprintf(cx->desc, ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
> +		 cx->address);
>  
>  out:
>  	set_cpus_allowed(current, saved_mask);
> Index: linux-2.6.25-rc/drivers/acpi/processor_idle.c
> ===================================================================
> --- linux-2.6.25-rc.orig/drivers/acpi/processor_idle.c
> +++ linux-2.6.25-rc/drivers/acpi/processor_idle.c
> @@ -917,11 +917,16 @@ static int acpi_processor_get_power_info
>  				 * Otherwise, ignore this info and continue.
>  				 */
>  				cx.entry_method = ACPI_CSTATE_HALT;
> +				snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI HLT");
>  			} else {
>  				continue;
>  			}
> +		} else {
> +			snprintf(cx.desc, ACPI_CX_DESC_LEN, "ACPI IOPORT 0x%x",
> +				 cx.address);
>  		}
>  
> +
>  		obj = &(element->package.elements[2]);
>  		if (obj->type != ACPI_TYPE_INTEGER)
>  			continue;
> @@ -1620,6 +1625,11 @@ static int acpi_processor_setup_cpuidle(
>  		return -EINVAL;
>  	}
>  
> +	for (i = 0; i < CPUIDLE_STATE_MAX; i++) {
> +		dev->states[i].name[0] = '\0';
> +		dev->states[i].desc[0] = '\0';
> +	}
> +
>  	for (i = 1; i < ACPI_PROCESSOR_MAX_POWER && i <= max_cstate; i++) {
>  		cx = &pr->power.states[i];
>  		state = &dev->states[count];
> @@ -1636,6 +1646,7 @@ static int acpi_processor_setup_cpuidle(
>  		cpuidle_set_statedata(state, cx);
>  
>  		snprintf(state->name, CPUIDLE_NAME_LEN, "C%d", i);
> +		strncpy(state->desc, cx->desc, CPUIDLE_DESC_LEN);
>  		state->exit_latency = cx->latency;
>  		state->target_residency = cx->latency * 6;
>  		state->power_usage = cx->power;
> Index: linux-2.6.25-rc/drivers/cpuidle/sysfs.c
> ===================================================================
> --- linux-2.6.25-rc.orig/drivers/cpuidle/sysfs.c
> +++ linux-2.6.25-rc/drivers/cpuidle/sysfs.c
> @@ -218,16 +218,23 @@ static ssize_t show_state_##_name(struct
>  	return sprintf(buf, "%u\n", state->_name);\
>  }
>  
> -static ssize_t show_state_name(struct cpuidle_state *state, char *buf)
> -{
> -	return sprintf(buf, "%s\n", state->name);
> +#define define_show_state_str_function(_name) \
> +static ssize_t show_state_##_name(struct cpuidle_state *state, char *buf) \
> +{ \
> +	if (state->_name[0] == '\0')\
> +		return sprintf(buf, "<null>\n");\
> +	return sprintf(buf, "%s\n", state->_name);\
>  }
>  
>  define_show_state_function(exit_latency)
>  define_show_state_function(power_usage)
>  define_show_state_function(usage)
>  define_show_state_function(time)
> +define_show_state_str_function(name)
> +define_show_state_str_function(desc)
> +
>  define_one_state_ro(name, show_state_name);
> +define_one_state_ro(desc, show_state_desc);
>  define_one_state_ro(latency, show_state_exit_latency);
>  define_one_state_ro(power, show_state_power_usage);
>  define_one_state_ro(usage, show_state_usage);
> @@ -235,6 +242,7 @@ define_one_state_ro(time, show_state_tim
>  
>  static struct attribute *cpuidle_state_default_attrs[] = {
>  	&attr_name.attr,
> +	&attr_desc.attr,
>  	&attr_latency.attr,
>  	&attr_power.attr,
>  	&attr_usage.attr,
> Index: linux-2.6.25-rc/include/acpi/processor.h
> ===================================================================
> --- linux-2.6.25-rc.orig/include/acpi/processor.h
> +++ linux-2.6.25-rc/include/acpi/processor.h
> @@ -32,9 +32,11 @@
>  #define DOMAIN_COORD_TYPE_SW_ANY	0xfd
>  #define DOMAIN_COORD_TYPE_HW_ALL	0xfe
>  
> -#define ACPI_CSTATE_SYSTEMIO	(0)
> -#define ACPI_CSTATE_FFH		(1)
> -#define ACPI_CSTATE_HALT	(2)
> +#define ACPI_CSTATE_SYSTEMIO	0
> +#define ACPI_CSTATE_FFH		1
> +#define ACPI_CSTATE_HALT	2
> +
> +#define ACPI_CX_DESC_LEN	32
>  
>  /* Power Management */
>  
> @@ -74,6 +76,7 @@ struct acpi_processor_cx {
>  	u64 time;
>  	struct acpi_processor_cx_policy promotion;
>  	struct acpi_processor_cx_policy demotion;
> +	char desc[ACPI_CX_DESC_LEN];
>  };
>  
>  struct acpi_processor_power {
> Index: linux-2.6.25-rc/include/linux/cpuidle.h
> ===================================================================
> --- linux-2.6.25-rc.orig/include/linux/cpuidle.h
> +++ linux-2.6.25-rc/include/linux/cpuidle.h
> @@ -19,6 +19,7 @@
>  
>  #define CPUIDLE_STATE_MAX	8
>  #define CPUIDLE_NAME_LEN	16
> +#define CPUIDLE_DESC_LEN	32
>  
>  struct cpuidle_device;
>  
> @@ -29,6 +30,7 @@ struct cpuidle_device;
>  
>  struct cpuidle_state {
>  	char		name[CPUIDLE_NAME_LEN];
> +	char		desc[CPUIDLE_DESC_LEN];
>  	void		*driver_data;
>  
>  	unsigned int	flags;
> Index: linux-2.6.25-rc/drivers/cpuidle/cpuidle.c
> ===================================================================
> --- linux-2.6.25-rc.orig/drivers/cpuidle/cpuidle.c
> +++ linux-2.6.25-rc/drivers/cpuidle/cpuidle.c
> @@ -219,7 +219,8 @@ static void poll_idle_init(struct cpuidl
>  
>  	cpuidle_set_statedata(state, NULL);
>  
> -	snprintf(state->name, CPUIDLE_NAME_LEN, "C0 (poll idle)");
> +	snprintf(state->name, CPUIDLE_NAME_LEN, "C0");
> +	snprintf(state->desc, CPUIDLE_DESC_LEN, "CPUIDLE CORE POLL IDLE");
>  	state->exit_latency = 0;
>  	state->target_residency = 0;
>  	state->power_usage = -1;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
