From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 4/4] cpuidle - support multiple drivers
Date: Thu, 11 Oct 2012 19:39:12 +0200
Message-ID: <50770440.2010905@linaro.org>
References: <1348526634-19029-1-git-send-email-daniel.lezcano@linaro.org> <2357350.9DgMVa61GL@vostro.rjw.lan> <507699B5.3010702@linaro.org> <9187353.riJYJYPsk3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44909 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964797Ab2JKRjS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Oct 2012 13:39:18 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1144163bkc.19
        for <linux-acpi@vger.kernel.org>; Thu, 11 Oct 2012 10:39:17 -0700 (PDT)
In-Reply-To: <9187353.riJYJYPsk3@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linaro-dev@lists.linaro.org, patches@linaro.org, pdeschrijver@nvidia.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org

On 10/11/2012 07:21 PM, Rafael J. Wysocki wrote:
> On Thursday 11 of October 2012 12:04:37 Daniel Lezcano wrote:
>> On 10/07/2012 11:26 PM, Rafael J. Wysocki wrote:
>>> On Tuesday 25 of September 2012 00:43:54 Daniel Lezcano wrote:
>>>> With the tegra3 and the big.LITTLE [1] new architectures, several =
cpus
>>>> with different characteristics (latencies and states) can co-exist=
s on the
>>>> system.
>>>>
>>>> The cpuidle framework has the limitation of handling only identica=
l cpus.
>>>>
>>>> This patch removes this limitation by introducing the multiple dri=
ver support
>>>> for cpuidle.
>>>>
>>>> This option is configurable at compile time and should be enabled =
for the
>>>> architectures mentioned above. So there is no impact for the other=
 platforms
>>>> if the option is disabled. The option defaults to 'n'. Note the mu=
ltiple drivers
>>>> support is also compatible with the existing drivers, even if just=
 one driver is
>>>> needed, all the cpu will be tied to this driver using an extra sma=
ll chunk of
>>>> processor memory.
>>>>
>>>> The multiple driver support use a per-cpu driver pointer instead o=
f a global
>>>> variable and the accessor to this variable are done from a cpu con=
text.
>> Thanks Rafael for the review.
>>
>> I took into account all your remarks for the V2.
>>
>> [ cut ]
>>
>>>> +static int __cpuidle_register_all_cpu_driver(struct cpuidle_drive=
r *drv)
>>>> +{
>>>> +	int ret =3D 0;
>>>> +	int i, cpu;
>>>> +
>>>> +	for_each_present_cpu(cpu) {
>>>> +		ret =3D __cpuidle_register_driver(drv, cpu);
>>>> +		if (!ret)
>>>> +			continue;
>>>> +		for (i =3D cpu - 1; i >=3D 0; i--)
>>> I wonder if this is going to work in all cases.  For example, is th=
ere any
>>> guarantee that the CPU numbers start from 0 and that there are no g=
aps?
>> AFAICS, the cpumask.h is not assuming the cpu numbers start from zer=
o
>> and they are contiguous.
>>
>> I will fix this reverse loop, thanks for spotting this.
>>
>> [ cut ]
>>
>>>>  void cpuidle_unregister_driver(struct cpuidle_driver *drv)
>>>>  {
>>>>  	spin_lock(&cpuidle_driver_lock);
>>>> -	__cpuidle_unregister_driver(drv);
>>>> +#ifdef CONFIG_CPU_IDLE_MULTIPLE_DRIVERS
>>>> +	__cpuidle_unregister_all_cpu_driver(drv);
>>>> +#else
>>>> +	__cpuidle_unregister_driver(drv, smp_processor_id());
>>>> +#endif
>>> I'm slightly cautious about using smp_processor_id() above.
>>> get_cpu()/put_cpu() is the preferred way of doing this nowadays (al=
though
>>> this particular code is under the spinlock, so it should be OK).
>> yes, get_cpu does preempt_disable() and smp_processor_id()
>> As spin_lock does also preempt_disable() that should be ok.
>> But I changed the code to use the preferred way.
> Cool, thanks!
>
> I've seen your new version=20

Actually, the patchset is just sysfs cleanup for the multiple drivers
support.
The patches are trivial IMO. If you think they are ok and they are
merged, I will send the multiple drivers patchset V2 on top of them.

> and I'm going to look deeper into it in the next
> few days, but I will be travelling from tomorrow through the end of t=
he next
> week, so I may be even slower to respond than usually. Sorry about th=
at.

No problem, I understand.

Thanks
-- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
