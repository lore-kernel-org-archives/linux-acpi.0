From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 1/7] node: Link memory nodes to their compute nodes
Date: Mon, 19 Nov 2018 08:45:25 +0530
Message-ID: <d5c7a267-840b-f253-ef0d-3715b2bcc196@arm.com>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181115135710.GD19286@bombadil.infradead.org>
 <20181115145920.GG11416@localhost.localdomain>
 <20181115203654.GA28246@bombadil.infradead.org>
 <20181116183254.GD14630@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181116183254.GD14630@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org



On 11/17/2018 12:02 AM, Keith Busch wrote:
> On Thu, Nov 15, 2018 at 12:36:54PM -0800, Matthew Wilcox wrote:
>> On Thu, Nov 15, 2018 at 07:59:20AM -0700, Keith Busch wrote:
>>> On Thu, Nov 15, 2018 at 05:57:10AM -0800, Matthew Wilcox wrote:
>>>> On Wed, Nov 14, 2018 at 03:49:14PM -0700, Keith Busch wrote:
>>>>> Memory-only nodes will often have affinity to a compute node, and
>>>>> platforms have ways to express that locality relationship.
>>>>>
>>>>> A node containing CPUs or other DMA devices that can initiate memory
>>>>> access are referred to as "memory iniators". A "memory target" is a
>>>>> node that provides at least one phyiscal address range accessible to a
>>>>> memory initiator.
>>>>
>>>> I think I may be confused here.  If there is _no_ link from node X to
>>>> node Y, does that mean that node X's CPUs cannot access the memory on
>>>> node Y?  In my mind, all nodes can access all memory in the system,
>>>> just not with uniform bandwidth/latency.
>>>
>>> The link is just about which nodes are "local". It's like how nodes have
>>> a cpulist. Other CPUs not in the node's list can acces that node's memory,
>>> but the ones in the mask are local, and provide useful optimization hints.
>>
>> So ... let's imagine a hypothetical system (I've never seen one built like
>> this, but it doesn't seem too implausible).  Connect four CPU sockets in
>> a square, each of which has some regular DIMMs attached to it.  CPU A is
>> 0 hops to Memory A, one hop to Memory B and Memory C, and two hops from
>> Memory D (each CPU only has two "QPI" links).  Then maybe there's some
>> special memory extender device attached on the PCIe bus.  Now there's
>> Memory B1 and B2 that's attached to CPU B and it's local to CPU B, but
>> not as local as Memory B is ... and we'd probably _prefer_ to allocate
>> memory for CPU A from Memory B1 than from Memory D.  But ... *mumble*,
>> this seems hard.
> 
> Indeed, that particular example is out of scope for this series. The
> first objective is to aid a process running in node B's CPUs to allocate
> memory in B1. Anything that crosses QPI are their own.

This is problematic. Any new kernel API interface should accommodate B2 type
memory as well from the above example which is on a PCIe bus. Because
eventually they would be represented as some sort of a NUMA node and then
applications will have to depend on this sysfs interface for their desired
memory placement requirements. Unless this interface is thought through for
B2 type of memory, it might not be extensible in the future.
