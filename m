From: giggz <giggzounet@gmail.com>
Subject: Re: Bugs in my DSDT (aopen 1556/1557 ou keynux impact)
Date: Mon, 28 May 2007 13:05:49 +0200
Message-ID: <f3ed49$kga$1@sea.gmane.org>
References: <4659BEF5.5020005@gmail.com> <f3e2sr$ivj$1@sea.gmane.org> <465AA567.4030308@gmail.com> <f3ea1i$bhb$1@sea.gmane.org> <f3ebtg$gq9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:55331 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbXE1LHQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 May 2007 07:07:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hsd48-0005ad-OL
	for linux-acpi@vger.kernel.org; Mon, 28 May 2007 13:07:08 +0200
Received: from cam44-1-82-67-121-239.fbx.proxad.net ([82.67.121.239])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 28 May 2007 13:07:08 +0200
Received: from giggzounet by cam44-1-82-67-121-239.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 28 May 2007 13:07:08 +0200
In-Reply-To: <f3ebtg$gq9$1@sea.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

giggz a =E9crit :
> giggz a =E9crit :
>> [...] (little cut)
>>
>>>> But I can't find the solution for the other error problem :
>>>> I have that :
>>>>                   Method (RAMW, 2, NotSerialized)
>>>>                     {
>>>>                         Acquire (MUTX, 0xFFFF)
>>>>                         If (LGreater (Arg0, 0x7F))
>>>>                         {
>>>>                             Store (Arg2, DAT3)
>>>>                         }
>>>>
>>>>                         Store (Arg0, DAT2)
>>>>                         Store (Arg1, DAT1)
>>>>                         Store (0xBB, CMCD)
>>>>                         Store (0x64, Local1)
>>>>                         While (Local1)
>>>>                         {
>>>>                             Decrement (Local1)
>>>>                             Sleep (0x05)
>>>>                             Store (CMCD, Local0)
>>>>                             If (LEqual (Local0, Zero))
>>>>                             {
>>>>                                 Store (Zero, Local1)
>>>>                             }
>>>>                         }
>>>>
>>>>                         Release (MUTX)
>>>>                     }
>>>>
>>>> And Arg2 doesn't exist...but what can I do ?
>>> Find callers of this method, if they pass more than 2 args to it, t=
hen
>>> simply change Method(RAMW, 2 -> Method(RAMW, 3.
>>> If noone sends 3rd argument, then the only choice is to remove the =
whole
>>>  "If () {}".
>> I'm total newbie in this domain...So How can I find "callers" .
>>
>> I have done that :
>> search for "RAMW" in all the dsdt.dsl file. I don't find any other, =
just
>> the definition of the Method. Do I just remove the method ?
>>
>=20
> I test to compile with Method (RAMW, 3, NotSerialized). And I have no
> more error.
> What Do I have to do ? Remove this Method or put 3 arguments ?
>=20

Ok I looked through the dsdt.dsl file. Juste above this method I found
this other method :
                    Method (RAMR, 2, NotSerialized)
                    {
                        Acquire (MUTX, 0xFFFF)
                        If (LGreater (Arg0, 0x7F))
                        {
                            Store (Arg1, DAT3)
                        }

                        Store (Arg0, DAT2)
                        Store (0xBA, CMCD)
                        Store (0x64, Local1)
                        While (Local1)
                        {
                            Decrement (Local1)
                            Sleep (0x05)
                            Store (CMCD, Local0)
                            If (LEqual (Local0, Zero))
                            {
                                Store (Zero, Local1)
                            }
                        }

                        Store (DAT1, Local0)
                        Release (MUTX)
                        Return (Local0)
                    }

Perhaps the error is really a bug in the dsdt : Arg2 must be Arg1!

How can I know ?

>> Thx
>> Guillaume
>>
>>
>>> To unsubscribe from this list: send the line "unsubscribe linux-acp=
i" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
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
