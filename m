From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 0/6] cpuidle : per cpu latencies
Date: Mon, 17 Sep 2012 23:35:00 +0200
Message-ID: <50579784.4090000@linaro.org>
References: <1347013172-12465-1-git-send-email-daniel.lezcano@linaro.org> <201209080017.17418.rjw@sisk.pl> <5056D96C.5040904@linaro.org> <201209172250.33157.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:35743 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab2IQVfG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Sep 2012 17:35:06 -0400
Received: by eaac11 with SMTP id c11so2613641eaa.19
        for <linux-acpi@vger.kernel.org>; Mon, 17 Sep 2012 14:35:04 -0700 (PDT)
In-Reply-To: <201209172250.33157.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, patches@linaro.org, linaro-dev@lists.linaro.org, pdeschrijver@nvidia.com, lorenzo.pieralisi@arm.com, "len.brown@intel.com >> Len Brown" <len.brown@intel.com>

On 09/17/2012 10:50 PM, Rafael J. Wysocki wrote:
> On Monday, September 17, 2012, Daniel Lezcano wrote:
>> On 09/08/2012 12:17 AM, Rafael J. Wysocki wrote:
>>> On Friday, September 07, 2012, Daniel Lezcano wrote:
>>>> Since commit 46bcfad7a819bd17ac4e831b04405152d59784ab,
>>>>         cpuidle: Single/Global registration of idle states
>>>>
>>>> we have a single registration for the cpuidle states which makes
>>>> sense. But now two new architectures are coming: tegra3 and big.LI=
TTLE.
>>>>
>>>> These architectures have different cpus with different caracterist=
ics
>>>> for power saving. High load =3D> powerfull processors, idle =3D> s=
mall processors.
>>>>
>>>> That implies different cpu latencies.
>>>>
>>>> This patchset keeps the current behavior as introduced by Deepthi =
without
>>>> breaking the drivers and add the possibility to specify a per cpu =
states.
>>>>
>>>>  * Tested on intel core 2 duo T9500
>>>>  * Tested on vexpress by Lorenzo Pieralsi
>>>>  * Tested on tegra3 by Peter De Schrijver
>>>>
>>>> Daniel Lezcano (6):
>>>>   acpi : move the acpi_idle_driver variable declaration
>>>>   acpi : move cpuidle_device field out of the acpi_processor_power
>>>>     structure
>>>>   acpi : remove pointless cpuidle device state_count init
>>>
>>> I've posted comments about patches [1-3/6] already.  In short, I do=
n't like
>>> [1/6], [2/6] would require some more work IMO and I'm not sure abou=
t the
>>> validity of the observation that [3/6] is based on.
>>>
>>> Yes, I agree that the ACPI processor driver as a whole might be cle=
aner
>>> and it probably would be good to spend some time on cleaning it up,=
 but
>>> not necessarily in a hurry.
>>>
>>> Unfortunately, I also don't agree with the approach used by the rem=
aining
>>> patches, which is to try to use a separate array of states for each
>>> individual CPU core.  This way we end up with quite some duplicated=
 data
>>> if the CPU cores in question actually happen to be identical.
>>
>> Actually, there is a single array of states which is defined with th=
e
>> cpuidle_driver. A pointer to this array from the cpuidle_device
>> structure is added and used from the cpuidle core.
>>
>> If the cpu cores are identical, this pointer will refer to the same =
array.
>=20
> OK, but what if there are two (or more) sets of cores, where all core=
s in one
> set are identical, but two cores from different sets differ?

A second array is defined and registered for these cores with the
cpuidle_register_states function.

Let's pick an example with the big.LITTLE architecture.

There are two A7 and two A15, resulting in the code on 4 cpuidle_device
structure (eg. dev_A7_1, dev_A7_2, dev_A15_1, dev_A15_2). Then the
driver registers a different cpu states array for the A7s and the A15s

At the end,

dev_A7_1->states points to the array states 1
dev_A7_2->states points to the array states 1

dev_A15_1->states points to the array states 2
dev_A15_2->states points to the array states 2

It is similar with Tegra3.

I think Peter and Lorenzo already wrote a driver based on this approach=
=2E
Peter, Lorenzo any comments ?

The single registration mechanism introduced by Deepthi is kept and we
have a way to specify different idle states for different cpus.

> In that case it would be good to have one array of states per set, bu=
t the
> patch doesn't seem to do that, does it?

Yes, this is what does the patch.

>> Maybe I misunderstood you remark but there is no data duplication, t=
hat
>> was the purpose of this approach to just add a pointer to point to a
>> single array when the core are identical and to a different array wh=
en
>> the cores are different (set by the driver). Furthermore, this patch
>> allows to support multiple cpu latencies without impacting the exist=
ing
>> drivers.
>=20
> Well that's required. :-)

Yes :)

>>> What about using a separate cpuidle driver for every kind of differ=
ent CPUs in
>>> the system (e.g. one driver for "big" CPUs and the other for "littl=
e" ones)?
>>>
>>> Have you considered this approach already?
>>
>> No, what would be the benefit of this approach ?
>=20
> Uniform handling of all the CPUs of the same kind without data duplic=
ation
> and less code complexity, I think.
>=20
>> We will need to switch
>> the driver each time we switch the cluster (assuming all it is the b=
L
>> switcher in place and not the scheduler). IMHO, that could be subopt=
imal
>> because we will have to (un)register the driver, register the device=
s,
>> pull all the sysfs and notifications mechanisms. The cpuidle core is=
 not
>> designed for that.
>=20
> I don't seem to understand how things are supposed to work, then.

Sorry, I did not suggest that. I am wondering how several cpuidle
drivers can co-exist together in the state of the code. Maybe I
misunderstood your idea.

The patchset I sent is pretty simple and do not duplicate the array sta=
tes.

That would be nice if Len could react to this patchset (4/6,5/6, and
6/6). Cc'ing him to its intel address.

> What _exactly_ do you mean by "the bL switcher", for instance?

The switcher is in charge of migrating tasks from the A7 to A15 (and
vice versa) depending on the system load and make the one cluster up an=
d
visible while the other is not visible [1].


[1] www.arm.com/files/downloads/big.LITTLE_Final.pdf

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
