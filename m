From: Stefan =?iso-8859-1?q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Subject: Re: Radeon PM Support
Date: Thu, 5 Aug 2004 21:53:25 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200408052153.25467.stefandoesinger@gmx.at>
References: <1091139240.26511.9.camel@6-allhosts> <200408051453.55710.stefandoesinger@gmx.at> <200408051914.39445.anib@anib.de>
Reply-To: stefandoesinger-RbZlAiThDcE@public.gmane.org
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1ApEByUb7ileMU1"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200408051914.39445.anib-La3J9u0raUk@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: anib-La3J9u0raUk@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--Boundary-00=_1ApEByUb7ileMU1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Donnerstag, 5. August 2004 19:14 schrieb Alexander Bruder:
> it also happends for the 80x series (in my case 801Lcib) with ATI
> Technologies Inc Radeon R250 Lf [Radeon Mobility 9000] using the
> framebuffer.
I use an Acer TM 803.....
Suspend to RAM works with user mode VGA ROM post.

Just a short HOWTO(based on kernel 2.6.8-rc2 + recent acpi patch from 
acpi.sf.net):
*Apply the resume-finish-split patch to the kernel.
*Use the attached dsdt(see acpi.sf.net how to do this)
*the boot-radeon.c program can ROM-post the radeon card(compile with gcc 
boot-radeon.c -o boot-radeon -llrmi) You need the lrmi libs+headers. Call it 
after resuming from S3. You have to call it from console. If you use X, you 
can do this:
chvt 1
boot-radeon
chvt 7

Before going to S3 you'll have to unload ehci-hcd. All other drivers may 
remain loaded.

The things that do not work properly:
*VGA resume with radeonfb, the most annoying problem
*sending ehci-hcd to suspend fails. uhci works
*restoring irq routing on resume. That's what the modified dsdt is for. It 
forces the wlan card to use IRQ10 instead of IRQ11.

Stefan

--Boundary-00=_1ApEByUb7ileMU1
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="resume-finish-split.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="resume-finish-split.patch"

--- linux-2.6.8-rc2/include/linux/pm.h	2004-08-04 20:36:48.044455680 +0200
+++ include/linux/pm.h	2004-08-04 19:50:07.000000000 +0200
@@ -214,6 +214,7 @@
 	u32	pm_disk_mode;
 	int (*prepare)(u32 state);
 	int (*enter)(u32 state);
+	int (*leave)(u32 state);
 	int (*finish)(u32 state);
 };
 
--- linux-2.6.8-rc2/kernel/power/main.c	2004-08-04 20:36:17.755060368 +0200
+++ kernel/power/main.c	2004-08-04 19:52:26.000000000 +0200
@@ -108,6 +108,8 @@
 
 static void suspend_finish(u32 state)
 {
+	if (pm_ops && pm_ops->leave)
+		pm_ops->leave(state);
 	device_resume();
 	if (pm_ops && pm_ops->finish)
 		pm_ops->finish(state);
--- linux-2.6.8-rc2/drivers/acpi/sleep/main.c	2004-08-04 20:29:23.863981376 +0200
+++ drivers/acpi/sleep/main.c	2004-08-04 20:33:41.348837728 +0200
@@ -127,7 +127,23 @@
 	return ACPI_SUCCESS(status) ? 0 : -EFAULT;
 }
 
+/**
+ *	acpi_pm_leave - Make system ready to resume devices.
+ *	@pm_state:		State we're coming out of.
+ *
+ *	This is called after we wake back up and before device
+ *	resume methods are called.
+ */
+
+static int acpi_pm_leave(u32 pm_state)
+{
+	u32 acpi_state = acpi_suspend_states[pm_state];
 
+	acpi_leave_sleep_state(acpi_state);
+	acpi_disable_wakeup_device(acpi_state);
+	
+	return 0;
+}
 /**
  *	acpi_pm_finish - Finish up suspend sequence.
  *	@pm_state:		State we're coming out of.
@@ -140,9 +156,6 @@
 {
 	u32 acpi_state = acpi_suspend_states[pm_state];
 
-	acpi_leave_sleep_state(acpi_state);
-	acpi_disable_wakeup_device(acpi_state);
-
 	/* reset firmware waking vector */
 	acpi_set_firmware_waking_vector((acpi_physical_address) 0);
 
@@ -170,6 +183,7 @@
 static struct pm_ops acpi_pm_ops = {
 	.prepare	= acpi_pm_prepare,
 	.enter		= acpi_pm_enter,
+	.leave		= acpi_pm_leave,
 	.finish		= acpi_pm_finish,
 };
 

--Boundary-00=_1ApEByUb7ileMU1
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="ACER-TravelMate_800-4a12-custom.asl"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ACER-TravelMate_800-4a12-custom.asl"

/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20040527
 *
 * Disassembly of dsdt.dat, Wed Jul  7 22:53:26 2004
 */
