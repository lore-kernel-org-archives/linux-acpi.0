From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH 2/6] acpi : move cpuidle_device field out of the
 acpi_processor_power structure
Date: Fri, 7 Sep 2012 16:33:52 +0530
Message-ID: <CAP245DX=M7uCc8owwefa-V1YAgYUie+DSnm289ur0t4tYJHAJw@mail.gmail.com>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org>
	<1347013172-12465-3-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:55197 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760317Ab2IGLDx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Sep 2012 07:03:53 -0400
Received: by vbbff1 with SMTP id ff1so3038710vbb.19
        for <linux-acpi@vger.kernel.org>; Fri, 07 Sep 2012 04:03:52 -0700 (PDT)
In-Reply-To: <1347013172-12465-3-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, lenb@kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, pdeschrijver@nvidia.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Sep 7, 2012 at 3:49 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> Currently we have the cpuidle_device field in the acpi_processor_power structure.
> This adds a dependency in processor.h for cpuidle.h.
>
> In order to be consistent with the rest of the drivers and for the per cpu states
> coming right after this patch, this one move out of the acpi_processor_power
> structure the cpuidle_device field.

Reword a little to make it easier to read:

In order to be consistent with the rest of the drivers and for the
per-cpu states coming after this patch, this patch moves the
cpuidle_device field out of the acpi_processor_power structure.

> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Tested-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/acpi/processor_idle.c |   25 ++++++++++++++++++-------
>  include/acpi/processor.h      |    2 --
>  2 files changed, 18 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index de89624..084b1d2 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -79,6 +79,8 @@ module_param(bm_check_disable, uint, 0000);
>  static unsigned int latency_factor __read_mostly = 2;
>  module_param(latency_factor, uint, 0644);
>
> +static DEFINE_PER_CPU(struct cpuidle_device, acpi_cpuidle_device);
> +
>  static int disabled_by_idle_boot_param(void)
>  {
>         return boot_option_idle_override == IDLE_POLL ||
> @@ -998,7 +1000,7 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr)
>         int i, count = CPUIDLE_DRIVER_STATE_START;
>         struct acpi_processor_cx *cx;
>         struct cpuidle_state_usage *state_usage;
> -       struct cpuidle_device *dev = &pr->power.dev;
> +       struct cpuidle_device *dev = &per_cpu(acpi_cpuidle_device, pr->id);
>
>         if (!pr->flags.power_setup_done)
>                 return -EINVAL;
> @@ -1130,6 +1132,7 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
>  int acpi_processor_hotplug(struct acpi_processor *pr)
>  {
>         int ret = 0;
> +       struct cpuidle_device *dev = &per_cpu(acpi_cpuidle_device, pr->id);
>
>         if (disabled_by_idle_boot_param())
>                 return 0;
> @@ -1145,11 +1148,11 @@ int acpi_processor_hotplug(struct acpi_processor *pr)
>                 return -ENODEV;
>
>         cpuidle_pause_and_lock();
> -       cpuidle_disable_device(&pr->power.dev);
> +       cpuidle_disable_device(dev);
>         acpi_processor_get_power_info(pr);
>         if (pr->flags.power) {
>                 acpi_processor_setup_cpuidle_cx(pr);
> -               ret = cpuidle_enable_device(&pr->power.dev);
> +               ret = cpuidle_enable_device(dev);
>         }
>         cpuidle_resume_and_unlock();
>
> @@ -1160,6 +1163,7 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
>  {
>         int cpu;
>         struct acpi_processor *_pr;
> +       struct cpuidle_device *dev;
>
>         if (disabled_by_idle_boot_param())
>                 return 0;
> @@ -1190,7 +1194,8 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
>                         _pr = per_cpu(processors, cpu);
>                         if (!_pr || !_pr->flags.power_setup_done)
>                                 continue;
> -                       cpuidle_disable_device(&_pr->power.dev);
> +                       dev = &per_cpu(acpi_cpuidle_device, cpu);
> +                       cpuidle_disable_device(dev);
>                 }
>
>                 /* Populate Updated C-state information */
> @@ -1204,7 +1209,8 @@ int acpi_processor_cst_has_changed(struct acpi_processor *pr)
>                         acpi_processor_get_power_info(_pr);
>                         if (_pr->flags.power) {
>                                 acpi_processor_setup_cpuidle_cx(_pr);
> -                               cpuidle_enable_device(&_pr->power.dev);
> +                               dev = &per_cpu(acpi_cpuidle_device, cpu);
> +                               cpuidle_enable_device(dev);
>                         }
>                 }
>                 put_online_cpus();
> @@ -1221,6 +1227,7 @@ int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
>  {
>         acpi_status status = 0;
>         int retval;
> +       struct cpuidle_device *dev;
>         static int first_run;
>
>         if (disabled_by_idle_boot_param())
> @@ -1270,7 +1277,9 @@ int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
>                  * must already be registered before registering device
>                  */
>                 acpi_processor_setup_cpuidle_cx(pr);
> -               retval = cpuidle_register_device(&pr->power.dev);
> +
> +               dev = &per_cpu(acpi_cpuidle_device, pr->id);
> +               retval = cpuidle_register_device(dev);
>                 if (retval) {
>                         if (acpi_processor_registered == 0)
>                                 cpuidle_unregister_driver(&acpi_idle_driver);
> @@ -1284,11 +1293,13 @@ int __cpuinit acpi_processor_power_init(struct acpi_processor *pr,
>  int acpi_processor_power_exit(struct acpi_processor *pr,
>                               struct acpi_device *device)
>  {
> +       struct cpuidle_device *dev = &per_cpu(acpi_cpuidle_device, pr->id);
> +
>         if (disabled_by_idle_boot_param())
>                 return 0;
>
>         if (pr->flags.power) {
> -               cpuidle_unregister_device(&pr->power.dev);
> +               cpuidle_unregister_device(dev);
>                 acpi_processor_registered--;
>                 if (acpi_processor_registered == 0)
>                         cpuidle_unregister_driver(&acpi_idle_driver);
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 8b2c39a..4d98ec8 100644
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
> -       struct cpuidle_device dev;
>         struct acpi_processor_cx *state;
>         unsigned long bm_check_timestamp;
>         u32 default_state;
> --
> 1.7.5.4
>
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev@lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
