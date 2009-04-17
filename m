From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [RFC][PATCH] ACPICA: Drop Operand cache
Date: Sat, 18 Apr 2009 00:07:06 +0400
Message-ID: <49E8E16A.1070006@suse.de>
References: <49E8C9A8.5020201@suse.de> <4911F71203A09E4D9981D27F9D83085821F006A4@orsmsx503.amr.corp.intel.com> <49E8DEBC.8030307@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:35832 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752370AbZDQUHH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Apr 2009 16:07:07 -0400
In-Reply-To: <49E8DEBC.8030307@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Alexey Starikovskiy wrote:
> Moore, Robert wrote:
>> Please explain further what this accomplishes. This removes the use of 
>> any cache for the acpi operand object? What about performance? That 
>> was the major reason the cache was added in the first place.
> Our cache implementation fights with memory debugger in Microsoft Visual 
> C standard library. If you care about performance, the best way is to 
> disable this memory debugger, as we don't use it anyway. You could 
> accomplish it in two ways, one is to disable all DEBUG, the other is to 
> only disable memory debugger.
> 
Here is the link to the offending MSVC flag description:
http://msdn.microsoft.com/en-us/library/10t349zs(VS.71).aspx

Regards,
Alex.
