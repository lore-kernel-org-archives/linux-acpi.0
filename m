From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Warning: pnp 00:0b: can't evaluate _CRS: 12311
Date: Wed, 25 Apr 2012 14:50:40 -0600
Message-ID: <CAErSpo5E3E=A+EEAZjmkYc8x3B==9ZtYufNaG4t8xQegtOfxfA@mail.gmail.com>
References: <CA+icZUWVwUr19xL0Dn5mHnZjQaVjj6VYD3BMMktEWO0vgoZEXw@mail.gmail.com>
 <CA+icZUUGFaz0c-tHa9EGUxZaxPj_M=zrE+kE0dv5UMoA6GyN3w@mail.gmail.com>
 <CAErSpo5vZSf_EZr6-XnAA8N2Luv6rA92YtZsidWZCZ8rarkPUQ@mail.gmail.com>
 <CA+icZUU+asnLWAevwqKBgnvrmKNitL8-0+8ijDii4pt9VsjspA@mail.gmail.com> <94F2FBAB4432B54E8AACC7DFDE6C92E346A77806@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:58489 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757159Ab2DYUvE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Apr 2012 16:51:04 -0400
Received: by lbbgf7 with SMTP id gf7so445417lbb.19
        for <linux-acpi@vger.kernel.org>; Wed, 25 Apr 2012 13:51:00 -0700 (PDT)
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E346A77806@ORSMSX101.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>

On Wed, Apr 25, 2012 at 2:36 PM, Moore, Robert <robert.moore@intel.com>=
 wrote:
>> >>> [ =A0 =A00.294037] pnp 00:0b: can't evaluate _CRS: 12311
>
> It sure would be nice if this error message would include the full pa=
thname to the _CRS method. As it stands, it is rather difficult to dete=
rmine just what caused this.

Agreed.

I extracted and disassembled the acpidump.  There were five
occurrences of PNP0C02:

DSDT.dsl  \_SB.PCI0.LPCB.LDRC (has a constant _CRS)
DSDT.dsl  \_SB.PCI0.LPCB.CWDT (has _HID INT3F0D and _CID PNP0C02, so
doesn't match message)
DSDT.dsl  \_SB.PCI0.PDRC
SSDT1.dsl  \_SB.PTID (has no _CRS and has _HID INT340E and _CID
PNP0C02, so doesn't match message)
SSDT4.dsl  \_SB.IFFS (has no _CRS)

So I think PDRC must be the one causing the trouble.  Its _CRS runs
some AML, but I'm not AML-savvy enough to figure it out:

    Scope (_SB.PCI0)
    {
        Device (PDRC)
        {
            Name (_HID, EisaId ("PNP0C02"))
            Name (_UID, One)
            Name (BUF0, ResourceTemplate ()
            {
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00004000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00008000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00001000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00001000,         // Address Length
                    )
                Memory32Fixed (ReadWrite,
                    0x00000000,         // Address Base
                    0x00000000,         // Address Length
                    )
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
                    )
            })
            Method (_CRS, 0, Serialized)
            {
                CreateDWordField (BUF0, 0x04, RBR0)
                ShiftLeft (^^LPCB.RCBA, 0x0E, RBR0)
                CreateDWordField (BUF0, 0x7C, TBR0)
                Store (TBAB, TBR0)
                CreateDWordField (BUF0, 0x80, TBLN)
                If (LEqual (TBAB, Zero))
                {
                    Store (Zero, TBLN)
                }

                CreateDWordField (BUF0, 0x10, MBR0)
                ShiftLeft (MHBR, 0x0F, MBR0)
                CreateDWordField (BUF0, 0x1C, DBR0)
                ShiftLeft (DIBR, 0x0C, DBR0)
                CreateDWordField (BUF0, 0x28, EBR0)
                ShiftLeft (EPBR, 0x0C, EBR0)
                CreateDWordField (BUF0, 0x34, XBR0)
                ShiftLeft (PXBR, 0x1A, XBR0)
                CreateDWordField (BUF0, 0x38, XSZ0)
                ShiftRight (0x10000000, PXSZ, XSZ0)
                Return (BUF0)
            }
        }
    }
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