DefinitionBlock ("DSDT.aml", "DSDT", 1, "ACER  ", "Cardinal", 537003824)
{
    OperationRegion (DBG, SystemIO, 0x80, 0x01)
    Field (DBG, ByteAcc, NoLock, Preserve)
    {
        DEBG,   8
    }

    Scope (_PR)
    {
        Processor (CPU0, 0x00, 0x00001010, 0x06)
        {
            Name (_PCT, Package (0x02)
            {
                ResourceTemplate ()
                {
                    Register (SystemIO, 0x08, 0x00, 0x00000000000000B2)
                }, 

                ResourceTemplate ()
                {
                    Register (SystemIO, 0x08, 0x00, 0x00000000000000B3)
                }
            })
            Name (_PSS, Package (0x05)
            {
                Package (0x06)
                {
                    0x0640, 
                    0x5DC0, 
                    0x0A, 
                    0x0A, 
                    0x89, 
                    0x00
                }, 

                Package (0x06)
                {
                    0x0578, 
                    0x4E20, 
                    0x0A, 
                    0x0A, 
                    0x8A, 
                    0x01
                }, 

                Package (0x06)
                {
                    0x04B0, 
                    0x4650, 
                    0x0A, 
                    0x0A, 
                    0x8B, 
                    0x02
                }, 

                Package (0x06)
                {
                    0x0320, 
                    0x3E80, 
                    0x0A, 
                    0x0A, 
                    0x8C, 
                    0x03
                }, 

                Package (0x06)
                {
                    0x0258, 
                    0x2EE0, 
                    0x0A, 
                    0x0A, 
                    0x8D, 
                    0x04
                }
            })
            Method (_PPC, 0, NotSerialized)
            {
                Return (0x00)
            }
        }
    }

    Scope (_SI)
    {
        Method (_MSG, 1, NotSerialized)
        {
            If (Arg0)
            {
                Store (One, \_SB.PCI0.LPC0.BL27)
            }
            Else
            {
                Store (Zero, \_SB.PCI0.LPC0.BL27)
            }
        }
    }

    Name (\_S0, Package (0x02)
    {
        0x00, 
        0x00
    })
    Name (\_S3, Package (0x02)
    {
        0x05, 
        0x05
    })
    Name (\_S4, Package (0x02)
    {
        0x06, 
        0x06
    })
    Name (\_S5, Package (0x02)
    {
        0x07, 
        0x07
    })
    Method (_PTS, 1, NotSerialized)
    {
        Store (Arg0, \_SB.STAT)
        Store (">>>> _PTS ------------", Debug)
        Store (Arg0, Debug)
        Store (Arg0, \_SB.SLEE)
        Store (0x84, \_SB.PCI0.LPC0.BCMD)
        Store (0x00, \_SB.PCI0.LPC0.SMIC)
        If (Or (LEqual (Arg0, 0x03), LEqual (Arg0, 0x04)))
        {
            Store (0x01, \_SB.PCI0.LPC0.EC0.APWR)
        }

        If (LEqual (Arg0, 0x03))
        {
            Store (0x80, \_SB.PCI0.LPC0.BCMD)
            Store (0x00, \_SB.PCI0.LPC0.SMIC)
        }

        If (LEqual (Arg0, 0x04))
        {
            Store (0x01, \_SB.S4WP)
            Store (0x82, \_SB.PCI0.LPC0.BCMD)
            Store (0x00, \_SB.PCI0.LPC0.SMIC)
            Store (One, \_SB.PCI0.LPC0.EC0.PFLG)
            Store (One, \_SB.PCI0.LPC0.EC0.S4LD)
        }

        If (LEqual (SizeOf (\_OS), 0x27))
        {
            Notify (\_SB.BAT1, 0x80)
            Notify (\_SB.BAT2, 0x80)
            Notify (\_SB.ACAD, 0x00)
        }

        If (LEqual (Arg0, 0x05))
        {
            Store (One, \_SB.PCI0.LPC0.EC0.S5LW)
        }
    }

    Method (_WAK, 1, NotSerialized)
    {
        Store (">>>> _WAK ------------", Debug)
        Store (Arg0, Debug)
        Store (Arg0, \_SB.STAT)
        If (LEqual (Arg0, 0x03))
        {
            Store (0x81, \_SB.PCI0.LPC0.BCMD)
            Store (0x00, \_SB.PCI0.LPC0.SMIC)
        }

        If (LEqual (Arg0, 0x04))
        {
            Store (0x01, \_SB.OKEC)
            Notify (\_SB.SLPB, 0x02)
        }

        If (LEqual (SizeOf (\_OS), 0x14))
        {
            Store (\_SB.PCI0.LPC0.RBID, Local0)
            Store (\_SB.PCI0.IDE0.BAYR, Local1)
            Store (Local0, \_SB.PCI0.IDE0.BAYR)
            If (LNot (LEqual (Local0, Local1)))
            {
                If (Or (LEqual (Local1, 0x01), LEqual (Local1, 0x02)))
                {
                    If (And (LEqual (\_SB.PCI0.MYOS, 0x03), LEqual (Local0, 0x03)))
                    {
                        Notify (\_SB.PCI0.IDE0.SECN.BAY1, 0x03)
                    }
                    Else
                    {
                        Notify (\_SB.PCI0.IDE0.SECN.BAY1, 0x01)
                    }
                }
            }

            If (Or (LEqual (Local0, 0x01), LEqual (Local0, 0x02)))
            {
                Notify (\_SB.PCI0.IDE0.SECN.BAY1, 0x00)
            }
        }

        If (LEqual (SizeOf (\_OS), 0x27))
        {
            Notify (\_SB.BAT1, 0x80)
            Notify (\_SB.BAT2, 0x80)
            Notify (\_SB.ACAD, 0x00)
        }

        Store (\_SB.PCI0.LPC0.EC0.ACDF, \_SB.ACST)
        If (LEqual (SizeOf (\_OS), 0x11))
        {
            Notify (\_SB.SLPB, 0x02)
        }

        Store (0x00, \_SB.SLEE)
    }

    Scope (_GPE)
    {
        Method (_L05, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.MDM0, 0x02)
        }

        Method (_L0B, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.HUB, 0x00)
            If (Or (LEqual (\_SB.PCI0.MYOS, 0x01), LEqual (\_SB.PCI0.MYOS, 0x03)))
            {
                Notify (\_SB.SLPB, 0x02)
            }
        }

        Method (_L03, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB1, 0x02)
        }

        Method (_L04, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB2, 0x02)
        }

        Method (_L0C, 0, NotSerialized)
        {
            Notify (\_SB.PCI0.USB3, 0x02)
        }

        Method (_E18, 0, NotSerialized)
        {
            Sleep (0x01)
        }
    }

    Scope (_SB)
    {
        Name (STAT, 0x00)
        Name (D1ST, 0x00)
        Name (D1SJ, 0x01)
        Device (PCI0)
        {
            Name (MYOS, 0x02)
            Method (_INI, 0, NotSerialized)
            {
                Store (0x01, \_SB.D1SJ)
                Store (0x02, MYOS)
                If (LEqual (SizeOf (\_OS), 0x14))
                {
                    Store (0x01, MYOS)
                    Store (0x01, \_SB.W2KF)
                    If (CondRefOf (_OSI, Local0))
                    {
                        If (\_OSI ("Windows 2001"))
                        {
                            Store (0x03, MYOS)
                            Store (0x03, \_SB.W2KF)
                        }
                    }
                }
                Else
                {
                    If (LEqual (SizeOf (\_OS), 0x11))
                    {
                        Store (0x00, MYOS)
                        Store (0x00, \_SB.W2KF)
                    }
                    Else
                    {
                        If (LEqual (SizeOf (\_OS), 0x27))
                        {
                            Store (0x02, MYOS)
                            Store (0x02, \_SB.W2KF)
                        }
                    }
                }
            }

            Name (_HID, EisaId ("PNP0A03"))
            Name (_ADR, 0x00)
            Name (_BBN, 0x00)
            OperationRegion (HBUS, PCI_Config, 0x40, 0xC0)
            Field (HBUS, DWordAcc, NoLock, Preserve)
            {
                Offset (0x20), 
                DRB0,   8, 
                DRB1,   8, 
                DRB2,   8, 
                DRB3,   8, 
                Offset (0x50), 
                    ,   4, 
                PM0H,   2, 
                Offset (0x51), 
                PM1L,   2, 
                    ,   2, 
                PM1H,   2, 
                Offset (0x52), 
                PM2L,   2, 
                    ,   2, 
                PM2H,   2, 
                Offset (0x53), 
                PM3L,   2, 
                    ,   2, 
                PM3H,   2, 
                Offset (0x54), 
                PM4L,   2, 
                    ,   2, 
                PM4H,   2, 
                Offset (0x55), 
                PM5L,   2, 
                    ,   2, 
                PM5H,   2, 
                Offset (0x56), 
                PM6L,   2, 
                    ,   2, 
                PM6H,   2, 
                Offset (0x57), 
                FDHC,   8
            }

            Name (BUF0, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,
                    0x0000,
                    0x00FF,
                    0x0000,
                    0x0100, 0x00)
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,
                    0x00000000,
                    0x00000CF7,
                    0x00000000,
                    0x00000CF8, 0x00)
                IO (Decode16, 0x0CF8, 0x0CF8, 0x01, 0x08)
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,
                    0x00000D00,
                    0x0000FFFF,
                    0x00000000,
                    0x0000F300, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000A0000,
                    0x000BFFFF,
                    0x00000000,
                    0x00020000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000C0000,
                    0x000C3FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000C4000,
                    0x000C7FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000C8000,
                    0x000CBFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000CC000,
                    0x000CFFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000D0000,
                    0x000D3FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000D4000,
                    0x000D7FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000D8000,
                    0x000DBFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000DC000,
                    0x000DFFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000E0000,
                    0x000E3FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000E4000,
                    0x000E7FFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000E8000,
                    0x000EBFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000EC000,
                    0x000EFFFF,
                    0x00000000,
                    0x00004000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x000F0000,
                    0x000FFFFF,
                    0x00000000,
                    0x00010000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x00000000,
                    0xFEBFFFFF,
                    0x00000000,
                    0x00000000, 0x00)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,
                    0x00000000,
                    0x00000000,
                    0x00000000,
                    0x00000000, 0x00)
            })
            Method (_CRS, 0, Serialized)
            {
                If (PM1L)
                {
                    CreateDWordField (BUF0, 0x80, C0LN)
                    Store (Zero, C0LN)
                }

                If (LEqual (PM1L, 0x01))
                {
                    CreateBitField (BUF0, 0x0378, C0RW)
                    Store (Zero, C0RW)
                }

                If (PM1H)
                {
                    CreateDWordField (BUF0, 0x9B, C4LN)
                    Store (Zero, C4LN)
                }

                If (LEqual (PM1H, 0x01))
                {
                    CreateBitField (BUF0, 0x0450, C4RW)
                    Store (Zero, C4RW)
                }

                If (PM2L)
                {
                    CreateDWordField (BUF0, 0xB6, C8LN)
                    Store (Zero, C8LN)
                }

                If (LEqual (PM2L, 0x01))
                {
                    CreateBitField (BUF0, 0x0528, C8RW)
                    Store (Zero, C8RW)
                }

                If (PM2H)
                {
                    CreateDWordField (BUF0, 0xD1, CCLN)
                    Store (Zero, CCLN)
                }

                If (LEqual (PM2H, 0x01))
                {
                    CreateBitField (BUF0, 0x0600, CCRW)
                    Store (Zero, CCRW)
                }

                If (PM3L)
                {
                    CreateDWordField (BUF0, 0xEC, D0LN)
                    Store (Zero, D0LN)
                }

                If (LEqual (PM3L, 0x01))
                {
                    CreateBitField (BUF0, 0x06D8, D0RW)
                    Store (Zero, D0RW)
                }

                If (PM3H)
                {
                    CreateDWordField (BUF0, 0x0107, D4LN)
                    Store (Zero, D4LN)
                }

                If (LEqual (PM3H, 0x01))
                {
                    CreateBitField (BUF0, 0x07B0, D4RW)
                    Store (Zero, D4RW)
                }

                If (PM4L)
                {
                    CreateDWordField (BUF0, 0x0122, D8LN)
                    Store (Zero, D8LN)
                }

                If (LEqual (PM4L, 0x01))
                {
                    CreateBitField (BUF0, 0x0888, D8RW)
                    Store (Zero, D8RW)
                }

                If (PM4H)
                {
                    CreateDWordField (BUF0, 0x013D, DCLN)
                    Store (Zero, DCLN)
                }

                If (LEqual (PM4H, 0x01))
                {
                    CreateBitField (BUF0, 0x0960, DCRW)
                    Store (Zero, DCRW)
                }

                If (PM5L)
                {
                    CreateDWordField (BUF0, 0x0158, E0LN)
                    Store (Zero, E0LN)
                }

                If (LEqual (PM5L, 0x01))
                {
                    CreateBitField (BUF0, 0x0A38, E0RW)
                    Store (Zero, E0RW)
                }

                If (PM5H)
                {
                    CreateDWordField (BUF0, 0x0173, E4LN)
                    Store (Zero, E4LN)
                }

                If (LEqual (PM5H, 0x01))
                {
                    CreateBitField (BUF0, 0x0B10, E4RW)
                    Store (Zero, E4RW)
                }

                If (PM6L)
                {
                    CreateDWordField (BUF0, 0x018E, E8LN)
                    Store (Zero, E8LN)
                }

                If (LEqual (PM6L, 0x01))
                {
                    CreateBitField (BUF0, 0x0BE8, E8RW)
                    Store (Zero, E8RW)
                }

                If (PM6H)
                {
                    CreateDWordField (BUF0, 0x01A9, ECLN)
                    Store (Zero, ECLN)
                }

                If (LEqual (PM6H, 0x01))
                {
                    CreateBitField (BUF0, 0x0CC0, ECRW)
                    Store (Zero, ECRW)
                }

                If (PM0H)
                {
                    CreateDWordField (BUF0, 0x01C4, F0LN)
                    Store (Zero, F0LN)
                }

                If (LEqual (PM0H, 0x01))
                {
                    CreateBitField (BUF0, 0x0D98, F0RW)
                    Store (Zero, F0RW)
                }

                CreateDWordField (BUF0, 0x01D3, M1MN)
                CreateDWordField (BUF0, 0x01D7, M1MX)
                CreateDWordField (BUF0, 0x01DF, M1LN)
                Multiply (0x02000000, DRB3, M1MN)
                Add (Subtract (M1MX, M1MN), 0x01, M1LN)
                ShiftRight (And (\_SB.PCI0.LPC0.MTSE, 0x0380), 0x07, Local0)
                If (And (Local0, 0x04))
                {
                    CreateDWordField (BUF0, 0x01EE, M2MN)
                    CreateDWordField (BUF0, 0x01F2, M2MX)
                    CreateDWordField (BUF0, 0x01FA, M2LN)
                    Store (0xFED00000, M2MN)
                    Store (0xFED003FF, M2MX)
                    Store (0x0400, M2LN)
                    If (LEqual (Local0, 0x05))
                    {
                        Store (0xFED01000, M2MN)
                        Store (0xFED013FF, M2MX)
                    }

                    If (LEqual (Local0, 0x06))
                    {
                        Store (0xFED02000, M2MN)
                        Store (0xFED023FF, M2MX)
                    }

                    If (LEqual (Local0, 0x07))
                    {
                        Store (0xFED03000, M2MN)
                        Store (0xFED033FF, M2MX)
                    }
                }

                Return (BUF0)
            }

            Name (_PRT, Package (0x0F)
            {
                Package (0x04)
                {
                    0xFFFF, 
                    0x00, 
                    \_SB.PCI0.LPC0.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x01, 
                    \_SB.PCI0.LPC0.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x02, 
                    \_SB.PCI0.LPC0.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0xFFFF, 
                    0x03, 
                    \_SB.PCI0.LPC0.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x0001FFFF, 
                    0x00, 
                    \_SB.PCI0.LPC0.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    0x00, 
                    \_SB.PCI0.LPC0.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    0x01, 
                    \_SB.PCI0.LPC0.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    0x02, 
                    \_SB.PCI0.LPC0.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x001DFFFF, 
                    0x03, 
                    \_SB.PCI0.LPC0.LNKH, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x001EFFFF, 
                    0x00, 
                    \_SB.PCI0.LPC0.LNKA, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x001EFFFF, 
                    0x01, 
                    \_SB.PCI0.LPC0.LNKB, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x001EFFFF, 
                    0x02, 
                    \_SB.PCI0.LPC0.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x001EFFFF, 
                    0x03, 
                    \_SB.PCI0.LPC0.LNKD, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x001FFFFF, 
                    0x00, 
                    \_SB.PCI0.LPC0.LNKC, 
                    0x00
                }, 

                Package (0x04)
                {
                    0x001FFFFF, 
                    0x01, 
                    \_SB.PCI0.LPC0.LNKB, 
                    0x00
                }
            })
            Device (AGP)
            {
                Name (_ADR, 0x00010000)
                Name (_PRT, Package (0x01)
                {
                    Package (0x04)
                    {
                        0xFFFF, 
                        0x00, 
                        \_SB.PCI0.LPC0.LNKA, 
                        0x00
                    }
                })
                Device (VGA)
                {
                    Name (_ADR, 0x00)
                    Name (SWIT, 0x01)
                    Name (CRTA, 0x01)
                    Name (LCDA, 0x01)
                    Name (TV0A, 0x01)
                    Name (TOGF, 0x02)
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }

                    Name (_PSC, 0x00)
                    Name (USBF, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        Store (0x00, _PSC)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store (0x03, _PSC)
                    }

                    Method (_DOS, 1, NotSerialized)
                    {
                        Store (And (Arg0, 0x03), SWIT)
                    }

                    Method (_DOD, 0, NotSerialized)
                    {
                        Return (Package (0x03)
                        {
                            0x00010100, 
                            0x00010110, 
                            0x00010200
                        })
                    }

                    Device (CRT)
                    {
                        Name (_ADR, 0x0100)
                        Method (_DCS, 0, NotSerialized)
                        {
                            If (CRTA)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            If (CRTA)
                            {
                                Return (0x01)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            Store ("CRT --_DSS", Debug)
                        }
                    }

                    Device (TV0)
                    {
                        Name (_ADR, 0x0200)
                        Method (_DCS, 0, NotSerialized)
                        {
                            If (TV0A)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            If (TV0A)
                            {
                                Return (0x01)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            Store ("TV --_DSS", Debug)
                        }
                    }

                    Device (LCD)
                    {
                        Name (_ADR, 0x0110)
                        Method (_DCS, 0, NotSerialized)
                        {
                            If (LCDA)
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x1D)
                            }
                        }

                        Method (_DGS, 0, NotSerialized)
                        {
                            Store (LCDA, Local0)
                            If (LCDA)
                            {
                                Return (0x01)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_DSS, 1, NotSerialized)
                        {
                            Store ("LCD --_DSS", Debug)
                        }
                    }

                    Method (SWIH, 0, NotSerialized)
                    {
                        Store (0x03, Local0)
                        If (LEqual (Local0, 0x03))
                        {
                            Increment (TOGF)
                            Store (TOGF, Local1)
                            If (LEqual (Local1, 0x01))
                            {
                                Store (One, LCDA)
                                Store (Zero, CRTA)
                                Store (Zero, TV0A)
                            }
                            Else
                            {
                                If (LEqual (Local1, 0x02))
                                {
                                    Store (Zero, LCDA)
                                    Store (One, CRTA)
                                    Store (Zero, TV0A)
                                }
                                Else
                                {
                                    If (LEqual (Local1, 0x03))
                                    {
                                        Store (One, LCDA)
                                        Store (One, CRTA)
                                        Store (Zero, TV0A)
                                    }
                                    Else
                                    {
                                        Store (One, TOGF)
                                        Store (One, LCDA)
                                        Store (Zero, CRTA)
                                        Store (Zero, TV0A)
                                    }
                                }
                            }
                        }
                        Else
                        {
                            If (LEqual (Local0, 0x05))
                            {
                                Increment (TOGF)
                                Store (TOGF, Local1)
                                If (LEqual (Local1, 0x01))
                                {
                                    Store (One, LCDA)
                                    Store (Zero, CRTA)
                                    Store (Zero, TV0A)
                                }
                                Else
                                {
                                    Store (Zero, TOGF)
                                    Store (Zero, LCDA)
                                    Store (Zero, CRTA)
                                    Store (One, TV0A)
                                    Store (Zero, TV0A)
                                }
                            }
                            Else
                            {
                                If (LEqual (Local0, 0x07))
                                {
                                    Increment (TOGF)
                                    Store (TOGF, Local1)
                                    If (LEqual (Local1, 0x01))
                                    {
                                        Store (0x01, LCDA)
                                        Store (0x00, CRTA)
                                        Store (0x00, TV0A)
                                    }
                                    Else
                                    {
                                        If (LEqual (Local1, 0x02))
                                        {
                                            Store (0x00, LCDA)
                                            Store (0x01, CRTA)
                                            Store (0x00, TV0A)
                                        }
                                        Else
                                        {
                                            If (LEqual (Local1, 0x03))
                                            {
                                                Store (0x01, LCDA)
                                                Store (0x01, CRTA)
                                                Store (0x00, TV0A)
                                            }
                                            Else
                                            {
                                                Store (0x00, TOGF)
                                                Store (0x00, LCDA)
                                                Store (0x00, CRTA)
                                                Store (0x01, TV0A)
                                                Store (0x00, TV0A)
                                            }
                                        }
                                    }
                                }
                                Else
                                {
                                    Store (0x01, TOGF)
                                    Store (0x01, LCDA)
                                    Store (0x00, CRTA)
                                    Store (0x00, TV0A)
                                }
                            }
                        }

                        Notify (\_SB.PCI0.AGP.VGA, 0x80)
                    }

                    Method (GETD, 0, NotSerialized)
                    {
                        Store (0x98, \_SB.PCI0.LPC0.BCMD)
                        Store (0x00, \_SB.PCI0.LPC0.SMIC)
                        Store (\_SB.DISD, Local0)
                        If (LEqual (Local0, 0x01))
                        {
                            Store (0x01, TOGF)
                        }

                        If (LEqual (Local0, 0x02))
                        {
                            Store (0x02, TOGF)
                        }

                        If (LEqual (Local0, 0x03))
                        {
                            Store (0x03, TOGF)
                        }

                        If (LEqual (Local0, 0x04))
                        {
                            Store (0x00, TOGF)
                        }
                    }
                }
            }

            Device (LPC0)
            {
                Name (_ADR, 0x001F0000)
                Method (DECD, 4, NotSerialized)
                {
                    Store (Arg0, Debug)
                }

                OperationRegion (REGS, PCI_Config, 0x40, 0xC0)
                Field (REGS, DWordAcc, NoLock, Preserve)
                {
                    PMBA,   16, 
                    Offset (0x18), 
                    GPBA,   16, 
                    Offset (0x90), 
                    POSD,   1, 
                    Offset (0x91), 
                    MTSE,   16, 
                    Offset (0x94), 
                    Offset (0xA0), 
                    CMAD,   3, 
                        ,   1, 
                    CMBD,   3, 
                    Offset (0xA1), 
                    LPTD,   2, 
                        ,   2, 
                    FDDD,   1, 
                    Offset (0xA6), 
                    ECO1,   1, 
                    ECO2,   1, 
                    ELPT,   1, 
                    EFDD,   1
                }

                OperationRegion (PIRX, PCI_Config, 0x60, 0x0C)
                Field (PIRX, DWordAcc, NoLock, Preserve)
                {
                    AccessAs (ByteAcc, 0x00), 
                    PIRA,   8, 
                    PIRB,   8, 
                    PIRC,   8, 
                    PIRD,   8, 
                    Offset (0x08), 
                    PIRE,   8, 
                    PIRF,   8, 
                    PIRG,   8, 
                    PIRH,   8
                }

                Device (MBRD)
                {
                    Name (_HID, EisaId ("PNP0C02"))
                    Name (_UID, 0x1F)
                    Name (RSRC, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0010, 0x0010, 0x01, 0x10)
                        IO (Decode16, 0x0024, 0x0024, 0x01, 0x02)
                        IO (Decode16, 0x0028, 0x0028, 0x01, 0x02)
                        IO (Decode16, 0x002C, 0x002C, 0x01, 0x02)
                        IO (Decode16, 0x0030, 0x0030, 0x01, 0x02)
                        IO (Decode16, 0x0034, 0x0034, 0x01, 0x02)
                        IO (Decode16, 0x0038, 0x0038, 0x01, 0x02)
                        IO (Decode16, 0x003C, 0x003C, 0x01, 0x02)
                        IO (Decode16, 0x0050, 0x0050, 0x01, 0x04)
                        IO (Decode16, 0x0072, 0x0072, 0x01, 0x06)
                        IO (Decode16, 0x0080, 0x0080, 0x01, 0x01)
                        IO (Decode16, 0x0090, 0x0090, 0x01, 0x10)
                        IO (Decode16, 0x00A4, 0x00A4, 0x01, 0x02)
                        IO (Decode16, 0x00A8, 0x00A8, 0x01, 0x02)
                        IO (Decode16, 0x00AC, 0x00AC, 0x01, 0x02)
                        IO (Decode16, 0x00B0, 0x00B0, 0x01, 0x06)
                        IO (Decode16, 0x00B8, 0x00B8, 0x01, 0x02)
                        IO (Decode16, 0x00BC, 0x00BC, 0x01, 0x02)
                        IO (Decode16, 0x1000, 0x1000, 0x01, 0x80)
                        IO (Decode16, 0x1180, 0x1180, 0x01, 0x40)
                        IO (Decode16, 0x01C0, 0x01C0, 0x01, 0x10)
                        IO (Decode16, 0x002E, 0x002E, 0x01, 0x02)
                        IO (Decode16, 0x004E, 0x004E, 0x01, 0x02)
                        IO (Decode16, 0x0068, 0x0068, 0x01, 0x01)
                        IO (Decode16, 0x006C, 0x006C, 0x01, 0x01)
                        IO (Decode16, 0xFE00, 0xFE00, 0x00, 0x01)
                        IO (Decode16, 0x04D0, 0x04D0, 0x01, 0x02)
                        IO (Decode16, 0x0600, 0x0600, 0x01, 0x10)
                        IO (Decode16, 0x0610, 0x0610, 0x01, 0x10)
                        IO (Decode16, 0x0068, 0x0068, 0x01, 0x01)
                        IO (Decode16, 0x006C, 0x006C, 0x01, 0x01)
                        Memory32Fixed (ReadOnly, 0xFF800000, 0x00400000)
                        Memory32Fixed (ReadOnly, 0xFFF00000, 0x00100000)
                        Memory32Fixed (ReadWrite, 0x00000000, 0x000A0000)
                        Memory32Fixed (ReadOnly, 0x000E0000, 0x00020000)
                        Memory32Fixed (ReadWrite, 0x00100000, 0x00000000)
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (RSRC, 0x92, PMMN)
                        CreateWordField (RSRC, 0x94, PMMX)
                        And (^^PMBA, 0xFF80, PMMN)
                        Store (PMMN, PMMX)
                        CreateWordField (RSRC, 0x9A, GPMN)
                        CreateWordField (RSRC, 0x9C, GPMX)
                        And (^^GPBA, 0xFF80, GPMN)
                        Store (GPMN, GPMX)
                        CreateDWordField (RSRC, 0x0130, TMEM)
                        Store (\_SB.PCI0.DRB3, TMEM)
                        ShiftLeft (TMEM, 0x19, TMEM)
                        Subtract (TMEM, 0x00100000, TMEM)
                        Return (RSRC)
                    }
                }

                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0000, 0x0000, 0x01, 0x10)
                        IO (Decode16, 0x0081, 0x0081, 0x01, 0x0F)
                        IO (Decode16, 0x00C0, 0x00C0, 0x01, 0x20)
                        DMA (Compatibility, NotBusMaster, Transfer16) {4}
                    })
                }

                Device (MATH)
                {
                    Name (_HID, EisaId ("PNP0C04"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x00F0, 0x00F0, 0x01, 0x0F)
                        IRQ (Edge, ActiveHigh, Exclusive) {13}
                    })
                }

                Device (PIC)
                {
                    Name (_HID, EisaId ("PNP0000"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0020, 0x0020, 0x01, 0x02)
                        IO (Decode16, 0x00A0, 0x00A0, 0x01, 0x02)
                        IRQ (Edge, ActiveHigh, Exclusive) {2}
                    })
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0070, 0x0070, 0x01, 0x02)
                        IRQ (Edge, ActiveHigh, Exclusive) {8}
                    })
                }

                Device (SPKR)
                {
                    Name (_HID, EisaId ("PNP0800"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0061, 0x0061, 0x01, 0x01)
                    })
                }

                Device (TIME)
                {
                    Name (_HID, EisaId ("PNP0100"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0040, 0x0040, 0x01, 0x04)
                        IRQ (Edge, ActiveHigh, Exclusive) {0}
                    })
                }

                Device (LNKA)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x01)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {10}
                    })
                    Name (RSRC, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {}
                    })
                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (PIRA, 0x80, PIRA)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (RSRC, 0x01, IRQ0)
                        And (PIRA, 0x0F, Local0)
                        ShiftLeft (0x01, Local0, IRQ0)
                        Return (RSRC)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (PIRA, 0x70), PIRA)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (PIRA, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKB)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x02)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {10}
                    })
                    Name (RSRC, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {}
                    })
                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (PIRB, 0x80, PIRB)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (RSRC, 0x01, IRQ0)
                        And (PIRB, 0x0F, Local0)
                        ShiftLeft (0x01, Local0, IRQ0)
                        Return (RSRC)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (PIRB, 0x70), PIRB)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (PIRB, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKC)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x03)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {10}
                    })
                    Name (RSRC, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {}
                    })
                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (PIRC, 0x80, PIRC)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (RSRC, 0x01, IRQ0)
                        And (PIRC, 0x0F, Local0)
                        ShiftLeft (0x01, Local0, IRQ0)
                        Return (RSRC)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (PIRC, 0x70), PIRC)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (PIRC, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKD)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x04)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {5}
                    })
                    Name (RSRC, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {}
                    })
                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (PIRD, 0x80, PIRD)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (RSRC, 0x01, IRQ0)
                        And (PIRD, 0x0F, Local0)
                        ShiftLeft (0x01, Local0, IRQ0)
                        Return (RSRC)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (PIRD, 0x70), PIRD)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (PIRD, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKE)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x05)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {10}
                    })
                    Name (RSRC, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {}
                    })
                    Name (INES, 0x00)
                    Method (_DIS, 0, NotSerialized)
                    {
                        If (Or (LEqual (\_SB.PCI0.MYOS, 0x00), LEqual (\_SB.PCI0.MYOS, 0x02)))
                        {
                            Or (PIRE, 0x80, PIRE)
                        }
                        Else
                        {
                            Or (PIRE, 0x80, PIRE)
                        }
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (RSRC, 0x01, IRQ0)
                        And (PIRE, 0x0F, Local0)
                        ShiftLeft (0x01, Local0, IRQ0)
                        Return (RSRC)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (PIRE, 0x70), PIRE)
                        Store (PIRE, INES)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (Or (LEqual (\_SB.PCI0.MYOS, 0x00), LEqual (\_SB.PCI0.MYOS, 0x02)))
                        {
                            If (And (PIRE, 0x80))
                            {
                                Return (0x09)
                            }
                        }
                        Else
                        {
                            If (And (PIRE, 0x80))
                            {
                                Return (0x09)
                            }
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKF)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x06)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {3,4,5,7,9,11,12}
                    })
                    Name (RSRC, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {}
                    })
                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (PIRF, 0x80, PIRF)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (RSRC, 0x01, IRQ0)
                        And (PIRF, 0x0F, Local0)
                        ShiftLeft (0x01, Local0, IRQ0)
                        Return (RSRC)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (PIRF, 0x70), PIRF)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (PIRF, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKG)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x07)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {10}
                    })
                    Name (RSRC, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {}
                    })
                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (PIRG, 0x80, PIRG)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (RSRC, 0x01, IRQ0)
                        And (PIRG, 0x0F, Local0)
                        ShiftLeft (0x01, Local0, IRQ0)
                        Return (RSRC)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (PIRG, 0x70), PIRG)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (PIRG, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                Device (LNKH)
                {
                    Name (_HID, EisaId ("PNP0C0F"))
                    Name (_UID, 0x08)
                    Name (_PRS, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {10}
                    })
                    Name (RSRC, ResourceTemplate ()
                    {
                        IRQ (Level, ActiveLow, Shared) {}
                    })
                    Method (_DIS, 0, NotSerialized)
                    {
                        Or (PIRH, 0x80, PIRH)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        CreateWordField (RSRC, 0x01, IRQ0)
                        And (PIRH, 0x0F, Local0)
                        ShiftLeft (0x01, Local0, IRQ0)
                        Return (RSRC)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateWordField (Arg0, 0x01, IRQ0)
                        FindSetRightBit (IRQ0, Local0)
                        Decrement (Local0)
                        Or (Local0, And (PIRH, 0x70), PIRH)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        If (And (PIRH, 0x80))
                        {
                            Return (0x09)
                        }

                        Return (0x0B)
                    }
                }

                OperationRegion (GPOX, SystemIO, 0x1180, 0x40)
                Field (GPOX, DWordAcc, Lock, Preserve)
                {
                    Offset (0x07), 
                        ,   1, 
                    IO25,   1, 
                        ,   1, 
                    IO27,   1, 
                    Offset (0x0E), 
                    LV16,   1, 
                    LV17,   1, 
                    Offset (0x0F), 
                        ,   1, 
                    LV25,   1, 
                        ,   1, 
                    LV27,   1, 
                    Offset (0x1B), 
                        ,   1, 
                    BL25,   1, 
                        ,   1, 
                    BL27,   1, 
                    Offset (0x38), 
                    RBID,   2, 
                    LV34,   1, 
                    LV35,   1, 
                    LV36,   1, 
                    LV37,   1, 
                    LV38,   1, 
                    LV39,   1
                }

                OperationRegion (PMIO, SystemIO, 0x1000, 0x51)
                Field (PMIO, WordAcc, Lock, Preserve)
                {
                    AccessAs (DWordAcc, 0x00), 
                    Offset (0x29), 
                        ,   3, 
                    PMES,   1, 
                    Offset (0x2B), 
                        ,   3, 
                    PMEE,   1, 
                    Offset (0x2C), 
                    GPI0,   1, 
                    GPI1,   1, 
                    GPI2,   1, 
                    GPI3,   1, 
                    GPI4,   1, 
                    GPI5,   1, 
                    GPI6,   1, 
                    GPI7,   1, 
                    GPI8,   1, 
                    GPI9,   1, 
                    GPIA,   1, 
                    GPIB,   1, 
                    GPIC,   1, 
                    GPID,   1, 
                    GPIE,   1, 
                    GPIF,   1, 
                        ,   6, 
                    GPEE,   1
                }

                Device (KBC)
                {
                    Name (_HID, EisaId ("PNP0303"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0060, 0x0060, 0x01, 0x01)
                        IO (Decode16, 0x0064, 0x0064, 0x01, 0x01)
                        IRQNoFlags () {1}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }
                }

                Device (MOUE)
                {
                    Name (_HID, EisaId ("IBM3780"))
                    Name (_CID, 0x130FD041)
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQNoFlags () {12}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (SizeOf (\_OS), 0x14))
                        {
                            Return (0x00)
                        }
                        Else
                        {
                            If (\_SB.PS2M)
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }
                    }
                }

                Device (MOU2)
                {
                    Name (_HID, EisaId ("PNP0F13"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IRQNoFlags () {12}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        If (LEqual (SizeOf (\_OS), 0x14))
                        {
                            If (\_SB.PS2M)
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }
                        Else
                        {
                            Return (0x00)
                        }
                    }
                }

                Device (SIO)
                {
                    Name (_HID, EisaId ("PNP0A05"))
                    OperationRegion (SIIO, SystemIO, 0x4E, 0x02)
                    Field (SIIO, ByteAcc, NoLock, Preserve)
                    {
                        INDX,   8, 
                        DATA,   8
                    }

                    Mutex (N393, 0x00)
                    Method (SETD, 1, Serialized)
                    {
                        Store (0x07, INDX)
                        Store (Arg0, DATA)
                    }

                    Method (READ, 1, Serialized)
                    {
                        Store (Arg0, INDX)
                        Store (DATA, Local0)
                        Return (Local0)
                    }

                    Method (WRIT, 2, Serialized)
                    {
                        Store (Arg0, INDX)
                        Store (Arg1, DATA)
                    }

                    Method (LDRS, 3, NotSerialized)
                    {
                        Acquire (N393, 0xFFFF)
                        Store (0x07, INDX)
                        Store (Arg0, DATA)
                        Store (Arg1, INDX)
                        Store (Arg2, DATA)
                        Release (N393)
                    }

                    Method (LDRG, 2, NotSerialized)
                    {
                        Acquire (N393, 0xFFFF)
                        Store (0x07, INDX)
                        Store (Arg0, DATA)
                        Store (Arg1, INDX)
                        Store (DATA, Local0)
                        Release (N393)
                        Return (Local0)
                    }

                    Method (RCF6, 1, NotSerialized)
                    {
                        Acquire (N393, 0xFFFF)
                        Store (0x26, INDX)
                        Store (DATA, Local0)
                        And (Local0, Arg0, Local0)
                        Release (N393)
                        Return (XOr (Local0, Arg0))
                    }

                    Method (PDRS, 2, NotSerialized)
                    {
                        If (\_SB.PCI0.LPC0.POSD)
                        {
                            If (LEqual (Arg0, 0x00))
                            {
                                If (LEqual (Arg1, 0x03F0))
                                {
                                    Store (0x00, Local0)
                                }
                                Else
                                {
                                    If (LEqual (Arg1, 0x0370))
                                    {
                                        Store (0x01, Local0)
                                    }
                                }

                                Store (Local0, \_SB.PCI0.LPC0.FDDD)
                            }
                            Else
                            {
                                If (LEqual (Arg0, 0x01))
                                {
                                    If (LEqual (Arg1, 0x0378))
                                    {
                                        Store (0x00, Local0)
                                    }
                                    Else
                                    {
                                        If (LEqual (Arg1, 0x0278))
                                        {
                                            Store (0x01, Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (Arg1, 0x03BC))
                                            {
                                                Store (0x02, Local0)
                                            }
                                        }
                                    }

                                    Store (Local0, \_SB.PCI0.LPC0.LPTD)
                                }
                                Else
                                {
                                    If (LEqual (Arg1, 0x03F8))
                                    {
                                        Store (0x00, Local0)
                                    }
                                    Else
                                    {
                                        If (LEqual (Arg1, 0x02F8))
                                        {
                                            Store (0x01, Local0)
                                        }
                                        Else
                                        {
                                            If (LEqual (Arg1, 0x0220))
                                            {
                                                Store (0x02, Local0)
                                            }
                                            Else
                                            {
                                                If (LEqual (Arg1, 0x0228))
                                                {
                                                    Store (0x03, Local0)
                                                }
                                                Else
                                                {
                                                    If (LEqual (Arg1, 0x0238))
                                                    {
                                                        Store (0x04, Local0)
                                                    }
                                                    Else
                                                    {
                                                        If (LEqual (Arg1, 0x02E8))
                                                        {
                                                            Store (0x05, Local0)
                                                        }
                                                        Else
                                                        {
                                                            If (LEqual (Arg1, 0x0338))
                                                            {
                                                                Store (0x06, Local0)
                                                            }
                                                            Else
                                                            {
                                                                If (LEqual (Arg1, 0x03E8))
                                                                {
                                                                    Store (0x07, Local0)
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    If (LEqual (Arg0, 0x02))
                                    {
                                        Store (Local0, \_SB.PCI0.LPC0.CMBD)
                                    }
                                    Else
                                    {
                                        If (LEqual (Arg0, 0x03))
                                        {
                                            Store (Local0, \_SB.PCI0.LPC0.CMAD)
                                        }
                                    }
                                }
                            }

                            Return (0x01)
                        }
                        Else
                        {
                            Return (0x00)
                        }
                    }

                    Device (ECP)
                    {
                        Name (_HID, EisaId ("PNP0401"))
                        Name (_UID, 0x03)
                        Method (_STA, 0, NotSerialized)
                        {
                            Store (LDRG (0x01, 0xF0), Local0)
                            ShiftRight (Local0, 0x05, Local0)
                            If (LAnd (RCF6 (0x02), LOr (LEqual (Local0, 0x04), LEqual (Local0, 0x07))))
                            {
                                ShiftLeft (LDRG (0x01, 0x30), 0x01, Local1)
                                Add (0x0D, Local1, Local1)
                                Return (Local1)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_PS0, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x01)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x00)
                        }

                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (ResourceTemplate ()
                            {
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                EndDependentFn ()
                            })
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x00)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (DCRS, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                IRQNoFlags () {7}
                                DMA (Compatibility, NotBusMaster, Transfer8) {3}
                            })
                            Store (LDRG (0x01, 0x60), Local1)
                            Store (LDRG (0x01, 0x61), Local0)
                            Store (Local0, Index (DCRS, 0x02))
                            Store (Local0, Index (DCRS, 0x0A))
                            Store (Local0, Index (DCRS, 0x04))
                            Store (Local0, Index (DCRS, 0x0C))
                            Store (Local1, Index (DCRS, 0x03))
                            Store (Local1, Index (DCRS, 0x05))
                            Add (Local1, 0x04, Local1)
                            Store (Local1, Index (DCRS, 0x0B))
                            Store (Local1, Index (DCRS, 0x0D))
                            ShiftLeft (0x01, LDRG (0x01, 0x70), Local0)
                            Store (Local0, Index (DCRS, 0x11))
                            ShiftRight (Local0, 0x08, Local1)
                            Store (Local1, Index (DCRS, 0x12))
                            ShiftLeft (0x01, LDRG (0x01, 0x74), Local0)
                            Store (Local0, Index (DCRS, 0x14))
                            ShiftRight (Local0, 0x08, Local1)
                            Store (Local1, Index (DCRS, 0x15))
                            Return (DCRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, ADRL)
                            CreateByteField (Arg0, 0x03, ADRM)
                            CreateWordField (Arg0, 0x11, IRQM)
                            CreateWordField (Arg0, 0x14, DMAM)
                            FindSetRightBit (IRQM, Local0)
                            Decrement (Local0)
                            FindSetRightBit (DMAM, Local1)
                            Decrement (Local1)
                            LDRS (0x01, 0x70, Local0)
                            LDRS (0x01, 0x74, Local1)
                            LDRS (0x01, 0x60, ADRM)
                            LDRS (0x01, 0x61, ADRL)
                            LDRS (0x01, 0x30, 0x01)
                        }
                    }

                    Device (EPP)
                    {
                        Name (_HID, EisaId ("PNP0400"))
                        Name (_UID, 0x02)
                        Method (_STA, 0, NotSerialized)
                        {
                            Store (LDRG (0x01, 0xF0), Local0)
                            ShiftRight (Local0, 0x05, Local0)
                            If (LAnd (RCF6 (0x02), LOr (LEqual (Local0, 0x02), LEqual (Local0, 0x03))))
                            {
                                ShiftLeft (LDRG (0x01, 0x30), 0x01, Local1)
                                Add (0x0D, Local1, Local1)
                                Return (Local1)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_PS0, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x01)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x00)
                        }

                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (ResourceTemplate ()
                            {
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0178, 0x0178, 0x08, 0x08)
                                    IO (Decode16, 0x0578, 0x0578, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0178, 0x0178, 0x08, 0x08)
                                    IO (Decode16, 0x0578, 0x0578, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                }
                                EndDependentFn ()
                            })
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x00)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (DCRS, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                IRQNoFlags () {7}
                            })
                            Store (LDRG (0x01, 0x60), Local1)
                            Store (LDRG (0x01, 0x61), Local0)
                            Store (Local0, Index (DCRS, 0x02))
                            Store (Local0, Index (DCRS, 0x0A))
                            Store (Local0, Index (DCRS, 0x04))
                            Store (Local0, Index (DCRS, 0x0C))
                            Store (Local1, Index (DCRS, 0x03))
                            Store (Local1, Index (DCRS, 0x05))
                            Add (Local1, 0x04, Local1)
                            Store (Local1, Index (DCRS, 0x0B))
                            Store (Local1, Index (DCRS, 0x0D))
                            ShiftLeft (0x01, LDRG (0x01, 0x70), Local0)
                            Store (Local0, Index (DCRS, 0x11))
                            ShiftRight (Local0, 0x08, Local1)
                            Store (Local1, Index (DCRS, 0x12))
                            Return (DCRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, ADRL)
                            CreateByteField (Arg0, 0x03, ADRM)
                            CreateWordField (Arg0, 0x11, IRQM)
                            FindSetRightBit (IRQM, Local0)
                            Decrement (Local0)
                            LDRS (0x01, 0x70, Local0)
                            LDRS (0x01, 0x60, ADRM)
                            LDRS (0x01, 0x61, ADRL)
                            LDRS (0x01, 0x30, 0x01)
                        }
                    }

                    Device (LPTB)
                    {
                        Name (_HID, EisaId ("PNP0400"))
                        Name (_UID, 0x01)
                        Method (_STA, 0, NotSerialized)
                        {
                            Store (LDRG (0x01, 0xF0), Local0)
                            ShiftRight (Local0, 0x05, Local0)
                            If (LAnd (RCF6 (0x02), LEqual (Local0, 0x01)))
                            {
                                ShiftLeft (LDRG (0x01, 0x30), 0x01, Local1)
                                Add (0x0D, Local1, Local1)
                                Return (Local1)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_PS0, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x01)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x00)
                        }

                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (ResourceTemplate ()
                            {
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03BC, 0x03BC, 0x04, 0x04)
                                    IO (Decode16, 0x07BC, 0x07BC, 0x04, 0x04)
                                    IRQNoFlags () {7}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03BC, 0x03BC, 0x04, 0x04)
                                    IO (Decode16, 0x07BC, 0x07BC, 0x04, 0x04)
                                    IRQNoFlags () {5}
                                }
                                EndDependentFn ()
                            })
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x00)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (DCRS, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                IRQNoFlags () {7}
                            })
                            Store (LDRG (0x01, 0x60), Local1)
                            Store (LDRG (0x01, 0x61), Local0)
                            Store (Local0, Index (DCRS, 0x02))
                            Store (Local0, Index (DCRS, 0x0A))
                            Store (Local0, Index (DCRS, 0x04))
                            Store (Local0, Index (DCRS, 0x0C))
                            Store (Local1, Index (DCRS, 0x03))
                            Store (Local1, Index (DCRS, 0x05))
                            Add (Local1, 0x04, Local1)
                            Store (Local1, Index (DCRS, 0x0B))
                            Store (Local1, Index (DCRS, 0x0D))
                            If (And (Local0, 0x04))
                            {
                                Store (0x04, Local0)
                            }
                            Else
                            {
                                Store (0x08, Local0)
                            }

                            Store (Local0, Index (DCRS, 0x06))
                            Store (Local0, Index (DCRS, 0x07))
                            Store (Local0, Index (DCRS, 0x0E))
                            Store (Local0, Index (DCRS, 0x0F))
                            ShiftLeft (0x01, LDRG (0x01, 0x70), Local0)
                            Store (Local0, Index (DCRS, 0x11))
                            ShiftRight (Local0, 0x08, Local1)
                            Store (Local1, Index (DCRS, 0x12))
                            Return (DCRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, ADRL)
                            CreateByteField (Arg0, 0x03, ADRM)
                            CreateWordField (Arg0, 0x11, IRQM)
                            FindSetRightBit (IRQM, Local0)
                            Decrement (Local0)
                            LDRS (0x01, 0x70, Local0)
                            LDRS (0x01, 0x60, ADRM)
                            LDRS (0x01, 0x61, ADRL)
                            LDRS (0x01, 0x30, 0x01)
                        }
                    }

                    Device (LPT)
                    {
                        Name (_HID, EisaId ("PNP0400"))
                        Name (_UID, 0x00)
                        Method (_STA, 0, NotSerialized)
                        {
                            Store (LDRG (0x01, 0xF0), Local0)
                            ShiftRight (Local0, 0x05, Local0)
                            If (LAnd (RCF6 (0x02), LEqual (Local0, 0x00)))
                            {
                                ShiftLeft (LDRG (0x01, 0x30), 0x01, Local1)
                                Add (0x0D, Local1, Local1)
                                Return (Local1)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_PS0, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x01)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x00)
                        }

                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (ResourceTemplate ()
                            {
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                    IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                    IRQNoFlags () {5}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x0278, 0x0278, 0x08, 0x08)
                                    IO (Decode16, 0x0678, 0x0678, 0x08, 0x08)
                                    IRQNoFlags () {7}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03BC, 0x03BC, 0x04, 0x04)
                                    IO (Decode16, 0x07BC, 0x07BC, 0x04, 0x04)
                                    IRQNoFlags () {7}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03BC, 0x03BC, 0x04, 0x04)
                                    IO (Decode16, 0x07BC, 0x07BC, 0x04, 0x04)
                                    IRQNoFlags () {5}
                                }
                                EndDependentFn ()
                            })
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            LDRS (0x01, 0x30, 0x00)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (DCRS, ResourceTemplate ()
                            {
                                IO (Decode16, 0x0378, 0x0378, 0x08, 0x08)
                                IO (Decode16, 0x0778, 0x0778, 0x08, 0x08)
                                IRQNoFlags () {7}
                            })
                            Store (LDRG (0x01, 0x60), Local1)
                            Store (LDRG (0x01, 0x61), Local0)
                            Store (Local0, Index (DCRS, 0x02))
                            Store (Local0, Index (DCRS, 0x0A))
                            Store (Local0, Index (DCRS, 0x04))
                            Store (Local0, Index (DCRS, 0x0C))
                            Store (Local1, Index (DCRS, 0x03))
                            Store (Local1, Index (DCRS, 0x05))
                            Add (Local1, 0x04, Local1)
                            Store (Local1, Index (DCRS, 0x0B))
                            Store (Local1, Index (DCRS, 0x0D))
                            If (And (Local0, 0x04))
                            {
                                Store (0x04, Local0)
                            }
                            Else
                            {
                                Store (0x08, Local0)
                            }

                            Store (Local0, Index (DCRS, 0x06))
                            Store (Local0, Index (DCRS, 0x07))
                            Store (Local0, Index (DCRS, 0x0E))
                            Store (Local0, Index (DCRS, 0x0F))
                            ShiftLeft (0x01, LDRG (0x01, 0x70), Local0)
                            Store (Local0, Index (DCRS, 0x11))
                            ShiftRight (Local0, 0x08, Local1)
                            Store (Local1, Index (DCRS, 0x12))
                            Return (DCRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, ADRL)
                            CreateByteField (Arg0, 0x03, ADRM)
                            CreateWordField (Arg0, 0x11, IRQM)
                            FindSetRightBit (IRQM, Local0)
                            Decrement (Local0)
                            LDRS (0x01, 0x70, Local0)
                            LDRS (0x01, 0x60, ADRM)
                            LDRS (0x01, 0x61, ADRL)
                            LDRS (0x01, 0x30, 0x01)
                        }
                    }

                    Device (COMA)
                    {
                        Name (_HID, EisaId ("PNP0501"))
                        Name (_UID, 0x00)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (RCF6 (0x08))
                            {
                                ShiftLeft (LDRG (0x03, 0x30), 0x01, Local1)
                                Add (0x0D, Local1, Local1)
                                Return (Local1)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_PS0, 0, NotSerialized)
                        {
                            LDRS (0x03, 0x30, 0x01)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            LDRS (0x03, 0x30, 0x00)
                        }

                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (ResourceTemplate ()
                            {
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                }
                                EndDependentFn ()
                            })
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            LDRS (0x03, 0x30, 0x00)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (DCRS, ResourceTemplate ()
                            {
                                IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                IRQNoFlags () {4}
                            })
                            Store (LDRG (0x03, 0x60), Local1)
                            Store (LDRG (0x03, 0x61), Local0)
                            Store (Local0, Index (DCRS, 0x02))
                            Store (Local0, Index (DCRS, 0x04))
                            Store (Local1, Index (DCRS, 0x03))
                            Store (Local1, Index (DCRS, 0x05))
                            ShiftLeft (0x01, LDRG (0x03, 0x70), Local0)
                            Store (Local0, Index (DCRS, 0x09))
                            ShiftRight (Local0, 0x08, Local1)
                            Store (Local1, Index (DCRS, 0x0A))
                            Return (DCRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            CreateByteField (Arg0, 0x02, ADRL)
                            CreateByteField (Arg0, 0x03, ADRM)
                            CreateWordField (Arg0, 0x09, IRQM)
                            FindSetRightBit (IRQM, Local0)
                            Decrement (Local0)
                            LDRS (0x03, 0x70, Local0)
                            LDRS (0x03, 0x60, ADRM)
                            LDRS (0x03, 0x61, ADRL)
                            LDRS (0x03, 0x30, 0x01)
                        }
                    }

                    Device (FIR)
                    {
                        Method (_HID, 0, NotSerialized)
                        {
                            If (LOr (LEqual (MYOS, 0x01), LEqual (MYOS, 0x03)))
                            {
                                Return (0x0160633A)
                            }
                            Else
                            {
                                Return (0x0160633A)
                            }
                        }

                        Name (_UID, 0x00)
                        Method (_STA, 0, NotSerialized)
                        {
                            Store (LDRG (0x02, 0x74), Local0)
                            If (LAnd (RCF6 (0x04), LNot (LEqual (Local0, 0x04))))
                            {
                                ShiftLeft (LDRG (0x02, 0x30), 0x01, Local1)
                                Add (0x0D, Local1, Local1)
                                Return (Local1)
                            }
                            Else
                            {
                                Return (0x00)
                            }
                        }

                        Method (_PS0, 0, NotSerialized)
                        {
                            LDRS (0x02, 0x30, 0x01)
                        }

                        Method (_PS3, 0, NotSerialized)
                        {
                            LDRS (0x02, 0x30, 0x00)
                        }

                        Method (_PRS, 0, NotSerialized)
                        {
                            Return (ResourceTemplate ()
                            {
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {0}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {0}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {0}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {0}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {0}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {0}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {0}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {0}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {1}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x03E8, 0x03E8, 0x08, 0x08)
                                    IRQNoFlags () {3}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                StartDependentFnNoPri ()
                                {
                                    IO (Decode16, 0x02E8, 0x02E8, 0x08, 0x08)
                                    IRQNoFlags () {4}
                                    DMA (Compatibility, NotBusMaster, Transfer8) {3}
                                }
                                EndDependentFn ()
                            })
                        }

                        Method (_DIS, 0, NotSerialized)
                        {
                            LDRS (0x02, 0x30, 0x00)
                            Store (0x00, \_SB.PCI0.LPC0.ECO1)
                        }

                        Method (_CRS, 0, NotSerialized)
                        {
                            Name (DCRS, ResourceTemplate ()
                            {
                                IO (Decode16, 0x02F8, 0x02F8, 0x08, 0x08)
                                IRQNoFlags () {3}
                                DMA (Compatibility, NotBusMaster, Transfer8) {0}
                            })
                            Store (LDRG (0x02, 0x60), Local1)
                            Store (LDRG (0x02, 0x61), Local0)
                            Store (Local0, Index (DCRS, 0x02))
                            Store (Local0, Index (DCRS, 0x04))
                            Store (Local1, Index (DCRS, 0x03))
                            Store (Local1, Index (DCRS, 0x05))
                            ShiftLeft (0x01, LDRG (0x02, 0x70), Local0)
                            Store (Local0, Index (DCRS, 0x09))
                            ShiftRight (Local0, 0x08, Local1)
                            Store (Local1, Index (DCRS, 0x0A))
                            ShiftLeft (0x01, LDRG (0x02, 0x74), Local0)
                            Store (Local0, Index (DCRS, 0x0C))
                            ShiftRight (Local0, 0x08, Local1)
                            Store (Local1, Index (DCRS, 0x0D))
                            Return (DCRS)
                        }

                        Method (_SRS, 1, NotSerialized)
                        {
                            Store (0x01, \_SB.PCI0.LPC0.ECO1)
                            CreateByteField (Arg0, 0x02, ADRL)
                            CreateByteField (Arg0, 0x03, ADRM)
                            CreateWordField (Arg0, 0x09, IRQM)
                            CreateWordField (Arg0, 0x0C, DMAM)
                            FindSetRightBit (IRQM, Local0)
                            Decrement (Local0)
                            FindSetRightBit (DMAM, Local1)
                            Decrement (Local1)
                            LDRS (0x02, 0x70, Local0)
                            LDRS (0x02, 0x74, Local1)
                            LDRS (0x02, 0x60, ADRM)
                            LDRS (0x02, 0x61, ADRL)
                            PDRS (0x02, Add (ShiftLeft (ADRM, 0x08), ADRL))
                            LDRS (0x02, 0x30, 0x01)
                        }
                    }
                }

                Device (EC0)
                {
                    Name (_HID, EisaId ("PNP0C09"))
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0062, 0x0062, 0x01, 0x01)
                        IO (Decode16, 0x0066, 0x0066, 0x01, 0x01)
                    })
                    Name (_GPE, 0x1D)
                    Name (OSEJ, 0x00)
                    Method (_REG, 2, NotSerialized)
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (Arg1, \_SB.OKEC)
                            If (Or (LEqual (\_SB.PCI0.MYOS, 0x03), LEqual (\_SB.PCI0.MYOS, 0x01)))
                            {
                                If (Arg1)
                                {
                                    Store (0x01, \_SB.PCI0.LPC0.EC0.RG57)
                                }
                            }
                        }
                    }

                    OperationRegion (ERAM, EmbeddedControl, 0x00, 0xFF)
                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x04), 
                        CMCM,   8, 
                        CMD1,   8, 
                        CMD2,   8, 
                        CMD3,   8, 
                        Offset (0x18), 
                        SMPR,   8, 
                        SMST,   8, 
                        SMAD,   8, 
                        SMCM,   8, 
                        SMD0,   256, 
                        BCNT,   8, 
                        SMAA,   8, 
                        BATD,   16, 
                        ACDF,   1, 
                        Offset (0x41), 
                            ,   4, 
                        FPR1,   1, 
                        S4LD,   1, 
                        S5LW,   1, 
                        PFLG,   1, 
                        Offset (0x43), 
                        TMSS,   2, 
                            ,   2, 
                        BANK,   4, 
                        Offset (0x45), 
                        VFAN,   1, 
                        Offset (0x46), 
                        RL01,   1, 
                        RD01,   1, 
                        RF01,   1, 
                        RP01,   1, 
                        RB01,   1, 
                        RC01,   1, 
                            ,   1, 
                        R701,   1, 
                        R801,   1, 
                        RM01,   1, 
                        RI01,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        RA01,   1, 
                        RR01,   1, 
                        RL10,   1, 
                        RD10,   1, 
                        RF10,   1, 
                        RP10,   1, 
                        RB10,   1, 
                        RC10,   1, 
                            ,   1, 
                        R710,   1, 
                        R810,   1, 
                        RM10,   1, 
                        RI10,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        RA10,   1, 
                        RR10,   1, 
                        WL01,   1, 
                        WD01,   1, 
                        WF01,   1, 
                        WP01,   1, 
                        WB01,   1, 
                        WC01,   1, 
                            ,   1, 
                        W701,   1, 
                        W801,   1, 
                        WM01,   1, 
                        WI01,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        WA01,   1, 
                        WR01,   1, 
                        WL10,   1, 
                        WD10,   1, 
                        WF10,   1, 
                        WP10,   1, 
                        WB10,   1, 
                        WC10,   1, 
                            ,   1, 
                        W710,   1, 
                        W810,   1, 
                        WM10,   1, 
                        WI10,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        WA10,   1, 
                        WR10,   1, 
                        LIDE,   1, 
                        BAYE,   1, 
                        EFDE,   1, 
                        PRDE,   1, 
                        BRBE,   1, 
                        CRTE,   1, 
                            ,   1, 
                        W7BE,   1, 
                        W8BE,   1, 
                        PMEE,   1, 
                        INTE,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        DB2E,   1, 
                        DB3E,   1, 
                        Offset (0x52), 
                        LIDS,   1, 
                        BAYS,   1, 
                        EFDS,   1, 
                        PRDS,   1, 
                        BRBS,   1, 
                        CRTS,   1, 
                            ,   1, 
                        W7BS,   1, 
                        W8BS,   1, 
                        DPEM,   1, 
                        DINT,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        DB2S,   1, 
                        DB3S,   1, 
                        Offset (0x57), 
                        RG57,   8, 
                        CTMP,   8, 
                        RG59,   8, 
                        RG5A,   8, 
                        RG5B,   8, 
                        FSPD,   16, 
                        Offset (0x5F), 
                        FAN2,   1, 
                        SFN2,   1, 
                        Offset (0x60), 
                            ,   1, 
                        FANC,   1, 
                        Offset (0x70), 
                        MBID,   8, 
                        MBTS,   1, 
                        MBTF,   1, 
                        Offset (0x72), 
                        MBTC,   1, 
                        Offset (0x77), 
                        BA1C,   8, 
                        MBVG,   16, 
                        MCUR,   16, 
                        Offset (0x80), 
                        SBID,   8, 
                        SBTS,   1, 
                        SBTF,   1, 
                        Offset (0x82), 
                        SBTC,   1, 
                        Offset (0x87), 
                        BA2C,   8, 
                        ABVG,   16, 
                        ACUR,   16, 
                        Offset (0xC3), 
                        MBRM,   16, 
                        Offset (0xCA), 
                        ABRM,   16, 
                        Offset (0xD0), 
                        EBPL,   1, 
                        Offset (0xD2), 
                            ,   6, 
                        APWR,   1, 
                        Offset (0xD6), 
                        DBPL,   8, 
                        Offset (0xE7), 
                        GQKS,   7
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C), 
                        SMW0,   16
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C), 
                        SMB0,   8
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C), 
                        FLD0,   64
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C), 
                        FLD1,   128
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C), 
                        FLD2,   192
                    }

                    Field (ERAM, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x1C), 
                        FLD3,   256
                    }

                    Mutex (MUT0, 0x00)
                    Method (SMRD, 4, NotSerialized)
                    {
                        If (LNot (\_SB.OKEC))
                        {
                            Return (0xFF)
                        }

                        If (LNot (LEqual (Arg0, 0x07)))
                        {
                            If (LNot (LEqual (Arg0, 0x09)))
                            {
                                If (LNot (LEqual (Arg0, 0x0B)))
                                {
                                    Return (0x19)
                                }
                            }
                        }

                        Acquire (MUT0, 0xFFFF)
                        Store (0x04, Local0)
                        While (LGreater (Local0, 0x01))
                        {
                            And (SMST, 0x40, SMST)
                            Store (Arg2, SMCM)
                            Store (Arg1, SMAD)
                            Store (Arg0, SMPR)
                            Store (0x00, Local3)
                            While (LNot (And (SMST, 0xBF, Local1)))
                            {
                                Sleep (0x02)
                                Increment (Local3)
                                If (LEqual (Local3, 0x32))
                                {
                                    And (SMST, 0x40, SMST)
                                    Store (Arg2, SMCM)
                                    Store (Arg1, SMAD)
                                    Store (Arg0, SMPR)
                                    Store (0x00, Local3)
                                }
                            }

                            If (LEqual (Local1, 0x80))
                            {
                                Store (0x00, Local0)
                            }
                            Else
                            {
                                Decrement (Local0)
                            }
                        }

                        If (Local0)
                        {
                            Store (And (Local1, 0x1F), Local0)
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x07))
                            {
                                Store (SMB0, Arg3)
                            }

                            If (LEqual (Arg0, 0x09))
                            {
                                Store (SMW0, Arg3)
                            }

                            If (LEqual (Arg0, 0x0B))
                            {
                                Store (BCNT, Local3)
                                ShiftRight (0x0100, 0x03, Local2)
                                If (LGreater (Local3, Local2))
                                {
                                    Store (Local2, Local3)
                                }

                                If (LLess (Local3, 0x09))
                                {
                                    Store (FLD0, Local2)
                                }
                                Else
                                {
                                    If (LLess (Local3, 0x11))
                                    {
                                        Store (FLD1, Local2)
                                    }
                                    Else
                                    {
                                        If (LLess (Local3, 0x19))
                                        {
                                            Store (FLD2, Local2)
                                        }
                                        Else
                                        {
                                            Store (FLD3, Local2)
                                        }
                                    }
                                }

                                Increment (Local3)
                                Store (Buffer (Local3) {}, Local4)
                                Decrement (Local3)
                                Store (Zero, Local5)
                                While (LGreater (Local3, Local5))
                                {
                                    GBFE (Local2, Local5, RefOf (Local6))
                                    PBFE (Local4, Local5, Local6)
                                    Increment (Local5)
                                }

                                PBFE (Local4, Local5, 0x00)
                                Store (Local4, Arg3)
                            }
                        }

                        Release (MUT0)
                        Return (Local0)
                    }

                    Method (SMWR, 4, NotSerialized)
                    {
                        If (LNot (\_SB.OKEC))
                        {
                            Return (0xFF)
                        }

                        If (LNot (LEqual (Arg0, 0x06)))
                        {
                            If (LNot (LEqual (Arg0, 0x08)))
                            {
                                If (LNot (LEqual (Arg0, 0x0A)))
                                {
                                    Return (0x19)
                                }
                            }
                        }

                        Acquire (MUT0, 0xFFFF)
                        Store (0x04, Local0)
                        While (LGreater (Local0, 0x01))
                        {
                            If (LEqual (Arg0, 0x06))
                            {
                                Store (Arg3, SMB0)
                            }

                            If (LEqual (Arg0, 0x08))
                            {
                                Store (Arg3, SMW0)
                            }

                            If (LEqual (Arg0, 0x0A))
                            {
                                Store (Arg3, SMD0)
                            }

                            And (SMST, 0x40, SMST)
                            Store (Arg2, SMCM)
                            Store (Arg1, SMAD)
                            Store (Arg0, SMPR)
                            Store (0x00, Local3)
                            While (LNot (And (SMST, 0xBF, Local1)))
                            {
                                Sleep (0x02)
                                Increment (Local3)
                                If (LEqual (Local3, 0x32))
                                {
                                    And (SMST, 0x40, SMST)
                                    Store (Arg2, SMCM)
                                    Store (Arg1, SMAD)
                                    Store (Arg0, SMPR)
                                    Store (0x00, Local3)
                                }
                            }

                            If (LEqual (Local1, 0x80))
                            {
                                Store (0x00, Local0)
                            }
                            Else
                            {
                                Decrement (Local0)
                            }
                        }

                        If (Local0)
                        {
                            Store (And (Local1, 0x1F), Local0)
                        }

                        Release (MUT0)
                        Return (Local0)
                    }

                    Method (BPOL, 1, NotSerialized)
                    {
                        Store (Arg0, DBPL)
                        Store (0x01, EBPL)
                    }

                    Name (ECUS, 0x00)
                    Name (BATO, 0x00)
                    Name (BATN, 0x00)
                    Name (BATF, 0xC0)
                    Method (_Q09, 0, NotSerialized)
                    {
                        If (LEqual (SizeOf (\_OS), 0x14))
                        {
                            Notify (\_SB.BAT1, 0x80)
                            Notify (\_SB.BAT1, 0x00)
                            Notify (\_SB.BAT2, 0x80)
                            Notify (\_SB.BAT2, 0x00)
                            Notify (\_SB.ACAD, 0x00)
                        }

                        If (LEqual (SizeOf (\_OS), 0x14))
                        {
                            BPOL (0x3C)
                        }
                    }

                    Method (_Q20, 0, NotSerialized)
                    {
                        If (And (SMST, 0x40))
                        {
                            Store (SMAA, Local0)
                            If (LEqual (Local0, 0x14))
                            {
                                SELE ()
                                If (And (0x40, BATF))
                                {
                                    Notify (\_SB.BAT1, 0x81)
                                }

                                If (And (0x80, BATF))
                                {
                                    Notify (\_SB.BAT2, 0x81)
                                }

                                If (And (0x02, BATF))
                                {
                                    Notify (\_SB.ACAD, 0x80)
                                }

                                Notify (\_SB.BAT1, 0x80)
                                Notify (\_SB.BAT2, 0x80)
                                Store (BATD, BATO)
                                And (SMST, 0xBF, SMST)
                            }
                        }
                    }

                    Method (SELE, 0, NotSerialized)
                    {
                        Store (BATD, BATN)
                        Store (0x00, BATF)
                        If (And (0xC0, BATN))
                        {
                            Or (BATF, 0x01, BATF)
                        }

                        If (And (0x0300, BATN))
                        {
                            Or (BATF, 0x04, BATF)
                        }

                        And (BATN, 0x01, Local0)
                        And (BATO, 0x01, Local1)
                        If (Local0)
                        {
                            Or (BATF, 0x0100, BATF)
                        }
                        Else
                        {
                            And (BATF, 0xFEFF, BATF)
                        }

                        If (Not (LEqual (Local0, Local1)))
                        {
                            Or (BATF, 0x40, BATF)
                        }

                        And (BATN, 0x02, Local0)
                        And (BATO, 0x02, Local1)
                        If (Local0)
                        {
                            Or (BATF, 0x0200, BATF)
                        }
                        Else
                        {
                            And (BATF, 0xFDFF, BATF)
                        }

                        If (Not (LEqual (Local0, Local1)))
                        {
                            Or (BATF, 0x80, BATF)
                        }

                        And (BATN, 0xC0, Local0)
                        And (BATO, 0xC0, Local1)
                        If (Not (LEqual (Local0, Local1)))
                        {
                            Or (BATF, 0x02, BATF)
                        }

                        If (And (0x01, BATF))
                        {
                            If (And (0x04, BATF))
                            {
                                If (And (BATN, 0x20))
                                {
                                    Or (BATF, 0x10, BATF)
                                }
                                Else
                                {
                                    Or (BATF, 0x20, BATF)
                                }
                            }
                        }
                    }

                    Method (_Q0D, 0, NotSerialized)
                    {
                        Store ("Sleep Button Query: Fn+F4", Debug)
                        Notify (\_SB.SLPB, 0x80)
                    }

                    Method (_Q0E, 0, NotSerialized)
                    {
                        \_SB.PCI0.AGP.VGA.SWIH ()
                    }

                    Method (_Q0F, 0, NotSerialized)
                    {
                        Store ("Display blank: Fn+F6", Debug)
                        Not (LV16, Local0)
                        Store (Local0, LV16)
                    }

                    Method (_Q13, 0, NotSerialized)
                    {
                        Store ("Brightness Up: Fn+->", Debug)
                        Store (0x8C, \_SB.PCI0.LPC0.BCMD)
                        Store (0x00, \_SB.PCI0.LPC0.SMIC)
                    }

                    Method (_Q12, 0, NotSerialized)
                    {
                        Store ("Brightness Down: Fn+<-", Debug)
                        Store (0x8D, \_SB.PCI0.LPC0.BCMD)
                        Store (0x00, \_SB.PCI0.LPC0.SMIC)
                    }

                    Method (_Q80, 0, NotSerialized)
                    {
                        Store ("Temperature increasing: _Q80", Debug)
                        Notify (\_TZ.THRM, 0x80)
                    }

                    Method (_Q81, 0, NotSerialized)
                    {
                        Store ("Temperature decreasing: _Q81", Debug)
                        Notify (\_TZ.THRM, 0x80)
                    }

                    Event (EJT1)
                    Method (_Q8A, 0, NotSerialized)
                    {
                        Mutex (MUT0, 0x00)
                        Mutex (MUT1, 0x00)
                        Store ("------------------_Q0x8A --------------------------------------", Debug)
                        If (LIDE)
                        {
                            Store (0x01, LIDE)
                            Notify (\_SB.LID, 0x80)
                        }

                        If (DB2E)
                        {
                            Store ("-------- Device R-Bay Event ------", Debug)
                            Store (0x01, DB2E)
                            If (Or (LEqual (\_SB.PCI0.MYOS, 0x01), LEqual (\_SB.PCI0.MYOS, 0x03)))
                            {
                                If (DB2S)
                                {
                                    Store ("----------- Device Bay Change Status ---------- IN ", Debug)
                                    Store (\_SB.PCI0.LPC0.RBID, Local0)
                                    Store (Local0, \_SB.PCI0.IDE0.BAYR)
                                    If (LEqual (Local0, 0x00))
                                    {
                                        Store (0x00, \_SB.PCI0.LPC0.LV37)
                                    }
                                    Else
                                    {
                                        Store (0x00, \_SB.PCI0.LPC0.LV37)
                                        Store (0x00, \_SB.PCI0.LPC0.LV39)
                                        Sleep (0x32)
                                        Store (0x01, \_SB.PCI0.LPC0.LV39)
                                        Sleep (0x09C4)
                                        Store (0x01, \_SB.PCI0.IDE0.SSIG)
                                        Store (0x01, \_SB.PCI0.IDE0.UDC1)
                                        Store (0x02, \_SB.PCI0.IDE0.UDT1)
                                        Or (\_SB.PCI0.IDE0.FSCB, 0x04, \_SB.PCI0.IDE0.FSCB)
                                        Store (0xE303, \_SB.PCI0.IDE0.ITM1)
                                        Store (0x00, \_SB.PCI0.IDE0.SSIG)
                                        Notify (\_SB.PCI0.IDE0.SECN.BAY1, 0x00)
                                    }
                                }
                                Else
                                {
                                    Store ("-------- Device Bay Event ------ OUT ", Debug)
                                    Store (\_SB.PCI0.IDE0.BAYR, Local0)
                                    Store (0x01, \_SB.PCI0.LPC0.LV37)
                                    If (Or (LEqual (Local0, 0x01), LEqual (Local0, 0x02)))
                                    {
                                        Notify (\_SB.PCI0.IDE0.SECN.BAY1, 0x01)
                                    }
                                }
                            }
                        }
                    }
                }

                OperationRegion (SMI0, SystemIO, 0x0000FE00, 0x00000002)
                Field (SMI0, AnyAcc, NoLock, Preserve)
                {
                    SMIC,   8
                }

                OperationRegion (SMI1, SystemMemory, 0x1FF7BEBD, 0x00000090)
                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    BCMD,   8, 
                    DID,    32, 
                    INFO,   1024
                }

                Field (SMI1, AnyAcc, NoLock, Preserve)
                {
                    AccessAs (ByteAcc, 0x00), 
                    Offset (0x05), 
                    INF,    8
                }
            }

            Device (MDM0)
            {
                Name (_ADR, 0x001F0006)
                Name (_PRW, Package (0x02)
                {
                    0x05, 
                    0x03
                })
            }

            Device (HUB)
            {
                Name (_ADR, 0x001E0000)
                Name (_PRT, Package (0x05)
                {
                    Package (0x04)
                    {
                        0x0002FFFF, 
                        0x00, 
                        \_SB.PCI0.LPC0.LNKD, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x0004FFFF, 
                        0x00, 
                        \_SB.PCI0.LPC0.LNKE, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x0004FFFF, 
                        0x01, 
                        \_SB.PCI0.LPC0.LNKF, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x0006FFFF, 
                        0x00, 
                        \_SB.PCI0.LPC0.LNKB, 
                        0x00
                    }, 

                    Package (0x04)
                    {
                        0x0007FFFF, 
                        0x00, 
                        \_SB.PCI0.LPC0.LNKC, 
                        0x00
                    }
                })
                Device (GLAN)
                {
                    Name (_ADR, 0x00020000)
                    Name (_PRW, Package (0x02)
                    {
                        0x0B, 
                        0x05
                    })
                }
            }

            Device (IDE0)
            {
                Name (_ADR, 0x001F0001)
                OperationRegion (PCI, PCI_Config, 0x00, 0x58)
                Field (PCI, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x03), 
                        ,   7, 
                    SIDE,   1, 
                    Offset (0x42), 
                        ,   1, 
                    EIOR,   1, 
                        ,   13, 
                    ESID,   1, 
                    Offset (0x48), 
                    UMA0,   1, 
                    UMA1,   1, 
                    UMA2,   1, 
                    UMA3,   1, 
                    Offset (0x56), 
                    PSIG,   2, 
                    SSIG,   2
                }

                Field (PCI, DWordAcc, NoLock, Preserve)
                {
                    Offset (0x40), 
                    ITM0,   16, 
                    ITM1,   16, 
                    SIT0,   4, 
                    SIT1,   4, 
                    Offset (0x48), 
                    UDC0,   2, 
                    UDC1,   2, 
                    Offset (0x4A), 
                    UDT0,   8, 
                    UDT1,   8, 
                    Offset (0x54), 
                    ICF0,   2, 
                    ICF1,   2, 
                    CB80,   4, 
                        ,   2, 
                    WPPE,   1, 
                        ,   1, 
                    FSCB,   4, 
                    TRIP,   2, 
                    TRIS,   2, 
                    FATS,   4
                }

                Name (TIM0, Package (0x01)
                {
                    Package (0x05)
                    {
                        0x78, 
                        0xB4, 
                        0xF0, 
                        0x0186, 
                        0x0258
                    }
                })
                Name (TIM1, Package (0x01)
                {
                    Package (0x03)
                    {
                        0x78, 
                        0x96, 
                        0x01FE
                    }
                })
                Name (TIM2, Package (0x01)
                {
                    Package (0x06)
                    {
                        0x18, 
                        0x1E, 
                        0x2D, 
                        0x3C, 
                        0x5A, 
                        0x78
                    }
                })
                Name (AT01, Buffer (0x07)
                {
                    0x03, 0x00, 0x00, 0x00, 0x00, 0x00, 0xEF
                })
                Name (AT02, Buffer (0x07)
                {
                    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x90
                })
                Name (AT03, Buffer (0x07)
                {
                    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xC6
                })
                Name (AT04, Buffer (0x07)
                {
                    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x91
                })
                Name (ATA0, Buffer (0x1D) {})
                Name (ATA1, Buffer (0x1D) {})
                Name (ATA2, Buffer (0x1D) {})
                Name (ATA3, Buffer (0x1D) {})
                Name (ATAB, Buffer (0x0E) {})
                Name (CMDC, 0x00)
                Name (BAYR, 0x00)
                Method (_INI, 0, NotSerialized)
                {
                    Store (\_SB.PCI0.LPC0.RBID, BAYR)
                }

                Method (GTFB, 3, Serialized)
                {
                    Multiply (CMDC, 0x38, Local0)
                    CreateField (ATAB, Local0, 0x38, CMDX)
                    Multiply (CMDC, 0x07, Local0)
                    CreateByteField (ATAB, Add (Local0, 0x01), A001)
                    CreateByteField (ATAB, Add (Local0, 0x05), A005)
                    Store (Arg0, CMDX)
                    Store (Arg1, A001)
                    Store (Arg2, A005)
                    Increment (CMDC)
                }

                Mutex (GTFM, 0x00)
                Method (GTF, 3, Serialized)
                {
                    Acquire (GTFM, 0xFFFF)
                    CreateDWordField (Arg2, 0x00, PIO0)
                    CreateDWordField (Arg2, 0x04, DMA0)
                    CreateDWordField (Arg2, 0x08, PIO1)
                    CreateDWordField (Arg2, 0x0C, DMA1)
                    CreateDWordField (Arg2, 0x10, CHNF)
                    Store (0x00, CMDC)
                    Name (ID00, 0x80)
                    Name (ID49, 0x0C00)
                    Name (ID59, 0x00)
                    Name (ID53, 0x04)
                    Name (ID63, 0x0F00)
                    Name (ID88, 0x0F00)
                    Name (IRDY, 0x01)
                    Name (PIOT, 0x00)
                    Name (DMAT, 0x00)
                    If (LEqual (SizeOf (Arg1), 0x0200))
                    {
                        CreateByteField (Arg1, 0x00, IB00)
                        Store (IB00, ID00)
                        CreateWordField (Arg1, 0x62, IW49)
                        Store (IW49, ID49)
                        CreateWordField (Arg1, 0x6A, IW53)
                        Store (IW53, ID53)
                        CreateWordField (Arg1, 0x7E, IW63)
                        Store (IW63, ID63)
                        CreateWordField (Arg1, 0x76, IW59)
                        Store (IW59, ID59)
                        CreateWordField (Arg1, 0xB0, IW88)
                        Store (IW88, ID88)
                    }
                    Else
                    {
                        Return (ATAB)
                    }

                    Store (0xA0, Local7)
                    If (Arg0)
                    {
                        Store (0xB0, Local7)
                        And (CHNF, 0x08, IRDY)
                        If (And (CHNF, 0x10))
                        {
                            Store (PIO1, PIOT)
                        }
                        Else
                        {
                            Store (PIO0, PIOT)
                        }

                        If (And (CHNF, 0x04))
                        {
                            If (And (CHNF, 0x10))
                            {
                                Store (DMA1, DMAT)
                            }
                            Else
                            {
                                Store (DMA0, DMAT)
                            }
                        }
                    }
                    Else
                    {
                        And (CHNF, 0x02, IRDY)
                        Store (PIO0, PIOT)
                        If (And (CHNF, 0x01))
                        {
                            Store (DMA0, DMAT)
                        }
                    }

                    If (LAnd (And (ID53, 0x04), And (ID88, 0xFF)))
                    {
                        Store (0x00, Local1)
                        And (ID88, 0xFF, Local2)
                        While (ShiftRight (Local2, Local1))
                        {
                            Increment (Local1)
                        }

                        Decrement (Local1)
                        GTFB (AT01, Or (0x40, Local1), Local7)
                    }

                    If (IRDY)
                    {
                        Store (Match (DerefOf (Index (TIM0, 0x00)), MGE, PIOT, MTR, 0x00, 0x00), Local1)
                        If (LEqual (Local1, Ones))
                        {
                            Store (0x04, Local1)
                        }

                        Subtract (0x04, Local1, Local1)
                        GTFB (AT01, Or (0x08, Local1), Local7)
                    }
                    Else
                    {
                        If (And (ID49, 0x0400))
                        {
                            GTFB (AT01, 0x01, Local7)
                        }
                    }

                    Release (GTFM)
                    Return (ATAB)
                }

                Method (RATA, 1, NotSerialized)
                {
                    CreateByteField (Arg0, 0x00, CMDN)
                    Multiply (CMDN, 0x38, Local0)
                    CreateField (Arg0, 0x08, Local0, RETB)
                    Return (RETB)
                }

                Name (REGF, 0x01)
                Method (_REG, 2, NotSerialized)
                {
                    If (LEqual (Arg0, 0x02))
                    {
                        Store (Arg1, REGF)
                    }
                }

                Name (BAYD, 0x00)
                Method (_STA, 0, NotSerialized)
                {
                    Return (0x0F)
                }

                Method (GTM, 6, NotSerialized)
                {
                    Store (Buffer (0x14) {}, Local0)
                    CreateDWordField (Local0, 0x00, PIO0)
                    CreateDWordField (Local0, 0x04, DMA0)
                    CreateDWordField (Local0, 0x08, PIO1)
                    CreateDWordField (Local0, 0x0C, DMA1)
                    CreateDWordField (Local0, 0x10, FLAG)
                    If (LOr (And (Arg0, 0x08), LNot (And (Arg0, 0x01))))
                    {
                        Store (0x0384, PIO0)
                    }
                    Else
                    {
                        Add (ShiftRight (And (Arg0, 0x0300), 0x08), ShiftRight (And (Arg0, 0x3000), 0x0C), Local1)
                        Multiply (Subtract (0x09, Local1), 0x1E, PIO0)
                    }

                    If (And (Arg0, 0x4000))
                    {
                        If (LOr (And (Arg0, 0x80), LNot (And (Arg0, 0x10))))
                        {
                            Store (0x0384, PIO1)
                        }
                        Else
                        {
                            Add (And (Arg1, 0x03), ShiftRight (And (Arg1, 0x0C), 0x02), Local1)
                            Multiply (Subtract (0x09, Local1), 0x1E, PIO1)
                        }
                    }
                    Else
                    {
                        Store (PIO0, PIO1)
                    }

                    If (And (Arg2, 0x01))
                    {
                        If (And (Arg5, 0x01))
                        {
                            Store (0x08, DMA0)
                        }
                        Else
                        {
                            Subtract (0x04, And (Arg3, 0x03), Local1)
                            If (And (Arg4, 0x01))
                            {
                                Multiply (Local1, 0x0F, DMA0)
                            }
                            Else
                            {
                                Multiply (Local1, 0x1E, DMA0)
                            }
                        }
                    }
                    Else
                    {
                        Store (PIO0, DMA0)
                    }

                    If (And (Arg0, 0x4000))
                    {
                        If (And (Arg2, 0x02))
                        {
                            If (And (Arg5, 0x02))
                            {
                                Store (0x08, DMA1)
                            }
                            Else
                            {
                                Subtract (0x04, ShiftRight (And (Arg3, 0x30), 0x04), Local1)
                                If (And (Arg4, 0x02))
                                {
                                    Multiply (Local1, 0x0F, DMA1)
                                }
                                Else
                                {
                                    Multiply (Local1, 0x1E, DMA1)
                                }
                            }
                        }
                        Else
                        {
                            Store (PIO1, DMA1)
                        }
                    }
                    Else
                    {
                        Store (DMA0, DMA1)
                    }

                    Store (Zero, FLAG)
                    If (And (Arg0, 0x01))
                    {
                        Or (FLAG, 0x10, FLAG)
                    }

                    If (And (Arg2, 0x01))
                    {
                        Or (FLAG, 0x01, FLAG)
                    }

                    If (And (Arg0, 0x02))
                    {
                        Or (FLAG, 0x02, FLAG)
                    }

                    If (And (Arg2, 0x02))
                    {
                        Or (FLAG, 0x04, FLAG)
                    }

                    If (And (Arg0, 0x20))
                    {
                        Or (FLAG, 0x08, FLAG)
                    }

                    Return (Local0)
                }

                Method (STMS, 3, NotSerialized)
                {
                    Store (Buffer (0x18) {}, Local7)
                    CreateDWordField (Local7, 0x00, ITM)
                    CreateDWordField (Local7, 0x04, SIT)
                    CreateDWordField (Local7, 0x08, UDC)
                    CreateDWordField (Local7, 0x0C, UDT)
                    CreateDWordField (Local7, 0x10, ICF)
                    CreateDWordField (Local7, 0x14, A100)
                    Store (0x01, WPPE)
                    CreateDWordField (Arg0, 0x00, PIO0)
                    CreateDWordField (Arg0, 0x04, DMA0)
                    CreateDWordField (Arg0, 0x08, PIO1)
                    CreateDWordField (Arg0, 0x0C, DMA1)
                    CreateDWordField (Arg0, 0x10, FLAG)
                    Store (FLAG, Local4)
                    Store (0x4000, Local0)
                    Name (W49M, 0x00)
                    Name (W53M, 0x00)
                    Name (W62M, 0x00)
                    Name (W64M, 0x00)
                    Name (W88M, 0x00)
                    If (LEqual (SizeOf (Arg1), 0x0200))
                    {
                        CreateDWordField (Arg1, 0x00, W00A)
                        CreateDWordField (Arg1, 0x62, W49A)
                        CreateDWordField (Arg1, 0x6A, W53A)
                        CreateDWordField (Arg1, 0x7C, W62A)
                        CreateDWordField (Arg1, 0x80, W64A)
                        CreateDWordField (Arg1, 0xB0, W88A)
                        Store (W49A, W49M)
                        Store (W53A, W53M)
                        Store (W62A, W62M)
                        Store (W64A, W64M)
                        Store (W88A, W88M)
                        If (W00A)
                        {
                            Or (Local0, 0x8000, Local0)
                        }

                        If (LNot (And (W00A, 0x80)))
                        {
                            Or (Local0, 0x04, Local0)
                        }
                    }
                    Else
                    {
                        Store (0x00, W49M)
                        Store (0x00, W53M)
                        Store (0x00, W62M)
                        Store (0x00, W64M)
                        Store (0x00, W88M)
                    }

                    Name (W49S, 0x00)
                    Name (W53S, 0x00)
                    Name (W62S, 0x00)
                    Name (W64S, 0x00)
                    Name (W88S, 0x00)
                    If (LEqual (SizeOf (Arg2), 0x0200))
                    {
                        CreateDWordField (Arg2, 0x00, W00B)
                        CreateDWordField (Arg2, 0x62, W49B)
                        CreateDWordField (Arg2, 0x6A, W53B)
                        CreateDWordField (Arg2, 0x7C, W62B)
                        CreateDWordField (Arg2, 0x80, W64B)
                        CreateDWordField (Arg2, 0xB0, W88B)
                        Store (W49B, W49S)
                        Store (W53B, W53S)
                        Store (W62B, W62S)
                        Store (W64B, W64S)
                        Store (W88B, W88S)
                        If (W00B)
                        {
                            Or (Local0, 0x8000, Local0)
                        }

                        If (LNot (And (W00B, 0x80)))
                        {
                            Or (Local0, 0x40, Local0)
                        }
                    }
                    Else
                    {
                        Store (0x00, W49S)
                        Store (0x00, W53S)
                        Store (0x00, W62S)
                        Store (0x00, W64S)
                        Store (0x00, W88S)
                    }

                    Store (0x00, A100)
                    If (And (0x38, W88M))
                    {
                        If (And (0x20, W88M))
                        {
                            Store (0x08, DMA0)
                            Or (A100, 0x00100010, A100)
                        }
                        Else
                        {
                            If (And (0x10, W88M))
                            {
                                Store (0x1E, DMA0)
                                Or (A100, 0x10, A100)
                            }
                            Else
                            {
                                Store (0x2D, DMA0)
                            }
                        }
                    }
                    Else
                    {
                        If (And (0x07, W88M))
                        {
                            Or (0x0100, A100, A100)
                            If (And (0x04, W88M))
                            {
                                Store (0x3C, DMA0)
                            }
                            Else
                            {
                                If (And (0x02, W88M))
                                {
                                    Store (0x5A, DMA0)
                                }
                                Else
                                {
                                    Store (0x78, DMA0)
                                }
                            }
                        }
                    }

                    If (And (0x3F, W88S))
                    {
                        If (And (0x20, W88S))
                        {
                            Store (0x08, DMA1)
                            Or (A100, 0x00200020, A100)
                        }
                        Else
                        {
                            If (And (0x10, W88S))
                            {
                                Store (0x1E, DMA1)
                                Or (A100, 0x20, A100)
                            }
                            Else
                            {
                                Store (0x2D, DMA1)
                            }
                        }
                    }

                    If (LAnd (And (W49M, 0x0800), And (Local4, 0x02)))
                    {
                        Or (Local0, 0x02, Local0)
                    }

                    If (LLess (PIO0, 0x0384))
                    {
                        Or (Local0, 0x01, Local0)
                    }

                    If (LAnd (And (W49S, 0x0800), And (Local4, 0x08)))
                    {
                        Or (Local0, 0x20, Local0)
                    }

                    If (LLess (PIO1, 0x0384))
                    {
                        Or (Local0, 0x10, Local0)
                    }

                    If (And (Local4, 0x01))
                    {
                        Store (PIO0, Local1)
                    }
                    Else
                    {
                        Store (DMA0, Local1)
                    }

                    If (LNot (LLess (Local1, 0xF0)))
                    {
                        Or (Local0, 0x08, Local0)
                    }
                    Else
                    {
                        If (And (W53M, 0x02))
                        {
                            If (LAnd (And (W64M, 0x02), LNot (LGreater (Local1, 0x78))))
                            {
                                Or (Local0, 0x2301, Local0)
                            }
                            Else
                            {
                                If (LAnd (And (W64M, 0x01), LNot (LGreater (Local1, 0xB4))))
                                {
                                    Or (Local0, 0x2101, Local0)
                                }
                            }
                        }
                        Else
                        {
                            Or (Local0, 0x1001, Local0)
                        }
                    }

                    Store (Local0, ITM)
                    Store (Zero, Local0)
                    If (And (Local4, 0x04))
                    {
                        Store (PIO1, Local1)
                    }
                    Else
                    {
                        Store (DMA1, Local1)
                    }

                    If (And (Local4, 0x10))
                    {
                        If (LNot (LLess (Local1, 0xF0)))
                        {
                            Or (0x80, ITM, ITM)
                        }
                        Else
                        {
                            Or (0x10, ITM, ITM)
                            If (And (W53S, 0x02))
                            {
                                If (LAnd (And (W64S, 0x02), LNot (LGreater (Local1, 0x78))))
                                {
                                    Store (0x0B, Local0)
                                }
                                Else
                                {
                                    If (LAnd (And (W64S, 0x01), LNot (LGreater (Local1, 0xB4))))
                                    {
                                        Store (0x09, Local0)
                                    }
                                }
                            }
                            Else
                            {
                                Store (0x04, Local0)
                            }
                        }
                    }

                    Store (Local0, SIT)
                    Store (0x00, Local0)
                    If (LAnd (And (0x3F, W88M), And (Local4, 0x01)))
                    {
                        Or (Local0, 0x01, Local0)
                    }

                    If (And (Local4, 0x04))
                    {
                        Or (Local0, 0x02, Local0)
                    }

                    Store (Local0, UDC)
                    Store (0x00, Local0)
                    If (And (Local4, 0x01))
                    {
                        If (LLess (DMA0, 0x1E))
                        {
                            Or (A100, 0x1000, A100)
                            Or (Local0, 0x01, Local0)
                        }
                        Else
                        {
                            If (LLess (DMA0, 0x3C))
                            {
                                Divide (DMA0, 0x0F, , Local1)
                            }
                            Else
                            {
                                Divide (DMA0, 0x1E, , Local1)
                            }

                            Subtract (0x04, Local1, Local0)
                        }
                    }

                    If (And (Local4, 0x04))
                    {
                        If (LLess (DMA1, 0x1E))
                        {
                            Or (A100, 0x2000, A100)
                            Or (Local0, 0x10, Local0)
                        }
                        Else
                        {
                            If (LLess (DMA1, 0x3C))
                            {
                                Divide (DMA1, 0x0F, , Local1)
                            }
                            Else
                            {
                                Divide (DMA1, 0x1E, , Local1)
                            }

                            Subtract (0x04, Local1, Local1)
                            ShiftLeft (Local1, 0x04, Local1)
                            Or (Local0, Local1, Local0)
                        }
                    }

                    Store (Local0, UDT)
                    Store (0x00, Local0)
                    If (LLess (DMA0, 0x3C))
                    {
                        Or (Local0, 0x01, Local0)
                    }

                    If (LLess (DMA1, 0x3C))
                    {
                        Or (Local0, 0x02, Local0)
                    }

                    Store (Local0, ICF)
                    Return (Local7)
                }

                Method (GTF0, 7, NotSerialized)
                {
                    Store (Buffer (0x07)
                        {
                            0x03, 0x00, 0x00, 0x00, 0x00, 0xA0, 0xEF
                        }, Local7)
                    CreateByteField (Local7, 0x01, MODE)
                    If (And (Arg2, 0x01))
                    {
                        If (And (Arg6, 0x01))
                        {
                            Store (0x45, MODE)
                        }
                        Else
                        {
                            And (Arg3, 0x03, Local0)
                            If (And (Arg4, 0x01))
                            {
                                Add (Local0, 0x02, Local0)
                            }

                            Or (Local0, 0x40, MODE)
                        }
                    }
                    Else
                    {
                        Add (ShiftRight (And (Arg0, 0x0300), 0x08), ShiftRight (And (Arg0, 0x3000), 0x0C), Local0)
                        If (LNot (LLess (Local0, 0x05)))
                        {
                            Store (0x22, MODE)
                        }
                        Else
                        {
                            If (LNot (LLess (Local0, 0x03)))
                            {
                                Store (0x21, MODE)
                            }
                            Else
                            {
                                Store (0x20, MODE)
                            }
                        }
                    }

                    Concatenate (Local7, Local7, Local6)
                    If (LOr (And (Arg0, 0x08), LNot (And (Arg0, 0x01))))
                    {
                        If (And (Arg0, 0x02))
                        {
                            Store (0x00, MODE)
                        }
                        Else
                        {
                            Store (0x08, MODE)
                        }
                    }
                    Else
                    {
                        Add (ShiftRight (And (Arg0, 0x0300), 0x08), ShiftRight (And (Arg0, 0x3000), 0x0C), Local0)
                        If (LNot (LLess (Local0, 0x05)))
                        {
                            Store (0x0C, MODE)
                        }
                        Else
                        {
                            If (LNot (LLess (Local0, 0x03)))
                            {
                                Store (0x0B, MODE)
                            }
                            Else
                            {
                                Store (0x0A, MODE)
                            }
                        }
                    }

                    Concatenate (Local6, Local7, Local5)
                    Return (Local5)
                }

                Name (B04, Buffer (0x04) {})
                Name (B20, Buffer (0x04) {})
                Name (B40, Buffer (0x04) {})
                Device (PRIM)
                {
                    Name (_ADR, 0x00)
                    Name (_PSC, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        Store (0x00, _PSC)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store (0x03, _PSC)
                    }

                    Method (_GTM, 0, NotSerialized)
                    {
                        Store (Buffer (0x14)
                            {
                                0x00
                            }, Local0)
                        Store (^^GTM (^^ITM0, ^^SIT0, ^^UDC0, ^^UDT0, ^^ICF0, ^^FSCB), Local0)
                        Return (Local0)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (GTF (0x00, Arg1, Arg0), ATA0)
                        Store (GTF (0x01, Arg2, Arg0), ATA1)
                        Store (^^STMS (Arg0, Arg1, Arg2), Local0)
                        CreateDWordField (Local0, 0x00, ITM)
                        CreateDWordField (Local0, 0x04, SIT)
                        CreateDWordField (Local0, 0x08, UDC)
                        CreateDWordField (Local0, 0x0C, UDT)
                        CreateDWordField (Local0, 0x10, ICF)
                        Store (ITM, ^^ITM0)
                        Store (SIT, ^^SIT0)
                        Store (UDC, ^^UDC0)
                        Store (UDT, ^^UDT0)
                        CreateDWordField (Local0, 0x14, A100)
                        Or (And (^^CB80, 0x0C), ShiftRight (And (0x30, A100), 0x04), ^^CB80)
                        Or (And (^^FSCB, 0x0C), ShiftRight (And (0x3000, A100), 0x0C), ^^FSCB)
                        Or (And (^^FATS, 0x0C), ShiftRight (And (0x00300000, A100), 0x14), ^^FATS)
                        Store (ICF, ^^ICF0)
                    }

                    Device (MAST)
                    {
                        Name (_ADR, 0x00)
                        Name (H15F, Zero)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Return (RATA (ATA0))
                        }
                    }
                }

                Device (SECN)
                {
                    Name (_ADR, 0x01)
                    Name (FAST, 0x63)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (ESID)
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (0x08)
                        }
                    }

                    Name (_PSC, 0x00)
                    Method (_PS0, 0, NotSerialized)
                    {
                        Store (0x00, _PSC)
                    }

                    Method (_PS3, 0, NotSerialized)
                    {
                        Store (0x03, _PSC)
                    }

                    Method (_GTM, 0, NotSerialized)
                    {
                        Store (Buffer (0x14)
                            {
                                0x00
                            }, Local0)
                        Store (^^FSCB, Local1)
                        ShiftRight (Local1, 0x02, Local1)
                        Store (^^GTM (^^ITM1, ^^SIT1, ^^UDC1, ^^UDT1, ^^ICF1, Local1), Local0)
                        Return (Local0)
                    }

                    Method (_STM, 3, NotSerialized)
                    {
                        Store (GTF (0x00, Arg1, Arg0), ATA2)
                        Store (GTF (0x01, Arg2, Arg0), ATA3)
                        Store (^^STMS (Arg0, Arg1, Arg2), Local0)
                        CreateDWordField (Local0, 0x00, ITM)
                        CreateDWordField (Local0, 0x04, SIT)
                        CreateDWordField (Local0, 0x08, UDC)
                        CreateDWordField (Local0, 0x0C, UDT)
                        CreateDWordField (Local0, 0x10, ICF)
                        Store (ITM, ^^ITM1)
                        Store (SIT, ^^SIT1)
                        Store (UDC, ^^UDC1)
                        Store (UDT, ^^UDT1)
                        CreateDWordField (Local0, 0x14, A100)
                        Or (And (^^CB80, 0x03), ShiftRight (And (0x30, A100), 0x02), ^^CB80)
                        Or (And (^^FSCB, 0x03), ShiftRight (And (0x3000, A100), 0x0A), ^^FSCB)
                        Or (And (^^FATS, 0x03), ShiftRight (And (0x00300000, A100), 0x12), ^^FATS)
                        Store (ICF, ^^ICF1)
                    }

                    Device (BAY1)
                    {
                        Name (_ADR, 0x00)
                        Name (H15F, Zero)
                        Name (EJ0F, 0x00)
                        Method (_GTF, 0, NotSerialized)
                        {
                            Return (RATA (ATA2))
                        }

                        Method (_STA, 0, NotSerialized)
                        {
                            If (\_SB.PCI0.IDE0.ESID)
                            {
                                \_SB.PCI0.IDE0.SECN.CBAY ()
                                Store (^^BFLG, Local0)
                                If (LEqual (^^BNUM, 0x01))
                                {
                                    If (And (Local0, 0x01))
                                    {
                                        If (\_SB.PCI0.LPC0.LV37)
                                        {
                                            Return (0x08)
                                        }
                                        Else
                                        {
                                            Return (0x0F)
                                        }
                                    }
                                }
                                Else
                                {
                                    If (LEqual (^^BNUM, 0x02))
                                    {
                                        If (\_SB.PCI0.LPC0.LV37)
                                        {
                                            Return (0x08)
                                        }
                                        Else
                                        {
                                            Return (0x0F)
                                        }
                                    }
                                    Else
                                    {
                                        Return (0x08)
                                    }
                                }
                            }
                            Else
                            {
                                Return (0x08)
                            }
                        }

                        Method (_EJ0, 1, NotSerialized)
                        {
                            If (Arg0)
                            {
                                Store (0x01, ^^^SSIG)
                                Sleep (0x32)
                                Store (0xC000, ^^^ITM1)
                                Store (0x01, \_SB.PCI0.LPC0.LV37)
                                Store (0x00, \_SB.PCI0.LPC0.LV39)
                            }
                        }
                    }

                    Name (BNUM, 0x00)
                    Name (BFLG, 0x00)
                    Method (CBAY, 0, NotSerialized)
                    {
                        Store (0x00, BNUM)
                        Store (0x00, BFLG)
                        Store (\_SB.PCI0.LPC0.RBID, Local0)
                        If (Or (LEqual (Local0, 0x01), LEqual (Local0, 0x02)))
                        {
                            Increment (BNUM)
                            Or (BFLG, 0x01, BFLG)
                        }
                    }
                }

                Method (_PS0, 0, NotSerialized)
                {
                    If (And (LEqual (_PSC, 0x03), LEqual (\_SB.STAT, 0x03)))
                    {
                        Store (0x89, \_SB.PCI0.LPC0.BCMD)
                        Store (0x00, \_SB.PCI0.LPC0.SMIC)
                    }

                    Store (0x00, _PSC)
                }

                Method (_PS3, 0, NotSerialized)
                {
                    Store (0x03, _PSC)
                }

                Name (_PSC, 0x00)
            }

            Device (USB1)
            {
                Name (_ADR, 0x001D0000)
                OperationRegion (USBO, PCI_Config, 0xC4, 0x04)
                Field (USBO, ByteAcc, NoLock, Preserve)
                {
                    RSEN,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x03, 
                    0x03
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, \_SB.PCI0.USB1.RSEN)
                    }
                    Else
                    {
                        Store (0x00, \_SB.PCI0.USB1.RSEN)
                    }
                }
            }

            Device (USB2)
            {
                Name (_ADR, 0x001D0001)
                OperationRegion (USBO, PCI_Config, 0xC4, 0x04)
                Field (USBO, ByteAcc, NoLock, Preserve)
                {
                    RSEN,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x04, 
                    0x03
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, \_SB.PCI0.USB2.RSEN)
                    }
                    Else
                    {
                        Store (0x00, \_SB.PCI0.USB2.RSEN)
                    }
                }
            }

            Device (USB3)
            {
                Name (_ADR, 0x001D0002)
                OperationRegion (USBO, PCI_Config, 0xC4, 0x04)
                Field (USBO, ByteAcc, NoLock, Preserve)
                {
                    RSEN,   2
                }

                Name (_PRW, Package (0x02)
                {
                    0x0C, 
                    0x03
                })
                Method (_PSW, 1, NotSerialized)
                {
                    If (Arg0)
                    {
                        Store (0x03, \_SB.PCI0.USB3.RSEN)
                    }
                    Else
                    {
                        Store (0x00, \_SB.PCI0.USB3.RSEN)
                    }
                }
            }
        }

        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D"))
            Name (LSTS, 0x00)
            Method (_LID, 0, NotSerialized)
            {
                If (\_SB.OKEC)
                {
                    If (\_SB.PCI0.LPC0.EC0.LIDS)
                    {
                        Store (Zero, LSTS)
                    }
                    Else
                    {
                        Store (One, LSTS)
                    }
                }
                Else
                {
                    Store (Zero, LSTS)
                }

                Return (LSTS)
            }
        }

        Device (ACAD)
        {
            Name (_HID, "ACPI0003")
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Name (ACWT, 0x00)
            Method (_PSR, 0, NotSerialized)
            {
                Store (\_SB.ACST, ACWT)
                If (\_SB.OKEC)
                {
                    Store (\_SB.PCI0.LPC0.EC0.ACDF, \_SB.ACST)
                }

                If (LNot (LEqual (ACWT, \_SB.ACST)))
                {
                    Store (0x8B, \_SB.PCI0.LPC0.BCMD)
                    Store (0x00, \_SB.PCI0.LPC0.SMIC)
                }

                Return (\_SB.ACST)
            }
        }

        Method (VTOB, 1, NotSerialized)
        {
            Store (0x01, Local0)
            ShiftLeft (Local0, Arg0, Local0)
            Return (Local0)
        }

        Method (BTOV, 1, NotSerialized)
        {
            ShiftRight (Arg0, 0x01, Local0)
            Store (0x00, Local1)
            While (Local0)
            {
                Increment (Local1)
                ShiftRight (Local0, 0x01, Local0)
            }

            Return (Local1)
        }

        Method (MKWD, 2, NotSerialized)
        {
            If (And (Arg1, 0x80))
            {
                Store (0xFFFF0000, Local0)
            }
            Else
            {
                Store (Zero, Local0)
            }

            Or (Local0, Arg0, Local0)
            Or (Local0, ShiftLeft (Arg1, 0x08), Local0)
            Return (Local0)
        }

        Method (POSW, 1, NotSerialized)
        {
            If (And (Arg0, 0x8000))
            {
                If (LEqual (Arg0, 0xFFFF))
                {
                    Return (0xFFFFFFFF)
                }
                Else
                {
                    Not (Arg0, Local0)
                    Increment (Local0)
                    And (Local0, 0xFFFF, Local0)
                    Return (Local0)
                }
            }
            Else
            {
                Return (Arg0)
            }
        }

        Method (GBFE, 3, NotSerialized)
        {
            CreateByteField (Arg0, Arg1, TIDX)
            Store (TIDX, Arg2)
        }

        Method (PBFE, 3, NotSerialized)
        {
            CreateByteField (Arg0, Arg1, TIDX)
            Store (Arg2, TIDX)
        }

        Method (ITOS, 1, NotSerialized)
        {
            Store (Buffer (0x09)
                {
                    0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
                    0x00
                }, Local0)
            Store (Buffer (0x11)
                {
                    "0123456789ABCDEF"
                }, Local7)
            Store (0x08, Local1)
            Store (0x00, Local2)
            Store (0x00, Local3)
            While (Local1)
            {
                Decrement (Local1)
                And (ShiftRight (Arg0, ShiftLeft (Local1, 0x02)), 0x0F, Local4)
                If (Local4)
                {
                    Store (Ones, Local3)
                }

                If (Local3)
                {
                    GBFE (Local7, Local4, RefOf (Local5))
                    PBFE (Local0, Local2, Local5)
                    Increment (Local2)
                }
            }

            Return (Local0)
        }

        Device (BAT1)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, 0x01)
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Name (PBIF, Package (0x0D)
            {
                0x01, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0x01, 
                0xFFFFFFFF, 
                0xFA, 
                0x64, 
                0x0A, 
                0x19, 
                "BAT1", 
                " ", 
                " ", 
                " "
            })
            Name (PBST, Package (0x04)
            {
                0x00, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0x2710
            })
            Name (BAST, 0x00)
            Name (FAST, 0x00)
            Name (B1ST, 0x0F)
            Name (B1WT, 0x00)
            Method (_STA, 0, NotSerialized)
            {
                If (LLess (FAST, 0x10))
                {
                    Increment (FAST)
                    If (LEqual (FAST, 0x10))
                    {
                        Store (0x92, \_SB.PCI0.LPC0.BCMD)
                        Store (0x00, \_SB.PCI0.LPC0.SMIC)
                    }
                }

                If (\_SB.OKEC)
                {
                    If (\_SB.PCI0.LPC0.EC0.MBTS)
                    {
                        Store (0x1F, B1ST)
                    }
                    Else
                    {
                        Store (0x0F, B1ST)
                    }
                }
                Else
                {
                    Store (0x0F, B1ST)
                }

                Return (B1ST)
            }

            Method (_BIF, 0, NotSerialized)
            {
                If (\_SB.OKEC)
                {
                    If (\_SB.PCI0.LPC0.EC0.MBTS)
                    {
                        UPBI ()
                    }
                    Else
                    {
                        IVBI ()
                    }
                }
                Else
                {
                    IVBI ()
                }

                Return (PBIF)
            }

            Method (_BST, 0, NotSerialized)
            {
                If (\_SB.OKEC)
                {
                    If (\_SB.PCI0.LPC0.EC0.MBTS)
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

            Method (UPBI, 0, NotSerialized)
            {
                Store (0x1FFF, Local2)
                \_SB.PCI0.LPC0.EC0.SMWR (0x08, 0x14, 0x01, Local2)
                \_SB.PCI0.LPC0.EC0.SMRD (0x09, 0x14, 0x01, RefOf (Local3))
                If (LEqual (Local2, Or (Local3, 0x0FFF)))
                {
                    If (LNot (\_SB.PCI0.LPC0.EC0.SMRD (0x09, 0x16, 0x10, RefOf (Local5))))
                    {
                        Store (Local5, Index (PBIF, 0x02))
                    }
                }

                If (LEqual (\_SB.PCI0.LPC0.EC0.MBID, 0x01))
                {
                    Store (0x1130, Index (PBIF, 0x01))
                    Store (0x39D0, Index (PBIF, 0x04))
                    Store ("01ZG", Index (PBIF, 0x09))
                    Store ("LION", Index (PBIF, 0x0B))
                    Store ("SMP ", Index (PBIF, 0x0C))
                }
                Else
                {
                    If (LEqual (\_SB.PCI0.LPC0.EC0.MBID, 0x02))
                    {
                        Store (0x0E10, Index (PBIF, 0x01))
                        Store (0x39D0, Index (PBIF, 0x04))
                        Store ("02ZG", Index (PBIF, 0x09))
                        Store ("LION", Index (PBIF, 0x0B))
                        Store ("SANYO", Index (PBIF, 0x0C))
                    }
                    Else
                    {
                        If (LEqual (\_SB.PCI0.LPC0.EC0.MBID, 0x03))
                        {
                            Store (0x1130, Index (PBIF, 0x01))
                            Store (0x39D0, Index (PBIF, 0x04))
                            Store ("03ZG", Index (PBIF, 0x09))
                            Store ("LION", Index (PBIF, 0x0B))
                            Store ("SANYO", Index (PBIF, 0x0C))
                        }
                        Else
                        {
                            Store (0x1130, Index (PBIF, 0x01))
                            Store (0x39D0, Index (PBIF, 0x04))
                            Store ("01ZG", Index (PBIF, 0x09))
                            Store ("LION", Index (PBIF, 0x0B))
                            Store ("SMP ", Index (PBIF, 0x0C))
                        }
                    }
                }

                Store (0x01, Index (PBIF, 0x00))
                If (LEqual (SizeOf (\_OS), 0x27))
                {
                    Store (0x00, Index (PBIF, 0x00))
                }
            }

            Method (UPBS, 0, NotSerialized)
            {
                Store (\_SB.PCI0.LPC0.EC0.MCUR, Local5)
                Store (POSW (Local5), Index (PBST, 0x01))
                Store (\_SB.PCI0.LPC0.EC0.MBRM, Index (PBST, 0x02))
                Store (\_SB.PCI0.LPC0.EC0.MBVG, Index (PBST, 0x03))
                If (\_SB.PCI0.LPC0.EC0.MBTF)
                {
                    If (\_SB.PCI0.LPC0.EC0.ACDF)
                    {
                        Store (0x00, Index (PBST, 0x00))
                    }
                }
                Else
                {
                    If (\_SB.PCI0.LPC0.EC0.MBTC)
                    {
                        If (\_SB.PCI0.LPC0.EC0.ACDF)
                        {
                            Store (0x02, Index (PBST, 0x00))
                        }
                        Else
                        {
                            Store (0x00, Index (PBST, 0x00))
                        }
                    }
                    Else
                    {
                        If (\_SB.PCI0.LPC0.EC0.ACDF)
                        {
                            Store (0x00, Index (PBST, 0x00))
                        }
                        Else
                        {
                            Store (0x01, Index (PBST, 0x00))
                        }
                    }
                }
            }

            Method (IVBI, 0, NotSerialized)
            {
                Store (0xFFFFFFFF, Index (PBIF, 0x01))
                Store (0xFFFFFFFF, Index (PBIF, 0x02))
                Store (0xFFFFFFFF, Index (PBIF, 0x04))
                Store ("Bad", Index (PBIF, 0x09))
                Store ("      ", Index (PBIF, 0x0A))
                Store ("Bad", Index (PBIF, 0x0B))
                Store ("Bad", Index (PBIF, 0x0C))
            }

            Method (IVBS, 0, NotSerialized)
            {
                Store (0x00, Index (PBST, 0x00))
                Store (0xFFFFFFFF, Index (PBST, 0x01))
                Store (0xFFFFFFFF, Index (PBST, 0x02))
                Store (0x2710, Index (PBST, 0x03))
            }
        }

        Device (BAT2)
        {
            Name (_HID, EisaId ("PNP0C0A"))
            Name (_UID, 0x02)
            Name (_PCL, Package (0x01)
            {
                \_SB
            })
            Name (B2ST, 0x0F)
            Name (PBIF, Package (0x0D)
            {
                0x01, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0x01, 
                0xFFFFFFFF, 
                0xFA, 
                0x64, 
                0x0A, 
                0x19, 
                "BAT1", 
                " ", 
                " ", 
                " "
            })
            Name (PBST, Package (0x04)
            {
                0x00, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                0x2710
            })
            Method (_STA, 0, NotSerialized)
            {
                If (\_SB.OKEC)
                {
                    If (\_SB.PCI0.LPC0.EC0.SBTS)
                    {
                        Store (0x1F, B2ST)
                    }
                    Else
                    {
                        Store (0x0F, B2ST)
                    }
                }
                Else
                {
                    Store (0x0F, B2ST)
                }

                Return (B2ST)
            }

            Method (_BIF, 0, NotSerialized)
            {
                If (\_SB.OKEC)
                {
                    If (\_SB.PCI0.LPC0.EC0.SBTS)
                    {
                        UPBI ()
                    }
                    Else
                    {
                        IVBI ()
                    }
                }
                Else
                {
                    IVBI ()
                }

                Return (PBIF)
            }

            Method (_BST, 0, NotSerialized)
            {
                If (\_SB.OKEC)
                {
                    If (\_SB.PCI0.LPC0.EC0.SBTS)
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

            Method (UPBI, 0, NotSerialized)
            {
                Store (0x2FFF, Local2)
                \_SB.PCI0.LPC0.EC0.SMWR (0x08, 0x14, 0x01, Local2)
                \_SB.PCI0.LPC0.EC0.SMRD (0x09, 0x14, 0x01, RefOf (Local3))
                If (LEqual (Local2, Or (Local3, 0x0FFF)))
                {
                    If (LNot (\_SB.PCI0.LPC0.EC0.SMRD (0x09, 0x16, 0x10, RefOf (Local5))))
                    {
                        Store (Local5, Index (PBIF, 0x02))
                    }
                }

                If (LEqual (\_SB.PCI0.LPC0.EC0.SBID, 0x01))
                {
                    Store (0x1130, Index (PBIF, 0x01))
                    Store (0x39D0, Index (PBIF, 0x04))
                    Store ("01ZG", Index (PBIF, 0x09))
                    Store ("LION", Index (PBIF, 0x0B))
                    Store ("SMP ", Index (PBIF, 0x0C))
                }
                Else
                {
                    If (LEqual (\_SB.PCI0.LPC0.EC0.SBID, 0x02))
                    {
                        Store (0x0E10, Index (PBIF, 0x01))
                        Store (0x39D0, Index (PBIF, 0x04))
                        Store ("02ZG", Index (PBIF, 0x09))
                        Store ("LION", Index (PBIF, 0x0B))
                        Store ("SANYO", Index (PBIF, 0x0C))
                    }
                    Else
                    {
                        If (LEqual (\_SB.PCI0.LPC0.EC0.SBID, 0x03))
                        {
                            Store (0x1130, Index (PBIF, 0x01))
                            Store (0x39D0, Index (PBIF, 0x04))
                            Store ("03ZG", Index (PBIF, 0x09))
                            Store ("LION", Index (PBIF, 0x0B))
                            Store ("SANYO", Index (PBIF, 0x0C))
                        }
                        Else
                        {
                            Store (0x0E10, Index (PBIF, 0x01))
                            Store (0x39D0, Index (PBIF, 0x04))
                            Store ("02ZG", Index (PBIF, 0x09))
                            Store ("LION", Index (PBIF, 0x0B))
                            Store ("SANYO", Index (PBIF, 0x0C))
                        }
                    }
                }

                Store (0x01, Index (PBIF, 0x00))
                If (LEqual (SizeOf (\_OS), 0x27))
                {
                    Store (0x00, Index (PBIF, 0x00))
                }
            }

            Method (UPBS, 0, NotSerialized)
            {
                Store (\_SB.PCI0.LPC0.EC0.ACUR, Local5)
                Store (POSW (Local5), Index (PBST, 0x01))
                Store (\_SB.PCI0.LPC0.EC0.ABRM, Index (PBST, 0x02))
                Store (\_SB.PCI0.LPC0.EC0.ABVG, Index (PBST, 0x03))
                If (\_SB.PCI0.LPC0.EC0.SBTF)
                {
                    If (\_SB.PCI0.LPC0.EC0.ACDF)
                    {
                        Store (0x00, Index (PBST, 0x00))
                    }
                }
                Else
                {
                    If (\_SB.PCI0.LPC0.EC0.SBTC)
                    {
                        If (\_SB.PCI0.LPC0.EC0.ACDF)
                        {
                            Store (0x02, Index (PBST, 0x00))
                        }
                        Else
                        {
                            Store (0x00, Index (PBST, 0x00))
                        }
                    }
                    Else
                    {
                        If (\_SB.PCI0.LPC0.EC0.ACDF)
                        {
                            Store (0x00, Index (PBST, 0x00))
                        }
                        Else
                        {
                            Store (0x01, Index (PBST, 0x00))
                        }
                    }
                }
            }

            Method (IVBI, 0, NotSerialized)
            {
                Store (0xFFFFFFFF, Index (PBIF, 0x01))
                Store (0xFFFFFFFF, Index (PBIF, 0x02))
                Store (0xFFFFFFFF, Index (PBIF, 0x04))
                Store ("Bad", Index (PBIF, 0x09))
                Store ("      ", Index (PBIF, 0x0A))
                Store ("Bad", Index (PBIF, 0x0B))
                Store ("Bad", Index (PBIF, 0x0C))
            }

            Method (IVBS, 0, NotSerialized)
            {
                Store (0x00, Index (PBST, 0x00))
                Store (0xFFFFFFFF, Index (PBST, 0x01))
                Store (0xFFFFFFFF, Index (PBST, 0x02))
                Store (0x2710, Index (PBST, 0x03))
            }
        }

        Scope (\_TZ)
        {
            Name (TPL, 0x0CA0)
            Name (TAC1, 0x0D0E)
            Name (TAC0, 0x0D54)
            Name (TPAS, 0x0E44)
            Name (TPC, 0x0E94)
            Name (TPTM, 0x0C3C)
            Name (TBSE, 0x0AAC)
            Name (LTMP, 0x0CA0)
            Name (TVAR, Buffer (0x05)
            {
                0x00, 0x20, 0x1F, 0x0C, 0x1F
            })
            CreateByteField (TVAR, 0x00, PLCY)
            CreateWordField (TVAR, 0x01, CTOS)
            CreateWordField (TVAR, 0x03, CTHY)
            Device (FAN0)
            {
                Name (_HID, EisaId ("PNP0C0B"))
                Name (_UID, 0x01)
                Name (_PR0, Package (0x01)
                {
                    PFN0
                })
                Method (_PS0, 0, NotSerialized)
                {
                    Store ("Low Speed FAN - _PS0", Debug)
                }

                Method (_PS3, 0, NotSerialized)
                {
                    Store ("Low Speed FAN - _PS3", Debug)
                }
            }

            PowerResource (PFN0, 0x00, 0x0000)
            {
                Name (FNS1, 0x00)
                Name (FFST, 0x01)
                Method (_STA, 0, NotSerialized)
                {
                    Store (FNS1, Local1)
                    Return (Local1)
                }

                Method (_ON, 0, NotSerialized)
                {
                    Store (0x01, FNS1)
                    If (\_TZ.PFN1.FNS2)
                    {
                        Store ("FAN 1 (High speed already turn on) ", Debug)
                    }
                    Else
                    {
                        If (\_SB.OKEC)
                        {
                            Store (0xB4, \_SB.PCI0.LPC0.EC0.FSPD)
                            Store (0x01, \_SB.PCI0.LPC0.EC0.FPR1)
                        }
                    }

                    If (Or (LEqual (\_SB.PCI0.MYOS, 0x01), LEqual (\_SB.PCI0.MYOS, 0x03)))
                    {
                        \_TZ.THRM._SCP (0x01)
                    }
                }

                Method (_OFF, 0, NotSerialized)
                {
                    Store (0x00, FNS1)
                    If (LEqual (SizeOf (\_OS), 0x14))
                    {
                        If (\_SB.OKEC)
                        {
                            If (\_TZ.PFN1.FNS2)
                            {
                                Store (One, \_SB.PCI0.LPC0.EC0.FPR1)
                            }
                            Else
                            {
                                Store (Zero, \_SB.PCI0.LPC0.EC0.FPR1)
                            }
                        }
                    }
                    Else
                    {
                        If (LLess (FFST, 0x02))
                        {
                            Store (0x86, \_SB.PCI0.LPC0.BCMD)
                            Store (0x00, \_SB.PCI0.LPC0.SMIC)
                            Increment (FFST)
                        }
                        Else
                        {
                            If (\_SB.OKEC)
                            {
                                Store (0x00, \_SB.PCI0.LPC0.EC0.FPR1)
                            }
                        }
                    }

                    If (Or (LEqual (\_SB.PCI0.MYOS, 0x01), LEqual (\_SB.PCI0.MYOS, 0x03)))
                    {
                        \_TZ.THRM._SCP (0x01)
                    }
                }
            }

            Device (FAN1)
            {
                Name (_HID, EisaId ("PNP0C0B"))
                Name (_UID, 0x02)
                Name (_PR0, Package (0x02)
                {
                    PFN0, 
                    PFN1
                })
                Method (_PS0, 0, NotSerialized)
                {
                    Store ("High Speed FAN - _PS0", Debug)
                }

                Method (_PS3, 0, NotSerialized)
                {
                    Store ("High Speed FAN - _PS3", Debug)
                }
            }

            PowerResource (PFN1, 0x00, 0x0000)
            {
                Name (FNS2, 0x00)
                Method (_STA, 0, NotSerialized)
                {
                    Return (FNS2)
                }

                Method (_ON, 0, NotSerialized)
                {
                    Store (0x01, FNS2)
                    If (\_SB.OKEC)
                    {
                        Store (0xFF, \_SB.PCI0.LPC0.EC0.FSPD)
                        Store (0x01, \_SB.PCI0.LPC0.EC0.FPR1)
                    }

                    If (Or (LEqual (\_SB.PCI0.MYOS, 0x01), LEqual (\_SB.PCI0.MYOS, 0x03)))
                    {
                        \_TZ.THRM._SCP (0x01)
                    }
                }

                Method (_OFF, 0, NotSerialized)
                {
                    Store (Zero, FNS2)
                    Store (0x00, FNS2)
                    If (\_TZ.PFN0.FNS1)
                    {
                        If (\_SB.OKEC)
                        {
                            Store (0xB4, \_SB.PCI0.LPC0.EC0.FSPD)
                            Store (0x01, \_SB.PCI0.LPC0.EC0.FPR1)
                        }
                    }
                    Else
                    {
                        If (\_SB.OKEC)
                        {
                            Store (0x00, \_SB.PCI0.LPC0.EC0.FPR1)
                        }
                    }

                    If (Or (LEqual (\_SB.PCI0.MYOS, 0x01), LEqual (\_SB.PCI0.MYOS, 0x03)))
                    {
                        \_TZ.THRM._SCP (0x01)
                    }
                }
            }

            ThermalZone (THRM)
            {
                Name (_AL0, Package (0x01)
                {
                    FAN1
                })
                Method (_AC0, 0, NotSerialized)
                {
                    Return (TAC0)
                }

                Name (_AL1, Package (0x01)
                {
                    FAN0
                })
                Method (_AC1, 0, NotSerialized)
                {
                    Return (TAC1)
                }

                Method (_CRT, 0, NotSerialized)
                {
                    Return (TPC)
                }

                Method (_PSV, 0, NotSerialized)
                {
                    Return (TPAS)
                }

                Name (_TSP, 0x64)
                Method (_TMP, 0, NotSerialized)
                {
                    If (\_SB.OKEC)
                    {
                        Store (\_SB.PCI0.LPC0.EC0.CTMP, Local1)
                        Store ("Current Temperature is ----------- ", Debug)
                        Store (Local1, Debug)
                        Store (Local1, \_SB.CM25)
                        Add (Multiply (Local1, 0x0A), TBSE, Local1)
                    }
                    Else
                    {
                        Store (LTMP, Local1)
                    }

                    Return (Local1)
                }

                Name (_PSL, Package (0x01)
                {
                    \_PR.CPU0
                })
                Name (_TC1, 0x02)
                Name (_TC2, 0x03)
                Method (_SCP, 1, NotSerialized)
                {
                    Store (Zero, PLCY)
                    If (\_TZ.PFN0.FNS1)
                    {
                        If (LEqual (\_TZ.PFN1.FNS2, 0x00))
                        {
                            Store (0x0D22, TAC1)
                            Store (0x0D86, TAC0)
                        }
                        Else
                        {
                            Store (0x0D22, TAC1)
                            Store (0x0D40, TAC0)
                        }
                    }
                    Else
                    {
                        If (\_TZ.PFN1.FNS2)
                        {
                            Store (0x0D22, TAC1)
                            Store (0x0D40, TAC0)
                        }
                        Else
                        {
                            Store (0x0D40, TAC1)
                            Store (0x0D86, TAC0)
                        }
                    }

                    Store (0x0E44, TPAS)
                    Notify (\_TZ.THRM, 0x81)
                }
            }
        }

        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E"))
        }

        OperationRegion (EXCO, SystemIO, 0x72, 0x02)
        Field (EXCO, ByteAcc, NoLock, Preserve)
        {
            INDX,   8, 
            DATA,   8
        }

        IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
        {
            Offset (0x20), 
            ACST,   1, 
            OKEC,   1, 
            POPF,   1, 
            BLTF,   1, 
            W2KF,   2, 
            S4WP,   1, 
            FLA7,   1, 
            LSFG,   1, 
            LD10,   1, 
            PS2M,   1, 
            DISD,   3, 
            OVRL,   1, 
            Offset (0x22), 
            SLEE,   8, 
            BPFG,   8, 
            PWST,   8, 
            CM25,   8, 
            CM26,   8, 
            CM27,   8, 
            CM28,   16, 
            CM2A,   16, 
            F4FG,   1, 
            Offset (0x30), 
            CM30,   8, 
            CM31,   8, 
            CM32,   8
        }
    }
}


