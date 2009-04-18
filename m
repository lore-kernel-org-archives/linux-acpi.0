From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [RFC][PATCH] ACPICA: Drop Operand cache
Date: Fri, 17 Apr 2009 20:46:43 -0700
Message-ID: <4911F71203A09E4D9981D27F9D83085821F00A94@orsmsx503.amr.corp.intel.com>
References: <49E8C9A8.5020201@suse.de>
 <4911F71203A09E4D9981D27F9D83085821F006A4@orsmsx503.amr.corp.intel.com>
 <49E8DEBC.8030307@suse.de> <49E8E16A.1070006@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:12237 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168AbZDRDqq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Apr 2009 23:46:46 -0400
In-Reply-To: <49E8E16A.1070006@suse.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

I'll take a look at this sometime next week.
Bob


>-----Original Message-----
>From: Alexey Starikovskiy [mailto:astarikovskiy@suse.de]
>Sent: Friday, April 17, 2009 1:07 PM
>To: Moore, Robert
>Cc: Len Brown; ACPI Devel Maling List
>Subject: Re: [RFC][PATCH] ACPICA: Drop Operand cache
>
>Alexey Starikovskiy wrote:
>> Moore, Robert wrote:
>>> Please explain further what this accomplishes. This removes the use of
>>> any cache for the acpi operand object? What about performance? That
>>> was the major reason the cache was added in the first place.
>> Our cache implementation fights with memory debugger in Microsoft Visual
>> C standard library. If you care about performance, the best way is to
>> disable this memory debugger, as we don't use it anyway. You could
>> accomplish it in two ways, one is to disable all DEBUG, the other is to
>> only disable memory debugger.
>>
>Here is the link to the offending MSVC flag description:
>http://msdn.microsoft.com/en-us/library/10t349zs(VS.71).aspx
>
>Regards,
>Alex.
