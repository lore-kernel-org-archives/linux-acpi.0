From: Sergey Basmanov <sergey_basmanov@mail.ru>
Subject: HP dv9000t battery discharge rate
Date: Tue, 05 Dec 2006 00:30:55 +0300
Message-ID: <4574938F.6050202@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx27.mail.ru ([194.67.23.64]:16990 "EHLO mx27.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967220AbWLDVa5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Dec 2006 16:30:57 -0500
Received: from [62.33.35.22] (port=48679 helo=[10.11.10.19])
	by mx27.mail.ru with asmtp
	id 1GrLOp-000Adh-00
	for linux-acpi@vger.kernel.org; Tue, 05 Dec 2006 00:30:55 +0300
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

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
                    If (LNotEqual (Local5, DerefOf (Index (PBST, 0x02))))
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