--Boundary-00=_1ApEByUb7ileMU1
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="boot-radeon.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="boot-radeon.c"

#define LRMI_DEBUG 1

#include <stdlib.h>
#include <stdio.h>
#include <lrmi.h>

void err(char *function, int exitval) {
	fprintf(stderr, "%s():\n");
	exit(exitval);
}

int main () {
	struct LRMI_regs regs;
	
	ioperm(0, 1024, 1);
	iopl(3);

	if (!LRMI_init()) {
		err("LRMI_init", 1);
	}

	memset(&regs, 0, sizeof(regs));
	
	/*
	   if ((pvp = xf86GetPciInfoForEntity(pInt->entityIndex)))
	   	X86_AX = (pvp->bus << 8) | (pvp->device << 3) | (pvp->func & 0x7);
	   pushw(pInt, X86_CS);
	   pushw(pInt, X86_IP);
	   X86_CS = pInt->BIOSseg;
	   X86_EIP = 0x0003;
	   X86_ES = 0;                  // standard pc es 
	*/

	regs.eax = ((1 << 8) | (0 << 3) | (0 & 0x7)) & 0x0000FFFF;
	regs.cs = 0x0000c000;
	regs.ip = 0x00000003;
	//regs.ip = 0;
	//regs.es = 0;

	if (!LRMI_call(&regs)) {
		err("LRMI_int", -1);
	}


	exit(0);
}

--Boundary-00=_1ApEByUb7ileMU1--


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
