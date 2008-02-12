From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Fwd: FSC Esprimo Mobile V5505 - dmidecode
Date: Tue, 12 Feb 2008 23:11:51 +0300
Message-ID: <47B1FD87.8070801@gmail.com>
References: <200710122357.46851.dl9pf@gmx.de> <200801182329.49567.lenb@kernel.org> <200802121157.33691.dl9pf@gmx.de> <200802121500.25986.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:28492 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475AbYBLULv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Feb 2008 15:11:51 -0500
Received: by ug-out-1314.google.com with SMTP id z38so595551ugc.16
        for <linux-acpi@vger.kernel.org>; Tue, 12 Feb 2008 12:11:50 -0800 (PST)
In-Reply-To: <200802121500.25986.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: =?ISO-8859-1?Q?Jan-Simon_M=F6ller?= <dl9pf@gmx.de>, linux-acpi@vger.kernel.org

Len Brown wrote:
> On Tuesday 12 February 2008 05:57, Jan-Simon M=F6ller wrote:
>  =20
>> Sorry for the late reply !
>>
>> Am Samstag 19 Januar 2008 05:29:49 schrieb Len Brown:
>>    =20
>>> On Saturday 13 October 2007 04:13, Jan-Simon M=F6ller wrote:
>>>      =20
>>>> System Information
>>>>         Manufacturer: FUJITSU SIEMENS
>>>>         Product Name: ESPRIMO Mobile V5505
>>>>         Version: 20
>>>>         Wake-up Type: Power Switch
>>>>         SKU Number: Not Specified
>>>>         Family: Not Specified
>>>>
>>>> Handle 0x0002, DMI type 2, 8 bytes
>>>> Base Board Information
>>>>         Manufacturer: FUJITSU SIEMENS
>>>>         Product Name: ESPRIMO Mobile V5505
>>>>        =20
>>> Jan-Simon,
>>> Thanks for the dmidecode output.
>>>
>>> Did the console dmesg ask you to send it because
>>> of OSI(Linux)?
>>>
>>> Do you notice any functional difference when booting with
>>>
>>> "acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
>>> vs.
>>> "acpi_osi=3D!Linux"       (default for 2.6.23 and later)
>>>
>>> Also, please send me the output from acpidump.
>>>      =20
>> Didn't notice any difference.
>> acpidump here:
>>
>> http://bugzilla.kernel.org/show_bug.cgi?id=3D9939
>>
>>    =20
>>> thanks,
>>> -Len
>>>
>>>      =20
>> Thanks!
>>    =20
>
> thanks for the acpidump in http://bugzilla.kernel.org/show_bug.cgi?id=
=3D9939
>
> This BIOS makes heavy use of TRAP's into SMM, Windows version-specifi=
c hooks,
> and WMI -- all bad news for Linux.
>
> But OSI(Linux) itself is a NOP on this box, since LINX is set and nev=
er referenced, per below.
>
>  =20
LINX is not a variable, but a field in SystemMemory  region. Thus it=20
could be accessed from SMM or EC firmware without us knowing that.
IMHO it is too brave to call it NOP.

Regards,
Alex.
> -Len
>
>        Method (_INI, 0, NotSerialized)
>         {
>             If (DTSE)
>             {
>                 TRAP (0x47)
>             }
>
>             Store (0x07D0, OSYS)
>             If (CondRefOf (_OSI, Local0))
>             {
>                 If (_OSI ("Linux"))
>                 {
>                     Store (0x01, LINX)
>                 }
>
>                 If (_OSI ("Windows 2001"))
>                 {
>                     Store (0x07D1, OSYS)
>                 }
>
>                 If (_OSI ("Windows 2001 SP1"))
>                 {
>                     Store (0x07D1, OSYS)
>                 }
>
>                 If (_OSI ("Windows 2001 SP2"))
>                 {
>                     Store (0x07D2, OSYS)
>                 }
>
>                 If (_OSI ("Windows 2006"))
>                 {
>                     Store (0x07D6, OSYS)
>                 }
>             }
>
>             If (LAnd (MPEN, LEqual (OSYS, 0x07D1)))
>             {
>                 TRAP (0x3D)
>             }
>
>             TRAP (0x2B)
>             TRAP (0x32)
>         }
>     }
> ...
>     OperationRegion (GNVS, SystemMemory, 0x7F6DEDBC, 0x0100)
>     Field (GNVS, AnyAcc, Lock, Preserve)
>     {
>         OSYS,   16,
>         SMIF,   8,
>         PRM0,   8,
>         PRM1,   8,
>         SCIF,   8,
>         PRM2,   8,
>         PRM3,   8,
>         LCKF,   8,
>         PRM4,   8,
>         PRM5,   8,
>         P80D,   32,
>         LIDS,   8,
>         PWRS,   8,
>         DBGS,   8,
>         LINX,   8,
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  =20

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
