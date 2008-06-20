From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH 2/2] ACPI: detect GPE interrupt storm
Date: Fri, 20 Jun 2008 01:26:54 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806200120230.22284@localhost.localdomain>
References: <1213926172.3001.10.camel@rzhang-dt.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:38543 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbYFTF1I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 01:27:08 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2Q00FJHXSWKTM2@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 00:26:57 -0500 (CDT)
In-reply-to: <1213926172.3001.10.camel@rzhang-dt.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>


A GPE storm is a bug.

I think the mechanism in the previous patch to deal with that
failure is sufficient.  I don't like embedding heuristic policy
into the kernel all for the benefit of broken systems.
We'll never know if the heuristic is correct, and there
is always the risk that we impact an otherwise working system.

User-space can detect a GPE storm via /proc/interrupts
and /sys/firmware/acpi/interrupts, and handle it that way.
(and then we can debug the root cause of the failure,
 rather than have it hidden by the kernel)

-Len


On Fri, 20 Jun 2008, Zhang Rui wrote:

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
