From: Junk Mail Recipient <bulk-wOwPqRMbTBJeoWH0uzbU5w@public.gmane.org>
Subject: ACPI errors on ECS G220 laptop
Date: Tue, 04 Oct 2005 21:49:13 -0500
Message-ID: <1128480553.11538.9.camel@tuxprototype.deadeyedata.net>
Reply-To: bulk-wOwPqRMbTBJeoWH0uzbU5w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain
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

I recently purchased an ECS G220 laptop with the hopes of running Suse
9.3 on it.  I am pretty well outta luck as far as acpi goes though.  The
battery monitor doesn't work at all.  It perpetually shows a 1% charge.
It also doesn't seem to be getting any thermal information.  CPU scaling
can be done manually, but is not happening automatically.  

I followed the how-to on broken dsdt and from iasl I get 1 error and no
warnings.  Unfortunately this seems to be a pretty generic syntax error
and I am at a loss on how to track it down or where to go from here.  

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20050309 [Mar 19
2005]
Copyright (C) 2000 - 2005 Intel Corporation
Supports ACPI Specification Revision 3.0

dsdt.dsl  1901:     If (SS1)
Error    1037 -      ^ syntax error, unexpected PARSEOP_IF

ASL Input:  dsdt.dsl - 2444 lines, 74888 bytes, 903 keywords
Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 0 Optimizations

I would really appreciate any help you might be able to offer.  I am
including links to dsdt.dsl and dmesg on an external site due to size.
Let me know if there is any more information that might help.

http://www.msbfr.net/dsdt.dsl

http://www.msbfr.net/dmesg




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
