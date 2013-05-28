From: Jeff Wu <zlinuxkernel@gmail.com>
Subject: Re: [PATCH v2] ACPI:add _STA evaluating at do_acpi_find_child()
Date: Tue, 28 May 2013 23:16:04 +0800
Message-ID: <CAPb2CAMWHpiBYW7CB3V1aqBqHbHu+4xuSk7QesABbuX+7VeCMw@mail.gmail.com>
References: <1369711337-2410-1-git-send-email-jeff.wu@amd.com>
	<7656594.F3TsMgsJ7C@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:63907 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934418Ab3E1PQG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 May 2013 11:16:06 -0400
Received: by mail-ee0-f45.google.com with SMTP id l10so4878253eei.32
        for <linux-acpi@vger.kernel.org>; Tue, 28 May 2013 08:16:04 -0700 (PDT)
In-Reply-To: <7656594.F3TsMgsJ7C@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: jeff.wu@amd.com, Len Brown <lenb@kernel.org>, =?GB2312?B?wLbM7NPu?= <lantianyu1986@gmail.com>, linux-acpi@vger.kernel.org, shane.huang@amd.com, Aaron Lu <aaron.lwe@gmail.com>, lekensteyn@gmail.com, Sergio Perez <dagobertstaler@gmail.com>

2013/5/28 Rafael J. Wysocki <rjw@sisk.pl>:
> On Tuesday, May 28, 2013 11:22:17 AM jeff.wu@amd.com wrote:
>> From: Jeff Wu <zlinuxkernel@gmail.com>
>>
>> v2:
>> 1).If it's only one matching device, whether the deivce status is en=
abled or disabled,
>>    do_acpi_find_child() return its' handle
>> 2).If it's more than one matching devices, do_acpi_find_child() retu=
rn the first
>>    enabled device handle
>> The idea mail thread:
>> http://wwww.spinics.net/lists/linux-acpi/msg43481.html
>
> The information what's changed in v2 with respect to v1 is rather not
> interesting to the future readers of the changelog, so can you please=
 rearrange
> it as one comprehensive description of the patch?
Ok, i will rearrange it and send out the patch.
Thanks
Jeff wu

>
> The patch itself looks good to me.
That=91s great.

>
> Thanks,
> Rafael
>
>
>> v1:
>> Once do_acpi_find_child() found the first matching handle, it makes =
the acpi_get_child()
>> loop stop and return the matching handle. But, at some of the platfo=
rms, a "_ADR" is
>> with the multiple devices, and if one is enabled, the others will be=
 disabled.
>> Just like a case:
>> Address : 0x1FFFF ; handle : SB_PCI0.SATA.DEV0
>> Address : 0x1FFFF ; handle : SB_PCI0.SATA.DEV1
>> Address : 0x1FFFF ; handle : SB_PCI0.SATA.DEV2
>>
>> If DEV0 and DEV1 are disabled and DEV2 is enabled, the target is to =
get DEV2 handle, but
>> actually it always return the first disabled device DEV0 handle. So =
add a _STA evaluating
>> at do_acpi_find_child() to check the device status. If the object ex=
ists, but it is disabled,
>> acpi_get_child() will continue looping to get the correct handle tha=
t the object exists and
>> is enabled.
>>
>>
>> Signed-off-by: Jeff Wu <zlinuxkernel@gmail.com>
>> ---
>>  drivers/acpi/glue.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
>> index 40a84cc..51ca764 100644
>> --- a/drivers/acpi/glue.c
>> +++ b/drivers/acpi/glue.c
>> @@ -81,13 +81,15 @@ static struct acpi_bus_type *acpi_get_bus_type(s=
truct device *dev)
>>  static acpi_status do_acpi_find_child(acpi_handle handle, u32 lvl_n=
ot_used,
>>                                     void *addr_p, void **ret_p)
>>  {
>> -     unsigned long long addr;
>> +     unsigned long long addr, sta;
>>       acpi_status status;
>>
>>       status =3D acpi_evaluate_integer(handle, METHOD_NAME__ADR, NUL=
L, &addr);
>>       if (ACPI_SUCCESS(status) && addr =3D=3D *((u64 *)addr_p)) {
>>               *ret_p =3D handle;
>> -             return AE_CTRL_TERMINATE;
>> +             status =3D acpi_bus_get_status_handle(handle, &sta);
>> +             if (ACPI_SUCCESS(status) && (sta & ACPI_STA_DEVICE_ENA=
BLED))
>> +                     return AE_CTRL_TERMINATE;
>>       }
>>       return AE_OK;
>>  }
>>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
