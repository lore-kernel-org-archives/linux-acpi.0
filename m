From: Miles Lane <miles.lane@gmail.com>
Subject: Re: 2.6.33-rc5-git2 -- ACPI Error: Attempt to CreateField of length
	zero (20091214/dsopcode-529)
Date: Wed, 27 Jan 2010 07:43:27 -0500
Message-ID: <a44ae5cd1001270443x31c1e540v9c86263e7ffeeb6c@mail.gmail.com>
References: <4B5FE33A.7000201@gmail.com>
	 <efbf743b1001270005v301dbe34ia65b63973e761e8@mail.gmail.com>
	 <1264579476.7187.56.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f188.google.com ([209.85.210.188]:62285 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369Ab0A0Mn2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Jan 2010 07:43:28 -0500
In-Reply-To: <1264579476.7187.56.camel@minggr.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "rui.zhang" <rui.zhang@intel.com>

On Wed, Jan 27, 2010 at 3:04 AM, Lin Ming <ming.m.lin@intel.com> wrote:
>
>> From: Miles Lane <miles.lane@gmail.com>
>> Date: Wed, Jan 27, 2010 at 2:54 PM
>> Subject: 2.6.33-rc5-git2 -- ACPI Error: Attempt to CreateField of
>> length zero (20091214/dsopcode-529)
>> To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML
>> <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>
>>
>>
>> I am not sure how much of this is due to a single cause. =A0Please l=
et
>> me know if you'd like me to send separate reports.
>>
>> ACPI: EC: GPE =3D 0x1b, I/O: command/status =3D 0x66, data =3D 0x62
>> ACPI Warning: Incorrect checksum in table [ATKG] - FA, should be 05
>> (20091214/tbutils-314)
>>
>> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
>> ACPI Error: Attempt to CreateField of length zero (20091214/dsopcode=
-529)
>> ACPI Error (psparse-0537): Method parse/execution failed
>> [\_SB_.PCI0.IDE0.RATA] (Node ffff88013f81a9e0), AE_AML_OPERAND_VALUE
>> ACPI Error (psparse-0537): Method parse/execution failed
>> [\_SB_.PCI0.IDE0.PRT1._GTF] (Node ffff88013f81ab20),
>> AE_AML_OPERAND_VALUE
>> ata2.00: _GTF evaluation failed (AE 0x3004)
>> ata2.00: ATAPI: MATSHITADVD-RAM UJ892AS, 1.00, max UDMA/100, ATAPI A=
N
>> ACPI Error: Attempt to CreateField of length zero (20091214/dsopcode=
-529)
>> ACPI Error (psparse-0537): Method parse/execution failed
>> [\_SB_.PCI0.IDE0.RATA] (Node ffff88013f81a9e0), AE_AML_OPERAND_VALUE
>> ACPI Error (psparse-0537): Method parse/execution failed
>> [\_SB_.PCI0.IDE0.PRT1._GTF] (Node ffff88013f81ab20),
>> AE_AML_OPERAND_VALUE
>> ata2.00: _GTF evaluation failed (AE 0x3004)
>> ata2.00: configured for UDMA/100
>> scsi 1:0:0:0: CD-ROM =A0 =A0 =A0 =A0 =A0 =A0MATSHITA DVD-RAM UJ892AS=
 =A01.00 PQ: 0 ANSI: 5
>>
>
> >From the DSDT,
>
> =A02522 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Method (RATA, 1, NotSerialize=
d)
> =A02523 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> =A02524 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CreateByteField (Arg0=
, Zero, CMDN)
> =A02525 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Multiply (CMDN, 0x38,=
 Local0)
> =A02526 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CreateField (Arg0, 0x=
08, Local0, RETB)
> =A02527 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Store (RETB, Debug)
> =A02528 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Return (RETB)
> =A02529 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> =A02546 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Name (ATP1, Buffer (0x32) {})
> =A02547 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Device (PRT1)
> =A02548 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> =A02549 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Name (_ADR, 0x0001FFF=
=46)
> =A02550 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Method (_SDD, 1, NotS=
erialized)
> =A02551 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> =A02552 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Store (AGTF (=
Zero, Arg0), ATP1)
> =A02553 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A02554
> =A02555 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Method (_GTF, 0, NotS=
erialized)
> =A02556 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 {
> =A02557 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Return (RATA =
(ATP1))
> =A02558 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A02559 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> It seems that ATP1 is not set correctly in PRT1._SDD.
> Then ATP1 is passed into RATA and CMDN is created with value zero.
> That causes the error message.

This is the current BIOS for the ASUS UL50VT.  Is this something that g=
ets
fixed by a BIOS update?  Do you have a way to pass this information on =
to
ASUS?  Is there something the kernel code can do to work around the
problem, or is that already happening?

Thanks,
          Miles
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
