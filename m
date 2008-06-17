From: Len Brown <lenb@kernel.org>
Subject: Re: CPU temperature not detected
Date: Tue, 17 Jun 2008 19:01:28 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806171849320.7277@localhost.localdomain>
References: <BAY114-W5056724B82302477B1226BFAA80@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:35699 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761255AbYFQXBd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jun 2008 19:01:33 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K2M00BGQQMK4PG3@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 17 Jun 2008 18:01:33 -0500 (CDT)
In-reply-to: <BAY114-W5056724B82302477B1226BFAA80@phx.gbl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luke Sharkey <lukesharkey@hotmail.co.uk>
Cc: linux-acpi@vger.kernel.org



> 
>  I would like to know why /proc/acpi/thermal_zone/THRM/temperature contains a reading of 0 C -
> 1)   Firstly, does my cpu even have a sensor? (I have _only_ the on-die temperature, which is very hot).
> 2)    Secondly, can anyone shed some light on why /proc/acpi/fan is an empty directory?
> 
> Thank you!!!
> (my specs:  hp pavilion dv5000 series with AMD turion 64 bit processor ML-32.  Any other details I don't know to provide, please just say.  Thanks)

Thermal zone is below.
Clearly the EC is responsible for updating EC0.THEM.
It is possible that the EC is out to lunch.
Do other EC things work, such as battery status?
(or maybe ECOK is simply cleared...)

_TMP adds 2732 to the C it returns -- which linux then translates back 
from decikelvin to C.  ie. \_SB.PCI0.LPC0.EC0.THEM is returning 0.

_AC0 is an active trip point, and it returns a constant.
However, the BIOS neglects to aupply an _AL0 -- so there is
no fan associated with this active trip point -- it is just
a phantom.  I don't know why that is.  Could be a BIOS bug
that the fan isn't added in, or a BIOS bug that the fan
shouldn't be there and the AC0 should be deleted.

I recommend that you verify that you've got the latest BIOS.
I've got another dump in my archives that claims to be from an
hp dv-5000, and it looks quite different.
It has two thermal zones, both with _CRT and _TMP,
but no _PSV and no _AC0.

-Len


Scope (_TZ)
    {
        Name (DTMP, 0x0BBA)
        Name (DAC0, 0x0C3C)
        Name (DPSV, 0x0E30)
        Name (TBSE, 0x0AAC)
        Name (DCRT, 0x0E4E)
        ThermalZone (THRM)
        {
            Method (_TMP, 0, NotSerialized)
            {
                If (\_SB.PCI0.LPC0.ECOK ())
                {
                    Multiply (\_SB.PCI0.LPC0.EC0.THEM, 0x0A, Local0)
                    Add (Local0, 0x0AAC, Local0)
                    Return (Local0)
                }

                Return (DTMP)
            }

            Method (_AC0, 0, NotSerialized)
            {
                Return (DAC0)
            }

            Method (_CRT, 0, NotSerialized)
            {
                If (\_SB.PCI0.LPC0.ECOK ())
                {
                    Multiply (\_SB.PCI0.LPC0.EC0.THSD, 0x0A, Local0)
                    Add (Local0, 0x0AAC, Local0)
                    Return (Local0)
                }

                Return (DCRT)
            }

            Method (_PSV, 0, NotSerialized)
            {
                If (\_SB.PCI0.LPC0.ECOK ())
                {
                    Multiply (\_SB.PCI0.LPC0.EC0.THON, 0x0A, Local0)
                    Add (Local0, 0x0AAC, Local0)
                    Return (Local0)
                }

                Return (DPSV)
            }

            Name (_PSL, Package (0x01)
            {
                \_PR.CPU0
            })
            Name (_TC1, 0x02)
            Name (_TC2, 0x05)
            Name (_TSP, 0x32)
        }
    }

