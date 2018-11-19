From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 2/7] node: Add heterogenous memory performance
Date: Mon, 19 Nov 2018 09:05:07 +0530
Message-ID: <91369e94-d389-7cb9-6274-f46c9ec779d3@arm.com>
References: <20181114224921.12123-2-keith.busch@intel.com>
 <20181114224921.12123-3-keith.busch@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114224921.12123-3-keith.busch@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Keith Busch <keith.busch@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-mm@kvack.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rafael Wysocki <rafael@kernel.org>, Dave Hansen <dave.hansen@intel.com>, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-acpi@vger.kernel.org



On 11/15/2018 04:19 AM, Keith Busch wrote:
> Heterogeneous memory systems provide memory nodes with latency
> and bandwidth performance attributes that are different from other
> nodes. Create an interface for the kernel to register these attributes

There are other properties like power consumption, reliability which can
be associated with a particular PA range. Also the set of properties has
to be extensible for the future.

> under the node that provides the memory. If the system provides this
> information, applications can query the node attributes when deciding
> which node to request memory.

Right but each (memory initiator, memory target) should have these above
mentioned properties enumerated to have an 'property as seen' from kind
of semantics.

> 
> When multiple memory initiators exist, accessing the same memory target
> from each may not perform the same as the other. The highest performing
> initiator to a given target is considered to be a local initiator for
> that target. The kernel provides performance attributes only for the
> local initiators.

As mentioned above the interface must enumerate a future extensible set
of properties for each (memory initiator, memory target) pair available
on the system.

> 
> The memory's compute node should be symlinked in sysfs as one of the
> node's initiators.

Right. IIUC the first patch skips the linking process of for two nodes A
and B if (A == B) preventing association to local memory initiator.
