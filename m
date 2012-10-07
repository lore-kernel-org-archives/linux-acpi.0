From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH 2/4] cpuidle : move driver checking within the lock section
Date: Sun, 07 Oct 2012 22:17:15 +0200
Message-ID: <1719250.lMrW2bZ9vi@vostro.rjw.lan>
References: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org>
	<1348526634-19029-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1348526634-19029-3-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday 25 of September 2012 00:43:52 Daniel Lezcano wrote:
> The code checks if the driver is already set without taking the lock,
> but, right after, it takes the lock to assign the variable.
> 
> If it is safe to check the variable without lock, then it is safe to
> assign it without lock. If it is unsafe to assign without a lock, then
> it is unsafe to check it without a lock.
> 
> I don't find a path in the different drivers where that could happen
> because the arch specific drivers are written in such way it is not
> possible to register a driver while it is unregistered, except maybe
> in a very improbable case when "intel_idle" and "processor_idle" are
> competing. One could unregister a driver, while the other one is
> registering.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

The code looks generally OK (a minor nit below), but I'm not really sure what
you wanted to say in the changelog.  It would suffice to say that the existing
code is racy and either we don't need to take the spinlock in
cpuidle_unregister_driver() at all, or we should put the test under the
spinlock as well as the modification.

> ---
>  drivers/cpuidle/driver.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 39ba8e1..4a0c4ab 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -85,17 +85,17 @@ EXPORT_SYMBOL_GPL(cpuidle_get_driver);
>   */
>  void cpuidle_unregister_driver(struct cpuidle_driver *drv)
>  {
> +	spin_lock(&cpuidle_driver_lock);
> +
>  	if (drv != cpuidle_curr_driver) {
>  		WARN(1, "invalid cpuidle_unregister_driver(%s)\n",
>  			drv->name);

It is not necessary to execute the WARN() under the spinlock.

> -		return;
> +		goto out;
>  	}
>  
> -	spin_lock(&cpuidle_driver_lock);
> -
>  	if (!WARN_ON(drv->refcnt > 0))
>  		cpuidle_curr_driver = NULL;
> -
> +out:
>  	spin_unlock(&cpuidle_driver_lock);
>  }
>  EXPORT_SYMBOL_GPL(cpuidle_unregister_driver);

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
