From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [Devel] [PATCH] ACPICA: exfield: minor format change in	error
	message (fwd)
Date: Fri, 19 Feb 2010 12:18:29 -0800
Message-ID: <4911F71203A09E4D9981D27F9D830858599586A7@orsmsx503.amr.corp.intel.com>
References: <66D9D2F0CDB5C9428E6166B01EC85EE161E3A2E496@GVW0676EXC.americas.hpqcorp.net>
 <4911F71203A09E4D9981D27F9D830858599583B5@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54823 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753597Ab0BSUSb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Feb 2010 15:18:31 -0500
In-Reply-To: <4911F71203A09E4D9981D27F9D830858599583B5@orsmsx503.amr.corp.intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>, "Chumbalkar, Nagananda" <Nagananda.Chumbalkar@hp.com>, Len Brown <lenb@kernel.org>, "devel@acpica.org" <devel@acpica.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

I've discovered that this is a far bigger issue than one change in one file.

Most all of the invocations of ACPI_ERROR use %X to format an integer value. Most of these invocations were originally debug statements where all output was assumed to be in hex. In today's environment, we should follow standard conventions for such output -- meaning prefix all of the %X formats with 0x, or convert all %X to %u.

So, I'm going to open a bugzilla on this issue so we can address all invocations of ACPI_ERROR (and ACPI_WARNING) at the same time. There are over 300 invocations of these macros across ACPICA.

Bob


>-----Original Message-----
>From: devel-bounces@acpica.org [mailto:devel-bounces@acpica.org] On Behalf
>Of Moore, Robert
>Sent: Friday, February 19, 2010 9:09 AM
>To: Chumbalkar, Nagananda; Len Brown; devel@acpica.org
>Cc: linux-acpi@vger.kernel.org
>Subject: Re: [Devel] [PATCH] ACPICA: exfield: minor format change in error
>message (fwd)
>
>Thanks for your help, I'll roll this change into ACPICA today.
>
>
>>-----Original Message-----
>>From: Chumbalkar, Nagananda [mailto:Nagananda.Chumbalkar@hp.com]
>>Sent: Friday, February 19, 2010 8:38 AM
>>To: Moore, Robert; Len Brown; devel@acpica.org
>>Cc: linux-acpi@vger.kernel.org
>>Subject: RE: [Devel] [PATCH] ACPICA: exfield: minor format change in error
>>message (fwd)
>>
>>[PATCH v2] ACPICA: exfield: minor format change in error message
>>
>>Change %X to %u.
>>
>>V1->V2:
>>%d to %u
>>
>>Signed-off-by: Naga Chumbalkar <nagananda.chumbalkar@hp.com>
>>
>>diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.c
>>index 1588a2d..b9400e7 100644
>>--- a/drivers/acpi/acpica/exfield.c
>>+++ b/drivers/acpi/acpica/exfield.c
>>@@ -281,7 +281,8 @@ acpi_ex_write_data_to_field(union acpi_operand_object
>>*source_desc,
>>
>> 		if (source_desc->buffer.length < length) {
>> 			ACPI_ERROR((AE_INFO,
>>-				    "SMBus or IPMI write requires Buffer of length
>>%X, found length %X",
>>+				    "SMBus or IPMI write requires Buffer of "
>>+				    "length %u, found length %u",
>> 				    length, source_desc->buffer.length));
>>
>> 			return_ACPI_STATUS(AE_AML_BUFFER_LIMIT);
>>
>>
>>-----Original Message-----
>>From: Moore, Robert [mailto:robert.moore@intel.com]
>>Sent: Friday, February 19, 2010 1:49 AM
>>To: Len Brown; devel@acpica.org
>>Cc: linux-acpi@vger.kernel.org; Chumbalkar, Nagananda
>>Subject: RE: [Devel] [PATCH] ACPICA: exfield: minor format
>>change in error message (fwd)
>>
>>Yes.
>>
>>One nit:
>>+				    "length %d, found length %d",
>>
>>We usually use %u on these:
>>
>>+				    "length %u, found length %u",
>>
>>>-----Original Message-----
>>>From: devel-bounces@acpica.org
>>[mailto:devel-bounces@acpica.org] On Behalf
>>>Of Len Brown
>>>Sent: Thursday, February 18, 2010 10:43 PM
>>>To: devel@acpica.org
>>>Cc: linux-acpi@vger.kernel.org; Naga Chumbalkar
>>>Subject: [Devel] [PATCH] ACPICA: exfield: minor format change in error
>>>message (fwd)
>>>
>>>Bob,
>>>one for you.
>>>
>>>thanks,
>>>Len Brown, Intel Open Source Technology Center
>>>
>
>_______________________________________________
>Devel mailing list
>Devel@acpica.org
>http://lists.acpica.org/listinfo/devel
