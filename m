From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: Bugs in my DSDT (aopen 1556/1557 ou keynux impact)
Date: Mon, 28 May 2007 16:25:57 +0400
Message-ID: <465ACA55.1040303@gmail.com>
References: <4659BEF5.5020005@gmail.com> <f3e2sr$ivj$1@sea.gmane.org> <465AA567.4030308@gmail.com> <f3ea1i$bhb$1@sea.gmane.org> <f3ebtg$gq9$1@sea.gmane.org> <f3ed49$kga$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:40518 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbXE1M0C (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 28 May 2007 08:26:02 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1617407ugf
        for <linux-acpi@vger.kernel.org>; Mon, 28 May 2007 05:26:01 -0700 (PDT)
In-Reply-To: <f3ed49$kga$1@sea.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: giggz <giggzounet@gmail.com>
Cc: linux-acpi@vger.kernel.org

giggz ?????:
> giggz a =E9crit :
>> giggz a =E9crit :
>>> [...] (little cut)
>>>
>>>>> But I can't find the solution for the other error problem :
>>>>> I have that :
>>>>>                   Method (RAMW, 2, NotSerialized)
>>>>>                     {
>>>>>                         Acquire (MUTX, 0xFFFF)
>>>>>                         If (LGreater (Arg0, 0x7F))
>>>>>                         {
>>>>>                             Store (Arg2, DAT3)
>>>>>                         }
>>>>>
>>>>>                         Store (Arg0, DAT2)
>>>>>                         Store (Arg1, DAT1)
>>>>>                         Store (0xBB, CMCD)
>>>>>                         Store (0x64, Local1)
>>>>>                         While (Local1)
>>>>>                         {
>>>>>                             Decrement (Local1)
>>>>>                             Sleep (0x05)
>>>>>                             Store (CMCD, Local0)
>>>>>                             If (LEqual (Local0, Zero))
>>>>>                             {
>>>>>                                 Store (Zero, Local1)
>>>>>                             }
>>>>>                         }
>>>>>
>>>>>                         Release (MUTX)
>>>>>                     }
>>>>>
>>>>> And Arg2 doesn't exist...but what can I do ?
>>>> Find callers of this method, if they pass more than 2 args to it, =
then
>>>> simply change Method(RAMW, 2 -> Method(RAMW, 3.
>>>> If noone sends 3rd argument, then the only choice is to remove the=
 whole
>>>>  "If () {}".
>>> I'm total newbie in this domain...So How can I find "callers" .
>>>
>>> I have done that :
>>> search for "RAMW" in all the dsdt.dsl file. I don't find any other,=
 just
>>> the definition of the Method. Do I just remove the method ?
>>>
>> I test to compile with Method (RAMW, 3, NotSerialized). And I have n=
o
>> more error.
>> What Do I have to do ? Remove this Method or put 3 arguments ?
>>
>=20
> Ok I looked through the dsdt.dsl file. Juste above this method I foun=
d
> this other method :
>                     Method (RAMR, 2, NotSerialized)
>                     {
>                         Acquire (MUTX, 0xFFFF)
>                         If (LGreater (Arg0, 0x7F))
>                         {
>                             Store (Arg1, DAT3)
>                         }
>=20
>                         Store (Arg0, DAT2)
>                         Store (0xBA, CMCD)
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
>                         Store (DAT1, Local0)
>                         Release (MUTX)
>                         Return (Local0)
>                     }
>=20
> Perhaps the error is really a bug in the dsdt : Arg2 must be Arg1!
>=20
> How can I know ?
Ask AOpen technical support :)

Regards,
Alex.
>=20
>>> Thx
>>> Guillaume
>>>

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
