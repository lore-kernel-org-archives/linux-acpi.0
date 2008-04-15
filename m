From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH 65/73] ACPICA: Fix for extraneous debug message for packages
Date: Wed, 16 Apr 2008 01:12:07 +0400
Message-ID: <48051A27.6040004@suse.de>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <d67cc0dd29df98d6ac4824a617c151d7842e3a73.1207973800.git.len.brown@intel.com> <200804150309.25361.lenb@kernel.org> <48046902.8040900@gmail.com> <9D39833986E69849A2A8E74C1078B6B3257A97@orsmsx415.amr.corp.intel.com> <4804FA6A.2050401@suse.de> <9D39833986E69849A2A8E74C1078B6B3257BAC@orsmsx415.amr.corp.intel.com> <48051282.7050006@gmail.com> <9D39833986E69849A2A8E74C1078B6B32A4E62@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:57504 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754937AbYDOVMN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Apr 2008 17:12:13 -0400
In-Reply-To: <9D39833986E69849A2A8E74C1078B6B32A4E62@orsmsx415.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Moore, Robert wrote:
> Native word size of the machine.
> 
> As I remember, lint especially really likes array indexes that use the
> word size of the machine, and of course it is the most efficient
> usually. However, there is no C data type that represents the native
> word size across all compilation models.
and native word size being sizeof(void *)?

Let's look on that from the other perspective. int is intended by C authors
as least expensive to use integer type. long is intended to be least expensive
integer type of maximum capacity. Both types play nice with printf() and Co.

Now we introduce new typedef to annoy printf(), C, and Linux bosses only to
please lint?

Regards,
Alex.
> 
> 
>> -----Original Message-----
>> From: Alexey Starikovskiy [mailto:aystarik@gmail.com]
>> Sent: Tuesday, April 15, 2008 1:40 PM
>> To: Moore, Robert
>> Cc: Alexey Starikovskiy; Len Brown; linux-acpi@vger.kernel.org
>> Subject: Re: [PATCH 65/73] ACPICA: Fix for extraneous debug message for
>> packages
>>
>> Moore, Robert wrote:
>>> I think one of the reasons we introduced ACPI_NATIVE_UINT is that
> "int"
>>> is in fact not "native" under all compilation models.
>>>
>>> Here is the table from actypes.h
>>>
>>>  * Datatype  LP64 ILP64 LLP64 ILP32 LP32 16bit
>>>  * char      8    8     8     8     8    8
>>>  * short     16   16    16    16    16   16
>>>  * _int32         32
>>>  * int       32   64    32    32    16   16
>>>  * long      64   64    32    32    32   32
>>>  * long long            64    64
>>>  * pointer   64   64    64    32    32   32
>>>
>>>
>> Sorry, what do you mean by "not native" ?
>> sizeof(int) != sizeof(void *)  or something else?
>> How does it change applicability as array index?
> 

