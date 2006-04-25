From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Faulty DSDT
Date: Tue, 25 Apr 2006 13:29:54 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A42A7DFA@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:63596 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932153AbWDYUaD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Apr 2006 16:30:03 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?Q?Iv=E1n=22_Gracia?= <izanmail@yahoo.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org

This looks like a case where there are one or more SSDTs and the disass=
embler has a difficult time deciphering method calls from the DSDT to t=
he SSDT(s). This is a feature (along with the automatic generation of E=
xternal() statements) that is on the TBD list for the disassembler.

Parens help in these three cases that look like method invocations.

                        PDVN ()
                                SDVN ()
                SH1X (0x03)

And adding External statements helps even more:

External (PDVN, MethodObj)
External (SDVN, MethodObj)
External (SH1X, MethodObj)
External (HDDN, MethodObj)

There are a couple additional not-found issues, you can just use the -f=
 flag to force the compiler to generate code.

A full acpidump of the machine would help.
Bob



> -----Original Message-----
> From: Iv=E1n" Gracia [mailto:izanmail@yahoo.com]
> Sent: Tuesday, April 25, 2006 12:43 PM
> To: Moore, Robert
> Subject: RE: Faulty DSDT
>=20
> Hi Bob,
>=20
> I'm sending you the binary (dsdt.dar extracted with "cat /proc/acpi/d=
sdt >
> dsdt.dat"), and here is the output of "iasl -d dsdt.dat"
>=20
>=20
> Intel ACPI Component Architecture
> ASL Optimizing Compiler version 20060331 [Apr 25 2006]
> Copyright (C) 2000 - 2006 Intel Corporation
> Supports ACPI Specification Revision 3.0a
>=20
> dsdt.dsl  3736:                     }
> Error    1094 -                     ^ syntax error, unexpected '}',
> expecting '('
>=20
> dsdt.dsl  3748:                             }
> Error    1094 -                             ^ syntax error, unexpecte=
d
> '}', expecting '('
>=20
> dsdt.dsl  3867:                 0x03
> Error    1094 -                    ^ syntax error, unexpected
> PARSEOP_INTEGER, expecting '('
>=20
> dsdt.dsl  3914:         Notify (\_SB.PCI0.EXCB.EXCD, 0x01)
> Error    1094 -              ^ syntax error, unexpected PARSEOP_NOTIF=
Y,
> expecting '('
>=20
> dsdt.dsl  4234: [*** iASL: Read error on source code temp file ***]
> Error    1094 -^ syntax error, unexpected $end
>=20
> ASL Input:  dsdt.dsl - 4235 lines, 140026 bytes, 1745 keywords
> Compilation complete. 5 Errors, 0 Warnings, 0 Remarks, 0 Optimization=
s
>=20
>=20
> I got rid of the error in 3914 by removing ".EXCD", since I noticed t=
hat
> there was no \_SB.PCI0.EXCD, so I left that expression as
> "Notify (\_SB.PCI0.EXCB, 0x01)"
>=20
> Thank you very much!
>=20
> --- "Moore, Robert" <robert.moore@intel.com> wrote:
>=20
> > I would appreciate it if someone would send me both the binary DSDT=
 or
> > acpixtract output and the disassembled file.
> >
> > Thanks,
> > Bob
> >
> >
> > > -----Original Message-----
> > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > > owner@vger.kernel.org] On Behalf Of Brown, Len
> > > Sent: Monday, April 24, 2006 2:33 PM
> > > To: Iv=EF=BF=BDn" Gracia
> > > Cc: linux-acpi@vger.kernel.org
> > > Subject: RE: Faulty DSDT
> > >
> > > [adding linux-acpi@vger.kernel.org] to cc:
> > >
> > > >I have a Toshiba S3 laptop that comes with a falulty DSDT.
> > > >These are the
> > > >errors I get when trying to compile with iasl on both windows an=
d
> > linux
> > > >machines
> > >
> > > What issue motivates you to compile the DSDT in the first place?
> > >
> > > >Intel ACPI Component Architecture
> > > >ASL Optimizing Compiler version 20060317 [Mar 17 2006]
> > >
> > > probably good to get the very latest dis-assembler
> > > and compiler from here:
> > >
> > > http://www.intel.com/technology/iapc/acpi/downloads.htm
> > >
> > > 20060331 is the latest on the web site at the moment.
> > >
> > > >Copyright (C) 2000 - 2006 Intel Corporation
> > > >Supports ACPI Specification Revision 3.0a
> > > >
> > > >dsdt.dsl  3735:                     }
> > > >Error    1094 -                     ^ parse error, expecting `'(=
''
> > > >
> > > >dsdt.dsl  3747:                             }
> > > >Error    1094 -                             ^ parse error, expec=
ting
> > `'
> > > >
> > > >dsdt.dsl  3866:                 0x03
> > > >Error    1094 -                    ^ parse error, expecting `'('=
'
> > > >
> > > >dsdt.dsl  4233: [*** iASL: Read error on source code temp file *=
**]
> > > >Error    1094 -^ parse error
> > > >
> > > >ASL Input:  dsdt.dsl - 4234 lines, 139958 bytes, 1745 keywords
> > > >Compilation complete. 4 Errors, 0 Warnings, 0 Remarks, 0
> > Optimizations
> > > >
> > > >
> > > >*******
> > > >If (LEqual (Local0, 0x02))
> > > >{
> > > >   PDVN  <<line: 3735 here is a parse error
> > > >}
> > >
> > > looks like PDVN is missing the parameters.
> > > eg. PVDN(a, b, c)
> > > similar issues below.
> > >
> > > if the latest disassembler/compiler do not work, please open a bu=
g
> > > and attach the output from acpidump or the DSDT w/ no modificatio=
ns.
> > >
> > > thanks,
> > > -Len
> > >
> > > >Else
> > > >{
> > > >   If (LEqual (Local0, 0x08))
> > > >   {
> > > >      If (LAnd (LNot (LEqual (\_SB.MEM.VALF, 0x00)), LNot (LEqua=
l
> > > >(\_SB.MEM.HKRD, 0x00))))
> > > >      {
> > > >         Notify (\_SB.VALZ, 0x87)
> > > >      }
> > > >      Else
> > > >      {
> > > >          SDVN <<line: 3747 here is a parse error
> > > >      }
> > > >
> > > >*******
> > > >If (LEqual (SBTB, 0x01))
> > > >{
> > > >   SH1X
> > > >   0x03 <<line: 3866 Here is the parse error
> > > >}
> > > >*******
> > > >
> > > >
> > > >I was able to fix another error, but I have found no info about =
this
> > > >errors on forums or pages, and www.acpi.info is down (or at
> > > >least I can't
> > > >access) so I can't download the specs. Could you please give
> > > >me a hand, if
> > > >it's not too many trouble? Otherwise, please let me know were I =
can
> > get
> > > >some help. I've been fighting with these 4 errors for a couple o=
f
> > days,
> > > >and after comparing my dsdt with other dsdt's, I can't find any
> > > >workarounds for these errors, and I get an "ACPI- Can't load
> > > >DSDT" message
> > > >with dmesg.
> > > >
> > > >Sorry for the trouble, and thank you in advance for any help
> > > >you can give
> > > >on this matter.
> > > >
> > > >Kind regards,
> > > >Ivan Gracia
> > > >
> > > >
> > > >
> > > >__________________________________________________
> > > >Do You Yahoo!?
> > > >Tired of spam?  Yahoo! Mail has the best spam protection around
> > > >http://mail.yahoo.com
> > > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-a=
cpi"
> > in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> >
>=20
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
