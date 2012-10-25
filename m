From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/5] cpuidle / ACPI : pass the cpuidle_device parameter
Date: Fri, 26 Oct 2012 01:47:40 +0200
Message-ID: <16289180.eh6G2vqsI9@vostro.rjw.lan>
References: <1350640292-22468-1-git-send-email-daniel.lezcano@linaro.org> <1350640292-22468-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:37935 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751387Ab2JYXnn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Oct 2012 19:43:43 -0400
In-Reply-To: <1350640292-22468-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org

On Friday, October 19, 2012 11:51:30 AM Daniel Lezcano wrote:
> The cpuidle_device is retrieved in the function by using directly
> the global variable. But the caller of this function already have
> this device and it can be passed as a parameter. That is one small
> step to encapsulate the code more.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/acpi/processor_idle.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 9aac69b..5c4330f 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -974,13 +974,14 @@ struct cpuidle_driver acpi_idle_driver = {
>   * device i.e. per-cpu data
>   *
>   * @pr: the ACPI processor
> + * @dev : the cpuidle device
>   */
> -static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr)
> +static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
> +					   struct cpuidle_device *dev)
>  {
>  	int i, count = CPUIDLE_DRIVER_STATE_START;
>  	struct acpi_processor_cx *cx;
>  	struct cpuidle_state_usage *state_usage;
> -	struct cpuidle_device *dev = per_cpu(acpi_cpuidle_device, pr->id);

I'm not sure if that's worth it.  The value of dev should be in the cache
anyway and the way it is makes it clear that this is a per-CPU variable
without tracking the call sequence.

I'm not applying this unless you need it for some further changes.

Thanks,
Rafael


>  
>  	if (!pr->flags.power_setup_done)
>  		return -EINVAL;
> @@ -1132,7 +1133,7 @@ int acpi_processor_hotplug(struct acpi_processor *pr)
>  	cpuidle_disable_device(dev);
>  	acpi_processor_get_power_info(pr);
>  	if (pr->flags.power) {
> -		acpi_processor_setup_cpuidle_cx(pr);
> +		acpi_processor_setup_cpuidle_cx(pr, dev);
>  		ret = cpuidle_enable_device(dev);
>  	}
>  	cpuidle_resume_and_unlock();
> @@ -1189,8 +1190,8 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
>  				continue;
>  			acpi_processor_get_power_info(_pr);
>  			if (_pr->flags.power) {
> -				acpi_processor_setup_cpuidle_cx(_pr);
>  				dev = per_cpu(acpi_cpuidle_device, cpu);
> +				acpi_processor_setup_cpuidle_cx(_pr, dev);
>  				cpuidle_enable_device(dev);
>  			}
>  		}
> @@ -1259,7 +1260,7 @@ int __cpuinit acpi_processor_power_init(struct acpi_processor *pr)
>  			return -ENOMEM;
>  		per_cpu(acpi_cpuidle_device, pr->id) = dev;
>  
> -		acpi_processor_setup_cpuidle_cx(pr);
> +		acpi_processor_setup_cpuidle_cx(pr, dev);
>  
>  		/* Register per-cpu cpuidle_device. Cpuidle driver
>  		 * must already be registered before registering device
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
