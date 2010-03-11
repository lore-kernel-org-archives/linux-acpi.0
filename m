From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [RFC PATCH]: ACPI: Automatically online hot-added memory
Date: Thu, 11 Mar 2010 06:18:05 -0500
Message-ID: <4B98D16D.3090602@redhat.com>
References: <20100309141203.10037.62453.sendpatchset@prarit.bos.redhat.com>	 <20100309154243.GA26520@srcf.ucam.org>  <4B969305.9070103@redhat.com>	 <1268186225.3606.25.camel@localhost.localdomain>	 <4B979E63.1070806@redhat.com>	 <1268268915.3606.101.camel@localhost.localdomain>	 <4B985311.8090708@redhat.com> <1268294876.3632.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:2945 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756993Ab0CKLSI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Mar 2010 06:18:08 -0500
In-Reply-To: <1268294876.3632.5.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>



ykzhao wrote:
> On Thu, 2010-03-11 at 10:18 +0800, Prarit Bhargava wrote:
>   
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
>>>       
>> That doesn't work when you have multiple nodes AFAICT.  The cpus do not 
>> come into service because of a lack of memory on the node....  per node 
>> allocations will fail.
>>     
>
> In the test the system has multiple nodes. The reason is that the cpu
> without memory can turn to other node and allocate the memory.
>
>   
>> Just curious, exactly what did you test with?  2.6.33 (or newer)?
>>     
>
> I test it on 2.6.32 kernel.
>   

2.6.32 doesn't work with memory and cpu.
2.6.33 doesn't work with memory and cpu.

Other patches (which have been posted upstream) are required.


I'll try to dig up the patches and you can retest.

I will try a memory-free cpu add as well to see if that works... but the 
performance hit due to the off-node allocations probably doesn't make it 
worthwhile.


P.

>   
