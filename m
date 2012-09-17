From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 0/6] cpuidle : per cpu latencies
Date: Mon, 17 Sep 2012 10:03:56 +0200
Message-ID: <5056D96C.5040904@linaro.org>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org> <201209080017.17418.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:42671 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740Ab2IQIEB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Sep 2012 04:04:01 -0400
Received: by bkwj10 with SMTP id j10so2307773bkw.19
        for <linux-acpi@vger.kernel.org>; Mon, 17 Sep 2012 01:04:00 -0700 (PDT)
In-Reply-To: <201209080017.17418.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com

On 09/08/2012 12:17 AM, Rafael J. Wysocki wrote:
> On Friday, September 07, 2012, Daniel Lezcano wrote:
>> Since commit 46bcfad7a819bd17ac4e831b04405152d59784ab,
>>         cpuidle: Single/Global registration of idle states
>>
>> we have a single registration for the cpuidle states which makes
>> sense. But now two new architectures are coming: tegra3 and big.LITT=
LE.
>>
>> These architectures have different cpus with different caracteristic=
s
>> for power saving. High load =3D> powerfull processors, idle =3D> sma=
ll processors.
>>
>> That implies different cpu latencies.
>>
>> This patchset keeps the current behavior as introduced by Deepthi wi=
thout
>> breaking the drivers and add the possibility to specify a per cpu st=
ates.
>>
>>  * Tested on intel core 2 duo T9500
>>  * Tested on vexpress by Lorenzo Pieralsi
>>  * Tested on tegra3 by Peter De Schrijver
>>
>> Daniel Lezcano (6):
>>   acpi : move the acpi_idle_driver variable declaration
>>   acpi : move cpuidle_device field out of the acpi_processor_power
>>     structure
>>   acpi : remove pointless cpuidle device state_count init
>=20
> I've posted comments about patches [1-3/6] already.  In short, I don'=
t like
> [1/6], [2/6] would require some more work IMO and I'm not sure about =
the
> validity of the observation that [3/6] is based on.
>=20
> Yes, I agree that the ACPI processor driver as a whole might be clean=
er
> and it probably would be good to spend some time on cleaning it up, b=
ut
> not necessarily in a hurry.
>=20
> Unfortunately, I also don't agree with the approach used by the remai=
ning
> patches, which is to try to use a separate array of states for each
> individual CPU core.  This way we end up with quite some duplicated d=
ata
> if the CPU cores in question actually happen to be identical.

Actually, there is a single array of states which is defined with the
cpuidle_driver. A pointer to this array from the cpuidle_device
structure is added and used from the cpuidle core.

If the cpu cores are identical, this pointer will refer to the same arr=
ay.

Maybe I misunderstood you remark but there is no data duplication, that
was the purpose of this approach to just add a pointer to point to a
single array when the core are identical and to a different array when
the cores are different (set by the driver). Furthermore, this patch
allows to support multiple cpu latencies without impacting the existing
drivers.

> What about using a separate cpuidle driver for every kind of differen=
t CPUs in
> the system (e.g. one driver for "big" CPUs and the other for "little"=
 ones)?
>=20
> Have you considered this approach already?

No, what would be the benefit of this approach ? We will need to switch
the driver each time we switch the cluster (assuming all it is the bL
switcher in place and not the scheduler). IMHO, that could be suboptima=
l
because we will have to (un)register the driver, register the devices,
pull all the sysfs and notifications mechanisms. The cpuidle core is no=
t
designed for that.

eg.

int cpuidle_register_driver(struct cpuidle_driver *drv)
{
        if (!drv || !drv->state_count)
                return -EINVAL;

        if (cpuidle_disabled())
                return -ENODEV;

        spin_lock(&cpuidle_driver_lock);
>>>>    if (cpuidle_curr_driver) {
>>>>            spin_unlock(&cpuidle_driver_lock);
>>>>            return -EBUSY;
>>>>    }
        __cpuidle_register_driver(drv);
        cpuidle_curr_driver =3D drv;
        spin_unlock(&cpuidle_driver_lock);

        return 0;
}


>>   cpuidle : add a pointer for cpuidle_state in the cpuidle_device
>>   cpuidle : use per cpuidle device cpu states
>>   cpuidle : add cpuidle_register_states function
>>
>>  drivers/acpi/processor_driver.c    |    2 +-
>>  drivers/acpi/processor_idle.c      |   27 +++++++++++++++-------
>>  drivers/cpuidle/cpuidle.c          |   42 +++++++++++++++++++++++++=
+++-------
>>  drivers/cpuidle/governors/ladder.c |   22 +++++++++---------
>>  drivers/cpuidle/governors/menu.c   |    8 +++---
>>  drivers/cpuidle/sysfs.c            |    3 +-
>>  include/acpi/processor.h           |    3 --
>>  include/linux/cpuidle.h            |   11 ++++++--
>>  8 files changed, 76 insertions(+), 42 deletions(-)
>=20
> Thanks,
> Rafael


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
