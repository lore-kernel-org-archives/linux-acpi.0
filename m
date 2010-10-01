From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] /drivers/acpi/acpica/nsrepair.c (2.6.35.7) - Fixed
 useless compile warning
Date: Fri, 1 Oct 2010 09:46:27 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858B29AEC6D@orsmsx503.amr.corp.intel.com>
References: <593258.59408.qm@web45801.mail.sp1.yahoo.com>
 <alpine.LFD.2.00.1010010213051.7033@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:59977 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189Ab0JAQqa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Oct 2010 12:46:30 -0400
In-Reply-To: <alpine.LFD.2.00.1010010213051.7033@localhost.localdomain>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Poyo VL <poyo_vl@yahoo.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Yes, do tell. Compiler and options used.

We don't see a warning on any of the compilers we test with, nor lint.

Thanks,
Bob


>-----Original Message-----
>From: Len Brown [mailto:lenb@kernel.org]
>Sent: Thursday, September 30, 2010 11:14 PM
>To: Poyo VL
>Cc: linux-acpi@vger.kernel.org; Moore, Robert
>Subject: Re: [PATCH] /drivers/acpi/acpica/nsrepair.c (2.6.35.7) - Fixed
>useless compile warning
>
>
>
>thanks,
>Len Brown, Intel Open Source Technology Center
>
>On Sun, 19 Sep 2010, Poyo VL wrote:
>
>> This is not a problem, it is a simple fix for an ugly compiler warning.
>When I
>> tried to cimpile, I got the following warning:
>> drivers/acpi/acpica/nsrepair.c: In function 'acpi_ns_repair_object':
>> drivers/acpi/acpica/nsrepair.c:125:29: warning: 'new_object' may be used
>> uninitialized in this function
>> new_object is declared without being initialized. It is initialized in a
>> conditional expression like if (expected_btypes & ACPI_RTYPE_INTEGER) so
>the
>> compiler can't be sure that it will be used initialized, and it throws
>that
>> warning.
>> Just have to initialize new_object which is a pointer with NULL.
>
>I don't see this warning.
>What version of the compiler are you using?
>
>thanks,
>-Len
>
>> Patch:
>>
>> Signed-off-by: Ionut Gabriel Popescu <poyo_vl@yahoo.com>
>> ---
>>
>> --- a/drivers/acpi/acpica/nsrepair.c    2010-09-20 08:35:56.568006487
>+0300
>> +++ b/drivers/acpi/acpica/nsrepair.c    2010-09-20 08:00:40.000000000
>+0300
>> @@ -122,7 +122,7 @@ acpi_ns_repair_object(struct acpi_predef
>>                union acpi_operand_object **return_object_ptr)
>>  {
>>      union acpi_operand_object *return_object = *return_object_ptr;
>> -    union acpi_operand_object *new_object;
>> +    union acpi_operand_object *new_object = NULL;
>>      acpi_status status;
>>
>>      ACPI_FUNCTION_NAME(ns_repair_object);
>>
