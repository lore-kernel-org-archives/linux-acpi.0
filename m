From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 65/73] ACPICA: Fix for extraneous debug message for packages
Date: Tue, 15 Apr 2008 13:19:47 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B3257BAC@orsmsx415.amr.corp.intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org> <d67cc0dd29df98d6ac4824a617c151d7842e3a73.1207973800.git.len.brown@intel.com> <200804150309.25361.lenb@kernel.org> <48046902.8040900@gmail.com> <9D39833986E69849A2A8E74C1078B6B3257A97@orsmsx415.amr.corp.intel.com> <4804FA6A.2050401@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:53999 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbYDOUTz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Apr 2008 16:19:55 -0400
Content-class: urn:content-classes:message
In-Reply-To: <4804FA6A.2050401@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

I think one of the reasons we introduced ACPI_NATIVE_UINT is that "int"
is in fact not "native" under all compilation models.

Here is the table from actypes.h

 * Datatype  LP64 ILP64 LLP64 ILP32 LP32 16bit
 * char      8    8     8     8     8    8
 * short     16   16    16    16    16   16
 * _int32         32
 * int       32   64    32    32    16   16
 * long      64   64    32    32    32   32
 * long long            64    64
 * pointer   64   64    64    32    32   32




>-----Original Message-----
>From: Alexey Starikovskiy [mailto:astarikovskiy@suse.de]
>Sent: Tuesday, April 15, 2008 11:57 AM
>To: Moore, Robert
>Cc: Alexey Starikovskiy; Len Brown; linux-acpi@vger.kernel.org
>Subject: Re: [PATCH 65/73] ACPICA: Fix for extraneous debug message for
>packages
>
>Moore, Robert wrote:
>> We use acpi_native_uint for things like array indexes so it goes
32/64
>> without warnings (lint or otherwise).
>>
>> However,
>> typedef UINT32                          ACPI_NATIVE_UINT;
>>
>> should get converted to
>> typedef u32                             acpi_native_uint;
>Well, "unsigned int" is supposed to be of native length. u32 is not
going
>to be of
>native length on 64 bits.
>What kind of warning do you avoid?
>I don't know any checker who does not accept int/unsigned int as array
>index...
>
>Regards,
>Alex.
>
>
>>
>> during the linuxiztion, I think
>>
>>> -----Original Message-----
>>> From: Alexey Starikovskiy [mailto:aystarik@gmail.com]
>>> Sent: Tuesday, April 15, 2008 1:36 AM
>>> To: Len Brown
>>> Cc: linux-acpi@vger.kernel.org; Moore, Robert; Alexey Starikovskiy
>>> Subject: Re: [PATCH 65/73] ACPICA: Fix for extraneous debug message
for
>>> packages
>>>
>>> Len Brown wrote:
>>>> From: Len Brown <len.brown@intel.com>
>>>>
>>>> drivers/acpi/dispatcher/dsobject.c:499: warning: format '%X'
expects
>> type
>>> 'unsigned int', but argument 4 has type 'acpi_native_uint'
>>>> drivers/acpi/dispatcher/dsobject.c:507: warning: format '%X'
expects
>> type
>>> 'unsigned int', but argument 7 has type 'acpi_native_uint'
>>>> Signed-off-by: Len Brown <len.brown@intel.com>
>>>> ---
>>>>  drivers/acpi/dispatcher/dsobject.c |    2 +-
>>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/dispatcher/dsobject.c
>>> b/drivers/acpi/dispatcher/dsobject.c
>>>> index 5184278..bdef2f0 100644
>>>> --- a/drivers/acpi/dispatcher/dsobject.c
>>>> +++ b/drivers/acpi/dispatcher/dsobject.c
>>>> @@ -373,7 +373,7 @@ acpi_ds_build_internal_package_obj(struct
>>> acpi_walk_state *walk_state,
>>>>  	union acpi_parse_object *parent;
>>>>  	union acpi_operand_object *obj_desc = NULL;
>>>>  	acpi_status status = AE_OK;
>>>> -	acpi_native_uint i;
>>>> +	u32 i;
>>>>
>>> why not just unsigned ?
>>>>  	u16 index;
>>>>  	u16 reference_count;
>>>>
>>>>
>>

