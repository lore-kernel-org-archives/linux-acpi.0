From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 65/73] ACPICA: Fix for extraneous debug message for packages
Date: Tue, 15 Apr 2008 14:29:53 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B32A4E98@orsmsx415.amr.corp.intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <d67cc0dd29df98d6ac4824a617c151d7842e3a73.1207973800.git.len.brown@intel.com> <200804150309.25361.lenb@kernel.org> <48046902.8040900@gmail.com> <9D39833986E69849A2A8E74C1078B6B3257A97@orsmsx415.amr.corp.intel.com> <4804FA6A.2050401@suse.de> <9D39833986E69849A2A8E74C1078B6B3257BAC@orsmsx415.amr.corp.intel.com> <48051282.7050006@gmail.com> <9D39833986E69849A2A8E74C1078B6B32A4E62@orsmsx415.amr.corp.intel.com> <48051A27.6040004@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:31022 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759410AbYDOV34 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Apr 2008 17:29:56 -0400
Content-class: urn:content-classes:message
In-Reply-To: <48051A27.6040004@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Well, yes native word size being the pointer size, now that the 16-bit
model is out of the picture.

We defined ACPI_NATIVE_UINT in order to have an integer data type that
is 32 bits in 32-bit mode, and 64 bits in 64-bit mode (and originally,
16 bits in 16-bit mode). There is no corresponding C type that can
accomplish this across all compilation models.

Yes, ACPI_NATIVE_UINT has issues with printf because there is
unfortunately no printf formatting operator other than %p that goes 32
bits in 32-bit mode and 64 bits in 64-bit mode. I think there may be
cases in ACPICA where we just cast an ACPI_NATIVE_UINT to a pointer to
use it with printf.


>-----Original Message-----
>From: Alexey Starikovskiy [mailto:astarikovskiy@suse.de]
>Sent: Tuesday, April 15, 2008 2:12 PM
>To: Moore, Robert
>Cc: Alexey Starikovskiy; Len Brown; linux-acpi@vger.kernel.org
>Subject: Re: [PATCH 65/73] ACPICA: Fix for extraneous debug message for
>packages
>
>Moore, Robert wrote:
>> Native word size of the machine.
>>
>> As I remember, lint especially really likes array indexes that use
the
>> word size of the machine, and of course it is the most efficient
>> usually. However, there is no C data type that represents the native
>> word size across all compilation models.
>and native word size being sizeof(void *)?
>
>Let's look on that from the other perspective. int is intended by C
authors
>as least expensive to use integer type. long is intended to be least
>expensive
>integer type of maximum capacity. Both types play nice with printf()
and
>Co.
>
>Now we introduce new typedef to annoy printf(), C, and Linux bosses
only to
>please lint?
>
>Regards,
>Alex.
>>
>>
>>> -----Original Message-----
>>> From: Alexey Starikovskiy [mailto:aystarik@gmail.com]
>>> Sent: Tuesday, April 15, 2008 1:40 PM
>>> To: Moore, Robert
>>> Cc: Alexey Starikovskiy; Len Brown; linux-acpi@vger.kernel.org
>>> Subject: Re: [PATCH 65/73] ACPICA: Fix for extraneous debug message
for
>>> packages
>>>
>>> Moore, Robert wrote:
>>>> I think one of the reasons we introduced ACPI_NATIVE_UINT is that
>> "int"
>>>> is in fact not "native" under all compilation models.
>>>>
>>>> Here is the table from actypes.h
>>>>
>>>>  * Datatype  LP64 ILP64 LLP64 ILP32 LP32 16bit
>>>>  * char      8    8     8     8     8    8
>>>>  * short     16   16    16    16    16   16
>>>>  * _int32         32
>>>>  * int       32   64    32    32    16   16
>>>>  * long      64   64    32    32    32   32
>>>>  * long long            64    64
>>>>  * pointer   64   64    64    32    32   32
>>>>
>>>>
>>> Sorry, what do you mean by "not native" ?
>>> sizeof(int) != sizeof(void *)  or something else?
>>> How does it change applicability as array index?
>>

