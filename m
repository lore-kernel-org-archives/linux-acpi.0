From: Frank Bruno <fbruno-K2GnTyEPumIAvxtiuMwx3w@public.gmane.org>
Subject: Non-power related ACPI devices (help)
Date: Sun, 26 Jan 2003 18:03:19 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3E346937.7080100@attbi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000602010507010802090405"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------000602010507010802090405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello,
I've installed Redhat 8.0 on a Compaq TC1000 tablet computer that I own. 
I upgraded the kernel to 2.4.20+ the corresponding ACPI patch from 
sourceforge. I have compiled the kernel with CONFIG_ACPI_DEBUG. The 
TC1000 is fairly standard except for two devices. The first being the 
touchscreen and the second some related buttons. I finally tracked down 
the devices under windows and found that both are configured via ACPI. 
I've attached the corresponding snippet from dsdt.

The first device is nothing more than a serial port on com1 (I believe). 
The corresponding windows driver is a serial driver. The other one I am 
not sure about.

My question is: how can i get these devices initialized via ACPI? If 
someone could point me in the right direction, I'd greatly appreciate it.

Thanks,
Frank



--------------000602010507010802090405
Content-Type: text/plain;
 name="stuff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stuff"


                Device (DIGI)
                {
                    Name (_HID, EisaId ("FPI2002"))
                    Name (_UID, 0x01)
                    Name (RSRC, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0000, 0x0000, 0x08, 0x08)
                        IRQNoFlags () {}
                    })
                    Name (_PRS, ResourceTemplate ()
                    {
                        StartDependentFn (0x00, 0x01)
                        {
                            IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                            IRQNoFlags () {4}
                        }
                        EndDependentFn ()
                    })
                    OperationRegion (VSIO, SystemIO, 0x03F0, 0x02)
                    Field (VSIO, ByteAcc, NoLock, Preserve)
                    {
                        INDX,   8, 
                        DATA,   8
                    }

                    IndexField (INDX, DATA, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0xE2), 
                        CRE2,   8, 
                        CRE3,   8, 
                        Offset (0xE6), 
                        CRE6,   8, 
                        CRE7,   8, 
                        CRE8,   8, 
                        Offset (0xEE), 
                        CREE,   8
                    }

                    Method (ENCG, 0, NotSerialized)
                    {
                        Store (\_SB.PCI0.PIB.EXFE, Local0)
                        Or (Local0, 0x02, Local0)
                        Store (Local0, \_SB.PCI0.PIB.EXFE)
                    }

                    Method (EXCG, 0, NotSerialized)
                    {
                        Store (\_SB.PCI0.PIB.EXFE, Local0)
                        And (Local0, 0xFD, Local0)
                        Store (Local0, \_SB.PCI0.PIB.EXFE)
                    }

                    Method (_STA, 0, NotSerialized)
                    {
                        ENCG ()
                        Store (CRE2, Local0)
                        And (Local0, 0x04, Local0)
                        If (Local0)
                        {
                            Store (CRE7, Local1)
                            EXCG ()
                            Return (0x0F)
                        }

                        EXCG ()
                        Return (0x0D)
                    }

                    Method (_DIS, 0, NotSerialized)
                    {
                        ENCG ()
                        Store (CRE2, Local0)
                        And (Local0, 0xFB, Local0)
                        Store (Local0, CRE2)
                        Store (Zero, CRE7)
                        EXCG ()
                        Store (Zero, \_SB.PCI0.PIB.SAIQ)
                    }

                    Method (_CRS, 0, NotSerialized)
                    {
                        Name (BUF0, ResourceTemplate ()
                        {
                            IO (Decode16, 0x03F8, 0x03F8, 0x08, 0x08)
                            IRQNoFlags () {4}
                        })
                        CreateByteField (BUF0, 0x02, IOLO)
                        CreateByteField (BUF0, 0x03, IOHI)
                        CreateByteField (BUF0, 0x04, IORL)
                        CreateByteField (BUF0, 0x05, IORH)
                        CreateByteField (BUF0, 0x09, IRQL)
                        ENCG ()
                        Store (CRE7, Local0)
                        Store (Local0, Local1)
                        And (Local1, 0xC0, Local1)
                        ShiftRight (Local1, 0x06, Local1)
                        And (Local0, 0x3F, Local0)
                        ShiftLeft (Local0, 0x02, Local0)
                        Store (Local0, IOLO)
                        Store (Local1, IOHI)
                        Store (IOLO, IORL)
                        Store (IOHI, IORH)
                        EXCG ()
                        Store (\_SB.PCI0.PIB.SAIQ, Local0)
                        Store (0x01, Local1)
                        ShiftLeft (Local1, Local0, IRQL)
                        Return (BUF0)
                    }

                    Method (_SRS, 1, NotSerialized)
                    {
                        CreateByteField (Arg0, 0x02, IOLO)
                        CreateByteField (Arg0, 0x03, IOHI)
                        CreateByteField (Arg0, 0x09, IRQL)
                        ENCG ()
                        Store (CRE2, Local0)
                        And (Local0, 0xFB, Local0)
                        Store (Local0, CRE2)
                        Store (IOLO, Local0)
                        ShiftRight (Local0, 0x02, Local0)
                        And (Local0, 0xFE, Local0)
                        Store (IOHI, Local1)
                        ShiftLeft (Local1, 0x06, Local1)
                        Or (Local0, Local1, Local0)
                        Store (Local0, CRE7)
                        FindSetRightBit (IRQL, Local0)
                        Decrement (Local0)
                        Store (Local0, \_SB.PCI0.PIB.SAIQ)
                        Store (CRE2, Local0)
                        Or (Local0, 0x04, Local0)
                        Store (Local0, CRE2)
                        EXCG ()
                    }
                }

                Device (BTNS)
                {
                    Name (_HID, "Compaq TabletPC Buttons")
                    Name (_CRS, ResourceTemplate ()
                    {
                        IO (Decode16, 0x0060, 0x0060, 0x01, 0x01)
                        IO (Decode16, 0x0064, 0x0064, 0x01, 0x01)
                        IRQ (Edge, ActiveHigh, Exclusive) {1}
                    })
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }
                }


--------------000602010507010802090405--



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
