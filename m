From: Berthold Cogel <cogel-F8dkAKZEjLURtNtAH2Wc8g@public.gmane.org>
Subject: Acer Extensa 3002 WLMi: Help wanted fixing the DSDT
Date: Fri, 23 Sep 2005 23:50:18 +0200
Message-ID: <4334789A.8020803@rrz.uni-koeln.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Development <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hello!

I've exported the DSTD of my notebook (Acer Extensa 3002 WLMi) and tried
to recompile it:

--:<---

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20040715 [Sep 22 2004]
Copyright (C) 2000 - 2004 Intel Corporation
Supports ACPI Specification Revision 2.0c

dsdt.dsl.orig   245:     Method (_WAK, 1, NotSerialized)
Warning  2026 -                     ^ Reserved method must return a
value (_WAK)

dsdt.dsl.orig  4901:                         Method (_STA, 0, NotSerialized)
Warning  2019 -    Not all control paths return a value ^  (_STA)

dsdt.dsl.orig  4901:                         Method (_STA, 0, NotSerialized)
Warning  2026 -     Reserved method must return a value ^  (_STA)
ASL Input:  dsdt.dsl.orig - 5430 lines, 203286 bytes, 2595 keywords
AML Output: DSDT.aml - 22082 bytes 643 named objects 1952 executable opcodes

Compilation complete. 0 Errors, 3 Warnings, 0 Remarks, 723 Optimizations

--:<---


I've fixed the errors according to information I found in the list and
other sources:


--:<---

diff -c orig/dsdt.dsl.orig fixed/dsdt.dsl
*** orig/dsdt.dsl.orig  2005-08-23 23:51:15.000000000 +0200
--- fixed/dsdt.dsl      2005-08-27 19:50:55.000000000 +0200
***************
*** 295,300 ****
--- 295,301 ----
          }

          Store (0x00, \_SB.SLEE)
+       Return(Package(0x02){0x00, 0x00})
      }

      Scope (_GPE)
***************
*** 4917,4922 ****
--- 4918,4927 ----
                                              Return (0x0F)
                                          }
                                      }
+                                     Else
+                                     {
+                                         Return (0x08)
+                                     }
                                  }
                                  Else
                                  {

--:<---


Then I patched the DSDT with the code from the sbs-linux project
(sbs-cm-20050328, acer-tm4xxx-sbs-cm.diff). Recompiling gives some
errors I haven't fixed yet:


--:<---

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20040715 [Sep 22 2004]
Copyright (C) 2000 - 2004 Intel Corporation
Supports ACPI Specification Revision 2.0c

smbus-cm.asl    87:         Method (_SBI, 0, NotSerialized)
Warning  2033 -  Unknown reserved name ^  (_SBI)

smbus-cm.asl   147:         Method (_SBR, 3, NotSerialized)
Warning  2033 -  Unknown reserved name ^  (_SBR)

smbus-cm.asl   237:         Method (_SBW, 5, NotSerialized)
Warning  2033 -  Unknown reserved name ^  (_SBW)

smbus-cm.asl   314:         Method (_SBA, 0, NotSerialized)
Warning  2033 -  Unknown reserved name ^  (_SBA)

ASL Input:  dsdt.dsl - 5337 lines, 247867 bytes, 3171 keywords
AML Output: DSDT.aml - 25869 bytes 706 named objects 2465 executable opcodes

Compilation complete. 0 Errors, 4 Warnings, 0 Remarks, 921 Optimizations

--:<---


Does anybody know how to fix the DSDT?

Thanks,

Berthold




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
