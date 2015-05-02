From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 15/17] ACPICA/ARM: ACPI 5.1: Update for GTDT table changes.
Date: Sat, 02 May 2015 22:02:08 +0800
Message-ID: <5544D8E0.9000301@linaro.org>
References: <cover.1406689493.git.lv.zheng@intel.com>	<a3f86a5075c565002cd4bed0befb7d167fa0f105.1406689494.git.lv.zheng@intel.com> <CAOZdJXU6vENaPJdwt6VBOwWrZ5tcjqk4k4uxBX2T5QPUDCgo7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36678 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbbEBOCS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 May 2015 10:02:18 -0400
Received: by pabsx10 with SMTP id sx10so117813819pab.3
        for <linux-acpi@vger.kernel.org>; Sat, 02 May 2015 07:02:18 -0700 (PDT)
In-Reply-To: <CAOZdJXU6vENaPJdwt6VBOwWrZ5tcjqk4k4uxBX2T5QPUDCgo7A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>, Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Bob Moore <robert.moore@intel.com>

Hi Timur,

oh, you already noticed this issue, sorry for the
noise in my previous email.

On 2015=E5=B9=B405=E6=9C=8802=E6=97=A5 06:43, Timur Tabi wrote:
> On Tue, Jul 29, 2014 at 11:21 PM, Lv Zheng <lv.zheng@intel.com> wrote=
:
>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>
>> New fields and new subtables. Tomasz Nowicki.
>> tomasz.nowicki@linaro.org
>>
>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Signed-off-by: Bob Moore <robert.moore@intel.com>
>> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
>
> Hi, I know this patch is old, but something confuses me about it:
>
>> +/* Common GTDT subtable header */
>> +
>> +struct acpi_gtdt_header {
>> +       u8 type;
>> +       u16 length;
>> +};
>
> I'm trying to write a function that parses the watchdog structure
> (acpi_gtdt_watchdog).  The first entry in that structure is
> acpi_gtdt_header.  Looking at the ACPI specification, I see that this
> is correct: the type is one byte, and the length is two bytes.
>
> However, this means that I cannot use acpi_parse_entries() to parse
> the watchdog subtable:
>
> int __init
> acpi_parse_entries(char *id, unsigned long table_size,
>          acpi_tbl_entry_handler handler,
>          struct acpi_table_header *table_header,
>          int entry_id, unsigned int max_entries)
>
> acpi_tbl_entry_handler takes an acpi_subtable_header as its first
> parameter.  However, that structure looks like this:
>
> struct acpi_subtable_header {
>      u8 type;
>      u8 length;
> };
>
> This is not compatible, so I'm confused now.  How do I properly parse
> the watchdog subtable, if I cannot use acpi_parse_entries?

This is really a pain. I noticed this when I was prototyping the code
for GTDT in ACPI 5.1, and I even sent an email to Charles to ask him if
there are mistakes here, but there are chances that more than 255 bytes
in that structure so we must use u16 for the length.

>
> For context, here is my patch:
>
> http://www.spinics.net/lists/linux-watchdog/msg06240.html
>
> Scroll down to function arm_sbsa_wdt_parse_gtdt().  The typecast in
> first line is invalid:
>
> +    struct acpi_gtdt_watchdog *wdg =3D (struct acpi_gtdt_watchdog *)=
header;
>
> because of the mismatch.  I don't know how to fix this.

Yes, you can't use acpi_parse_entries() anymore, in my opinion, you
can introduce a similar function as acpi_parse_entries(), you can
refer to some code that parsing the structures with u16 length, the
code I'm familiar it's the code for Intel DMAR (similar with ARM IORT),
for DMAR table parsing, it has the same head as GTDT watchdog timer:

/* DMAR subtable header */

struct acpi_dmar_header {
         u16 type;
         u16 length;
};

please refer to drivers/iommu/dmar.c and drivers/iommu/intel-iommu.c,
hope it helps.

Thanks
Hanjun


>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
