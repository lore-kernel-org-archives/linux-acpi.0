From: Gregor Pirnaver <gregor.pirnaver-P4JjCWVWlXs@public.gmane.org>
Subject: Fixing DSDT (SOLOnote P1556P)
Date: Mon, 29 Nov 2004 09:34:13 +0100
Message-ID: <200411290934.13740.gregor.pirnaver@email.si>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello everyone (this is my first post to this list),

I'm trying to fix DSDT for laptop SOLOnote P1556P, but I 
don't know how I should define CPU0 and CPU0.CSTX to fix 
compile errors I get.

Files:

Original DSDT:
http://mandrakeprinas.org/prenos/SOLOnote_dsdt.dat.gz
http://mandrakeprinas.org/prenos/SOLOnote_dsdt.dsl.gz

DSDT with two compile errors (hopefully correctly) fixed:
http://mandrakeprinas.org/prenos/SOLOnote_dsdt_two_errors_fixed.dsl.gz


And the error I don't know how to fix:

$ ./iasl -tc SOLOnote_dsdt_two_errors_fixed.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20041105 
[Nov 28 2004]
Copyright (C) 2000 - 2004 Intel Corporation
Supports ACPI Specification Revision 2.0c

SOLOnote_dsdt_two_errors_fixed.dsl   305:                 
\_PR.CPU0
Error    1022 -                             Object does not 
exist ^  (\_PR.CPU0)

SOLOnote_dsdt_two_errors_fixed.dsl   384:                 
\_PR.CPU0
Error    1022 -                             Object does not 
exist ^  (\_PR.CPU0)

SOLOnote_dsdt_two_errors_fixed.dsl  2652:                         
Notify (\_PR.CPU0, 0x80)
Error    1022 -                                             
Object does not exist ^  (\_PR.CPU0)

SOLOnote_dsdt_two_errors_fixed.dsl  2653:                         
Notify (\_PR.CPU0, 0x81)
Error    1022 -                                             
Object does not exist ^  (\_PR.CPU0)

SOLOnote_dsdt_two_errors_fixed.dsl  2663:                         
Notify (\_PR.CPU0, 0x80)
Error    1022 -                                             
Object does not exist ^  (\_PR.CPU0)

SOLOnote_dsdt_two_errors_fixed.dsl  2668:                         
Store (0x55, \_PR.CPU0.CSTX)
Error    1022 -                                                       
Object does not exist ^  (\_PR.CPU0.CSTX)

SOLOnote_dsdt_two_errors_fixed.dsl  2669:                         
Notify (\_PR.CPU0, 0x81)
Error    1022 -                                             
Object does not exist ^  (\_PR.CPU0)

SOLOnote_dsdt_two_errors_fixed.dsl  2674:                         
Store (0x00, \_PR.CPU0.CSTX)
Error    1022 -                                                       
Object does not exist ^  (\_PR.CPU0.CSTX)

SOLOnote_dsdt_two_errors_fixed.dsl  2675:                         
Notify (\_PR.CPU0, 0x81)
Error    1022 -                                             
Object does not exist ^  (\_PR.CPU0)

ASL Input:  SOLOnote_dsdt_two_errors_fixed.dsl - 4314 lines, 
149203 bytes, 2044 keywords
Compilation complete. 9 Errors, 0 Warnings, 0 Remarks, 387 
Optimizations


-- 
Uporabnik Mandrake Linuxa
http://MandrakePriNas.org/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
