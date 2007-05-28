From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Bugs in my DSDT (aopen 1556/1557 ou keynux impact)
Date: Mon, 28 May 2007 13:48:23 +0400
Message-ID: <465AA567.4030308@gmail.com>
References: <4659BEF5.5020005@gmail.com> <f3e2sr$ivj$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:43669 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757794AbXE1Js1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 May 2007 05:48:27 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1589012ugf
        for <linux-acpi@vger.kernel.org>; Mon, 28 May 2007 02:48:26 -0700 (PDT)
In-Reply-To: <f3e2sr$ivj$1@sea.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: giggz <giggzounet@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hi,

giggz ?????:
> giggz a =E9crit :
>> Hi,
>>
>> I have done that :
>>
>> cat /proc/acpi/dsdt > dsdt.dat
>> iasl -d dsdt.dat
>> iasl -tc dsdt.dsl
>>
>> The output :
>>
>> Intel ACPI Component Architecture
>> ASL Optimizing Compiler version 20061109 [May 18 2007]
>> Copyright (C) 2000 - 2006 Intel Corporation
>> Supports ACPI Specification Revision 3.0a
>>
>> dsdt.dsl   207:     Method (_WAK, 1, NotSerialized)
>> Warning  1079 -                ^ Reserved method must return a value=
 (_WAK)
>> dsdt.dsl  2714:                             Store (Arg2, DAT3)
>> Error    4005 -    Method argument is not initialized ^  (Arg2)
>>
>> dsdt.dsl  2714:                             Store (Arg2, DAT3)
>> Remark   5065 -   Not a parameter, used as local only ^  (Arg2)
=46or this too need to look at source of the method(s).
>>
>> dsdt.dsl  3121:                     Release (MTIO)
>> Warning  1098 -        Statement is unreachable ^
Same here.
>>
>> ASL Input:  dsdt.dsl - 4852 lines, 179994 bytes, 2068 keywords
>> Compilation complete. 2 Errors, 2 Warnings, 1 Remarks, 493 Optimizat=
ions
>>
>> Do anyone can and want to help me, please ?
>> I can post the dsdt.dsl too but it's quite long...
>>
>> Thx
>> Guillaume
>=20
> Hi,
>=20
> I found solutions of 3 compilation problems on the net :
> For the error :
> dsdt.dsl   207:     Method (_WAK, 1, NotSerialized)
> Warning  1079 -                ^ Reserved method must return a value =
(_WAK)
>=20
> I had that :
>    Method (_WAK, 1, NotSerialized)
>     {
>         Store (Arg0, P80H)
>         Store (0x29, SMIF)
>         Store (0x00, TRP0)
>         If (LEqual (Arg0, 0x03))
>         {
>             Store (0xA1, \_SB.PCI0.LPCB.EC0.P54S)
>             Store (0x12, SMIF)
>             Store (0x00, TRP0)
>             If (LEqual (PAR1, 0x00))
>             {
>                 Notify (\_SB.SLPB, 0x02)
>             }
>=20
>             Store (0x66, P80H)
>         }
>=20
>         If (LEqual (Arg0, 0x04))
>         {
>             If (CondRefOf (_OSI, Local0))
>             {
>                 Store (0x07D1, OSYS)
>             }
>             Else
>             {
>                 If (LEqual (SizeOf (_OS), 0x14))
>                 {
>                     Store (0x07D0, OSYS)
>                 }
>                 Else
>                 {
>                     If (LEqual (SizeOf (_OS), 0x27))
>                     {
>                         Store (0x07CF, OSYS)
>                     }
>                     Else
>                     {
>                         Store (0x07CE, OSYS)
>                     }
>                 }
>             }
>         }
>=20
>     }
>=20
> I put at the end :
> 	Return(Package(0x02){0x00, 0x00}) =09
> The warning diseapears but I don't know if it's the good solution...I=
f
> anyone can tell me that's true or false...

This one doesn't matter as linux does not look at the result anyway.

>=20
>=20
>=20
> For the error :
> dsdt.dsl  2600:                     Field (RAM, AnyAcc, Lock, Preserv=
e)
> Error    4074 -                              ^ Host Operation Region
> requires ByteAcc access
>=20
> I changed AnyAcc with ByteAcc.
Right.
>=20
>=20
> For the error :
> dsdt.dsl  3121:                     Release (MTIO)
> Warning  1098 -        Statement is unreachable ^
>=20
> I had :
>                Method (READ, 1, Serialized)
>                 {
>                     Acquire (MTIO, 0xFFFF)
>                     Store (Arg0, INDX)
>                     Store (DATA, Local0)
>                     Return (Local0)
>                     Release (MTIO)
> 		}
>=20
> And now I have that :
>                Method (READ, 1, Serialized)
>                 {
>                     Acquire (MTIO, 0xFFFF)
>                     Store (Arg0, INDX)
>                     Store (DATA, Local0)
>                     Release (MTIO)
>                     Return (Local0)
>                 }
>=20
Right.
>=20
> But I can't find the solution for the other error problem :
> I have that :
>                   Method (RAMW, 2, NotSerialized)
>                     {
>                         Acquire (MUTX, 0xFFFF)
>                         If (LGreater (Arg0, 0x7F))
>                         {
>                             Store (Arg2, DAT3)
>                         }
>=20
>                         Store (Arg0, DAT2)
>                         Store (Arg1, DAT1)
>                         Store (0xBB, CMCD)
>                         Store (0x64, Local1)
>                         While (Local1)
>                         {
>                             Decrement (Local1)
>                             Sleep (0x05)
>                             Store (CMCD, Local0)
>                             If (LEqual (Local0, Zero))
>                             {
>                                 Store (Zero, Local1)
>                             }
>                         }
>=20
>                         Release (MUTX)
>                     }
>=20
> And Arg2 doesn't exist...but what can I do ?
=46ind callers of this method, if they pass more than 2 args to it, the=
n
simply change Method(RAMW, 2 -> Method(RAMW, 3.
If noone sends 3rd argument, then the only choice is to remove the whol=
e
 "If () {}".
>=20
> Thx
> Have a nice day
> Guillaume
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
