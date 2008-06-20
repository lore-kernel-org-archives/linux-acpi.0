From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [RFC PATCH 2/2] ACPI: detect GPE interrupt storm
Date: Fri, 20 Jun 2008 10:55:02 +0400
Message-ID: <485B5446.2040700@suse.de>
References: <1213926172.3001.10.camel@rzhang-dt.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:55511 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750986AbYFTGyZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 02:54:25 -0400
In-Reply-To: <1213926172.3001.10.camel@rzhang-dt.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>

NAK.
It is too low level to be useful, and if you will insist on lowering the threshold to something sane,
it will harm already broken situation, there driver does not know if it's working in interrupt or poll mode.

Regards,
Alex.

Zhang Rui wrote:
> From: Ling Ming <ming.m.lin@intel.com>
> 
> Dectect GPE storm and disable a certain GPE if needed.
> 
> Introduce a new module parameter "debug_gpe_storm" as a runtime switch to
> enable/disable this mechanism. The default value is TRUE, user can
> "echo 0 > /sys/modules/acpi/parameters/debug_gpe_storm" to disable it.
> 
> Note: we try to disable a GPE if it's fired more than 1000 times in a second.
> 	And this 1000/s is just a wild guess currently. Need more tests to get a
> 	proper value.
> 
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/events/evgpe.c |   15 +++++++++++-
>  drivers/acpi/system.c       |   55 ++++++++++++++++++++++++++++++++++++++++----
>  include/acpi/acpiosxf.h     |    2 -
>  3 files changed, 65 insertions(+), 7 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/events/evgpe.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/events/evgpe.c	2008-06-20 09:27:00.000000000 +0800
> +++ linux-2.6/drivers/acpi/events/evgpe.c	2008-06-20 09:34:32.000000000 +0800
> @@ -623,7 +623,20 @@
>  
>  	ACPI_FUNCTION_TRACE(ev_gpe_dispatch);
>  
> -	acpi_os_gpe_count(gpe_number);
> +	if (acpi_os_gpe_storm_detect(gpe_number)) {
> +		/*
> +		 * GPE storm detected, disable it automatically
> +		 * To disable gpe storm detection:
> +		 * "echo 0 > /sys/module/acpi/parameters/debug_gpe_storm"
> +		 */
> +		acpi_status status = acpi_ev_disable_gpe(gpe_event_info);
> +		if (ACPI_FAILURE(status)) {
> +			ACPI_EXCEPTION((AE_INFO, status,
> +				"Unable to disable GPE[%2X]", gpe_number));
> +		}
> +
> +		return_UINT32(ACPI_INTERRUPT_NOT_HANDLED);
> +	}
>  
>  	/*
>  	 * If edge-triggered, clear the GPE status bit now.  Note that
> Index: linux-2.6/drivers/acpi/system.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/system.c	2008-06-20 09:27:00.000000000 +0800
> +++ linux-2.6/drivers/acpi/system.c	2008-06-20 09:34:32.000000000 +0800
> @@ -168,9 +168,14 @@
>  #define NUM_COUNTERS_EXTRA 3
>  
>  #define ACPI_EVENT_VALID	0x01
> +#define GPE_STORM_INTERVAL     HZ
> +#define GPE_STORM_THRESHOLD    1000
> +
>  struct event_counter {
>  	u32 count;
>  	u32 flags;
> +	u32 storm;
> +	unsigned long last_time;
>  };
>  
>  static struct event_counter *all_counters;
> @@ -263,20 +268,60 @@
>  	return;
>  }
>  
> -void acpi_os_gpe_count(u32 gpe_number)
> +/*
> + * acpi_gbl_gpe_lock is already acquired in acpi_ev_gpe_detect
> + */
> +int check_gpe_storm(u32 gpe_number)
>  {
> +	struct event_counter *gpe_counter;
> +
> +	if (gpe_number >= num_gpes)
> +		return 0;
> +
> +	gpe_counter = &all_counters[gpe_number];
> +
> +	if (time_after(jiffies, gpe_counter->last_time + GPE_STORM_INTERVAL)) {
> +		gpe_counter->storm = 0;
> +		gpe_counter->last_time = jiffies;
> +	}
> +
> +	gpe_counter->storm++;
> +	if (gpe_counter->storm > GPE_STORM_THRESHOLD) {
> +		printk(KERN_WARNING "GPE[%2X] storm detected,"
> +				"%d interrupts in %d milliseconds.\n",
> +			gpe_number, gpe_counter->storm, GPE_STORM_INTERVAL);
> +		gpe_counter->storm = 0;
> +		gpe_counter->last_time = jiffies;
> +
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static int debug_gpe_storm = 1;
> +module_param(debug_gpe_storm, bool, 0644);
> +
> +int acpi_os_gpe_storm_detect(u32 gpe_number)
> +{
> +	int storm = 0;
> +
>  	acpi_gpe_count++;
>  
>  	if (!all_counters)
> -		return;
> +		return storm;
>  
> -	if (gpe_number < num_gpes)
> +	if (gpe_number < num_gpes) {
>  		all_counters[gpe_number].count++;
> +
> +		/* If debug_gpe_storm enabled, check gpe storm */
> +		if (debug_gpe_storm)
> +			storm = check_gpe_storm(gpe_number);
> +	}
>  	else
>  		all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_ERROR].
>  					count++;
> -
> -	return;
> +	return storm;
>  }
>  
>  void acpi_os_fixed_event_count(u32 event_number)
> Index: linux-2.6/include/acpi/acpiosxf.h
> ===================================================================
> --- linux-2.6.orig/include/acpi/acpiosxf.h	2008-06-20 09:27:00.000000000 +0800
> +++ linux-2.6/include/acpi/acpiosxf.h	2008-06-20 09:34:32.000000000 +0800
> @@ -181,7 +181,7 @@
>  acpi_status
>  acpi_os_remove_interrupt_handler(u32 gsi, acpi_osd_handler service_routine);
>  
> -void acpi_os_gpe_count(u32 gpe_number);
> +int acpi_os_gpe_storm_detect(u32 gpe_number);
>  void acpi_os_fixed_event_count(u32 fixed_event_number);
>  
>  /*
> 
> 

