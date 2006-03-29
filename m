From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: no /proc/acpi, trying to dump dsdt to a file
Date: Wed, 29 Mar 2006 13:05:37 -0800
Message-ID: <971FCB6690CD0E4898387DBF7552B90E04D4B597@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:46147 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750970AbWC2VFj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2006 16:05:39 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: glen martin <lists@locutory.org>
Cc: linux-acpi@vger.kernel.org

iASL will automatically convert to using Ones and Zeros where appropria=
te.

Here's what I get from the disassembled table from windows:

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20060328 [Mar 29 2006]
Copyright (C) 2000 - 2006 Intel Corporation
Supports ACPI Specification Revision 3.0a

dsdt.dsl  2470:                         Name (PS=A2=BEC, 0x0A)
Error    1094 -                                 ^ Invalid character (0x=
03), expecting ASL keyword or name

dsdt.dsl  2470:                         Name (PS=A2=BEC, 0x0A)
Error    1094 -     parse error, expecting `','' ^

dsdt.dsl  5205:             If (LNot (And (\_SB.PCI0.HFZF, Local2)))
Error    1062 -                   Object does not exist ^  (\_SB.PCI0.H=
=46ZF)

dsdt.dsl  5209:                     Or (\_SB.PCI0.HFZF, Local2, \_SB.PC=
I0.HFZF)
Error    1062 -                Object does not exist ^  (\_SB.PCI0.HFZF=
)

dsdt.dsl  5209:                     Or (\_SB.PCI0.HFZF, Local2, \_SB.PC=
I0.HFZF)
Error    1062 -                                        Object does not =
exist ^  (\_SB.PCI0.HFZF)

dsdt.dsl  5350:     Method (WFZF, 1, NotSerialized)
Warning  2086 -                ^ Not all control paths return a value (=
WFZF)

dsdt.dsl  5363:             Return (While (Local1)
Error    1094 -             parse error ^

dsdt.dsl  5377:             })
Error    1094 -  parse error ^

ASL Input:  dsdt.dsl - 6139 lines, 193056 bytes, 1948 keywords
Compilation complete. 7 Errors, 1 Warnings, 0 Remarks, 511 Optimization=
s


The first two are the bad name. The compiler will never allow this. The=
 next three look like an external() is required (disassembler doesn't o=
utput these, yet.)

Last 2 errors are interesting, looks like a problem in either the disas=
sembler or compiler, here's the code:

            Return (While (Local1)
            {
                Stall (0x0F)
                Decrement (Local1)
                If (LEqual (Local1, 0x00))
                {
                    Return (Store (CREG, Local2))
                }

                And (Local2, 0x80, Local2)
                If (LEqual (Local2, 0x00))
                {
                    Return (Decrement (Local1))
                }
            })

Looks very odd, I'll keep looking at it.

BTW, here is the new message from the disassembler:

ACPI Warning (utmisc-0732): Found bad character(s) in name, repaired: [=
PS*C] [20060328]

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of glen martin
> Sent: Wednesday, March 29, 2006 12:28 PM
> To: Moore, Robert
> Cc: linux-acpi@vger.kernel.org
> Subject: Re: no /proc/acpi, trying to dump dsdt to a file
>=20
> Doh! So it does. I created the analogous fix, commenting out nssearch=
=2Ec
> line 406, and now have a shiny disassembled DSDT to play with. Hooray=
!
>=20
> I  cleaned the nssearch error messages from the top of the disassembl=
ed
> output, then recompiled with iasl, which got a small number of errors=
 to
> track down.
>=20
> But remember, this whole story started when iasl was puking on the ds=
dt
> file I downloaded from sourceforge. So I diff'd my disassembly agains=
t
> the file I found in the repository and discovered a large number of
> changes that replace numeric constants "0x00, 0x01" with symbols (ZER=
O,
> ONE).  Did iasl used to handle symbolic names for constants? I can't
> imagine someone going through to replace all these by hand ... :b
>=20
>=20
>=20
> Moore, Robert wrote:
>=20
> >Compiler uses the same error checking code.
> >Bob
> >
> >
> >
> >
> >>test A8N # iasl -d dsdt1.dat
> >>
> >>Intel ACPI Component Architecture
> >>AML Disassembler version 20060127 [Mar 29 2006]
> >>Copyright (C) 2000 - 2006 Intel Corporation
> >>Supports ACPI Specification Revision 3.0a
> >>
> >>Loading Acpi table from file dsdt1.dat
> >>Acpi table [DSDT] successfully installed and loaded
> >>Pass 1 parse of [DSDT]
> >>
> >>test A8N # more dsdt1.dsl
> >>ACPI Error (nssearch-0405): Bad character in ACPI Name: 43035350
> >>[20060127]
> >>ACPI Error (dswload-0393): [0x43035350] (NON-ASCII) Namespace looku=
p
> >>failure, AE_BAD_CHARACTER
> >>ACPI Exception (psloop-0347): AE_BAD_CHARACTER, During name
> >>lookup/catalog [20060127]
> >>Could not parse ACPI tables, AE_BAD_CHARACTER
> >><>
> >>
> >>
> >>
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
