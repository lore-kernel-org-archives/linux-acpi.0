From: Alexei Gilchrist <alexei-JAjqph6Yjy/o0IyPN7li9Ydd74u8MsAO@public.gmane.org>
Subject: Help debuging DSL ...
Date: Thu, 4 Dec 2003 12:04:29 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031204020429.GB955@physics.uq.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Hi, 

I've dissasembled the dsdt table for my machine (Panasonic W2) using
iasl -d dsdt.dat and tried recompiling it, with the following errors:

-----------------------------------------------------------------------------------------
> iasl -tc dsdt.dsl 

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20030918 [Sep 18 2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b

dsdt.dsl   176:                 Return (\_SB.PCI0.LPC0.EC0.EC02 (Arg1))
Warning  2030 -   Called method may not always return a value ^ 

dsdt.dsl   181:                 Return (\_SB.PCI0.LPC0.EC0.EC03 (Arg1, Arg2))
Warning  2030 -   Called method may not always return a value ^ 

dsdt.dsl   186:                 Return (\_SB.PCI0.LPC0.EC0.EC04 (Arg1, Arg2))
Warning  2030 -   Called method may not always return a value ^ 

dsdt.dsl   191:                 Return (\_SB.PCI0.LPC0.EC0.EC05 (Arg1, Arg2))
Error    1029 -                Called method returns no value ^ 

dsdt.dsl  1368:                     Method (SRCH, 0, NotSerialized)
Warning  2019 -                                ^ Not all control paths return a value (SRCH)

dsdt.dsl  1739:                     Method (EC03, 2, Serialized)
Warning  2019 -                                ^ Not all control paths return a value (EC03)

dsdt.dsl  1875:                     Method (EC02, 1, Serialized)
Warning  2019 -                                ^ Not all control paths return a value (EC02)

dsdt.dsl  1896:                     Method (EC04, 2, Serialized)
Warning  2019 -                                ^ Not all control paths return a value (EC04)

ASL Input:  dsdt.dsl - 4720 lines, 158659 bytes, 2567 keywords
Compilation complete. 1 Errors, 7 Warnings, 0 Remarks, 700 Optimizations
-----------------------------------------------------------------------------------------

It's easy to see where return values are missing in the code, but what should they be?
are there defauls success/failure values? 

e.g.

                   Method (EC05, 2, Serialized)
                    {
                        If (LEqual (Arg0, 0x00))
                        {
                            EC82 (0xF0, Arg1)
                        }
                    }

should return something on failure ....



Sorry if this is a stupid question but I'm new to ASL.

cheers,

Alexei


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
