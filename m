From: Len Brown <lenb@kernel.org>
Subject: Re: Dell OptiPlex 755 ACPI: DMI
Date: Wed, 13 Feb 2008 22:49:05 -0500
Message-ID: <200802132249.05631.lenb@kernel.org>
References: <47B17562.7010107@zertificon.com> <200802121446.15971.lenb@kernel.org> <TBoneMsgId%zertificon.com%47B2B702.1030305%zertificon.com%m.naumann@zertificon.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40257 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754632AbYBNDta (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Feb 2008 22:49:30 -0500
In-Reply-To: <TBoneMsgId%zertificon.com%47B2B702.1030305%zertificon.com%m.naumann@zertificon.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Moritz Naumann <securemail@zertificon.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday 13 February 2008 04:23, Moritz Naumann wrote:
> Len Brown schrieb:
> > Please send me the output from acpidump.
> 
> Please see the attached file.
> 
> Invocation was:
> # acpidump > acpidump_linux_`uname -r`.txt 2>&1
> 
> Note the "Wrong checksum for generic table!" message (which is why I 
> redirected stderr).

Linux appears to be a special case in this BIOS.
ISLI returns 1 for OSI(Linux), which causes GUSB to do nothing.
(otherwise GUSB appears to touch SMM).  GUSB is called at init time,
and also at wakup time.

Do you notice any difference in USB operation with acpi_osi=Linux?
How about after resume from suspend?

thanks,
-Len

       Method (ISLI, 0, NotSerialized)
        {
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Return (One)
### hmmm, special case for Linux, every other OS returns Zero
                }
                Else
                {
                    Return (Zero)
                }
            }
            Else
            {
                Return (Zero)
            }
        }

    Method (GUSB, 0, NotSerialized)
    {
        If (ISLI ())
# only invocation of ISLI
        {
            Return (Zero)
# OSI(Linux) does nothing
        }
        Else
        {
            Return (SMI2 (0xBA))
# everybody else invokes SMM
        }
    }
...
    Method (SMI2, 1, NotSerialized)
    {
        Acquire (SMIM, 0xFFFF)
        Store (Arg0, SMIC)
        Store (MGIC, Local0)
        Store (SMIC, Local1)
        Store (SMID, Local0)
        ShiftLeft (Local0, 0x08, Local0)
        Add (Local1, Local0, Local0)
        Release (SMIM)
        Return (Local0)
    }
....
    Method (_WAK, 1, NotSerialized)
    {
        If (LEqual (Arg0, 0x04))
        {
# wakeup from hibernate

            GUSB ()
        }
        Else
        {
            If (LEqual (Arg0, 0x03))
            {
# wakeup from suspend
                If (And (0x20, CMRD (0x49)))
                {
                    GUSB ()
                }
            }
        }
...
    Scope (_SB.PCI0)
    {
        Device (USB0)
        {
            Name (_ADR, 0x001D0000)
            Name (_UID, 0x05)
            Name (_PRW, Package (0x02)
            {
                0x03,
                0x03
            })
            OperationRegion (UPC1, PCI_Config, 0xC1, One)
            Field (UPC1, ByteAcc, NoLock, Preserve)
            {
                LEGK,   8
            }

            Method (_INI, 0, NotSerialized)
            {
                If (HACK ()) {}
                Else
                {
                    Store (LEGK, Local0)
                    And (Local0, 0x60, Local0)
                    Or (Local0, 0x20, Local0)
                    Store (Local0, LEGK)
                }

                GUSB ()
            }
