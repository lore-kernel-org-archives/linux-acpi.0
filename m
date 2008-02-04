From: Len Brown <lenb@kernel.org>
Subject: Re: acer aspire 5315, Ubuntu 2.6.22-14-generic, kernel says send dmidecode, acpi not working correctly
Date: Mon, 4 Feb 2008 00:54:49 -0500
Message-ID: <200802040054.49916.lenb@kernel.org>
References: <de8605510801271842pc2a690dnd603c6b9faad88ec@mail.gmail.com> <200802031731.43626.lenb@kernel.org> <de8605510802031823h2e928a0cr29ca31eaf5768406@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42118 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214AbYBDFzE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Feb 2008 00:55:04 -0500
In-Reply-To: <de8605510802031823h2e928a0cr29ca31eaf5768406@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ibiltari <ibiltari@gmail.com>
Cc: linux-acpi@vger.kernel.org

Thanks for the acpidump.

It looks like OSI(Linux) is a NOP on this box.
so you shouldn't notice any difference between acpi_osi=Linux
and acpi_osi=!Linux.

-Len

The write to OSYS is a NOP, as it quickly gets over-written.
Looks like Acer writes the value 0x70 the (debug?) port at 0xB3,
but otherwise OSI(Linux) will have no effect on this system.



               If (CondRefOf (_OSI, Local0))
                {
                    If (_OSI ("Linux"))
                    {
                        Store (0x03E8, OSYS)
                        OSMI (0x70)
                    }

                    If (_OSI ("Windows 2006"))
                    {
                        Store (0x07D6, OSYS)
                    }
                    Else
                    {
                        Store (0x07D1, OSYS)
                    }
                }
                Else
                {
                    Store (0x07D0, OSYS)
                }
...
    OperationRegion (SMIO, SystemIO, 0xB2, 0x02)
    Field (SMIO, ByteAcc, NoLock, Preserve)
    {
        APMC,   8,
        APMD,   8
    }
...
    Method (OSMI, 1, NotSerialized)
    {
        Store (Arg0, APMD)
        Store (0xB2, APMC)
        Stall (0xFF)
        Stall (0xFF)
        Stall (0xFF)
        Stall (0xFF)
        Stall (0xFF)
        Stall (0xFF)
    }
