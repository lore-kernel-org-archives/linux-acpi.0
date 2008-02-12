From: Len Brown <lenb@kernel.org>
Subject: Re: BIOS _OSI(Linux) query ignored - PowerEdge 1950
Date: Mon, 11 Feb 2008 23:46:59 -0500
Message-ID: <200802112346.59772.lenb@kernel.org>
References: <Pine.LNX.4.64.0802102149570.24091@bizon.gios.gov.pl> <200802102034.23680.lenb@kernel.org> <Pine.LNX.4.64.0802111826470.12656@bizon.gios.gov.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42795 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002AbYBLEr0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 11 Feb 2008 23:47:26 -0500
In-Reply-To: <Pine.LNX.4.64.0802111826470.12656@bizon.gios.gov.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Krzysztof Oledzki <olel@ans.pl>
Cc: linux-acpi@vger.kernel.org

On Monday 11 February 2008 12:27, Krzysztof Oledzki wrote:
> 
> On Sun, 10 Feb 2008, Len Brown wrote:
> 
> > On Sunday 10 February 2008 17:09, Krzysztof Oledzki wrote:
> >> Hello,
> >>
> >> ACPI: EC: Look up EC in DSDT
> >> ACPI: BIOS _OSI(Linux) query ignored
> >> ACPI: DMI System Vendor: Dell Inc.
> >> ACPI: DMI Product Name: PowerEdge 1950
> >> ACPI: DMI Product Version:
> >> ACPI: DMI Board Name: 0TT740
> >> ACPI: DMI BIOS Vendor: Dell Inc.
> >> ACPI: DMI BIOS Date: 10/27/2007
> >> ACPI: Please send DMI info above to linux-acpi@vger.kernel.org
> >

Thanks for the acpidiump output.
acpi_osi=Linux is a NOP on this box.

cheers,
-Len

It looks like Dell went out of their way to make Linux a recognized OS,
but the code that actually accesses TOOS makes Linux a synonym for Vista,
which we have w/o OSI(Linux).  The exception is the PCI root bridge HID/CID
exchange, where only Vista gets PCIe native.


        Name (TOOS, 0x00)
        Method (INIC, 0, NotSerialized)
        {
            If (CondRefOf (_OSI, Local0))
            {
                If (\_OSI ("Windows 2001"))
                {
                    Store (0x05, TOOS)
                }

                If (\_OSI ("Windows 2001.1"))
                {
                    Store (0x06, TOOS)
                }

                If (\_OSI ("Windows 2001.1 SP1"))
                {
                    Store (0x07, TOOS)
                }

                If (\_OSI ("Windows 2006"))
                {
                    Store (0x08, TOOS)
                }

                If (\_OSI ("Windows 2006.1"))
                {
                    Store (0x08, TOOS)
                }

                If (\_OSI ("Linux"))
                {
                    Store (0x01, TOOS)
# The windows compatible value of TOOS gets overwritten
# to 1 on OSI(Linux)

                }
            }
            Else
            {
                Store (\_OS, Local0)
                Store (SCMP (Local0, "Microsoft Windows NT"), Local1)
                If (Not (Local1))
                {
                    Store (0x04, TOOS)
                }
                Else
                {
                    Store (SCMP (Local0, "Microsoft Windows"), Local2)
                    If (Not (Local2))
                    {
                        Store (0x02, TOOS)
                    }
                    Else
                    {
                        Store (SCMP (Local0, "Microsoft WindowsME:Millennium Edition"), Local3)
                        If (Not (Local3))
                        {
                            Store (0x03, TOOS)
                        }
                    }
                }
            }
        }
....
            If (LGreaterEqual (\_SB.TOOS, 0x08))
            {
                Store (0x080AD041, \_SB.PCI0._HID)
                Store (0x030AD041, \_SB.PCI0._CID)
            }
            Else
            {
                Store (0x030AD041, \_SB.PCI0._HID)
                Store (0x080AD041, \_SB.PCI0._CID)
            }
