From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 1/7] node: Link memory nodes to their compute nodes
Date: Mon, 19 Nov 2018 08:22:49 +0530
Message-ID: <e0b99866-b98b-3385-d0c9-96d5a1d74a6d@arm.com>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181115135710.GD19286@bombadil.infradead.org>
 <20181115145920.GG11416@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181115145920.GG11416@localhost.localdomain>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>, Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org



On 11/15/2018 08:29 PM, Keith Busch wrote:
> On Thu, Nov 15, 2018 at 05:57:10AM -0800, Matthew Wilcox wrote:
>> On Wed, Nov 14, 2018 at 03:49:14PM -0700, Keith Busch wrote:
>>> Memory-only nodes will often have affinity to a compute node, and
>>> platforms have ways to express that locality relationship.
>>>
>>> A node containing CPUs or other DMA devices that can initiate memory
>>> access are referred to as "memory iniators". A "memory target" is a
>>> node that provides at least one phyiscal address range accessible to a
>>> memory initiator.
>>
>> I think I may be confused here.  If there is _no_ link from node X to
>> node Y, does that mean that node X's CPUs cannot access the memory on
>> node Y?  In my mind, all nodes can access all memory in the system,
>> just not with uniform bandwidth/latency.
> 
> The link is just about which nodes are "local". It's like how nodes have
> a cpulist. Other CPUs not in the node's list can acces that node's memory,
> but the ones in the mask are local, and provide useful optimization hints.
> 
> Would a node mask would be prefered to symlinks?

Having hint for local affinity is definitely a plus but this must provide
the coherency matrix to the user preferably in the form of a nodemask for
each memory target.
