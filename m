From: "Andreas Leppert" <wudmx-S0/GAf8tV78@public.gmane.org>
Subject: RE: throttling is not changing
Date: Mon, 13 Sep 2004 17:29:48 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1558615296@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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

hi,

dont know where's the problem... 

so i wanted to know, if my dsdt is broken. i disassembled my dsdt and compiled it using iasl.  it returns with one error:

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20040715 [Sep 13 2004]
Copyright (C) 2000 - 2004 Intel Corporation
Supports CPI Specification Revision 2.0C

dsdt.dsl 3081:     If (SS1)
Error  1037 -         ^ syntax error, unexpected PARSEOP_IF

ASL Input: dsdt.dsl - 3132 lines, 104097 bytes, 1533 keywords
Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 0 Optimizations

1) i'm really confused about it. does the throttling thing depends on my dsdt?
2) my dsdt is broken, isn't it?
3) where can i get more information about repairing this error? google didn't find something
4) don't know if you guys do this, so i just ask: do you repair dsdt from other people?

thanks in advance
Andreas Leppert

_______________________________________________________
WEB.DE Video-Mail - Sagen Sie mehr mit bewegten Bildern
Informationen unter: http://freemail.web.de/?mc=021199



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
