From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/5][RFC] cpuidle : add cpuidle_register_states function
Date: Fri, 27 Jul 2012 11:24:38 +0530
Message-ID: <50122D1E.5040207@linux.vnet.ibm.com>
References: <1343213162-8064-1-git-send-email-daniel.lezcano@linaro.org> <1343213162-8064-6-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:45939 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528Ab2G0Fyq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Jul 2012 01:54:46 -0400
Received: from /spool/local
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <deepthi@linux.vnet.ibm.com>;
	Fri, 27 Jul 2012 15:54:26 +1000
In-Reply-To: <1343213162-8064-6-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, linaro-dev@lists.linaro.org

On 07/25/2012 04:16 PM, Daniel Lezcano wrote:

> The tegra3 and big.LITTLE architecture have different cpu latencies.
> This API allows to specify a different cpu latency for a specific cpu.
> 
> With the previous patches, we use the per cpuidle device states pointer,
> this function overrides this pointer.
> 


May be add some more explanation and pointers to previous discussions,
as stated on the cover in the patch series.


> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>


Acked-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>

> ---
>  drivers/cpuidle/cpuidle.c |   17 +++++++++++++++++
>  include/linux/cpuidle.h   |   10 +++++++---
>  2 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 199878a..3b21b68 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -456,6 +456,23 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)
> 
>  EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
> 
> +int cpuidle_register_states(struct cpuidle_device *dev,
> +			    struct cpuidle_state *states,
> +			    int state_count)
> +{
> +	if (!dev || !states)
> +		return -EINVAL;
> +
> +	if (state_count <= 0)
> +		return -EINVAL;
> +
> +	dev->states = states;
> +	dev->state_count = state_count;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cpuidle_register_state);
> +
>  #ifdef CONFIG_SMP
> 
>  static void smp_callback(void *v)
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 40a04a1..425200d 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -144,7 +144,9 @@ extern void cpuidle_driver_unref(void);
>  extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
>  extern int cpuidle_register_device(struct cpuidle_device *dev);
>  extern void cpuidle_unregister_device(struct cpuidle_device *dev);
> -
> +extern int cpuidle_register_states(struct cpuidle_device *dev,
> +				   struct cpuidle_state *states,
> +				   int state_count);
>  extern void cpuidle_pause_and_lock(void);
>  extern void cpuidle_resume_and_unlock(void);
>  extern void cpuidle_pause(void);
> @@ -156,7 +158,6 @@ extern int cpuidle_wrap_enter(struct cpuidle_device *dev,
>  				int (*enter)(struct cpuidle_device *dev,
>  					struct cpuidle_driver *drv, int index));
>  extern int cpuidle_play_dead(void);
> -
>  #else
>  static inline void disable_cpuidle(void) { }
>  static inline int cpuidle_idle_call(void) { return -ENODEV; }
> @@ -169,7 +170,10 @@ static inline void cpuidle_unregister_driver(struct cpuidle_driver *drv) { }
>  static inline int cpuidle_register_device(struct cpuidle_device *dev)
>  {return -ENODEV; }
>  static inline void cpuidle_unregister_device(struct cpuidle_device *dev) { }
> -
> +static inline  int cpuidle_register_states(struct cpuidle_device *dev,
> +					   struct cpuidle_state *states,
> +					   int state_count)
> +{ return -ENODEV; }
>  static inline void cpuidle_pause_and_lock(void) { }
>  static inline void cpuidle_resume_and_unlock(void) { }
>  static inline void cpuidle_pause(void) { }


