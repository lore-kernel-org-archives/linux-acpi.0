From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/6] acpi : move cpuidle_device field out of the acpi_processor_power
 structure
Date: Tue, 11 Sep 2012 14:20:50 +0200
Message-ID: <504F2CA2.8010902@linaro.org>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org> <201209072340.33932.rjw@sisk.pl> <201209072354.28800.rjw@sisk.pl> <201209080006.11888.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:36446 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab2IKMUz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Sep 2012 08:20:55 -0400
Received: by eekc1 with SMTP id c1so336401eek.19
        for <linux-acpi@vger.kernel.org>; Tue, 11 Sep 2012 05:20:53 -0700 (PDT)
In-Reply-To: <201209080006.11888.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com

On 09/08/2012 12:06 AM, Rafael J. Wysocki wrote:
> On Friday, September 07, 2012, Rafael J. Wysocki wrote:
>> On Friday, September 07, 2012, Rafael J. Wysocki wrote:
>>> On Friday, September 07, 2012, Daniel Lezcano wrote:
>>>> Currently we have the cpuidle_device field in the acpi_processor_p=
ower structure.
>>>> This adds a dependency in processor.h for cpuidle.h.
>>>>
>>>> In order to be consistent with the rest of the drivers and for the=
 per cpu states
>>>> coming right after this patch, this one move out of the acpi_proce=
ssor_power
>>>> structure the cpuidle_device field.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>>>> Tested-by: Peter De Schrijver <pdeschrijver@nvidia.com>
>>>> ---
>>>>  drivers/acpi/processor_idle.c |   25 ++++++++++++++++++-------
>>>>  include/acpi/processor.h      |    2 --
>>>>  2 files changed, 18 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processo=
r_idle.c
>>>> index de89624..084b1d2 100644
>>>> --- a/drivers/acpi/processor_idle.c
>>>> +++ b/drivers/acpi/processor_idle.c
>>>> @@ -79,6 +79,8 @@ module_param(bm_check_disable, uint, 0000);
>>>>  static unsigned int latency_factor __read_mostly =3D 2;
>>>>  module_param(latency_factor, uint, 0644);
>>>> =20
>>>> +static DEFINE_PER_CPU(struct cpuidle_device, acpi_cpuidle_device)=
;
>>>> +
>>>
>>> Well.  Why are you moving that thing into the percpu memory?  It do=
esn't
>>> have to be per-CPU and storing it there just wastes the room.
>>
>> Sorry, it is per-CPU already, scratch that.
>=20
> Well, no, it isn't.  So I was right originally (boy, that code _is_ c=
onfusing).
>=20
> So originally you had per-CPU pointers called 'processors' that each =
pointed
> to a struct acpi_processor object created by acpi_processor_add() in =
slab
> memory.  Your patch doesn't touch those pointers, so they are still t=
here.

Yes, the purpose of this patch is the same as the other patches which i=
s
separate the cpuidle code from the rest of the acpi code. It is part of
the cleanup.

> In addition to them it creates a number of static per-CPU objects tha=
t
> previously were stored in those struct acpi_processor object mentione=
d above.
> These things need not be stored in percpu memory.

Agreed, this patch makes the cpuidle driver to consume more per cpu
memory. Is it acceptable to create a per cpu pointer for the cpuidle
devices which will be allocated in the processor_driver init function
like the intel_idle driver ? We keep the same memory consumption while
we are moving the cpuidle specific code the C file.

By the way, most of the cpuidle drivers for ARM are defining a static
cpuidle device structure per cpu. I guess your remark for acpi applies
to them too. Not easy to make all these drivers to converge to the same
code scheme ...

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
