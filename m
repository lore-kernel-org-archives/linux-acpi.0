From: Lars Amsel <mailinglisten-Ztphx+FISXizQB+pC5nmwQ@public.gmane.org>
Subject: ACPI on a Fujitsu-Siemens Amilo L
Date: Mon, 31 May 2004 18:39:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200405311839.20577.mailinglisten@merula.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
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

Hi all,

I'm trying to get ACPI work on my notebook as I bought it in autumn last year. 
First I decided to wait for Fedora Core 2 with full 2.6 support but I waited 
in vain (not for the release but for working ACPI).

So now I decided to have a view into details. I read 
http://forums.gentoo.org/viewtopic.php?t=122145 and downloaded the iasl 
compiler from intel, did a make on it (after fixing some pathes in the 
Makefile) and decompiled it and tried to recompile. I got the following error

[root-uXme+rPq5IdZ5tFPsFZChg@public.gmane.org compiler]# ./iasl -tc dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20040527 [May 31 2004]
Copyright (C) 2000 - 2004 Intel Corporation
Supports ACPI Specification Revision 2.0c

dsdt.dsl  3097:     If (SS1)
Error    1037 -      ^ syntax error, unexpected PARSEOP_IF

ASL Input:  dsdt.dsl - 3174 lines, 104798 bytes, 1533 keywords
Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 0 Optimizations

If have no idea what to do next ("Da schau ich rein wie ein Schwein ins 
Uhrwerk." one would say in germany).

Anyone that could help me?

Cheers

Lars

DSDT dump:       http://www.merula.de/tmp/dsdt.dat
DSDT decompiled: http://www.merula.de/tmp/dsdt.dsl


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
