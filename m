From: Murray Shields <murray-U+3wZKuTe26HXe+LvDLADg@public.gmane.org>
Subject: Need help the DSDT on an ASUS M6000R
Date: Sat, 24 Jul 2004 10:16:59 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4101AA7B.7040006@mu.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

I can't get the ACPI fully working on my ASUS M600R - specifically I 
can't detect the battery or the state of the AC adaptor. Everything else 
is okay.

When I modprobe battery and ac I get the following errors in dmesg:

Jul 11 22:40:38 asok ACPI-0406: *** Error: Handler for [EmbeddedControl] 
returned AE_TIME
Jul 11 22:40:38 asok ACPI-1133: *** Error: Method execution failed 
[\_SB_.PCI0.SBRG.EC0_.SMBR] (Node f7f2bf80), AE_TIME
Jul 11 22:40:38 asok ACPI-1133: *** Error: Method execution failed 
[\_SB_.PCI0.SBRG.EC0_.BIF0] (Node f7f2b7a0), AE_TIME
Jul 11 22:40:38 asok ACPI-1133: *** Error: Method execution failed 
[\_SB_.PCI0.BAT0._BIF] (Node f7f2a980), AE_TIME
Jul 11 22:40:50 asok ACPI-0406: *** Error: Handler for [EmbeddedControl] 
returned AE_TIME
Jul 11 22:40:50 asok ACPI-1133: *** Error: Method execution failed 
[\_SB_.PCI0.SBRG.EC0_.RDC3] (Node f7f2b3a0), AE_TIME
Jul 11 22:40:50 asok ACPI-1133: *** Error: Method execution failed 
[\ECIO] (Node f7f2bdc0), AE_TIME
Jul 11 22:40:50 asok ACPI-1133: *** Error: Method execution failed 
[\_SB_.PCI0.SBRG.EC0_.ACPS] (Node f7f2b440), AE_TIME
Jul 11 22:40:50 asok ACPI-1133: *** Error: Method execution failed 
[\ACPS] (Node f7f28b00), AE_TIME
Jul 11 22:40:50 asok ACPI-1133: *** Error: Method execution failed 
[\_SB_.PCI0.AC0_._PSR] (Node f7f2aba0), AE_TIM

If I extract then try to recompile the DSDT I get the following errors:

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20021002 [Oct  2 2002]
Copyright (C) 2000 - 2002 Intel Corporation
Supports ACPI Specification Revision 2.0a

dsdt.dsl  1714:                         Method (_PDC, 1, NotSerialized)
Warning  2033 -              Unknown reserved name ^  (_PDC)

dsdt.dsl  3073:                 Scope (\_SB.PCI0)
Warning  2031 -        Internal compiler error ^  (Not using optimized 
name - did not find node)

ASL Input:  dsdt.dsl - 5527 lines, 192073 bytes, 2719 keywords
AML Output: DSDT.aml - 20786 bytes 744 named objects 1975 executable opcodes

Compilation complete. 0 Errors, 2 Warnings, 0 Remarks, 686 Optimizations

The offending lines of code in context are:




                Scope (\_PR)
                {
                    Processor (CPU1, 0x01, 0x00000810, 0x06)
                    {
                        OperationRegion (SSDT, SystemMemory, 0x3DF45C70, 
0xFFFF)
                        Name (NCPU, 0x01)
                        Name (TYPE, 0x80000000)
                        Name (HNDL, 0x80000000)
                        Method (_PDC, 1, NotSerialized) 
<<<<<<<<<<<<<<<<<<<<<
                        {                Scope (\_SB.PCI0)
                {
                    Device (BAT0)
                    {
                        Name (_HID, EisaId ("PNP0C0A"))
                        Name (_UID, 0x00)
                        Name (_PCL, Package (0x01)
                        {
                            \_SB.PCI0
                        })
                        Method (_STA, 0, NotSerialized)
                        {
                            If (\_SB.PCI0.SBRG.EC0.BATP (0x00))
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x0F)
                            }
                        }

                            CreateDWordField (Arg0, 0x08, DAT0)
                            Store (DAT0, TYPE)
                        }

                        Name (_CST, Package (0x02)
                        {
                            0x01,
                            Package (0x04)
                            {
                                ResourceTemplate ()
                                {
                                    Register (SystemIO, 0x08, 0x00, 
0x0000000000000814)
                                },

                                0x02,
                                0x12,
                                0x03E8
                            }
                        })
                    }
                }

and


                Scope (\_SB.PCI0)
                {
                    Device (BAT0)
                    {
                        Name (_HID, EisaId ("PNP0C0A"))
                        Name (_UID, 0x00)
                        Name (_PCL, Package (0x01)
                        {
                            \_SB.PCI0
                        })
                        Method (_STA, 0, NotSerialized)
                        {
                            If (\_SB.PCI0.SBRG.EC0.BATP (0x00))
                            {
                                Return (0x1F)
                            }
                            Else
                            {
                                Return (0x0F)
                            }
                        }


Any help would be appreciated...

Thanks.

-- 
======================================================================
Murray Shields                                 Email: murray-U+3wZKuTe26HXe+LvDLADg@public.gmane.org
MU Systems Pty Ltd                              Phone: +61 7 3253 1222



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
