From: giggz <giggzounet@gmail.com>
Subject: Re: Bugs in my DSDT (aopen 1556/1557 ou keynux impact)
Date: Mon, 28 May 2007 10:11:12 +0200
Message-ID: <f3e2sr$ivj$1@sea.gmane.org>
References: <4659BEF5.5020005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:55387 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752418AbXE1IaF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 May 2007 04:30:05 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Hsac6-0002CW-4J
	for linux-acpi@vger.kernel.org; Mon, 28 May 2007 10:30:02 +0200
Received: from cam44-1-82-67-121-239.fbx.proxad.net ([82.67.121.239])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 28 May 2007 10:30:02 +0200
Received: from giggzounet by cam44-1-82-67-121-239.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 28 May 2007 10:30:02 +0200
In-Reply-To: <4659BEF5.5020005@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

giggz a =E9crit :
> Hi,
>=20
> I have done that :
>=20
> cat /proc/acpi/dsdt > dsdt.dat
> iasl -d dsdt.dat
> iasl -tc dsdt.dsl
>=20
> The output :
>=20
> Intel ACPI Component Architecture
> ASL Optimizing Compiler version 20061109 [May 18 2007]
> Copyright (C) 2000 - 2006 Intel Corporation
> Supports ACPI Specification Revision 3.0a
>=20
> dsdt.dsl   207:     Method (_WAK, 1, NotSerialized)
> Warning  1079 -                ^ Reserved method must return a value =
(_WAK)
>=20
> dsdt.dsl  2600:                     Field (RAM, AnyAcc, Lock, Preserv=
e)
> Error    4074 -                              ^ Host Operation Region
> requires ByteAcc access
>=20
> dsdt.dsl  2714:                             Store (Arg2, DAT3)
> Error    4005 -    Method argument is not initialized ^  (Arg2)
>=20
> dsdt.dsl  2714:                             Store (Arg2, DAT3)
> Remark   5065 -   Not a parameter, used as local only ^  (Arg2)
>=20
> dsdt.dsl  3121:                     Release (MTIO)
> Warning  1098 -        Statement is unreachable ^
>=20
> ASL Input:  dsdt.dsl - 4852 lines, 179994 bytes, 2068 keywords
> Compilation complete. 2 Errors, 2 Warnings, 1 Remarks, 493 Optimizati=
ons
>=20
> Do anyone can and want to help me, please ?
> I can post the dsdt.dsl too but it's quite long...
>=20
> Thx
> Guillaume

Hi,

I found solutions of 3 compilation problems on the net :
=46or the error :
dsdt.dsl   207:     Method (_WAK, 1, NotSerialized)
Warning  1079 -                ^ Reserved method must return a value (_=
WAK)

I had that :
   Method (_WAK, 1, NotSerialized)
    {
        Store (Arg0, P80H)
        Store (0x29, SMIF)
        Store (0x00, TRP0)
        If (LEqual (Arg0, 0x03))
        {
            Store (0xA1, \_SB.PCI0.LPCB.EC0.P54S)
            Store (0x12, SMIF)
            Store (0x00, TRP0)
            If (LEqual (PAR1, 0x00))
            {
                Notify (\_SB.SLPB, 0x02)
            }

            Store (0x66, P80H)
        }

        If (LEqual (Arg0, 0x04))
        {
            If (CondRefOf (_OSI, Local0))
            {
                Store (0x07D1, OSYS)
            }
            Else
            {
                If (LEqual (SizeOf (_OS), 0x14))
                {
                    Store (0x07D0, OSYS)
                }
                Else
                {
                    If (LEqual (SizeOf (_OS), 0x27))
                    {
                        Store (0x07CF, OSYS)
                    }
                    Else
                    {
                        Store (0x07CE, OSYS)
                    }
                }
            }
        }

    }

I put at the end :
	Return(Package(0x02){0x00, 0x00}) =09
The warning diseapears but I don't know if it's the good solution...If
anyone can tell me that's true or false...



=46or the error :
dsdt.dsl  2600:                     Field (RAM, AnyAcc, Lock, Preserve)
Error    4074 -                              ^ Host Operation Region
requires ByteAcc access

I changed AnyAcc with ByteAcc.


=46or the error :
dsdt.dsl  3121:                     Release (MTIO)
Warning  1098 -        Statement is unreachable ^

I had :
               Method (READ, 1, Serialized)
                {
                    Acquire (MTIO, 0xFFFF)
                    Store (Arg0, INDX)
                    Store (DATA, Local0)
                    Return (Local0)
                    Release (MTIO)
		}

And now I have that :
               Method (READ, 1, Serialized)
                {
                    Acquire (MTIO, 0xFFFF)
                    Store (Arg0, INDX)
                    Store (DATA, Local0)
                    Release (MTIO)
                    Return (Local0)
                }


But I can't find the solution for the other error problem :
I have that :
                  Method (RAMW, 2, NotSerialized)
                    {
                        Acquire (MUTX, 0xFFFF)
                        If (LGreater (Arg0, 0x7F))
                        {
                            Store (Arg2, DAT3)
                        }

                        Store (Arg0, DAT2)
                        Store (Arg1, DAT1)
                        Store (0xBB, CMCD)
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

                        Release (MUTX)
                    }

And Arg2 doesn't exist...but what can I do ?

Thx
Have a nice day
Guillaume

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
