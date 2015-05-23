From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 12/19] ACPICA: ACPI 6.0: Add changes for MADT table.
Date: Sat, 23 May 2015 08:02:52 +0800
Message-ID: <555FC3AC.1090108@linaro.org>
References: <cover.1432175162.git.lv.zheng@intel.com> <e5bb0a9389d04b75d702fbdb747f3015b6be51c3.1432175162.git.lv.zheng@intel.com> <555DED69.7040203@linaro.org> <1AE640813FDE7649BE1B193DEA596E8802720DDD@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:35245 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757547AbbEWADI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 May 2015 20:03:08 -0400
Received: by pdea3 with SMTP id a3so30455576pde.2
        for <linux-acpi@vger.kernel.org>; Fri, 22 May 2015 17:03:07 -0700 (PDT)
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E8802720DDD@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

On 2015=E5=B9=B405=E6=9C=8822=E6=97=A5 08:16, Zheng, Lv wrote:
> Hi,
>
>> From: Hanjun Guo [mailto:hanjun.guo@linaro.org]
>> Sent: Thursday, May 21, 2015 10:36 PM
>>
>> Hi Lv,
>>
>> On 2015=E5=B9=B405=E6=9C=8821=E6=97=A5 10:31, Lv Zheng wrote:
>>> From: Bob Moore <robert.moore@intel.com>
>>>
>>> ACPICA commit 02cbb41232bccf7a91967140cab95d5f48291f21
>>>
>>> New subtable type. Some additions to existing subtables.
>>>
>>> Link: https://github.com/acpica/acpica/commit/02cbb412
>>> Signed-off-by: Bob Moore <robert.moore@intel.com>
>>> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
>>> ---
>> [...]
>>>
>>>    /* Masks for Flags field above */
>>> @@ -819,7 +822,7 @@ struct acpi_madt_generic_interrupt {
>>>    #define ACPI_MADT_PERFORMANCE_IRQ_MODE  (1<<1)	/* 01: Performanc=
e Interrupt Mode */
>>>    #define ACPI_MADT_VGIC_IRQ_MODE         (1<<2)	/* 02: VGIC Maint=
enance Interrupt mode */
>>>
>>> -/* 12: Generic Distributor (ACPI 5.0) */
>>> +/* 12: Generic Distributor (ACPI 5.0 + ACPI 6.0 changes) */
>>>
>>>    struct acpi_madt_generic_distributor {
>>>    	struct acpi_subtable_header header;
>>> @@ -827,7 +830,8 @@ struct acpi_madt_generic_distributor {
>>>    	u32 gic_id;
>>>    	u64 base_address;
>>>    	u32 global_irq_base;
>>> -	u32 reserved2;		/* reserved - must be zero */
>>> +	u8 version;
>>
>> version filed in generic distributor has following values,
>>
>> /* Values for gic_version in Generic Distributor  (ACPI 6.0) */
>>
>> enum acpi_madt_gic_ver_type
>> {
>>           ACPI_MADT_GIC_VER_UNKNOWN       =3D 0,
>>           ACPI_MADT_GIC_VER_V1            =3D 1,
>>           ACPI_MADT_GIC_VER_V2            =3D 2,
>>           ACPI_MADT_GIC_VER_V3            =3D 3,
>>           ACPI_MADT_GIC_VER_V4            =3D 4,
>>           ACPI_MADT_GIC_VER_RESERVED      =3D 5     /* 5 and greater=
 are
>> reserved */
>> };
>>
>> should we put it here, or locate it to ARM64 arch related head
>> file?
>
> Yes, you can put it here.
> And also please help to submit an ACPICA patch to <devel@acpica.org>.

OK, I think it is a fix to this patch too, I will
prepare a patch soon.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
