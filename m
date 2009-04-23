From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [RFC][PATCH] ACPICA: Drop Operand cache
Date: Thu, 23 Apr 2009 13:47:20 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858224A6B01@orsmsx503.amr.corp.intel.com>
References: <49E8C9A8.5020201@suse.de>
 <4911F71203A09E4D9981D27F9D83085821F006A4@orsmsx503.amr.corp.intel.com>
 <49E8DEBC.8030307@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:13456 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754759AbZDWUrX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 16:47:23 -0400
In-Reply-To: <49E8DEBC.8030307@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

I've had a bit of time to start looking at this again.

I'm still a bit confused about what this is trying to accomplish. Is it a performance gain? Is it to reduce memory use or memory fragmentation? I know there has been discussion on and off concerning the use of caches, object sizes, the big union, etc., but please refresh me.

As far as the operand objects, once the tables are loaded and the namespace is initialized, these are all dynamic with a lifetime of at most the duration of an executing control method -- so I'm not clear as to what is to be gained by splitting a single-sized object into a bunch of differently-sized objects. One would *think* that it would be more efficient to just allocate the single-sized objects from a single fast cache.



>-----Original Message-----
>From: Alexey Starikovskiy [mailto:astarikovskiy@suse.de]
>Sent: Friday, April 17, 2009 12:56 PM
>To: Moore, Robert
>Cc: Len Brown; ACPI Devel Maling List
>Subject: Re: [RFC][PATCH] ACPICA: Drop Operand cache
>
>Moore, Robert wrote:
>> Please explain further what this accomplishes. This removes the use of
>any cache for the acpi operand object? What about performance? That was the
>major reason the cache was added in the first place.
>Our cache implementation fights with memory debugger in Microsoft Visual C
>standard library. If you care about performance, the best way is to disable
>this memory debugger, as we don't use it anyway. You could accomplish it in
>two ways, one is to disable all DEBUG, the other is to only disable memory
>debugger.
>
>With this patch, every object type is allowed to have it's own size, thus
>allowing separate optimization. For example, "extra" object, tied to region
>and field objects could be folded in to save both space and code, this
>optimization was implemented by Kuzmich some time ago, but was lost during
>layoffs.
>
>Regards,
>Alex.
>
>>
>>
>>> -----Original Message-----
>>> From: Alexey Starikovskiy [mailto:astarikovskiy@suse.de]
>>> Sent: Friday, April 17, 2009 11:26 AM
>>> To: Moore, Robert; Len Brown
>>> Cc: ACPI Devel Maling List
>>> Subject: [RFC][PATCH] ACPICA: Drop Operand cache
>>>
>>> Hi,
>>>
>>> I've played with AcpiOperandObject union and corresponding cache.
>Removing
>>> the union does not seem to be viable -- patch easily overcomes .5 meg
>>> barrier, without any visible change. Dropping only the cache and making
>all
>>> individual objects allocated from heap requires smaller number  of
>changes
>>> and chould make SLAB/SLUB developers happy.
>>>
>>> Regards,
>>> Alex.

