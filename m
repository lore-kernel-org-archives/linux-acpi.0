From: Richard Harman <acpi-Am9021/vqXxTGLny65vKQgC/G2K4zDHf@public.gmane.org>
Subject: Compaq Evo N600c DSDT woes
Date: Mon, 25 Nov 2002 13:31:03 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200211251831.gAPIV3L16208@xabean.net>
Reply-To: Richard Harman <acpi-Am9021/vqXxTGLny65vKQgC/G2K4zDHf@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-ID: <16202.1038249055.1-EkWRDH7uiTINc2XoG/4OBl6hYfS7NtTn@public.gmane.org>
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

I read through the archives about the Bios Override procedure (http://www.intel.com/technology/iapc/acpi/bios_override.htm) and how to fix some of the common DSDT problems "*PNPFOO" v.s. "PNPFOO".  Did that.  I also saw somebody else had a N600c, but no fixed DSDT as far as I could tell.  I'm still getting errors from the iasl compiler, because I don't have any clue about the AML language (willing and eager to learn though).  Do I need to go download the AML docs in pdf and figure out what I need to "fix" based on what my hardware is?

Here are the errors from the iasl compiler (after taking out the *s in the name) -- My question is where do I go from here?

$ iasl -tc -p fixed dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20021115 [Nov 25 2002]
Copyright (C) 2000 - 2002 Intel Corporation
Supports ACPI Specification Revision 2.0b

dsdt.dsl    53:             If (LEqual (\C001, 0x00))
Error    1022 -       Object does not exist ^  (\C001)

dsdt.dsl  2900:                             Method (_OFF, 0, NotSerialized)
Warning  2019 -   Not all control paths return a value ^  (_OFF)

dsdt.dsl  4866:                         \_SB.C03A.C04E.C189
Error    1022 -                     Object does not exist ^  (\_SB.C03A.C04E.C18
9)

dsdt.dsl  5760:                 Store (C106 (0x1F, 0x00, 0x00, 0x00), Local0)
Error    1029 -                           ^ Called method returns no value

dsdt.dsl  5827:             Store (C106 (0x08, 0x00, 0x00, 0x00), Local0)
Error    1029 -                       ^ Called method returns no value

dsdt.dsl  6016:                 \_PR.C000
Error    1022 -   Object does not exist ^  (\_PR.C000)

dsdt.dsl  6072:                         Notify (\_PR.C000, 0x80)
Error    1022 -                   Object does not exist ^  (\_PR.C000)

dsdt.dsl  6145:                         Notify (\_PR.C000, 0x80)
Error    1022 -                   Object does not exist ^  (\_PR.C000)

ASL Input:  dsdt.dsl - 6402 lines, 217515 bytes, 3840 keywords
Compilation complete. 7 Errors, 1 Warnings, 0 Remarks, 1078 Optimizations


-------------------------------------------------
Richard G Harman Jr <acpi-Am9021/vqXxTGLny65vKQgC/G2K4zDHf@public.gmane.org>



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
