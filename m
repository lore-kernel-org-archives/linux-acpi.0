From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Warning: pnp 00:0b: can't evaluate _CRS: 12311
Date: Wed, 25 Apr 2012 21:39:14 +0000
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E346A77908@ORSMSX101.amr.corp.intel.com>
References: <CA+icZUWVwUr19xL0Dn5mHnZjQaVjj6VYD3BMMktEWO0vgoZEXw@mail.gmail.com>
 <CA+icZUUGFaz0c-tHa9EGUxZaxPj_M=zrE+kE0dv5UMoA6GyN3w@mail.gmail.com>
 <CAErSpo5vZSf_EZr6-XnAA8N2Luv6rA92YtZsidWZCZ8rarkPUQ@mail.gmail.com>
 <CA+icZUU+asnLWAevwqKBgnvrmKNitL8-0+8ijDii4pt9VsjspA@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E346A77806@ORSMSX101.amr.corp.intel.com>
 <CAErSpo5E3E=A+EEAZjmkYc8x3B==9ZtYufNaG4t8xQegtOfxfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:18092 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757623Ab2DYVjb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Apr 2012 17:39:31 -0400
In-Reply-To: <CAErSpo5E3E=A+EEAZjmkYc8x3B==9ZtYufNaG4t8xQegtOfxfA@mail.gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>

This disassembly might make more sense. From the looks of the ASL, seve=
ral of the address base and length fields are being updated dynamically=
=2E  I don't see anything that would corrupt a resource descriptor, how=
ever.


Are we certain that the ACPI Error and pnp messages are directly relate=
d to the PNP0C02 device ID?

[    0.293699] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (ac=
tive)
[    0.294032] ACPI Error: Invalid/unsupported resource descriptor: Typ=
e 0x00 (20120320/utresrc-650)
[    0.294037] pnp 00:0b: can't evaluate _CRS: 12311


Also, I was able to execute all of the _CRS methods in the DSDT here wi=
th no errors, except for the last one, under the MEM2 device. IGDS retu=
rned zero, so the method did not return a valid resource descriptor, ju=
st nothing:

Device: \_SB_.MEM2
Evaluating _CRS
ACPI Warning: For \_SB_.MEM2._CRS: Missing expected return value (20120=
420/nspredef-283)
ACPI Error: No object was returned from [\_SB_.MEM2._CRS] (Node 004B62A=
8), AE_NOT_EXIST (20120420/uteval-198)
AcpiWalkResources failed: AE_NOT_EXIST

            Device (^^MEM2)
            {
                Name (_HID, EisaId ("PNP0C01"))
                Name (_UID, 0x02)
                Name (CRS, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x20000000,         // Address Base
                        0x00200000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x40000000,         // Address Base
                        0x00200000,         // Address Length
                        )
                })
                Method (_CRS, 0, NotSerialized)
                {
                    If (IGDS)
                    {
                        Return (CRS)
                    }
                }



/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20120420-32 [Apr 20 2012]
 * Copyright (c) 2000 - 2012 Intel Corporation
 *=20
 * Disassembly of dsdt.dat, Wed Apr 25 11:49:16 2012
 */

            Name (BUF0, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00004000,         // Address Length
                    _Y10)
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00008000,         // Address Length
                    _Y12)
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00001000,         // Address Length
                    _Y13)
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00001000,         // Address Length
                    _Y14)
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00000000,         // Address Length
                    _Y15)
                Memory32Fixed (ReadWrite,
                    0xFED20000,         // Address Base
                    0x00020000,         // Address Length
                    )
                Memory32Fixed (ReadOnly,
                    0xFED90000,         // Address Base
                    0x00004000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0xFED45000,         // Address Base
                    0x0004B000,         // Address Length
                    )
                Memory32Fixed (ReadOnly,
                    0xFF000000,         // Address Base
                    0x01000000,         // Address Length
                    )
                Memory32Fixed (ReadOnly,
                    0xFEE00000,         // Address Base
                    0x00100000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00001000,         // Address Length
                    _Y11)
            })
            Method (_CRS, 0, Serialized)
            {
                CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y10._BAS, RBR0)
                ShiftLeft (^^LPCB.RCBA, 0x0E, RBR0)
                CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y11._BAS, TBR0)
                Store (TBAB, TBR0)
                CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y11._LEN, TBLN)
                If (LEqual (TBAB, Zero))
                {
                    Store (Zero, TBLN)
                }

                CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y12._BAS, MBR0)
                ShiftLeft (MHBR, 0x0F, MBR0)
                CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y13._BAS, DBR0)
                ShiftLeft (DIBR, 0x0C, DBR0)
                CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y14._BAS, EBR0)
                ShiftLeft (EPBR, 0x0C, EBR0)
                CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y15._BAS, XBR0)
                ShiftLeft (PXBR, 0x1A, XBR0)
                CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y15._LEN, XSZ0)
                ShiftRight (0x10000000, PXSZ, XSZ0)
                Return (BUF0)
            }
        }


> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Wednesday, April 25, 2012 1:51 PM
> To: Moore, Robert
> Cc: sedat.dilek@gmail.com; linux-acpi@vger.kernel.org; Len Brown;
> linux-kernel@vger.kernel.org; Lin, Ming M
> Subject: Re: Warning: pnp 00:0b: can't evaluate _CRS: 12311
>=20
> On Wed, Apr 25, 2012 at 2:36 PM, Moore, Robert <robert.moore@intel.co=
m>
> wrote:
> >> >>> [ =A0 =A00.294037] pnp 00:0b: can't evaluate _CRS: 12311
> >
> > It sure would be nice if this error message would include the full
> pathname to the _CRS method. As it stands, it is rather difficult to
> determine just what caused this.
>=20
> Agreed.
>=20
> I extracted and disassembled the acpidump.  There were five occurrenc=
es
> of PNP0C02:
>=20
> DSDT.dsl  \_SB.PCI0.LPCB.LDRC (has a constant _CRS) DSDT.dsl
> \_SB.PCI0.LPCB.CWDT (has _HID INT3F0D and _CID PNP0C02, so doesn't
> match message) DSDT.dsl  \_SB.PCI0.PDRC SSDT1.dsl  \_SB.PTID (has no
> _CRS and has _HID INT340E and _CID PNP0C02, so doesn't match message)
> SSDT4.dsl  \_SB.IFFS (has no _CRS)
>=20
> So I think PDRC must be the one causing the trouble.  Its _CRS runs
> some AML, but I'm not AML-savvy enough to figure it out:
>=20
>     Scope (_SB.PCI0)
>     {
>         Device (PDRC)
>         {
>             Name (_HID, EisaId ("PNP0C02"))
>             Name (_UID, One)
>             Name (BUF0, ResourceTemplate ()
>             {
>                 Memory32Fixed (ReadWrite,
>                     0x00000000,         // Address Base
>                     0x00004000,         // Address Length
>                     )
>                 Memory32Fixed (ReadWrite,
>                     0x00000000,         // Address Base
>                     0x00008000,         // Address Length
>                     )
>                 Memory32Fixed (ReadWrite,
>                     0x00000000,         // Address Base
>                     0x00001000,         // Address Length
>                     )
>                 Memory32Fixed (ReadWrite,
>                     0x00000000,         // Address Base
>                     0x00001000,         // Address Length
>                     )
>                 Memory32Fixed (ReadWrite,
>                     0x00000000,         // Address Base
>                     0x00000000,         // Address Length
>                     )
>                 Memory32Fixed (ReadWrite,
>                     0xFED20000,         // Address Base
>                     0x00020000,         // Address Length
>                     )
>                 Memory32Fixed (ReadOnly,
>                     0xFED90000,         // Address Base
>                     0x00004000,         // Address Length
>                     )
>                 Memory32Fixed (ReadWrite,
>                     0xFED45000,         // Address Base
>                     0x0004B000,         // Address Length
>                     )
>                 Memory32Fixed (ReadOnly,
>                     0xFF000000,         // Address Base
>                     0x01000000,         // Address Length
>                     )
>                 Memory32Fixed (ReadOnly,
>                     0xFEE00000,         // Address Base
>                     0x00100000,         // Address Length
>                     )
>                 Memory32Fixed (ReadWrite,
>                     0x00000000,         // Address Base
>                     0x00001000,         // Address Length
>                     )
>             })
>             Method (_CRS, 0, Serialized)
>             {
>                 CreateDWordField (BUF0, 0x04, RBR0)
>                 ShiftLeft (^^LPCB.RCBA, 0x0E, RBR0)
>                 CreateDWordField (BUF0, 0x7C, TBR0)
>                 Store (TBAB, TBR0)
>                 CreateDWordField (BUF0, 0x80, TBLN)
>                 If (LEqual (TBAB, Zero))
>                 {
>                     Store (Zero, TBLN)
>                 }
>=20
>                 CreateDWordField (BUF0, 0x10, MBR0)
>                 ShiftLeft (MHBR, 0x0F, MBR0)
>                 CreateDWordField (BUF0, 0x1C, DBR0)
>                 ShiftLeft (DIBR, 0x0C, DBR0)
>                 CreateDWordField (BUF0, 0x28, EBR0)
>                 ShiftLeft (EPBR, 0x0C, EBR0)
>                 CreateDWordField (BUF0, 0x34, XBR0)
>                 ShiftLeft (PXBR, 0x1A, XBR0)
>                 CreateDWordField (BUF0, 0x38, XSZ0)
>                 ShiftRight (0x10000000, PXSZ, XSZ0)
>                 Return (BUF0)
>             }
>         }
>     }
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
