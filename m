From: Bradley Chapman <kakadu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Sager NP3760 DSDT - how to enable thermal zoning?
Date: Fri, 22 Oct 2004 14:37:59 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <e294b46e041022063770358b66@mail.gmail.com>
Reply-To: Bradley Chapman <kakadu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

(Please CC my e-mail address, I am not a member of this list)

Has anyone managed to successfully modify the DSDT of the Sager NP3760
(a rebranded Clevo M375E/M375W, IIRC) to support thermal zoning and
temperature monitoring?

Compiling the DSDT using iasl 20030918 returns the following errors:

# iasl -tc dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20021002 [Oct  2 2002]
Copyright (C) 2000 - 2002 Intel Corporation
Supports ACPI Specification Revision 2.0a

dsdt.dsl    22:             Method (_PPC, 0, NotSerialized)
Warning  2019 -                        ^ Not all control paths return
a value (_PPC)

dsdt.dsl    22:             Method (_PPC, 0, NotSerialized)
Warning  2026 -                        ^ Reserved method must return a
value (_PPC)

dsdt.dsl   148:             Method (_PDC, 1, NotSerialized)
Warning  2033 -  Unknown reserved name ^  (_PDC)

dsdt.dsl   201:             Method (_PSS, 0, NotSerialized)
Warning  2019 -                        ^ Not all control paths return
a value (_PSS)

dsdt.dsl   201:             Method (_PSS, 0, NotSerialized)
Warning  2026 -                        ^ Reserved method must return a
value (_PSS)

dsdt.dsl  1081:     Method (SBWB, 3, NotSerialized)
Warning  2019 -                ^ Not all control paths return a value (SBWB)

dsdt.dsl  1762:             Field (SMRM, DWordAcc, NoLock, Preserve)
Error    1047 -                       ^ Access width is greater than region size

dsdt.dsl  1765:                 GSRM,   1,
Error    1051 -                    ^ Access width of Field Unit
extends beyond region limit

dsdt.dsl  1766:                 DLCK,   1,
Error    1051 -                    ^ Access width of Field Unit
extends beyond region limit

dsdt.dsl  1767:                 DCLS,   1,
Error    1051 -                    ^ Access width of Field Unit
extends beyond region limit

dsdt.dsl  1768:                 DOPN,   1,
Error    1051 -                    ^ Access width of Field Unit
extends beyond region limit

dsdt.dsl  3025:                     Method (SARA, 0, NotSerialized)
Warning  2019 -                                ^ Not all control paths
return a value (SARA)

dsdt.dsl  3133:                     Method (WSWD, 4, NotSerialized)
Warning  2019 -                                ^ Not all control paths
return a value (WSWD)

dsdt.dsl  3520:                         /*** Missing
EndDependentFunctions descriptor */         })
Error    1071 -                                   Missing
EndDependentFn() macro in dependent resource list ^

dsdt.dsl  3661:                         /*** Missing
EndDependentFunctions descriptor */         })
Error    1071 -                                   Missing
EndDependentFn() macro in dependent resource list ^

dsdt.dsl  3732:                         /*** Missing
EndDependentFunctions descriptor */         })
Error    1071 -                                   Missing
EndDependentFn() macro in dependent resource list ^

dsdt.dsl  3745:                         /*** Missing
EndDependentFunctions descriptor */         })
Error    1071 -                                   Missing
EndDependentFn() macro in dependent resource list ^

dsdt.dsl  4160:                         /*** Missing
EndDependentFunctions descriptor */         })
Error    1071 -                                   Missing
EndDependentFn() macro in dependent resource list ^

dsdt.dsl  4229:                     /*** Missing EndDependentFunctions
descriptor */ })
Error    1071 -                           Missing EndDependentFn()
macro in dependent resource list ^

ASL Input:  dsdt.dsl - 4817 lines, 154622 bytes, 2139 keywords
Compilation complete. 11 Errors, 8 Warnings, 0 Remarks, 461 Optimizations

Do these errors have any bearing on the lack of thermal zoning?

The decompiled DSDT is available here (154K AML source): 
http://www.pryan.org/mozilla/site/TheOneKEA/misc/sager-np3760-dsdt.dsl

Brad


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
