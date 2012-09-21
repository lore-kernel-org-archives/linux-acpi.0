From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH][V2] cpuidle : rename function name "__cpuidle_register_driver"
Date: Sat, 22 Sep 2012 00:51:52 +0200
Message-ID: <201209220051.52681.rjw@sisk.pl>
References: <1348144884-14911-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:39314 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754581Ab2IUWpV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Sep 2012 18:45:21 -0400
In-Reply-To: <1348144884-14911-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org

On Thursday, September 20, 2012, Daniel Lezcano wrote:
> The function __cpuidle_register_driver name is confusing because it
> suggests, conforming to the coding style of the kernel, it registers
> the driver without taking a lock. Actually, it just fill the different
> power field states with a decresing value if the power has not been
> specified.
> 
> Clarify the purpose of the function by changing its name and
> move the condition out of this function.
> 
> This patch fix nothing and does not change the behavior of the
> function. It is just for the sake of clarity.
> 
> IHMO, reading in the code:
> 
> +       if (!drv->power_specified)
> +               set_power_states(drv);
> 
> is much more explicit than:
> 
> -       __cpuidle_register_driver(drv);
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Applied to the linux-next branch of the linux-pm.git tree as v3.7 material.

Thanks,
Rafael


> ---
>  drivers/cpuidle/driver.c |   15 +++++++++------
>  1 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 424bc81..87db387 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -18,9 +18,10 @@ static struct cpuidle_driver *cpuidle_curr_driver;
>  DEFINE_SPINLOCK(cpuidle_driver_lock);
>  int cpuidle_driver_refcount;
>  
> -static void __cpuidle_register_driver(struct cpuidle_driver *drv)
> +static void set_power_states(struct cpuidle_driver *drv)
>  {
>  	int i;
> +
>  	/*
>  	 * cpuidle driver should set the drv->power_specified bit
>  	 * before registering if the driver provides
> @@ -35,10 +36,8 @@ static void __cpuidle_register_driver(struct cpuidle_driver *drv)
>  	 * an power value of -1.  So we use -2, -3, etc, for other
>  	 * c-states.
>  	 */
> -	if (!drv->power_specified) {
> -		for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++)
> -			drv->states[i].power_usage = -1 - i;
> -	}
> +	for (i = CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++)
> +		drv->states[i].power_usage = -1 - i;
>  }
>  
>  /**
> @@ -58,8 +57,12 @@ int cpuidle_register_driver(struct cpuidle_driver *drv)
>  		spin_unlock(&cpuidle_driver_lock);
>  		return -EBUSY;
>  	}
> -	__cpuidle_register_driver(drv);
> +
> +	if (!drv->power_specified)
> +		set_power_states(drv);
> +
>  	cpuidle_curr_driver = drv;
> +
>  	spin_unlock(&cpuidle_driver_lock);
>  
>  	return 0;
> 

