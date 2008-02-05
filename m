From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - Acer Aspire 3100
Date: Tue, 5 Feb 2008 12:29:06 -0500
Message-ID: <200802051229.06312.lenb@kernel.org>
References: <fe8041900708061139j3c027f40v9cc4f6ccad1be998@mail.gmail.com> <200802031729.41807.lenb@kernel.org> <1202127691.6165.1.camel@jo-laptop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51780 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627AbYBER3V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 Feb 2008 12:29:21 -0500
In-Reply-To: <1202127691.6165.1.camel@jo-laptop>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jo <bissonjonathan@gmail.com>, linux-acpi@vger.kernel.org


> > > 
> > 
> >                     If (\_OSI ("Windows 2006"))
> >                     {
> >                         Store (0x40, ^OSTB)
> >                         Store (0x40, ^TPOS)
> >                     }
> > 
> >                     If (\_OSI ("Linux"))
> >                     {
> >                         Store (0x01, LINX)
> >                         Store (0x80, ^OSTB)
> >                         Store (0x80, ^TPOS)
> >                     }
> > 
> > Like other Acers...
> > LINX is written but never read, a NOP
> > OSTB is compared to >=4 only, so the Linux branch above is a NOP
> > OSTP return value is never referneced, a NOP
> > 
> > However, TPOS is referenced in the ATA _STM and _PS0 method,
> > wher it is compared equal to 0x40.  OSI(Linux) will disable
> > that code (whatever it does).
> > 
> > So unless you find the power management of your HDD to be better
> > with acpi_osi=Linux at suspend/resume time,
> > we'll stick with the default of acpi_osi=!Linux for all Acer.
> > 

> 
> Hmmmm what do you mean by "power management of your HDD". I got no
> problem with suspend/resume and I never use power management of HDD (as
> it seems that it is not really something that can help to enhance the
> lifetime of the harddisk).

In this case, it is invoked for you during suspend/resume.

> Is there a way to know what does this condition branch ?

The big picture is that if the box has a Vista sticker on it,
then it was validated with Vista, and why would Linux want to
run the BIOS through a (different) code path that was not validated?

But yes, one can read the code below and notice there is a hook in
SAT0.PRID._STM that only executes on Vista
(though curiously, _STM for the other 3 targets doesn't have this).
This hook does something to the PCI config space of the device.

and for all 4 targets, there is code under _PS0 - which is
what would be invoked on resume.

There is also some sort of spin on a busy-bit in the method
that restores power to the 4 SATA targets that executes
only if Vista compatible.

-Len


            Device (SAT0)
                Device (PRID)
                {
                    Name (_ADR, 0x00)
                    Name (SPTM, Buffer (0x14)
                    {
                        /* 0000 */    0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,
                        /* 0008 */    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
                        /* 0010 */    0x13, 0x00, 0x00, 0x00
                    })
                    Method (_GTM, 0, NotSerialized)
                    {
                        Return (SPTM)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, SPTM)
                        If (LEqual (TPOS, 0x40))
                        {
# Vista compatible path

                            \_SB.PCI0.SMB.SAPW ()
                        }
                    }

                    Name (S12P, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        If (LEqual (TPOS, 0x40))
                        {
# Vista compatible path
# looks like it spins on a busy bit in _PS0,
# the method used to bring the device back to powered-on
# non-vista will not spin on this bit
                            Store (0x28, Local0)
                            OperationRegion (SAI1, SystemIO, P3F4, 0x04)
                            Field (SAI1, ByteAcc, NoLock, Preserve)
                            {
                                        Offset (0x01),
                                    ,   7,
                                BSY0,   1
                            }

                            While (LAnd (LEqual (BSY0, 0x01), Local0))
                            {
                                Store (Local0, DBGP)
                                Sleep (0xFA)
                                Decrement (Local0)
                            }
                        }

                        Store (0x00, S12P)
                    }
...
                Device (SECD)
                {
                    Name (_ADR, 0x01)
                    Name (SPTM, Buffer (0x14)
                    {
                        /* 0000 */    0x78, 0x00, 0x00, 0x00, 0x0F, 0x00, 0x00, 0x00,
                        /* 0008 */    0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
                        /* 0010 */    0x13, 0x00, 0x00, 0x00
                    })
                    Method (_GTM, 0, NotSerialized)
                    {
                        Return (SPTM)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (Arg0, SPTM)
# note unconditional SAPW here, no check for Vista
                        \_SB.PCI0.SMB.SAPW ()
                    }

                    Name (S12S, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        If (LEqual (TPOS, 0x40))
                        {
# Vista path, like pri target above
                            Store (0x28, Local2)
                            OperationRegion (SAI2, SystemIO, P1F4, 0x04)
                            Field (SAI2, ByteAcc, NoLock, Preserve)
                            {
                                        Offset (0x01),
                                    ,   7,
                                BSY1,   1
                            }

                            While (LAnd (LEqual (BSY1, 0x01), Local2))
                            {
                                Sleep (0xFA)
                                Store (Local2, DBGP)
                                Decrement (Local2)
                            }
                        }

                        Store (0x00, S12S)
                    }
            Device (SAT1)
                Device (PRID)
# same SECD above
                Device (SECD)
# same as SECD above


So what does SAPW() do?

                Method (SAPW, 0, NotSerialized)
                {
                    Acquire (SAPM, 0xFFFF)
                    Store (Z00W, Local0)
                    And (Local0, 0x01, Local1)
                    If (Local1)
                    {
                        \_SB.PCI0.SAT0.FBWK ()
                        Or (Z00W, 0x20, Z00W)
                    }

                    And (Local0, 0x10, Local1)
                    If (Local1)
                    {
                        \_SB.PCI0.SAT1.FBWK ()
                        Or (Z00W, 0x40, Z00W)
                    }

                    Release (SAPM)
                }
...
            Device (SMB)
            {
                Name (_ADR, 0x00140000)
                OperationRegion (Z00V, PCI_Config, 0x08, 0x0100)
                Field (Z00V, ByteAcc, NoLock, Preserve)
                {
                    RVID,   8,
                            Offset (0xA5),
                    Z00W,   8,
# Z00W lives in PCI configuratioon space - no idea what it does
                            Offset (0xF0),
                    EIDX,   8,
                            Offset (0xF4),
                    EDAT,   32
                }
...
            Device (SAT0)
            {
                Name (_ADR, 0x00120000)
                OperationRegion (SAP1, PCI_Config, 0x00, 0x44)
                Field (SAP1, WordAcc, NoLock, Preserve)
                {
                            Offset (0x08),
                    CLCD,   32,
                            Offset (0x10),
                    P1F0,   16,
                            Offset (0x14),
                    P3F4,   16,
                            Offset (0x18),
                    P170,   16,
                            Offset (0x1C),
                    P1F4,   16,
                            Offset (0x40),
                    CNFG,   8
# CNFG lives in PCI configuration space for the device
                }

                Method (FBWK, 0, NotSerialized)
                {
                    And (CNFG, 0xF7, CNFG)
                    Sleep (0x0A)
                    And (CNFG, 0xEF, CNFG)
                }

# presumably x1080 is a debug port

    OperationRegion (\DEBG, SystemIO, 0x1080, 0x01)
    Field (\DEBG, ByteAcc, NoLock, Preserve)
    {
        DBGP,   8
    }
