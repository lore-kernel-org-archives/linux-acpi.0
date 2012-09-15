From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Subject: Re: [PATCH 1/3] acpi : move cpuidle_device field out of the
	acpi_processor_power structure
Date: Sat, 15 Sep 2012 22:44:06 +0200
Message-ID: <201209152244.06800.rjw@sisk.pl>
References: <1347614736-9553-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1347614736-9553-1-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Friday, September 14, 2012, Daniel Lezcano wrote:
> Currently we have the cpuidle_device field in the acpi_processor_power structure.
> This adds a dependency between processor.h and cpuidle.h
> 
> Although it is not a real problem, removing this dependency has the benefit of
> separating a bit more the cpuidle code from the rest of the acpi code.
> Also, the compilation should be a bit improved because we do no longer
> include cpuidle.h in processor.h. The preprocessor was generating 30418 loc
> and with this patch it generates 30256 loc for processor_thermal.c, a file
> which is not concerned at all by cpuidle, like processor_perflib.c and
> processor_throttling.c.
> 
> That may sound ridiculous, but "small streams make big rivers" :P
> 
> This patch moves this field into a static global per cpu variable like what is
> done in the intel_idle driver.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

I'm inclined to take this one for v3.7.

Len, other ACPI guys, any objections, comments?

Rafael


> ---
>  drivers/acpi/processor_idle.c |   32 ++++++++++++++++++++++++--------
>  include/acpi/processor.h      |    2 --
>  2 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index de89624..0a6405d 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -79,6 +79,8 @@ module_param(bm_check_disable, uint, 0000);
>  static unsigned int latency_factor __read_mostly = 2;
>  module_param(latency_factor, uint, 0644);
>  
> +static DEFINE_PER_CPU(struct cpuidle_device *, acpi_cpuidle_device);
> +
>  static int disabled_by_idle_boot_param(void)
>  {
>  	return boot_option_idle_override == IDLE_POLL ||
> @@ -998,7 +1000,7 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr)
>  	int i, count = CPUIDLE_DRIVER_STATE_START;
>  	struct acpi_processor_cx *cx;
>  	struct cpuidle_state_usage *state_usage;
> -	struct cpuidle_device *dev = &pr->power.dev;
> +	struct cpuidle_device *dev = per_cpu(acpi_cpuidle_device, pr->id);
>  
>  	if (!pr->flags.power_setup_done)
>  		return -EINVAL;
> @@ -1130,6 +1132,7 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
>  int acpi_processor_hotplug(struct acpi_processor *pr)
>  {
>  	int ret = 0;
> +	struct cpuidle_device *dev = per_cpu(acpi_cpuidle_device, pr->id);
>  
>  	if (disabled_by_idle_boot_param())
>  		return 0;
> @@ -1145,11 +1148,11 @@ int acpi_processor_hotplug(struct acpi_processor *pr)
>  		return -ENODEV;
>  
>  	cpuidle_pause_and_lock();
> -	cpuidle_disable_device(&pr->power.dev);
> +	cpuidle_disable_device(dev);
>  	acpi_processor_get_power_info(pr);
>  	if (pr->flags.power) {
>  		acpi_processor_setup_cpuidle_cx(pr);
> -		ret = cpuidle_enable_device(&pr->power.dev);
> +		ret = cpuidle_enable_device(dev);
>  	}
>  	cpuidle_resume_and_unlock();
>  
> @@ -1160,6 +1163,7 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
>  {
>  	int cpu;
>  	struct acpi_processor *_pr;
> +	struct cpuidle_device *dev;
>  
>  	if (disabled_by_idle_boot_param())
>  		return 0;
> @@ -1190,7 +1194,8 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
>  			_pr = per_cpu(processors, cpu);
>  			if (!_pr || !_pr->flags.power_setup_done)
>  				continue;
> -			cpuidle_disable_device(&_pr->power.dev);
> +			dev = per_cpu(acpi_cpuidle_device, cpu);
> +			cpuidle_disable_device(dev);
>  		}
>  
>  		/* Populate Updated C-state information */
> @@ -1204,7 +1209,8 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
>  			acpi_processor_get_power_info(_pr);
>  			if (_pr->flags.power) {
>  				acpi_processor_setup_cpuidle_cx(_pr);
> -				cpuidle_enable_device(&_pr->power.dev);
> +				dev = per_cpu(acpi_cpuidle_device, cpu);
> +				cpuidle_enable_device(dev);
>  			}
>  		}
>  		put_online_cpus();
> @@ -1221,6 +1227,7 @@ int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
>  {
>  	acpi_status status = 0;
>  	int retval;
> +	struct cpuidle_device *dev;
>  	static int first_run;
>  
>  	if (disabled_by_idle_boot_param())
> @@ -1266,11 +1273,18 @@ int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
>  			printk(KERN_DEBUG "ACPI: %s registered with cpuidle\n",
>  					acpi_idle_driver.name);
>  		}
> +
> +		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +		if (!dev)
> +			return -ENOMEM;
> +		per_cpu(acpi_cpuidle_device, pr->id) = dev;
> +
> +		acpi_processor_setup_cpuidle_cx(pr);
> +
>  		/* Register per-cpu cpuidle_device. Cpuidle driver
>  		 * must already be registered before registering device
>  		 */
> -		acpi_processor_setup_cpuidle_cx(pr);
> -		retval = cpuidle_register_device(&pr->power.dev);
> +		retval = cpuidle_register_device(dev);
>  		if (retval) {
>  			if (acpi_processor_registered == 0)
>  				cpuidle_unregister_driver(&acpi_idle_driver);
> @@ -1284,11 +1298,13 @@ int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
>  int acpi_processor_power_exit(struct acpi_processor *pr,
>  			      struct acpi_device *device)
>  {
> +	struct cpuidle_device *dev = per_cpu(acpi_cpuidle_device, pr->id);
> +
>  	if (disabled_by_idle_boot_param())
>  		return 0;
>  
>  	if (pr->flags.power) {
> -		cpuidle_unregister_device(&pr->power.dev);
> +		cpuidle_unregister_device(dev);
>  		acpi_processor_registered--;
>  		if (acpi_processor_registered == 0)
>  			cpuidle_unregister_driver(&acpi_idle_driver);
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index db427fa..ddd1a44 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -3,7 +3,6 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/cpu.h>
> -#include <linux/cpuidle.h>
>  #include <linux/thermal.h>
>  #include <asm/acpi.h>
>  
> @@ -64,7 +63,6 @@ struct acpi_processor_cx {
>  };
>  
>  struct acpi_processor_power {
> -	struct cpuidle_device dev;
>  	struct acpi_processor_cx *state;
>  	unsigned long bm_check_timestamp;
>  	u32 default_state;
> 
