From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: HP dv9000t battery discharge rate
Date: Tue, 5 Dec 2006 10:43:40 +0100
Message-ID: <20061205094340.GO4945@poupinou.org>
References: <4574938F.6050202@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from poup.poupinou.org ([195.101.94.96]:11727 "EHLO
	poup.poupinou.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759636AbWLEJnm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Dec 2006 04:43:42 -0500
Content-Disposition: inline
In-Reply-To: <4574938F.6050202@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergey Basmanov <sergey_basmanov@mail.ru>
Cc: linux-acpi@vger.kernel.org

On Tue, Dec 05, 2006 at 12:30:55AM +0300, Sergey Basmanov wrote:
> Hi,
> Was looking how to get battery discharge rate on this laptop.
> This is part of DSDT:
>            Name (PBST, Package (0x04)
>            {
>                0x00,
>                0xFFFFFFFF,
>                0xFFFFFFFF,
>                0x2710
>            })
> ...
> 
>            Method (_BST, 0, NotSerialized)
>            {
>                If (ECON)
>                {
>                    If (\_SB.PCI0.LPCB.EC0.MBTS)
>                    {
>                        UPBS ()
>                    }
>                    Else
>                    {
>                        IVBS ()
>                    }
>                }
>                Else
>                {
>                    IVBS ()
>                }
> 
>                Return (PBST)
>            }
> ...
>            Method (UPBS, 0, NotSerialized)
>            {
>                Store (\_SB.PCI0.LPCB.EC0.MBRM, Local5)
>                If (LNot (And (Local5, 0x8000)))
>                {
>                    ShiftRight (Local5, 0x05, Local5)
>                    ShiftLeft (Local5, 0x05, Local5)
>                    If (LNotEqual (Local5, DerefOf (Index (PBST, 0x02))))
>                    {
>                        Store (Local5, Index (PBST, 0x02))
>                    }
>                }
> 
>                Store (\_SB.PCI0.LPCB.EC0.MBCV, Index (PBST, 0x03))
>                Store (\_SB.PCI0.LPCB.EC0.MBST, Index (PBST, 0x00))
>                Store (\_SB.PCI0.LPCB.EC0.BA1C, BCAP)
>            }
> 
> and method IVBS just stores default values into PBST.
> So, I'm not familiar with iasl and rest, but if I understand right, UPBS 
> method is used in case when battery connected and known to system.
> In UPBS method I don't see any code that updates PBST at 0x01 
> (discharge_rate). HP support says that sensor is present in system.
> Any ideas where this sensor located and how can I get discharge rate 
> visible in ACPI (kernel 2.6.18.2)?

It's likely under the embedded controller.  If you give me the whole
OperationRegion() and the Field() for that one it might be possible
I could have a hint to get it.

It should be something like that:

Device (EC0)
{
	...
	...
	OperationRegion(XXXX, EmbeddedControl, 0x00, 0xFF)
	Field(XXXX, ByteAcc, ..., ...)
	{
		...
		...
	}
	...
}

I'll need all the Field with the same name (here XXXX).

Or alternatively send to me the whole ASL.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
