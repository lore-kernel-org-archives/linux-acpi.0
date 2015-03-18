From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [update][PATCH v10 06/21] ACPI / sleep: Introduce CONFIG_ACPI_GENERIC_SLEEP
Date: Wed, 18 Mar 2015 09:56:43 +0800
Message-ID: <5508DB5B.2060600@huawei.com>
References: <1426234469-6434-1-git-send-email-hanjun.guo@linaro.org> <10995588.scpoK3KRg2@vostro.rjw.lan> <5507A91A.1090206@huawei.com> <16235723.xVJ1Rfp9tM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:43637 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598AbbCRB5P (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Mar 2015 21:57:15 -0400
In-Reply-To: <16235723.xVJ1Rfp9tM@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Zhangdianfang <zhangdianfang@huawei.com>

On 2015/3/17 22:33, Rafael J. Wysocki wrote:
> On Tuesday, March 17, 2015 12:10:02 PM Hanjun Guo wrote:
>> On 2015/3/17 11:23, Rafael J. Wysocki wrote:
>>> On Tuesday, March 17, 2015 10:36:47 AM Hanjun Guo wrote:
>>>> On 2015/3/17 10:28, Rafael J. Wysocki wrote:
>>>>> On Tuesday, March 17, 2015 09:08:45 AM Hanjun Guo wrote:
>>>>>> On 2015/3/17 7:15, Rafael J. Wysocki wrote:
>>>>>>> On Monday, March 16, 2015 08:14:52 PM Hanjun Guo wrote:
>>>>>>>> On 2015=E5=B9=B403=E6=9C=8814=E6=97=A5 05:49, Rafael J. Wysock=
i wrote:
>>>>>>>>> On Friday, March 13, 2015 04:14:29 PM Hanjun Guo wrote:
>>>>>> [...]
>>>>>>>>>> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
>>>>>>>>>> index 074e52b..e8728d7 100644
>>>>>>>>>> --- a/arch/ia64/Kconfig
>>>>>>>>>> +++ b/arch/ia64/Kconfig
>>>>>>>>>> @@ -10,6 +10,7 @@ config IA64
>>>>>>>>>>   	select ARCH_MIGHT_HAVE_PC_SERIO
>>>>>>>>>>   	select PCI if (!IA64_HP_SIM)
>>>>>>>>>>   	select ACPI if (!IA64_HP_SIM)
>>>>>>>>>> +	select ACPI_GENERIC_SLEEP if ACPI
>>>>>>>>>>   	select ARCH_MIGHT_HAVE_ACPI_PDC if ACPI
>>>>>>>>>>   	select HAVE_UNSTABLE_SCHED_CLOCK
>>>>>>>>>>   	select HAVE_IDE
>>>>>>>>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>>>>>>>>> index b7d31ca..9804431 100644
>>>>>>>>>> --- a/arch/x86/Kconfig
>>>>>>>>>> +++ b/arch/x86/Kconfig
>>>>>>>>>> @@ -22,6 +22,7 @@ config X86_64
>>>>>>>>>>   ### Arch settings
>>>>>>>>>>   config X86
>>>>>>>>>>   	def_bool y
>>>>>>>>>> +	select ACPI_GENERIC_SLEEP if ACPI
>>>>>>>>> One more nit.  If you did
>>>>>>>>>
>>>>>>>>> +	select ACPI_GENERIC_SLEEP if ACPI_SLEEP
>>>>>>>>>
>>>>>>>>> here (and above for ia64), you'd avoid having to make ACPI_SL=
EEP
>>>>>>>>> depend on ACPI_GENERIC_SLEEP which goes somewhat backwards.
>>>>>>>> In sleep.c,
>>>>>>>>
>>>>>>>> #ifdef CONFIG_ACPI_SLEEP
>>>>>>>> acpi_target_system_state()
>>>>>>>> {
>>>>>>>> }
>>>>>>>> #endif
>>>>>>>>
>>>>>>>> and CONFIG_ACPI_SLEEP depends on SUSPEND || HIBERNATION,
>>>>>>>> which one of them will be enabled on ARM64 so ACPI_SLEEP
>>>>>>>> will also enabled too.
>>>>>>>>
>>>>>>>> So if we
>>>>>>>>
>>>>>>>> +select ACPI_GENERIC_SLEEP if ACPI_SLEEP
>>>>>>>>
>>>>>>>> and
>>>>>>>>
>>>>>>>> +acpi-$(CONFIG_ACPI_GENERIC_SLEEP) +=3D sleep.o
>>>>>>>>
>>>>>>>> it will lead to errors for acpi_target_system_state() that
>>>>>>>> is declared but not defined, so I will keep the code as
>>>>>>>> it is, what do you think?
>>>>>>> No, we need to hash this out.  Having two different Kconfig opt=
ions meaning
>>>>>>> almost the same thing (ACPI_SLEEP and ACPI_GENERIC_SLEEP) is be=
yond ugly.
>>>>>>>
>>>>>>> Do you need ACPI_SLEEP on ARM64 at all?
>>>>>> No, at least for now we don't need it, the spec for sleep is not=
 ready for
>>>>>> ARM64 arch, so ACPI_SLEEP will not work at all on ARM64.
>>>>> Well, so what about selecting ACPI_SLEEP from the architectures t=
hat use it?
>>>> Do you mean remove CONFIG_ACPI_GENERIC_SLEEP and
>>>>
>>>> +acpi-$(CONFIG_ACPI_SLEEP) +=3D sleep.o
>>>>
>>>> as well (also need to remove duplicate #ifdef CONFIG_ACPI_SLEEP in=
 sleep.c if
>>>> we doing so)?
>>> Well, almost.  There is one problem with that, becuase sleep.c cont=
ains code
>>> outside of the ACPI_SLEEP-dependent blocks.  That code is used for =
powering
>>> off ACPI platforms.
>>>
>>> I guess you don't want that code on ARM too, right?
>> Yes, you are right.
>>
>>> Perhaps we can use ACPI_REDUCED_HARDWARE_ONLY for that?  ARM64 will=
 be the
>> Sorry, I can't fully understand your intention here, could you pleas=
e
>> explain it more?
>>
>> Let me guess a little bit. Do you mean use ACPI_REDUCED_HARDWARE_ONL=
Y for
>> powering off ACPI platforms? if so, I guess it's not a good idea, AC=
PI spec
>> only says that S4BIOS is not supported on HW-reduced ACPI platforms,=
 S5
>> has no such limitation, if I miss something here, please let me know=
=2E
> OK, so in your current patch, please replace ACPI_GENERIC_SLEEP with
> ACPI_SYSTEM_POWER_STATES_SUPPORT and all should be clear.

OK, I will send a updated patch.

Thanks
Hanjun

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
