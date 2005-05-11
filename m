From: DJAX <djax-whniv8GeeGkdnm+yROfE0A@public.gmane.org>
Subject: Whait is CFGD for?
Date: Wed, 11 May 2005 15:53:27 +0200
Message-ID: <42820E57.7030309@altern.org>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,
I got an Acer Aspire 1694WLMi with bios 3c25.
I try to fix the DSDT, but  I don't how to correct the last errors.
The compiler tell me about an object CFGD that doesn't exist, but I
don't know how and where to declare it and with  which value to
initialise it.

Can you help me?

Thank you
Didier


The original DSDT:
http://users.linuxbourg.ch/didier/informatique/acer1694/dsdt.20050509.original.dsl
My "in work" DSDT:
http://users.linuxbourg.ch/didier/informatique/acer1694/dsdt.20050509.custom.dsl
The iasl message :
-----------------------------------8<---------------------------------------------------------
iasl -tc  dsdt.20050509.custom.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20050309 [May  6 2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

dsdt.20050509.custom.dsl   450:                     Or (CFGD, 0xC0, CFGD)
Error    1022 -                      Object does not exist ^  (CFGD)

dsdt.20050509.custom.dsl   450:                     Or (CFGD, 0xC0, CFGD)
Error    1022 -                                  Object does not exist
^  (CFGD)

dsdt.20050509.custom.dsl   470:                     And (CFGD, 0x3F, CFGD)
Error    1022 -                       Object does not exist ^  (CFGD)

dsdt.20050509.custom.dsl   470:                     And (CFGD, 0x3F, CFGD)
Error    1022 -                                   Object does not exist
^  (CFGD)

dsdt.20050509.custom.dsl  2625:                             And (CFGD,
0x3F, CFGD)
Error    1022 -                               Object does not exist ^ 
(CFGD)

dsdt.20050509.custom.dsl  2625:                             And (CFGD,
0x3F, CFGD)
Error    1022 -                                           Object does
not exist ^  (CFGD)

dsdt.20050509.custom.dsl  2634:                             Or (CFGD,
0xC0, CFGD)
Error    1022 -                              Object does not exist ^  (CFGD)

dsdt.20050509.custom.dsl  2634:                             Or (CFGD,
0xC0, CFGD)
Error    1022 -                                          Object does not
exist ^  (CFGD)

ASL Input:  dsdt.20050509.custom.dsl - 6944 lines, 244149 bytes, 3203
keywords
Compilation complete. 8 Errors, 0 Warnings, 0 Remarks, 1116 Optimizations
--------------------------------->8---------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
