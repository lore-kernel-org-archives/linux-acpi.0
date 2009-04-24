From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [RFC][PATCH] ACPICA: Drop Operand cache
Date: Fri, 24 Apr 2009 18:22:25 +0400
Message-ID: <49F1CB21.4090803@suse.de>
References: <49E8C9A8.5020201@suse.de> <4911F71203A09E4D9981D27F9D83085821F006A4@orsmsx503.amr.corp.intel.com> <49E8DEBC.8030307@suse.de> <4911F71203A09E4D9981D27F9D830858224A6B01@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:57265 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758089AbZDXOW3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Apr 2009 10:22:29 -0400
In-Reply-To: <4911F71203A09E4D9981D27F9D830858224A6B01@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Moore, Robert wrote:
> I've had a bit of time to start looking at this again.
> 
> I'm still a bit confused about what this is trying to accomplish.
> Is it a performance gain?
Yes, for in-kernel use. It has no performance difference with userland tools compiled without memory debug. It has negative performance gain 
on tools compiled with memory debug.
> Is it to reduce memory use or memory fragmentation?
Yes, both. Kernel people don't like us to keep separate caches for hundred byte allocation every 5 seconds. it's a waist of kernel resources.
> I know there has been discussion on and off concerning the use of caches, object sizes, the big union, etc., but please refresh me.
Yes, there was a outside patch to replace kernel caching with ACPICA caching. Then I explained implementation of ACPICA caching, patch was dropped (good thing), but people suggested that we simplify ACPICA memory usage to just malloc and don't use fits-all scheme for objects.
This is what my patch does -- it makes every object to only allocate it own size of memory. 

They also suggested dropping the object union, but this seems not practical as it is, because of huge number of casts between objects and common part (I've tried to do this first, but the patch became about 600k in size, containing mostly casts).
It is still possible to remove _use_ of object union there it is has benefits, for example, if function is supposed to only receive mutex object, there is a little reason to feed it with union.
> 
> As far as the operand objects, once the tables are loaded and the namespace is initialized, these are all dynamic with a lifetime of at 
> most the duration of an executing control method -- so I'm not clear as to what is to be gained by splitting a single-sized object into 
> a bunch of differently-sized objects. One would *think* that it would be more efficient to just allocate the single-sized objects 
> from a single fast cache.
Malloc in all Unix/Linux implementations use the same-size object caches (slabs) for kernel allocation for two decades now. So, inside kernel we don't gain anything by re-implementing this, mostly because we don't care about CPU caches, NUMA memory locality, etc.
There are several attempts to use slabs in malloc implementations for userspace libraries, but ACPICA is not that memory bound to require this. 

Regards,
Alex.
