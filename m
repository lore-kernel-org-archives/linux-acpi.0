From: chen gong <gong.chen@linux.intel.com>
Subject: Re: [RFC PATCH]: ACPI: Automatically online hot-added memory
Date: Thu, 11 Mar 2010 16:32:09 +0800
Message-ID: <4B98AA89.4060609@linux.intel.com>
References: <20100309141203.10037.62453.sendpatchset@prarit.bos.redhat.com>	 <20100309154243.GA26520@srcf.ucam.org>  <4B969305.9070103@redhat.com>	 <1268186225.3606.25.camel@localhost.localdomain>	 <4B979E63.1070806@redhat.com>	 <1268268915.3606.101.camel@localhost.localdomain>	 <4B985311.8090708@redhat.com> <1268294876.3632.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:24221 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755518Ab0CKIcM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Mar 2010 03:32:12 -0500
In-Reply-To: <1268294876.3632.5.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: Prarit Bhargava <prarit@redhat.com>, Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, trenn@novell.com

On 2010-3-11 16:07, ykzhao wrote:
> On Thu, 2010-03-11 at 10:18 +0800, Prarit Bhargava wrote:
>>>
>>> Yes. The nehalem processor has the integrated memory controller. But it
>>> is not required that the hot-added memory should be onlined before
>>> bringing up CPU.
>>>     I do the following memory-hotplug test on one Machine.
>>>     a. Before hot plugging memory, four CPUs socket are installed and
>>> all the logical CPU are brought up. (Only one node has the memory)
>>>     b. The memory is hot-plugged and then the memory is onlined so that
>>> it can be accessed by the system.
>>>
>>> In the above testing case the CPU is brought up before onlining the
>>> hot-added memory. And the test shows that it can work well.
>>>   
>>
>> That doesn't work when you have multiple nodes AFAICT.  The cpus do not 
>> come into service because of a lack of memory on the node....  per node 
>> allocations will fail.
> 
> In the test the system has multiple nodes. The reason is that the cpu
> without memory can turn to other node and allocate the memory.

I agree with Yakui. The memory and CPU are irrelevant in some way. CPU can
get memory from other nodes if it hasn't local memory, though for now it has some issues.
Andi is working on it now (http://lkml.org/lkml/2010/2/3/343)

BTW, how about using UDEV rules to do this operation. It looks more smooth. I know some
Novell guy is working on it.

> 
>>
>> Just curious, exactly what did you test with?  2.6.33 (or newer)?
> 
> I test it on 2.6.32 kernel.
> 
>>
>>>   
>>>> ie) with new processors it is possible that an entire node which 
>>>> consists of memory and cpus comes and goes with the socket enable and 
>>>> disable.
>>>>
>>>> The cpu bringup code does local node allocations for the cpu.  If the 
>>>> memory connected to the node (which is "behind" the socket) isn't 
>>>> online, then these allocations fail, and then the cpu bringup fails.
>>>>     
>>>
>>> If the CPU can't allocate the memory from its own node, it can turn to
>>> other node and see whether the memory can be allocated. And this depends
>>> on the NUMA allocation policy.
>>>   
>>
>> Maybe that could work, but I haven't gotten that to work.  Even if it 
>> does work, it's a HUGE performance hit :(.  I can't imagine incurring an 
>> extra hop just to get to per_cpu memory.  I'd rather bring the memory on 
>> the local node up first.
>>
>> I think it is much better to bring the memory up first.
>>
>> Either way, it's a nice feature to have.

