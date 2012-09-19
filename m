From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/3] cpuidle : rename function name "__cpuidle_register_driver"
Date: Wed, 19 Sep 2012 21:51:03 +0200
Message-ID: <201209192151.03236.rjw@sisk.pl>
References: <1348075369-16451-1-git-send-email-daniel.lezcano@linaro.org> <1348075369-16451-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:34506 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044Ab2ISTod (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Sep 2012 15:44:33 -0400
In-Reply-To: <1348075369-16451-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org

On Wednesday, September 19, 2012, Daniel Lezcano wrote:
> Clarify the purpose of the function by changing its name and
> move the condition out of this function.

Why exactly are you removing the condition?

Rafael


> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/driver.c |   15 ++++++++-------
>  1 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 40cd3f3..774d2cb 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -17,9 +17,10 @@
>  static struct cpuidle_driver *cpuidle_curr_driver;
>  DEFINE_SPINLOCK(cpuidle_driver_lock);
>  
> -static void __cpuidle_register_driver(struct cpuidle_driver *drv)
> +static void set_power_states(struct cpuidle_driver *drv)
>  {
>  	int i;
> +
>  	/*
>  	 * cpuidle driver should set the drv->power_specified bit
>  	 * before registering if the driver provides
> @@ -34,10 +35,8 @@ static void __cpuidle_register_driver(struct cpuidle_driver *drv)
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
>  
> @@ -58,8 +57,10 @@ int cpuidle_register_driver(struct cpuidle_driver *drv)
>  		spin_unlock(&cpuidle_driver_lock);
>  		return -EBUSY;
>  	}
> -	__cpuidle_register_driver(drv);
> -	cpuidle_curr_driver = drv;
> +
> +	if (!drv->power_specified)
> +		set_power_states(drv);
> +
>  	spin_unlock(&cpuidle_driver_lock);
>  
>  	return 0;
> 

