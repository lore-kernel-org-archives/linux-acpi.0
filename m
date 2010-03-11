From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [RFC PATCH]: ACPI: Automatically online hot-added memory
Date: Thu, 11 Mar 2010 06:25:07 -0500
Message-ID: <4B98D313.4080509@redhat.com>
References: <20100309141203.10037.62453.sendpatchset@prarit.bos.redhat.com>	 <20100309154243.GA26520@srcf.ucam.org>  <4B969305.9070103@redhat.com>	 <1268186225.3606.25.camel@localhost.localdomain>	 <4B979E63.1070806@redhat.com>	 <1268268915.3606.101.camel@localhost.localdomain>	 <4B985311.8090708@redhat.com> <1268294876.3632.5.camel@localhost.localdomain> <4B98AA89.4060609@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3733 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751949Ab0CKLZN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Mar 2010 06:25:13 -0500
In-Reply-To: <4B98AA89.4060609@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: chen gong <gong.chen@linux.intel.com>
Cc: ykzhao <yakui.zhao@intel.com>, Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, trenn@novell.com



chen gong wrote:
> On 2010-3-11 16:07, ykzhao wrote:
>   
>> On Thu, 2010-03-11 at 10:18 +0800, Prarit Bhargava wrote:
>>     
>>>> Yes. The nehalem processor has the integrated memory controller. But it
>>>> is not required that the hot-added memory should be onlined before
>>>> bringing up CPU.
>>>>     I do the following memory-hotplug test on one Machine.
>>>>     a. Before hot plugging memory, four CPUs socket are installed and
>>>> all the logical CPU are brought up. (Only one node has the memory)
>>>>     b. The memory is hot-plugged and then the memory is onlined so that
>>>> it can be accessed by the system.
>>>>
>>>> In the above testing case the CPU is brought up before onlining the
>>>> hot-added memory. And the test shows that it can work well.
>>>>   
>>>>         
>>> That doesn't work when you have multiple nodes AFAICT.  The cpus do not 
>>> come into service because of a lack of memory on the node....  per node 
>>> allocations will fail.
>>>       
>> In the test the system has multiple nodes. The reason is that the cpu
>> without memory can turn to other node and allocate the memory.
>>     
>
> I agree with Yakui. The memory and CPU are irrelevant in some way. CPU can
> get memory from other nodes if it hasn't local memory, though for now it has some issues.
> Andi is working on it now (http://lkml.org/lkml/2010/2/3/343)
>   

Right -- I'm working with Andi on this to get RHEL working.  So I have 
his slab patches, etc..  That's one of the reasons it isn't working 
right now.

> BTW, how about using UDEV rules to do this operation. It looks more smooth. I know some
> Novell guy is working on it.
>
>   

I was thinking about that, but the CPU comes online automatically, so 
why not memory?  It seems to be a discrepancy between the two.   And ... 
the two of you still aren't considering the obvious performance hit 
which I would think makes this a must have.

P.


>   
