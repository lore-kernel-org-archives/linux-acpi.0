From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 65/73] ACPICA: Fix for extraneous debug message for packages
Date: Tue, 15 Apr 2008 14:01:46 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B32A4E62@orsmsx415.amr.corp.intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <d67cc0dd29df98d6ac4824a617c151d7842e3a73.1207973800.git.len.brown@intel.com> <200804150309.25361.lenb@kernel.org> <48046902.8040900@gmail.com> <9D39833986E69849A2A8E74C1078B6B3257A97@orsmsx415.amr.corp.intel.com> <4804FA6A.2050401@suse.de> <9D39833986E69849A2A8E74C1078B6B3257BAC@orsmsx415.amr.corp.intel.com> <48051282.7050006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13057 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211AbYDOVBx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Apr 2008 17:01:53 -0400
Content-class: urn:content-classes:message
In-Reply-To: <48051282.7050006@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Native word size of the machine.

As I remember, lint especially really likes array indexes that use the
word size of the machine, and of course it is the most efficient
usually. However, there is no C data type that represents the native
word size across all compilation models.


>-----Original Message-----
>From: Alexey Starikovskiy [mailto:aystarik@gmail.com]
>Sent: Tuesday, April 15, 2008 1:40 PM
>To: Moore, Robert
>Cc: Alexey Starikovskiy; Len Brown; linux-acpi@vger.kernel.org
>Subject: Re: [PATCH 65/73] ACPICA: Fix for extraneous debug message for
>packages
>
>Moore, Robert wrote:
>> I think one of the reasons we introduced ACPI_NATIVE_UINT is that
"int"
>> is in fact not "native" under all compilation models.
>>
>> Here is the table from actypes.h
>>
>>  * Datatype  LP64 ILP64 LLP64 ILP32 LP32 16bit
>>  * char      8    8     8     8     8    8
>>  * short     16   16    16    16    16   16
>>  * _int32         32
>>  * int       32   64    32    32    16   16
>>  * long      64   64    32    32    32   32
>>  * long long            64    64
>>  * pointer   64   64    64    32    32   32
>>
>>
>Sorry, what do you mean by "not native" ?
>sizeof(int) != sizeof(void *)  or something else?
>How does it change applicability as array index?

