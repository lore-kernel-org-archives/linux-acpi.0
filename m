From: Karl Vogel <karl.vogel-/1BeJOKqmzrQT0dZR+AlfA@public.gmane.org>
Subject: Acer Aspire 1511LMi - battery unreadable
Date: Sun, 13 Jun 2004 22:16:25 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200406132216.25172.karl.vogel@seagha.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Recently bought an acer notebook (Athlon64 w/ nVidia nForce3), but it seems 
that there are problems with the ACPI tables. I've been reading up on the 
subject, but I'm unable to resolve the issue myself... so this is a cry for 
help :-)

When trying to read the battery status, I get the following kernel message:

---
  psargs-0352: *** Error: Looking up [Z005] in namespace, AE_NOT_FOUND
search_node c1521480 start_node c1521480 return_node 00000000
 psparse-1133: *** Error: [NULL NAME], AE_NOT_FOUND
 dswexec-0435 [225] ds_exec_end_op        : [Index]: Could not resolve 
operands, AE_NOT_FOUND
 psparse-1133: *** Error: Method execution failed [\_SB_.BAT1._BST] (Node 
c1520e80), AE_NOT_FOUND
acpi_battery-0207 [217] acpi_battery_get_statu: Error evaluating _BST
---


I tried patching the DSDT, but it doesn't cleanly compile with iasl. The 
following errors occur:

---
Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20040527 [Jun 11 2004]
Copyright (C) 2000 - 2004 Intel Corporation
Supports ACPI Specification Revision 2.0c

DSDT.dsl  2406:                             If (LLess (\_PR.CPU0._PPC, 
Local1))
Error    1022 -                               Object does not exist ^  
(\_PR.CPU0._PPC)

DSDT.dsl  2408:                                 Store (Local1, \_PR.CPU0._PPC)
Error    1022 -                                       Object does not exist ^  
(\_PR.CPU0._PPC)

DSDT.dsl  2421:                                     If (LNot (LEqual 
(\_PR.CPU0._PPC, 0x00)))
Error    1022 -                                              Object does not 
exist ^  (\_PR.CPU0._PPC)

DSDT.dsl  2423:                                         Store (0x00, 
\_PR.CPU0._PPC)
Error    1022 -                                             Object does not 
exist ^  (\_PR.CPU0._PPC)

DSDT.dsl  3865:                     Method (DRUL, 1, NotSerialized)
Warning  2019 -                                ^ Not all control paths return 
a value (DRUL)

DSDT.dsl  5074:                 Z005,
Error    1022 -                    ^ Object does not exist (Z005)

DSDT.dsl  5075:                 Z005,
Error    1022 -                    ^ Object does not exist (Z005)

DSDT.dsl  5347:     Method (\_WAK, 1, NotSerialized)
Warning  2026 -                 ^ Reserved method must return a value (_WAK)

ASL Input:  DSDT.dsl - 5420 lines, 192635 bytes, 2606 keywords
Compilation complete. 6 Errors, 2 Warnings, 0 Remarks, 644 Optimizations
---


The Z005 is never used, but it is present in a definition:

            Name (PBST, Package (0x04)
            {
                0x00,
                Z005,
                Z005,
                0x2710
            })


I replaced those with 0x000 (not sure what the default value should be, 0 
sounds logical).

The _PPC error is something I don't know how to resolve. Code looks like:

-- usage code:
                            If (LLess (\_PR.CPU0._PPC, Local1))
                            {
                                Store (Local1, \_PR.CPU0._PPC)
                                Notify (\_PR.CPU0, 0x80)
                                Sleep (0x01F4)
                            }
---

-- definition
    Scope (\_PR)
    {
        Processor (CPU0, 0x00, 0x00008010, 0x06) {}
    }
---

No _PPC here. I tried the following:

---
    Scope (\_PR)
    {
        Processor (CPU0, 0x00, 0x00008010, 0x06) {
        Name (_PPC, 0x00) }
    }
---

This I could compile, but my kernel crashed after this change.. so any ideas 
on how to fix this?!?

The DSDT is 23kb, so I'll refrain from posting it. If anybody wants it, just 
mail me directly.


ACPI info:

Jun 13 12:09:42 localhost kernel: ACPI: RSDP (v000 
PTLTD                                     ) @ 0x000f6ec0
Jun 13 12:09:42 localhost kernel: ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  
LTP 0x00000000) @ 0x1ff792fd
Jun 13 12:09:42 localhost kernel: ACPI: FADT (v001 NVIDIA CK8      0x06040000 
PTL_ 0x000f4240) @ 0x1ff7ee3e
Jun 13 12:09:42 localhost kernel: ACPI: MADT (v001 NVIDIA NV_APIC_ 0x06040000  
LTP 0x00000000) @ 0x1ff7eeb2
Jun 13 12:09:42 localhost kernel: ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  
LTP 0x00000001) @ 0x1ff7ef02
Jun 13 12:09:42 localhost kernel: ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  
LTP 0x00000001) @ 0x1ff7efd8
Jun 13 12:09:42 localhost kernel: ACPI: DSDT (v001 NVIDIA      CK8 0x06040000 
MSFT 0x0100000e) @ 0x00000000


Regards,
Karl


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
