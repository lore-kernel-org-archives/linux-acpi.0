From: "Brown, Len" <len.brown@intel.com>
Subject: debugging 600E
Date: Thu, 26 Jan 2006 13:16:27 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005D9812B@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr13.intel.com ([192.55.52.67]:47765 "EHLO
	fmsfmr001.fm.intel.com") by vger.kernel.org with ESMTP
	id S932390AbWAZSRL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jan 2006 13:17:11 -0500
Received: from fmsfmr100.fm.intel.com (fmsfmr100.fm.intel.com [10.253.24.20])
	by fmsfmr001.fm.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k0QIHBZ8003670
	for <linux-acpi@vger.kernel.org>; Thu, 26 Jan 2006 18:17:11 GMT
Received: from fmsmsxvs040.fm.intel.com (fmsmsxvs040.fm.intel.com [132.233.42.124])
	by fmsfmr100.fm.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k0QIHAdH003305
	for <linux-acpi@vger.kernel.org>; Thu, 26 Jan 2006 18:17:11 GMT
Received: from fmsmsx331.amr.corp.intel.com ([132.233.42.156])
 by fmsmsxvs040.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006012610171028313
 for <linux-acpi@vger.kernel.org>; Thu, 26 Jan 2006 10:17:10 -0800
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

Bob,
Is my use of the Debug AML object below valid?
I seem to get 0 for \_SB.PCI0.ISA0.PIRA no matter
how I try to read it.  As this is the PIIX4 PIRQA
Route Control Register, getting 0 is actually consistent
with the Linux failure.  So I guess the next question
is how to figure out how the DSDT is coming up with
an address for this register that doesn't work --
is there a way to print out the address of that object?

full acpidump and dmesg are here:
http://bugzilla.kernel.org/show_bug.cgi?id=5966

Oh, and VIPR() in _CRS is a method to check if the register
is enabled and valid, given a value of 0, it always
returns invalid.

notably, _SRS prints out
 
[ACPI Debug]  String: [0x03] "SRS"
[ACPI Debug]  Integer: 0x00000000
[ACPI Debug]  Integer: 0x00000009
[ACPI Debug]  Integer: 0x00000000

So we always read 0 -- our write has no effect.

thanks,
-Len

    Scope (_SB)
    {
        Device (LNKA)
        {
            Name (_HID, EisaId ("PNP0C0F"))
            Name (_UID, One)
            Method (_INI, 0, NotSerialized)
            {
Store("_INI", Debug)
                If (W98F)
                {
                    And (DerefOf (Index (_PRS, 0x02)), 0x7F, Index
(_PRS, 0x02))
                }
Else
{
Store("NOT W98F", Debug)
}
            }

            Method (_STA, 0, NotSerialized)
            {
Store("STA", Debug)
Store(\_SB.PCI0.ISA0.PIRA, Debug)
Store(VIPR(\_SB.PCI0.ISA0.PIRA), Debug)
                If (LNot (VPIR (\_SB.PCI0.ISA0.PIRA)))
                {
Store("Disabled", Debug)
                    Return (0x09)
                }
                Else
                {
Store("Enabled", Debug)
                    Return (0x0B)
                }
            }

            Name (_PRS, ResourceTemplate ()
            {
                IRQ (Level, ActiveLow, Shared)
                    {3,4,5,6,7,9,10,11,12,14,15}
            })
            Method (_DIS, 0, NotSerialized)
            {
Store("DIS", Debug)
Or(\_SB.PCI0.ISA0.PIRA, 0, Local0)
Store(Local0, Debug)
                Or (\_SB.PCI0.ISA0.PIRA, 0x80, \_SB.PCI0.ISA0.PIRA)
Or(\_SB.PCI0.ISA0.PIRA, 0, Local0)
Store(Local0, Debug)
            }

            Method (_CRS, 0, NotSerialized)
            {
                Name (BUFA, ResourceTemplate ()
                {
                    IRQ (Level, ActiveLow, Shared)
                        {}
                })
Store("CRS", Debug)
                CreateWordField (BUFA, One, IRA1)
                And (\_SB.PCI0.ISA0.PIRA, 0x8F, Local0)
Store(Local0, Debug)
                If (VPIR (Local0))
                {
                    Store (ShiftLeft (One, Local0), IRA1)
Store("VALID", Debug)
                }

                Return (BUFA)
            }

            Method (_SRS, 1, NotSerialized)
            {
Store("SRS", Debug)
Store(\_SB.PCI0.ISA0.PIRA, Local0)
Store(Local0, Debug)
                CreateWordField (Arg0, One, IRA2)
                FindSetRightBit (IRA2, Local0)
                And (\_SB.PCI0.ISA0.PIRA, 0x70, Local1)
                Or (Local1, Decrement (Local0), Local1)
                Store (Local1, \_SB.PCI0.ISA0.PIRA)
Store(Local1, Debug)
Or(\_SB.PCI0.ISA0.PIRA, 0, Local0)
Store(Local0, Debug)
            }
        }
