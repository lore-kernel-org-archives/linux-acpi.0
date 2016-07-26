From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v9 0/7] Make cpuid <-> nodeid mapping persistent
Date: Tue, 26 Jul 2016 11:59:38 +0800
Message-ID: <34809745-7e48-29d3-f31b-826414ccdef3@cn.fujitsu.com>
References: <1469435749-19582-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <20160725162022.e90e9c6c74a5d147e39e5945@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20160725162022.e90e9c6c74a5d147e39e5945@linux-foundation.org>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: cl@linux.com, tj@kernel.org, mika.j.penttila@gmail.com, mingo@redhat.com, rjw@rjwysocki.net, hpa@zytor.com, yasu.isimatu@gmail.com, isimatu.yasuaki@jp.fujitsu.com, kamezawa.hiroyu@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, gongzhaogang@inspur.com, len.brown@intel.com, lenb@kernel.org, tglx@linutronix.de, chen.tang@easystack.cn, rafael@kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-acpi@vger.kernel.org



=E5=9C=A8 2016=E5=B9=B407=E6=9C=8826=E6=97=A5 07:20, Andrew Morton =E5=86=
=99=E9=81=93:
> On Mon, 25 Jul 2016 16:35:42 +0800 Dou Liyang <douly.fnst@cn.fujitsu.co=
m> wrote:
>
>> [Problem]
>>
>> cpuid <-> nodeid mapping is firstly established at boot time. And work=
queue caches
>> the mapping in wq_numa_possible_cpumask in wq_numa_init() at boot time=
.
>>
>> When doing node online/offline, cpuid <-> nodeid mapping is establishe=
d/destroyed,
>> which means, cpuid <-> nodeid mapping will change if node hotplug happ=
ens. But
>> workqueue does not update wq_numa_possible_cpumask.
>>
>> So here is the problem:
>>
>> Assume we have the following cpuid <-> nodeid in the beginning:
>>
>>   Node | CPU
>> ------------------------
>> node 0 |  0-14, 60-74
>> node 1 | 15-29, 75-89
>> node 2 | 30-44, 90-104
>> node 3 | 45-59, 105-119
>>
>> and we hot-remove node2 and node3, it becomes:
>>
>>   Node | CPU
>> ------------------------
>> node 0 |  0-14, 60-74
>> node 1 | 15-29, 75-89
>>
>> and we hot-add node4 and node5, it becomes:
>>
>>   Node | CPU
>> ------------------------
>> node 0 |  0-14, 60-74
>> node 1 | 15-29, 75-89
>> node 4 | 30-59
>> node 5 | 90-119
>>
>> But in wq_numa_possible_cpumask, cpu30 is still mapped to node2, and t=
he like.
>>
>> When a pool workqueue is initialized, if its cpumask belongs to a node=
, its
>> pool->node will be mapped to that node. And memory used by this workqu=
eue will
>> also be allocated on that node.
>
> Plan B is to hunt down and fix up all the workqueue structures at
> hotplug-time.  Has that option been evaluated?
>

Yes, the option has been evaluate in this patch:
http://www.gossamer-threads.com/lists/linux/kernel/2116748

>
> Your fix is x86-only and this bug presumably affects other
> architectures, yes?I think a "Plan B" would fix all architectures?
>

Yes, the bug may presumably affect few architectures which support CPU=20
hotplug and NUMA.

We have sent the "Plan B" in our community and got a lot of advice and=20
ideas. Based on these suggestions, We carefully balance that two plan.=20
Then we choice the first.

>
> Thirdly, what is the merge path for these patches?  Is an x86
> or ACPI maintainer working with you on them?

Yes, we get a lot of guidance and help from RJ who is an ACPI maintainer.


Thanks,

Dou


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
