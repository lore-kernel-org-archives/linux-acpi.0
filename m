From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI on a Fujitsu-Siemens Amilo L
Date: Mon, 31 May 2004 21:04:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040531190438.GB7926@poupinou.org>
References: <200405311839.20577.mailinglisten@merula.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, May 31, 2004 at 06:39:20PM +0200, Lars Amsel wrote:
> Hi all,
> 
> I'm trying to get ACPI work on my notebook as I bought it in autumn last year. 
> First I decided to wait for Fedora Core 2 with full 2.6 support but I waited 
> in vain (not for the release but for working ACPI).
> 
> So now I decided to have a view into details. I read 
> http://forums.gentoo.org/viewtopic.php?t=122145 and downloaded the iasl 
> compiler from intel, did a make on it (after fixing some pathes in the 
> Makefile) and decompiled it and tried to recompile. I got the following error
> 
> [root-uXme+rPq5IdZ5tFPsFZChg@public.gmane.org compiler]# ./iasl -tc dsdt.dsl
> 
> Intel ACPI Component Architecture
> ASL Optimizing Compiler / AML Disassembler version 20040527 [May 31 2004]
> Copyright (C) 2000 - 2004 Intel Corporation
> Supports ACPI Specification Revision 2.0c
> 
> dsdt.dsl  3097:     If (SS1)
> Error    1037 -      ^ syntax error, unexpected PARSEOP_IF
> 
> ASL Input:  dsdt.dsl - 3174 lines, 104798 bytes, 1533 keywords
> Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 0 Optimizations
> 

This is some instructions outside of a method which is not allowed by
acpi standard.  The only way to go is to remove them and to warn Fujitsu
that they are indeed wrong.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
