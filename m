From: Rathgeb Markus <maggu2810-S0/GAf8tV78@public.gmane.org>
Subject: No back ptr to Op: type 8
Date: Fri, 18 Nov 2005 00:55:49 +0100
Message-ID: <437D1885.7040706@web.de>
References: <971FCB6690CD0E4898387DBF7552B90E037163DE@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E037163DE-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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

i used the
ASL Optimizing Compiler version 20051102 [Nov 17 2005]
after decompiling i insert the line:
     External (\_PR.CPU0._PPC)
an compile it again

my question:
what means the line: No back ptr to Op: type 8


=======================================================================

./iasl -tc org_de.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20051102 [Nov 17 2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

No back ptr to Op: type 8
No back ptr to Op: type 8
No back ptr to Op: type 8
org_de.dsl   253:             Store (Zero, \_PR.CPU0._PPC)
Error    1061 -                   Object does not exist ^  (\_PR.CPU0._PPC)

org_de.dsl  2215:                                 Store (Zero, 
\_PR.CPU0._PPC)
Error    1061 -                                       Object does not 
exist ^  (\_PR.CPU0._PPC)

org_de.dsl  2220:                                 Store (0x02, 
\_PR.CPU0._PPC)
Error    1061 -                                       Object does not 
exist ^  (\_PR.CPU0._PPC)

org_de.dsl  3168:                             Store (Zero, \_PR.CPU0._PPC)
Error    1061 -                                   Object does not exist 
^  (\_PR.CPU0._PPC)

org_de.dsl  3173:                             Store (0x02, \_PR.CPU0._PPC)
Error    1061 -                                   Object does not exist 
^  (\_PR.CPU0._PPC)

org_de.dsl  3528:                         Store (Zero, \_PR.CPU0._PPC)
Error    1061 -                               Object does not exist ^ 
(\_PR.CPU0._PPC)

org_de.dsl  3535:                         Store (0x02, \_PR.CPU0._PPC)
Error    1061 -                               Object does not exist ^ 
(\_PR.CPU0._PPC)

org_de.dsl  3737:                     Store (0x02, \_PR.CPU0._PPC)
Error    1061 -                           Object does not exist ^ 
(\_PR.CPU0._PPC)

org_de.dsl  3747:                         Store (Zero, \_PR.CPU0._PPC)
Error    1061 -                               Object does not exist ^ 
(\_PR.CPU0._PPC)

org_de.dsl  3752:                         Store (0x02, \_PR.CPU0._PPC)
Error    1061 -                               Object does not exist ^ 
(\_PR.CPU0._PPC)

ASL Input:  org_de.dsl - 3762 lines, 129845 bytes, 1649 keywords
Compilation complete. 10 Errors, 0 Warnings, 0 Remarks, 2 Optimizations

=======================================================================

scite org_de.dsl
....

=======================================================================

  ./iasl -tc org_de.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler version 20051102 [Nov 17 2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

No back ptr to Op: type 8
No back ptr to Op: type 8
No back ptr to Op: type 8
ASL Input:  org_de.dsl - 3763 lines, 129875 bytes, 1649 keywords
AML Output: DSDT.aml - 14936 bytes 463 named objects 1186 executable opcodes

Compilation complete. 0 Errors, 0 Warnings, 0 Remarks, 2 Optimizations



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
