From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/3] cpuidle : remove trailing carriage return
Date: Wed, 19 Sep 2012 22:16:17 +0200
Message-ID: <201209192216.17390.rjw@sisk.pl>
References: <1348075369-16451-1-git-send-email-daniel.lezcano@linaro.org> <1348075369-16451-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:34553 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407Ab2ISUJs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Sep 2012 16:09:48 -0400
In-Reply-To: <1348075369-16451-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org

On Wednesday, September 19, 2012, Daniel Lezcano wrote:
> This mindless patch is just about removing some trailing
> carriage returns.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Applied.

Thanks,
Rafael


> ---
>  drivers/cpuidle/driver.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 774d2cb..fc8bfc2 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -39,7 +39,6 @@ static void set_power_states(struct cpuidle_driver *drv)
>  		drv->states[i].power_usage = -1 - i;
>  }
>  
> -
>  /**
>   * cpuidle_register_driver - registers a driver
>   * @drv: the driver
> @@ -65,7 +64,6 @@ int cpuidle_register_driver(struct cpuidle_driver *drv)
>  
>  	return 0;
>  }
> -
>  EXPORT_SYMBOL_GPL(cpuidle_register_driver);
>  
>  /**
> @@ -93,5 +91,4 @@ void cpuidle_unregister_driver(struct cpuidle_driver *drv)
>  	cpuidle_curr_driver = NULL;
>  	spin_unlock(&cpuidle_driver_lock);
>  }
> -
>  EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
> 

