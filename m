From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Faulty DSDT
Date: Tue, 25 Apr 2006 09:36:12 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A42A7A7F@orsmsx415.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5504 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751596AbWDYQhM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Apr 2006 12:37:12 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>, =?iso-8859-1?Q?Iv=E1n=22_Gracia?= <izanmail@yahoo.com>
Cc: linux-acpi@vger.kernel.org

I would appreciate it if someone would send me both the binary DSDT or =
acpixtract output and the disassembled file.

Thanks,
Bob


> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Brown, Len
> Sent: Monday, April 24, 2006 2:33 PM
> To: Iv=E1n" Gracia
> Cc: linux-acpi@vger.kernel.org
> Subject: RE: Faulty DSDT
>=20
> [adding linux-acpi@vger.kernel.org] to cc:
>=20
> >I have a Toshiba S3 laptop that comes with a falulty DSDT.
> >These are the
> >errors I get when trying to compile with iasl on both windows and li=
nux
> >machines
>=20
> What issue motivates you to compile the DSDT in the first place?
>=20
> >Intel ACPI Component Architecture
> >ASL Optimizing Compiler version 20060317 [Mar 17 2006]
>=20
> probably good to get the very latest dis-assembler
> and compiler from here:
>=20
> http://www.intel.com/technology/iapc/acpi/downloads.htm
>=20
> 20060331 is the latest on the web site at the moment.
>=20
> >Copyright (C) 2000 - 2006 Intel Corporation
> >Supports ACPI Specification Revision 3.0a
> >
> >dsdt.dsl  3735:                     }
> >Error    1094 -                     ^ parse error, expecting `'(''
> >
> >dsdt.dsl  3747:                             }
> >Error    1094 -                             ^ parse error, expecting=
 `'
> >
> >dsdt.dsl  3866:                 0x03
> >Error    1094 -                    ^ parse error, expecting `'(''
> >
> >dsdt.dsl  4233: [*** iASL: Read error on source code temp file ***]
> >Error    1094 -^ parse error
> >
> >ASL Input:  dsdt.dsl - 4234 lines, 139958 bytes, 1745 keywords
> >Compilation complete. 4 Errors, 0 Warnings, 0 Remarks, 0 Optimizatio=
ns
> >
> >
> >*******
> >If (LEqual (Local0, 0x02))
> >{
> >   PDVN  <<line: 3735 here is a parse error
> >}
>=20
> looks like PDVN is missing the parameters.
> eg. PVDN(a, b, c)
> similar issues below.
>=20
> if the latest disassembler/compiler do not work, please open a bug
> and attach the output from acpidump or the DSDT w/ no modifications.
>=20
> thanks,
> -Len
>=20
> >Else
> >{
> >   If (LEqual (Local0, 0x08))
> >   {
> >      If (LAnd (LNot (LEqual (\_SB.MEM.VALF, 0x00)), LNot (LEqual
> >(\_SB.MEM.HKRD, 0x00))))
> >      {
> >         Notify (\_SB.VALZ, 0x87)
> >      }
> >      Else
> >      {
> >          SDVN <<line: 3747 here is a parse error
> >      }
> >
> >*******
> >If (LEqual (SBTB, 0x01))
> >{
> >   SH1X
> >   0x03 <<line: 3866 Here is the parse error
> >}
> >*******
> >
> >
> >I was able to fix another error, but I have found no info about this
> >errors on forums or pages, and www.acpi.info is down (or at
> >least I can't
> >access) so I can't download the specs. Could you please give
> >me a hand, if
> >it's not too many trouble? Otherwise, please let me know were I can =
get
> >some help. I've been fighting with these 4 errors for a couple of da=
ys,
> >and after comparing my dsdt with other dsdt's, I can't find any
> >workarounds for these errors, and I get an "ACPI- Can't load
> >DSDT" message
> >with dmesg.
> >
> >Sorry for the trouble, and thank you in advance for any help
> >you can give
> >on this matter.
> >
> >Kind regards,
> >Ivan Gracia
> >
> >
> >
> >__________________________________________________
> >Do You Yahoo!?
> >Tired of spam?  Yahoo! Mail has the best spam protection around
> >http://mail.yahoo.com
> >
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
