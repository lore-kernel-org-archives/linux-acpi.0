From: Luca Tettamanti <kronos.it@gmail.com>
Subject: [BUG] ACPI resource validation not working [Was: Re: ITE 8728F]
Date: Mon, 28 Nov 2011 21:53:55 +0100
Message-ID: <CAKPcRGofYw_DcVL1QDorSp8Gr1ZL6-ur=oZnDs0w_e91ZuwKbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46897 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868Ab1K1Ux4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 Nov 2011 15:53:56 -0500
Received: by yenl6 with SMTP id l6so3288442yen.19
        for <linux-acpi@vger.kernel.org>; Mon, 28 Nov 2011 12:53:55 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Nikolay Mikov <nik.mikov@gmail.com>, Thomas <trenn@suse.de>, Bob Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org

To give some context to the newcomers: while helping a user with a new
hwmon chip we discovered that the native driver is loaded fine even
though the IO ports are claimed by ACPI (OperationRegion) and
acpi_enforce_resources is "strict".

On Mon, Nov 28, 2011 at 4:48 PM, Luca Tettamanti <kronos.it@gmail.com> =
wrote:
> On Mon, Nov 28, 2011 at 4:08 PM, Jean Delvare <khali@linux-fr.org> wr=
ote:
>> On Mon, 28 Nov 2011 14:02:51 +0100, Luca Tettamanti wrote:
>>> The DSDT has this:
>>>
>>> Name (IOEB, 0x0290)
>>> OperationRegion (SIOE, SystemIO, IOEB, 0x20)
>>> Field (SIOE, ByteAcc, NoLock, Preserve)
>>> {
>>> =C2=A0 =C2=A0 Offset (0x05),
>>> =C2=A0 =C2=A0 GIDX, =C2=A0 8,
>>> =C2=A0 =C2=A0 GDAT, =C2=A0 8
>>> }
>>>
>>> so the requested area is well within what ACPI claims.
[cut]
>> A colleague of mine (hi Thomas!) suggests that Nikolay could boot wi=
th:
>>
>> ddebug=3D"file osl.c +p
>
> This should be:
>
> ddebug_query=3D"file osl.c +p"
>
> It should spam the log with all the resources found by ACPI parser,
> assuming that CONFIG_DYNAMIC_DEBUG is enabled.

Hum, the call to acpi_os_validate_address was removed between 2.6.38
and 2.6.39, with this commit by Bob More:

commit 9ad19ac456a5f097f7cbbfef820b95297d6a934f
Author: Bob Moore <robert.moore@intel.com>
Date:   Mon Feb 14 16:09:40 2011 +0800

    ACPICA: Split large dsopcode and dsload.c files.

which seems to be just moving code around (the culprit here is
acpi_ds_get_region_arguments). I guess that the removal wasn't
intentional since the corresponding call to acpi_os_invalidate_address
was left in place.
Bob should I put the call back in place? Am I missing something?

Luca
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
