From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [RFC][PATCH] ACPICA: Drop Operand cache
Date: Fri, 24 Apr 2009 14:31:55 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858224A7592@orsmsx503.amr.corp.intel.com>
References: <49E8C9A8.5020201@suse.de>
 <4911F71203A09E4D9981D27F9D83085821F006A4@orsmsx503.amr.corp.intel.com>
 <49E8DEBC.8030307@suse.de>
 <4911F71203A09E4D9981D27F9D830858224A6B01@orsmsx503.amr.corp.intel.com>
 <49F1CB21.4090803@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:1675 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755203AbZDXVb4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Apr 2009 17:31:56 -0400
In-Reply-To: <49F1CB21.4090803@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>

Yes, I think maybe the cache stuff can go away. I see no performance improvement with the (local) cache at the application level -- in fact, it is actually slower.

I think the cache code was most useful during the early stages when we were debugging the dynamic object deletion and other object handling code, and for gathering our own memory use statistics.

With that being said, I don't want to do this all in one big step. I have noticed some instability if the local cache code is disturbed or if the cache acquire/release object interfaces are implemented with simple calls to malloc/free. The logical steps would seem to me to be:

1) Implement the AcpiOs* cache interfaces with simple malloc/free calls.

2) Replace all acquire/release calls with malloc/free calls, remove cache create/delete/purge calls, remove all cache statistical information and debugger cache support.

3) Allocate only the size needed for the desired objects, not the union size.

Each step has risk, so I would not want to do them all at once.

Also, I'd like to poll a few of our other major users to get their feedback and input.

Thanks,
Bob


>-----Original Message-----
>From: Alexey Starikovskiy [mailto:astarikovskiy@suse.de]
>Sent: Friday, April 24, 2009 7:22 AM
>To: Moore, Robert
>Cc: Len Brown; ACPI Devel Maling List
>Subject: Re: [RFC][PATCH] ACPICA: Drop Operand cache
>
>Moore, Robert wrote:
>> I've had a bit of time to start looking at this again.
>>
>> I'm still a bit confused about what this is trying to accomplish.
>> Is it a performance gain?
>Yes, for in-kernel use. It has no performance difference with userland
>tools compiled without memory debug. It has negative performance gain
>on tools compiled with memory debug.
>> Is it to reduce memory use or memory fragmentation?
>Yes, both. Kernel people don't like us to keep separate caches for hundred
>byte allocation every 5 seconds. it's a waist of kernel resources.
>> I know there has been discussion on and off concerning the use of caches,
>object sizes, the big union, etc., but please refresh me.
>Yes, there was a outside patch to replace kernel caching with ACPICA
>caching. Then I explained implementation of ACPICA caching, patch was
>dropped (good thing), but people suggested that we simplify ACPICA memory
>usage to just malloc and don't use fits-all scheme for objects.
>This is what my patch does -- it makes every object to only allocate it own
>size of memory.
>
>They also suggested dropping the object union, but this seems not practical
>as it is, because of huge number of casts between objects and common part
>(I've tried to do this first, but the patch became about 600k in size,
>containing mostly casts).
>It is still possible to remove _use_ of object union there it is has
>benefits, for example, if function is supposed to only receive mutex
>object, there is a little reason to feed it with union.
>>
>> As far as the operand objects, once the tables are loaded and the
>namespace is initialized, these are all dynamic with a lifetime of at
>> most the duration of an executing control method -- so I'm not clear as
>to what is to be gained by splitting a single-sized object into
>> a bunch of differently-sized objects. One would *think* that it would be
>more efficient to just allocate the single-sized objects
>> from a single fast cache.
>Malloc in all Unix/Linux implementations use the same-size object caches
>(slabs) for kernel allocation for two decades now. So, inside kernel we
>don't gain anything by re-implementing this, mostly because we don't care
>about CPU caches, NUMA memory locality, etc.
>There are several attempts to use slabs in malloc implementations for
>userspace libraries, but ACPICA is not that memory bound to require this.
>
>Regards,
>Alex.
