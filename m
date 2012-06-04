From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: ACPICA version 20120518 linuxized patches
Date: Mon, 4 Jun 2012 10:18:10 +0800
Message-ID: <CAF1ivSa_fc9a=+qphxVHQxk9pcM3WQdi-sdo4wsMXoS8jMuKBQ@mail.gmail.com>
References: <1337676725.24434.34.camel@minggr>
	<4FC8E63C.9020109@kernel.org>
	<94F2FBAB4432B54E8AACC7DFDE6C92E346ACD057@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:47643 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755009Ab2FDCSL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 3 Jun 2012 22:18:11 -0400
Received: by vcbf11 with SMTP id f11so2213542vcb.19
        for <linux-acpi@vger.kernel.org>; Sun, 03 Jun 2012 19:18:10 -0700 (PDT)
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E346ACD057@ORSMSX101.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Sat, Jun 2, 2012 at 3:00 AM, Moore, Robert <robert.moore@intel.com> =
wrote:
> We've tried to be very careful about not including compiler-only code=
 into kernel code.
>
> I'm not entirely sure why patches 1,2, and 3 are applied against Linu=
x. Perhaps Ming can answer this, or I'll take a look at the patches.

That is because the patches also changed the core code.

drivers/acpi/acpica/dsfield.c
include/acpi/actypes.h
drivers/acpi/acpica/utmisc.c

So we need to apply them to avoid divergence problem.

Lin Ming

>
> Bob
>
>
>> -----Original Message-----
>> From: Len Brown [mailto:lenb417@gmail.com] On Behalf Of Len Brown
>> Sent: Friday, June 01, 2012 8:57 AM
>> To: Lin, Ming M
>> Cc: Moore, Robert; linux-acpi
>> Subject: Re: ACPICA version 20120518 linuxized patches
>>
>> On 05/22/2012 04:52 AM, Lin Ming wrote:
>>
>> > Hi Len,
>> >
>> > ACPICA version 20120518 linuxized patches attached.
>> >
>> > [PATCH 1/6] ACPICA: Disassembler: Add support for Operation Region
>> > externals [PATCH 2/6] ACPICA: ACPI 5/iASL: Add support for PCC
>> keyword
>> > [PATCH 3/6] ACPICA: iASL: Improved pathname support [PATCH 4/6]
>> > ACPICA: Remove argument of acpi_os_wait_events_complete [PATCH 5/6=
]
>> > ACPICA: Add FADT error message for GAS BitWidth overflow [PATCH 6/=
6]
>> > ACPICA: Update to version 20120518
>> >
>> > Regards,
>> > Lin Ming
>>
>>
>> Applied.
>>
>> I is great that the compiler and interpreter share the same code.
>> However, there is also the risk of building dead compiler code into =
the
>> kernel. =A0We should probably do an analysis of that...
>>
>> thanks,
>> Len Brown, Intel Open Source Technology Center
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
