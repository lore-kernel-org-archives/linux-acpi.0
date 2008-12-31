From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH] Add decaying history logic to cpuidle menu idle
	predictor
Date: Wed, 31 Dec 2008 09:27:47 +0800
Message-ID: <1230686867.4091.110.camel@yakui_zhao.sh.intel.com>
References: <20081230224602.GA6898@linux-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28798 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751631AbYLaBRo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Dec 2008 20:17:44 -0500
In-Reply-To: <20081230224602.GA6898@linux-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, 2008-12-31 at 06:46 +0800, Pallipadi, Venkatesh wrote:
> Add decaying history of predicted idle time, instead of using the last early
> wakeup. This logic helps menu governor do better job of predicting idle time.
> 
> With this change, we also measured noticable (~8%) power savings on
> a DP server system with CPUs supporting deep C states, when system
> was lightly loaded. There was no change to power or perf on other load
> conditions.
> 
> Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> 
> ---
>  drivers/cpuidle/governors/menu.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6/drivers/cpuidle/governors/menu.c
> ===================================================================
> --- linux-2.6.orig/drivers/cpuidle/governors/menu.c	2008-11-10 15:27:13.000000000 -0800
> +++ linux-2.6/drivers/cpuidle/governors/menu.c	2008-12-30 14:39:15.000000000 -0800
> @@ -15,12 +15,14 @@
>  #include <linux/tick.h>
>  
>  #define BREAK_FUZZ	4	/* 4 us */
> +#define PRED_HISTORY_PCT	50
Hi, Venki
   It seems that the history factor is fixed to 50%. 
   How about adding an interface to change the history factor?

Thanks.
>  
>  struct menu_device {
>  	int		last_state_idx;
>  
>  	unsigned int	expected_us;
>  	unsigned int	predicted_us;
> +	unsigned int    current_predicted_us;
>  	unsigned int	last_measured_us;
>  	unsigned int	elapsed_us;
>  };
> @@ -47,6 +49,12 @@ static int menu_select(struct cpuidle_de
>  	data->expected_us =
>  		(u32) ktime_to_ns(tick_nohz_get_sleep_length()) / 1000;
>  
> +	/* Recalculate predicted_us based on prediction_history_pct */
> +	data->predicted_us *= PRED_HISTORY_PCT;
> +	data->predicted_us += (100 - PRED_HISTORY_PCT) *
> +				data->current_predicted_us;
> +	data->predicted_us /= 100;
> +
>  	/* find the deepest idle state that satisfies our constraints */
>  	for (i = CPUIDLE_DRIVER_STATE_START + 1; i < dev->state_count; i++) {
>  		struct cpuidle_state *s = &dev->states[i];
> @@ -97,7 +105,7 @@ static void menu_reflect(struct cpuidle_
>  		measured_us = -1;
>  
>  	/* Predict time until next break event */
> -	data->predicted_us = max(measured_us, data->last_measured_us);
> +	data->current_predicted_us = max(measured_us, data->last_measured_us);
>  
>  	if (last_idle_us + BREAK_FUZZ <
>  	    data->expected_us - target->exit_latency) {

