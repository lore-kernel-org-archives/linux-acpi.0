From: Cam <camilo-Nk/s8sJ9yP7QXOPxS62xeg@public.gmane.org>
Subject: Re: ACPI on a Fujitsu-Siemens Amilo L
Date: Mon, 31 May 2004 18:55:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40BB718A.9090104@mesias.co.uk>
References: <200405311839.20577.mailinglisten@merula.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200405311839.20577.mailinglisten-Ztphx+FISXizQB+pC5nmwQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Lars Amsel <mailinglisten-Ztphx+FISXizQB+pC5nmwQ@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Lars

> I'm trying to get ACPI work on my notebook as I bought it in autumn last year. 
> First I decided to wait for Fedora Core 2 with full 2.6 support but I waited 
> in vain (not for the release but for working ACPI).

What doesn't work, is it failing to suspend/resume or are events not 
working, or does it not report the battery etc.?

I have found that on my machine suspend/resume only works reliably with 
some kernels, I pass the acpi_os_name because it is "Linux" in the 
Fedora kernels, also I have to rmmod and modprobe battery before it will 
start detecting a battery present.

> [root-uXme+rPq5IdZ5tFPsFZChg@public.gmane.org compiler]# ./iasl -tc dsdt.dsl
> 
> Intel ACPI Component Architecture
> ASL Optimizing Compiler / AML Disassembler version 20040527 [May 31 2004]
> Copyright (C) 2000 - 2004 Intel Corporation
> Supports ACPI Specification Revision 2.0c
> 
> dsdt.dsl  3097:     If (SS1)
> Error    1037 -      ^ syntax error, unexpected PARSEOP_IF

I'm guessing something before that point is causing confusion. Maybe 
post a little more of the input file for the gurus to examine.

FYI I have a laptop that now suspends and resumes, and reports battery 
info with Fedora Core 2 - but it was not easily achieved! Also I 
recompiled the kernel and patched the DSDT a few times but was not able 
to effect an improvement that way...

-Cam


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
