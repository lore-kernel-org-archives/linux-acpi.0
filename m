From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode (acpi_osi=!Linux)
Date: Mon, 2 Jul 2007 23:49:19 -0400
Message-ID: <200707022349.19743.lenb@kernel.org>
References: <200707011439.23511.a.biardi@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39670 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753385AbXGCDta (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Jul 2007 23:49:30 -0400
In-Reply-To: <200707011439.23511.a.biardi@tiscali.it>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: a.biardi@tiscali.it
Cc: linux-acpi@vger.kernel.org

thanks for the macbook pro acpidump, andrea.

Apple got it wrong -- they're using if/then/else with _OSI
to try to identify the OS, just like the broken reference code.

But it doesn't look like in this version it will make any difference.
The _STA.GUI bit for HPET will be set for Windows and Darwin, 
but not for Linux.  But Linux doesn't use that bit anyway.

Also, thanks for the dmesg -- the fact that you got no extra
line in dmesg means I botched it -- so I'll fix that it in a minute.

Finally, there are some interesting parts of the DSDT that will
change depending on "acpi_osi=Darwin" -- looks like bits
related to the smart battery.  We should look into what it
would mean to set _OSI "Darwin" at some point...

cheers,
-Len

for those interested in the details, here is the interesting part of the DSDT:

        Method (_INI, 0, NotSerialized)
        {
            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Darwin"))
                {
                    Store (0x2710, OSYS)

# if (Darwin), OSYS=Ox2710
                }
                Else
                {
                    If (_OSI ("Linux"))
                    {
                        Store (0x03E8, OSYS)
# if (Linux) OSYS=0x3E8
                    }
                    Else
                    {
                        Store (0x07D1, OSYS)
# else OSYS=7D1 (modern Windows goes here)
                    }
                }
            }
            Else
            {
                Store (0x07D0, OSYS)
# else OSYS=0x7D0 (old windows and old Linux go here)
            }
...
                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103"))
                    Name (_CID, 0x010CD041)
 ...
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LGreaterEqual (OSYS, 0x07D1))
                        {
                            If (HPAE)
                            {
                                Return (0x0F)
# if HPET enabled && (>= new Windows), return functioning, gui, enabled, present
# note that Linux is not >= new Windows here
                            }
                        }
                        Else
                        {
                            If (HPAE)
                            {
                                Return (0x0B)
# if HPET enabled && (< new Windows) return functioning, enabled, present
                            }
                        }

                        Return (0x00)
                    }

