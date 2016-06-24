From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v6 4/5] arm64: add support for ACPI Low Power Idle(LPI)
Date: Fri, 24 Jun 2016 23:04:07 +0200
Message-ID: <576DA047.7080808@linaro.org>
References: <1465915719-8409-1-git-send-email-sudeep.holla@arm.com>
 <1465915719-8409-5-git-send-email-sudeep.holla@arm.com>
 <20160622141700.GB2733@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38559 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbcFXVEK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jun 2016 17:04:10 -0400
Received: by mail-wm0-f44.google.com with SMTP id r201so40173952wme.1
        for <linux-acpi@vger.kernel.org>; Fri, 24 Jun 2016 14:04:09 -0700 (PDT)
In-Reply-To: <20160622141700.GB2733@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vikas Sajjan <vikas.cha.sajjan@hpe.com>, Sunil <sunil.vl@hpe.com>, Prashanth Prakash <pprakash@codeaurora.org>, Al Stone <al.stone@linaro.org>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org

On 06/22/2016 04:17 PM, Lorenzo Pieralisi wrote:
> Hi Sudeep,
>
> On Tue, Jun 14, 2016 at 03:48:38PM +0100, Sudeep Holla wrote:
>> This patch adds appropriate callbacks to support ACPI Low Power Idle
>> (LPI) on ARM64.
>>
>> Now that arm_enter_idle_state is exactly same in both generic ARM{32=
,64}
>> CPUIdle driver and ARM64 backend for ACPI processor idle driver, we =
can
>> unify it and move to cpuidle-arm.h header.
>>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   arch/arm64/kernel/cpuidle.c   | 17 +++++++++++++
>>   drivers/cpuidle/cpuidle-arm.c | 23 ++----------------
>>   drivers/firmware/psci.c       | 56 +++++++++++++++++++++++++++++++=
++++++++++++
>>   include/linux/cpuidle-arm.h   | 30 +++++++++++++++++++++++
>>   4 files changed, 105 insertions(+), 21 deletions(-)
>>   create mode 100644 include/linux/cpuidle-arm.h
>
> This patch seems fine by me, it would be good if Daniel can have
> a look too.
>
> Some minor comments below.
>
> [...]
>
>> diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
>> index 03e04582791c..c6caa863d156 100644
>> --- a/drivers/firmware/psci.c
>> +++ b/drivers/firmware/psci.c
>> @@ -13,6 +13,7 @@
>>
>>   #define pr_fmt(fmt) "psci: " fmt
>>
>> +#include <linux/acpi.h>
>>   #include <linux/arm-smccc.h>
>>   #include <linux/cpuidle.h>
>>   #include <linux/errno.h>
>> @@ -310,11 +311,66 @@ static int psci_dt_cpu_init_idle(struct device=
_node *cpu_node, int cpu)
>>   	return ret;
>>   }
>>
>> +#ifdef CONFIG_ACPI
>> +#include <acpi/processor.h>
>> +
>> +static int __maybe_unused psci_acpi_cpu_init_idle(unsigned int cpu)
>> +{
>> +	int i, count;
>> +	u32 *psci_states;
>> +	struct acpi_processor *pr;
>> +	struct acpi_lpi_state *lpi;
>> +
>> +	pr =3D per_cpu(processors, cpu);
>> +	if (unlikely(!pr || !pr->flags.has_lpi))
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * If the PSCI cpu_suspend function hook has not been initialized
>> +	 * idle states must not be enabled, so bail out
>> +	 */
>> +	if (!psci_ops.cpu_suspend)
>> +		return -EOPNOTSUPP;
>> +
>> +	count =3D pr->power.count - 1;
>> +	if (count <=3D 0)
>> +		return -ENODEV;
>> +
>> +	psci_states =3D kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
>> +	if (!psci_states)
>> +		return -ENOMEM;
>> +
>> +	for (i =3D 0; i < count; i++) {
>> +		u32 state;
>> +
>> +		lpi =3D &pr->power.lpi_states[i + 1];
>> +		state =3D lpi->address & 0xFFFFFFFF;

Why is needed to mask 'address' ?

>> +		if (!psci_power_state_is_valid(state)) {
>> +			pr_warn("Invalid PSCI power state %#x\n", state);
>> +			kfree(psci_states);
>> +			return -EINVAL;
>> +		}
>> +		psci_states[i] =3D state;
>> +	}
>> +	/* Idle states parsed correctly, initialize per-cpu pointer */
>> +	per_cpu(psci_power_state, cpu) =3D psci_states;
>> +	return 0;
>
> Most of the code in this function is FW independent, it would be nice
> to factor it out and add the respective ACPI/DT helper functions to
> retrieve idle states count and parameters, we can update it later
> anyway it is fine by me to leave it as it is.
>
>> +}
>> +#else
>> +static int __maybe_unused psci_acpi_cpu_init_idle(unsigned int cpu)
>> +{
>> +	return -EINVAL;
>> +}
>> +#endif
>> +
>>   int psci_cpu_init_idle(unsigned int cpu)
>>   {
>>   	struct device_node *cpu_node;
>>   	int ret;
>>
>> +	if (!acpi_disabled)
>> +		return psci_acpi_cpu_init_idle(cpu);

Is it possible the case where there is information in both the DT and i=
n=20
ACPI ? So ACPI is enabled without idle information which is in the DT ?

>>   	cpu_node =3D of_get_cpu_node(cpu, NULL);
>>   	if (!cpu_node)
>>   		return -ENODEV;
>> diff --git a/include/linux/cpuidle-arm.h b/include/linux/cpuidle-arm=
=2Eh
>> new file mode 100644
>> index 000000000000..b99bcb3f43dd
>> --- /dev/null
>> +++ b/include/linux/cpuidle-arm.h
>
> arm-cpuidle.h for consistency with other (ARM) include/linux files ?
>
>> @@ -0,0 +1,30 @@
>> +#include <linux/cpu_pm.h>
>> +
>> +#include <asm/cpuidle.h>
>> +
>> +/*
>> + * arm_enter_idle_state - Programs CPU to enter the specified state
>> + */
>> +static int arm_generic_enter_idle_state(int idx)
>> +{
>> +	int ret;
>> +
>> +	if (!idx) {
>> +		cpu_do_idle();
>> +		return idx;
>> +	}
>> +
>> +	ret =3D cpu_pm_enter();
>> +	if (!ret) {
>> +		/*
>> +		 * Pass idle state index to cpu_suspend which in turn will
>> +		 * call the CPU ops suspend protocol with idle index as a
>> +		 * parameter.
>> +		 */
>> +		ret =3D arm_cpuidle_suspend(idx);
>> +
>> +		cpu_pm_exit();
>> +	}
>> +
>> +	return ret ? -1 : idx;
>> +}
>
> Either you do this, or we have to add it somehow somewhere in
> drivers/cpuidle to avoid duplicating it.
>
> @Daniel: do you have an opinion on this please ?

Yes, this function should be added to avoid duplication.

  -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
