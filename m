From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Subject: Re: ACPI Error: Method parse/execution failed [\_SB_.PCI0.LPCB.EC0_._REG]
 (Node ffff880133a50208), AE_NOT_EXIST (20101013/psparse-537)
Date: Sat, 19 Feb 2011 11:05:02 +0100
Message-ID: <AANLkTim4xbozjXr60JtqT+JTS2tWUgjUFsMiW_aqOCX1@mail.gmail.com>
References: <AANLkTikzXtJ2L-j96ody6xB+0bs3WXFARE+HEnuGT3wn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:64861 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab1BSKFX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Feb 2011 05:05:23 -0500
Received: by yib18 with SMTP id 18so1952221yib.19
        for <linux-acpi@vger.kernel.org>; Sat, 19 Feb 2011 02:05:22 -0800 (PST)
In-Reply-To: <AANLkTikzXtJ2L-j96ody6xB+0bs3WXFARE+HEnuGT3wn@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Looks like my email was rejected. So I am re-sending it with link
instead of attachement.

thanks again for your help:

http://malat.free.fr/acpi/acpidump.txt

http://malat.free.fr/acpi/dmesg2.txt

On Fri, Feb 18, 2011 at 11:28 AM, Mathieu Malaterre
<mathieu.malaterre@gmail.com> wrote:
> Dear all,
>
> =A0I am still looking for help on the following errors I see in dmesg=
:
>
> [ =A0 =A00.532052] ACPI Error: No handler for Region [ERAM]
> (ffff880133a4ccf0) [EmbeddedControl] (20101013/evregion-369)
> [ =A0 =A00.532056] ACPI Error: Region EmbeddedControl(0x3) has no han=
dler
> (20101013/exfldio-292)
> [ =A0 =A00.532062] ACPI Error: Method parse/execution failed
> [\_SB_.PCI0.LPCB.EC0_._REG] (Node ffff880133a50208), AE_NOT_EXIST
> (20101013/psparse-537)
>
> =A0It looks like the error has been reported previously. As per
> recommendations from:
>
> http://www.spinics.net/lists/linux-acpi/msg30804.html
>
> =A0I am attaching a compressed version of dmesg output and acpidump.
>
> thanks a bunch !
>
> On Wed, Feb 16, 2011 at 5:29 PM, Mathieu Malaterre
> <mathieu.malaterre@gmail.com> wrote:
>> Dear all,
>>
>> =A0I recently bought a new laptop, where I installed a debian system=
=2E
>> However the ACPI output is a bit surprising on this machine:
>>
>> $ acpi -V
>> Battery 0: Discharging, 94%, 01:50:55 remaining
>> Battery 0: design capacity 4500 mAh, last full capacity 4570 mAh =3D=
 100%
>> Adapter 0: off-line
>> Cooling 0: Processor 0 of 3
>> Cooling 1: Processor 0 of 3
>> Cooling 2: Processor 0 of 3
>> Cooling 3: Processor 0 of 3
>> Cooling 4: LCD 4 of 7
>>
>> $ lsmod | grep acpi
>> acpi_cpufreq =A0 =A0 =A0 =A0 =A0 =A05571 =A01
>> processor =A0 =A0 =A0 =A0 =A0 =A0 =A029935 =A05 acpi_cpufreq
>>
>> Reading some online documentation (*) I should have something like a
>> toshiba_acpi module loaded, right ?
>>
>> Is this the right place too ask this kind of question ? If so what
>> else is needed to investigate what could be wrong on my setup ?
>>
>> Thanks !
>> --
>> Mathieu
>> (*) http://memebeam.org/toys/ToshibaAcpiDriver
>>
>
>
>
> --
> Mathieu
>



--=20
Mathieu
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
