From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v9 0/7] Make cpuid <-> nodeid mapping persistent
Date: Wed, 27 Jul 2016 09:18:19 +0800
Message-ID: <bf54b057-0d97-4614-f88e-f95b9a8eb88a@cn.fujitsu.com>
References: <1469435749-19582-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <20160725162022.e90e9c6c74a5d147e39e5945@linux-foundation.org>
 <34809745-7e48-29d3-f31b-826414ccdef3@cn.fujitsu.com>
 <122491145.6BHBUIrED6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:16334 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753177AbcG0BSg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jul 2016 21:18:36 -0400
In-Reply-To: <122491145.6BHBUIrED6@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, cl@linux.com, tj@kernel.org, mika.j.penttila@gmail.com, mingo@redhat.com, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, len.brown@intel.com, lenb@kernel.org, tglx@linutronix.de, chen.tang@easystack.cn, rafael@kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org

Hi, RJ

=E5=9C=A8 2016=E5=B9=B407=E6=9C=8826=E6=97=A5 19:53, Rafael J. Wysocki =
=E5=86=99=E9=81=93:
> On Tuesday, July 26, 2016 11:59:38 AM Dou Liyang wrote:
>>
>> =E5=9C=A8 2016=E5=B9=B407=E6=9C=8826=E6=97=A5 07:20, Andrew Morton =E5=
=86=99=E9=81=93:
>>> On Mon, 25 Jul 2016 16:35:42 +0800 Dou Liyang <douly.fnst@cn.fujits=
u.com> wrote:
>>>
>>>> [Problem]
>>>>
>>>> cpuid <-> nodeid mapping is firstly established at boot time. And =
workqueue caches
>>>> the mapping in wq_numa_possible_cpumask in wq_numa_init() at boot =
time.
>>>>
>>>> When doing node online/offline, cpuid <-> nodeid mapping is establ=
ished/destroyed,
>>>> which means, cpuid <-> nodeid mapping will change if node hotplug =
happens. But
>>>> workqueue does not update wq_numa_possible_cpumask.
>>>>
>>>> So here is the problem:
>>>>
>>>> Assume we have the following cpuid <-> nodeid in the beginning:
>>>>
>>>>   Node | CPU
>>>> ------------------------
>>>> node 0 |  0-14, 60-74
>>>> node 1 | 15-29, 75-89
>>>> node 2 | 30-44, 90-104
>>>> node 3 | 45-59, 105-119
>>>>
>>>> and we hot-remove node2 and node3, it becomes:
>>>>
>>>>   Node | CPU
>>>> ------------------------
>>>> node 0 |  0-14, 60-74
>>>> node 1 | 15-29, 75-89
>>>>
>>>> and we hot-add node4 and node5, it becomes:
>>>>
>>>>   Node | CPU
>>>> ------------------------
>>>> node 0 |  0-14, 60-74
>>>> node 1 | 15-29, 75-89
>>>> node 4 | 30-59
>>>> node 5 | 90-119
>>>>
>>>> But in wq_numa_possible_cpumask, cpu30 is still mapped to node2, a=
nd the like.
>>>>
>>>> When a pool workqueue is initialized, if its cpumask belongs to a =
node, its
>>>> pool->node will be mapped to that node. And memory used by this wo=
rkqueue will
>>>> also be allocated on that node.
>>>
>>> Plan B is to hunt down and fix up all the workqueue structures at
>>> hotplug-time.  Has that option been evaluated?
>>>
>>
>> Yes, the option has been evaluate in this patch:
>> http://www.gossamer-threads.com/lists/linux/kernel/2116748
>>
>>>
>>> Your fix is x86-only and this bug presumably affects other
>>> architectures, yes?I think a "Plan B" would fix all architectures?
>>>
>>
>> Yes, the bug may presumably affect few architectures which support C=
PU
>> hotplug and NUMA.
>>
>> We have sent the "Plan B" in our community and got a lot of advice a=
nd
>> ideas. Based on these suggestions, We carefully balance that two pla=
n.
>> Then we choice the first.
>>
>>>
>>> Thirdly, what is the merge path for these patches?  Is an x86
>>> or ACPI maintainer working with you on them?
>>
>> Yes, we get a lot of guidance and help from RJ who is an ACPI mainta=
iner.
>
> FWIW, the patches are fine by me from the ACPI perspective.
>
> If you want me to apply them, though, ACKs from the x86 and mm mainta=
iners
> will be necessary.
>

I will continue to investigate this bug and wait for maintainers's 	adv=
ices.

> Thanks,
> Rafael
>
>
>

Thanks.
Dou


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
