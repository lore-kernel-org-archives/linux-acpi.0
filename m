From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 0/6] cpuidle : per cpu latencies
Date: Fri, 07 Sep 2012 14:02:28 +0200
Message-ID: <5049E254.8080704@linaro.org>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org> <CAP245DXTdw4MxcHOS2EUgvaQv6RnH0NWvks3RhE8ORR1Zx7qbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37413 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760437Ab2IGMCh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Sep 2012 08:02:37 -0400
Received: by bkwj10 with SMTP id j10so1335741bkw.19
        for <linux-acpi@vger.kernel.org>; Fri, 07 Sep 2012 05:02:35 -0700 (PDT)
In-Reply-To: <CAP245DXTdw4MxcHOS2EUgvaQv6RnH0NWvks3RhE8ORR1Zx7qbw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: rjw@sisk.pl, lenb@kernel.org, linaro-dev@lists.linaro.org, patches@linaro.org, pdeschrijver@nvidia.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

On 09/07/2012 01:04 PM, Amit Kucheria wrote:
> On Fri, Sep 7, 2012 at 3:49 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
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
> Feel free to add my Reviewed-by for this series.


Thanks Amit for reviewing the patches.

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
