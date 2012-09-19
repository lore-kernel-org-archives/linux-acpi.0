From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] cpuidle : remove unused ref count function
Date: Wed, 19 Sep 2012 21:49:37 +0200
Message-ID: <201209192149.38164.rjw@sisk.pl>
References: <1348075369-16451-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:34496 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799Ab2ISTnJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Sep 2012 15:43:09 -0400
In-Reply-To: <1348075369-16451-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org

On Wednesday, September 19, 2012, Daniel Lezcano wrote:
> These two functions are never used.

This is not the case.  pm_genpd_attach_cpuidle() and
pm_genpd_detach_cpuidle() use them.

Please be more careful.

Thanks,
Rafael


> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/driver.c |   29 +----------------------------
>  include/linux/cpuidle.h  |    4 ----
>  2 files changed, 1 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 58bf3b1..40cd3f3 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -16,7 +16,6 @@
>  
>  static struct cpuidle_driver *cpuidle_curr_driver;
>  DEFINE_SPINLOCK(cpuidle_driver_lock);
> -int cpuidle_driver_refcount;
>  
>  static void __cpuidle_register_driver(struct cpuidle_driver *drv)
>  {
> @@ -90,34 +89,8 @@ void cpuidle_unregister_driver(struct cpuidle_driver *drv)
>  	}
>  
>  	spin_lock(&cpuidle_driver_lock);
> -
> -	if (!WARN_ON(cpuidle_driver_refcount > 0))
> -		cpuidle_curr_driver = NULL;
> -
> +	cpuidle_curr_driver = NULL;
>  	spin_unlock(&cpuidle_driver_lock);
>  }
>  
>  EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);
> -
> -struct cpuidle_driver *cpuidle_driver_ref(void)
> -{
> -	struct cpuidle_driver *drv;
> -
> -	spin_lock(&cpuidle_driver_lock);
> -
> -	drv = cpuidle_curr_driver;
> -	cpuidle_driver_refcount++;
> -
> -	spin_unlock(&cpuidle_driver_lock);
> -	return drv;
> -}
> -
> -void cpuidle_driver_unref(void)
> -{
> -	spin_lock(&cpuidle_driver_lock);
> -
> -	if (!WARN_ON(cpuidle_driver_refcount <= 0))
> -		cpuidle_driver_refcount--;
> -
> -	spin_unlock(&cpuidle_driver_lock);
> -}
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 279b1ea..5abf62b 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -145,8 +145,6 @@ extern void disable_cpuidle(void);
>  extern int cpuidle_idle_call(void);
>  extern int cpuidle_register_driver(struct cpuidle_driver *drv);
>  extern struct cpuidle_driver *cpuidle_get_driver(void);
> -extern struct cpuidle_driver *cpuidle_driver_ref(void);
> -extern void cpuidle_driver_unref(void);
>  extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
>  extern int cpuidle_register_device(struct cpuidle_device *dev);
>  extern void cpuidle_unregister_device(struct cpuidle_device *dev);
> @@ -169,8 +167,6 @@ static inline int cpuidle_idle_call(void) { return -ENODEV; }
>  static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
>  {return -ENODEV; }
>  static inline struct cpuidle_driver *cpuidle_get_driver(void) {return NULL; }
> -static inline struct cpuidle_driver *cpuidle_driver_ref(void) {return NULL; }
> -static inline void cpuidle_driver_unref(void) {}
>  static inline void cpuidle_unregister_driver(struct cpuidle_driver *drv) { }
>  static inline int cpuidle_register_device(struct cpuidle_device *dev)
>  {return -ENODEV; }
> 

