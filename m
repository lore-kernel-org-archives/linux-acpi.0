From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [RFC PATCH]: ACPI: Automatically online hot-added memory
Date: Wed, 17 Mar 2010 11:24:47 -0400
Message-ID: <4BA0F43F.5080902@redhat.com>
References: <20100309141203.10037.62453.sendpatchset@prarit.bos.redhat.com> <4B979E63.1070806@redhat.com> <1268268915.3606.101.camel@localhost.localdomain> <201003121401.54675.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33320 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752427Ab0CQPYz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Mar 2010 11:24:55 -0400
In-Reply-To: <201003121401.54675.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: ykzhao <yakui.zhao@intel.com>, Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Kleen, Andi" <andi.kleen@intel.com>



Thomas Renninger wrote:
> On Thursday 11 March 2010 01:55:15 ykzhao wrote:
>  =20
>> On Wed, 2010-03-10 at 21:28 +0800, Prarit Bhargava wrote:
>>    =20
>>>> Why do we need to see whether the memory is onlined before bringin=
g cpu
>>>> to online state? It seems that there is no dependency between cpu =
online
>>>> and memory online.
>>>>
>>>>  =20
>>>>        =20
>>> Yakui,
>>>
>>>      =20
>> =EF=BB=BFThanks for the explanation.
>>
>>    =20
>>> Here's a deeper look into the issue.  New Intel processors have an=20
>>> on-die memory controller and this means that as the socket comes an=
d=20
>>> goes, so does the memory "behind" the socket.
>>>      =20
>> Yes. The nehalem processor has the integrated memory controller. But=
 it
>> is not required that the hot-added memory should be onlined before
>> bringing up CPU.
>>     I do the following memory-hotplug test on one Machine.
>>     a. Before hot plugging memory, four CPUs socket are installed an=
d
>> all the logical CPU are brought up. (Only one node has the memory)
>>     b. The memory is hot-plugged and then the memory is onlined so t=
hat
>> it can be accessed by the system.
>>
>> In the above testing case the CPU is brought up before onlining the
>> hot-added memory. And the test shows that it can work well.
>>
>>    =20
>>> ie) with new processors it is possible that an entire node which=20
>>> consists of memory and cpus comes and goes with the socket enable a=
nd=20
>>> disable.
>>>
>>> The cpu bringup code does local node allocations for the cpu.  If t=
he=20
>>> memory connected to the node (which is "behind" the socket) isn't=20
>>> online, then these allocations fail, and then the cpu bringup fails=
=2E
>>>      =20
>> If the CPU can't allocate the memory from its own node, it can turn =
to
>> other node and see whether the memory can be allocated. And this dep=
ends
>> on the NUMA allocation policy.
>>    =20
> Yes and this is broken and needs fixing.
> Yakui, I expect you miss this patch and wrongly online the cpus to ex=
isting
> nodes, therefore you do not run into "out of memory" conditions:
> 0271f91003d3703675be13b8865618359a6caa1f
>  =20

=46WIW, I'm working on a 2.6.32 based tree, but I have that patch in (a=
s=20
well as several others).  I'm also running the latest upstream (tip as=20
of this morning).  The issues I see in my 2.6.32 based tree are the sam=
e=20
AFAICT that I see upstream: a cpu comes online and attempts to make a=20
per_node allocation which fails, so the cpu bringup fails.

> I know for sure that slab is broken.
>  =20

Yes, but I believe Andi Kleen has added some patches that resolve (at=20
least some of) the issues.  I've been using slab (and occasionally=20
testing slub).

> slub behaves different, but I am not sure whether this is due to wron=
g CPU
> hotadd code (processor_core.c is also broken and you get wrong C-stat=
e info
> from BIOS tables on hotadded CPUs)
>
> Prarit: Can you retest with slub and processor.max_cstate=3D1, this c=
ould/should
> work.
>
>  =20

Two tests:

1.  WITHOUT my auto online patch, the cpus fail to come into service=20
because of a per_node allocation failure.
2.  WITH my auto online patch, the cpus come into service

=2E.. I have NOT done any sort of testing to see if the cpus are really=
=20
live ;)

> AFAIK vmware injects memory in the same way into clients, so you may =
have
> different behavior of virtualized Linux clients.
>
>  =20

Are you referring the vmware ballooning driver (or whatever they call=20
it).  IIRC (and I'm not saying I do ;) ), vmware adds memory and=20
automatically onlines it in a guest.  I'm not sure how that's done -- i=
t=20
could be via udev.

I'll see if anyone here knows.

> One question: You also want to automatically add the CPUs, once a CPU=
 hotplug
> event got fired, right?
>  =20

Yes,  That's correct.

> The fact that the memory hotplug driver adds the memory immediately o=
nce notified,
> does not ensure that the HW/BIOS fires this event first.
>  =20

Is that right?  FWIW I always see this sequence of events:

ACPI memory added
ACPI cpus added

I never see them out-of-order.  OTOH, I'm only testing on Intel's lates=
t=20
platform so maybe there are some older systems that don't do this in=20
that order.=20

> Theoretically you need a logic to not add CPUs to memoryless nodes, p=
oll/wait
> until memory got added, etc.
>  =20
Theoretically yes -- but are there any systems that generate cpu add=20
events before memory add events?

Thanks for the input Thomas :)

P.
>    Thomas
>  =20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
