From: Jon Mason <jon.mason@broadcom.com>
Subject: Re: [PATCH] ACPI: SPCR: Use access width to determine mmio usage
Date: Thu, 4 May 2017 13:30:41 -0400
Message-ID: <CAC3K-4pyppQmb=QZyv8TW3dOGsUR1k64NtLayOeMYpLpDQXfrQ@mail.gmail.com>
References: <1493910330-17913-1-git-send-email-jon.mason@broadcom.com> <94F2FBAB4432B54E8AACC7DFDE6C92E37E597D3A@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:33042 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbdEDRam (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 May 2017 13:30:42 -0400
Received: by mail-io0-f177.google.com with SMTP id p24so31144590ioi.0
        for <linux-acpi@vger.kernel.org>; Thu, 04 May 2017 10:30:42 -0700 (PDT)
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E37E597D3A@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "Zheng, Lv" <lv.zheng@intel.com>, "Box, David E" <david.e.box@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "bcm-kernel-feedback-list@broadcom.com" <bcm-kernel-feedback-list@broadcom.com>

On Thu, May 4, 2017 at 12:28 PM, Moore, Robert <robert.moore@intel.com> wrote:
> Jon,
>
> You might want to take a look at using the acpi_read and acpi_write ACPICA interfaces that accept a GAS structure and handle the access width (etc.) automatically.
>
> Bob

This function in SPCR is using common code for the early console.  So
the acpi_read/write would not be usable in that common code.

Thanks,
Jon

>
>
>> -----Original Message-----
>> From: Jon Mason [mailto:jon.mason@broadcom.com]
>> Sent: Thursday, May 4, 2017 8:06 AM
>> To: Rafael Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>;
>> Moore, Robert <robert.moore@intel.com>; Zheng, Lv <lv.zheng@intel.com>
>> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
>> devel@acpica.org; bcm-kernel-feedback-list@broadcom.com
>> Subject: [PATCH] ACPI: SPCR: Use access width to determine mmio usage
>>
>> The current SPCR code does not check the access width of the mmio, and
>> uses a default of 8bit register accesses.  This prevents devices that
>> only do 16 or 32bit register accesses from working.  By simply checking
>> this field and setting the mmio string appropriately, this issue can be
>> corrected.  To prevent any legacy issues, the code will default to 8bit
>> accesses if the value is anything but 16 or 32.
>>
>> Signed-off-by: Jon Mason <jon.mason@broadcom.com>
>> ---
>>  drivers/acpi/spcr.c     | 18 ++++++++++++++++--
>>  include/acpi/acrestyp.h |  7 +++++++
>>  2 files changed, 23 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c index
>> 01c9466..11233f6 100644
>> --- a/drivers/acpi/spcr.c
>> +++ b/drivers/acpi/spcr.c
>> @@ -74,8 +74,22 @@ int __init parse_spcr(bool earlycon)
>>               goto done;
>>       }
>>
>> -     iotype = table->serial_port.space_id ==
>> ACPI_ADR_SPACE_SYSTEM_MEMORY ?
>> -                     "mmio" : "io";
>> +     if (table->serial_port.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
>> +             switch (table->serial_port.access_width) {
>> +             default:
>> +                     pr_err("Unexpected SPCR Access Width.  Defaulting to
>> byte size\n");
>> +             case ACPI_ACCESS_SIZE_BYTE:
>> +                     iotype = "mmio";
>> +                     break;
>> +             case ACPI_ACCESS_SIZE_WORD:
>> +                     iotype = "mmio16";
>> +                     break;
>> +             case ACPI_ACCESS_SIZE_DWORD:
>> +                     iotype = "mmio32";
>> +                     break;
>> +             }
>> +     } else
>> +             iotype = "io";
>>
>>       switch (table->interface_type) {
>>       case ACPI_DBG2_ARM_SBSA_32BIT:
>> diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h index
>> f0f7403..781cb55 100644
>> --- a/include/acpi/acrestyp.h
>> +++ b/include/acpi/acrestyp.h
>> @@ -372,6 +372,13 @@ struct acpi_resource_generic_register {
>>       u64 address;
>>  };
>>
>> +/* Generic Address Space Access Sizes */
>> +#define ACPI_ACCESS_SIZE_UNDEFINED           0
>> +#define ACPI_ACCESS_SIZE_BYTE                        1
>> +#define ACPI_ACCESS_SIZE_WORD                        2
>> +#define ACPI_ACCESS_SIZE_DWORD                       3
>> +#define ACPI_ACCESS_SIZE_QWORD                       4
>> +
>>  struct acpi_resource_gpio {
>>       u8 revision_id;
>>       u8 connection_type;
>> --
>> 2.7.4
>
