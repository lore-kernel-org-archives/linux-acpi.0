From: Henning Heinold <h.heinold@tarent.de>
Subject: Problem with uart and acpi
Date: Thu, 25 Feb 2010 10:13:29 +0100
Message-ID: <20100225091328.GB22799@ugs.tarent.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gate.tarent.de ([212.79.178.249]:52334 "EHLO ugs.tarent.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753920Ab0BYJn7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Feb 2010 04:43:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by ugs.tarent.de (Postfix) with ESMTP id 3D0834000C4A9
	for <linux-acpi@vger.kernel.org>; Thu, 25 Feb 2010 10:15:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by ugs.tarent.de (Postfix) with ESMTP id 2BFC6400203F5
	for <linux-acpi@vger.kernel.org>; Thu, 25 Feb 2010 10:15:08 +0100 (CET)
Received: from ugs.tarent.de ([127.0.0.1])
	by localhost (ugs.tarent.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9p8GAsk3pzcr for <linux-acpi@vger.kernel.org>;
	Thu, 25 Feb 2010 10:15:08 +0100 (CET)
Received: from entw1 (lui.tarent.buero [192.168.4.41])
	by ugs.tarent.de (Postfix) with ESMTP id 0AA5C4000C4A9
	for <linux-acpi@vger.kernel.org>; Thu, 25 Feb 2010 10:15:08 +0100 (CET)
Received: from henning by entw1 with local (Exim 4.69)
	(envelope-from <h.heinold@tarent.de>)
	id 1NkZmj-0006BX-4T
	for linux-acpi@vger.kernel.org; Thu, 25 Feb 2010 10:13:29 +0100
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

we got some viliv x70 ez, atom based netbooks with wifi, bt, gsm, gps and touchscreen.

I got all running now under ubuntu with latest stable kernel 2.6.32.8 except the gps. Viliv claims
it is a sirf3 chip. It is connect to on irq 3(verified it under windows, where of course the
gps works), the 8250 modul run fine
and show me the that the uart is connected to ttyS1. Unfornatly when the 8250_pnp
is loaded the following occurs:

[    3.368311] serial 00:0c: activated
[    3.376287] serial 00:0c: disabled
 
So it seems something(acpi maybee) is disabling it and of course there is no output when I connect
to the uart and run gpsd.

So any help which got me further is appreciate. 

Here some more info's:

/sys/devices/pnp0/00\:0c/firmware_node/hid -> PNP0501
 
/sys/devices/pnp0/00\:0c/firmware_node/path -> \_SB_.PCI0.SBRG.UAR2

In the attachment is the code I found in the DSDT.dsl for UAR2.

Bye Henning.


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dsdt.txt"

                Device (UAR2)
                {
                    Name (_UID, 0x02)
                    Name (_HID, EisaId ("PNP0501"))
                    Name (CRS, ResourceTemplate ()
                    {
                        StartDependentFn (0x00, 0x00)
                        {
                            FixedIO (
                                0x02F8,             // Address
                                0x08,               // Length
                                )
                            IRQNoFlags ()
                                {3}
                        }
                        EndDependentFn ()
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (ESTS, 0x04))
                        {
                            If (And (ESTS, 0x40))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (0x0D)
                            }
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (CRS)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        If (And (ESTS, 0x20))
                        {
                            Store (EDAT, DBG8)
                            Sleep (One)
                            Store (0xBF, ESTS)
                            Store (0xBF, DBG8)
                        }

                        Sleep (One)
                        Store (D2FD, DBG8)
                        Sleep (One)
                        Store (D2FD, DBG8)
                        Store (0xCD, DBG8)
                    }


--ZGiS0Q5IWpPtfppv--
