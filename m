From: "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>
Subject: RE: HP dv9000t battery discharge rate
Date: Tue, 5 Dec 2006 04:55:22 +0300
Message-ID: <8E389A5F2FEABA4CB1DEC35A25CB39CE7DBE75@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19280 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968025AbWLECIX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Dec 2006 21:08:23 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergey Basmanov <sergey_basmanov@mail.ru>
Cc: linux-acpi@vger.kernel.org


I guess your DSDT does not support 'present rate'.
Look in /proc/acpi/BAT*/state file. The 'present rate' field is the PBST
at 0x01. I expect the 'unknown' (0xFFFFFFFF) value of 'present rate'. Is
it?


-----Original Message-----
From: linux-acpi-owner@vger.kernel.org
[mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Sergey Basmanov
Sent: Tuesday, December 05, 2006 12:31 AM
To: linux-acpi@vger.kernel.org
Subject: HP dv9000t battery discharge rate

Hi,
Was looking how to get battery discharge rate on this laptop.
This is part of DSDT:
            Name (PBST, Package (0x04)
            {
                0x00,
                0xFFFFFFFF,
                0xFFFFFFFF,
                0x2710
            })
...

            Method (_BST, 0, NotSerialized)
            {
                If (ECON)
                {
                    If (\_SB.PCI0.LPCB.EC0.MBTS)
                    {
                        UPBS ()
                    }
                    Else
                    {
                        IVBS ()
                    }
                }
                Else
                {
                    IVBS ()
                }

                Return (PBST)
            }
...
            Method (UPBS, 0, NotSerialized)
            {
                Store (\_SB.PCI0.LPCB.EC0.MBRM, Local5)
                If (LNot (And (Local5, 0x8000)))
                {
                    ShiftRight (Local5, 0x05, Local5)
                    ShiftLeft (Local5, 0x05, Local5)
                    If (LNotEqual (Local5, DerefOf (Index (PBST,
0x02))))
                    {
                        Store (Local5, Index (PBST, 0x02))
                    }
                }

                Store (\_SB.PCI0.LPCB.EC0.MBCV, Index (PBST, 0x03))
                Store (\_SB.PCI0.LPCB.EC0.MBST, Index (PBST, 0x00))
                Store (\_SB.PCI0.LPCB.EC0.BA1C, BCAP)
            }

and method IVBS just stores default values into PBST.
So, I'm not familiar with iasl and rest, but if I understand right, UPBS

method is used in case when battery connected and known to system.
In UPBS method I don't see any code that updates PBST at 0x01 
(discharge_rate). HP support says that sensor is present in system.
Any ideas where this sensor located and how can I get discharge rate 
visible in ACPI (kernel 2.6.18.2)?

PS: Please, reply to e-mail directly because I'm not subscribed to this 
list.
Thank You..

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
