From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Toshiba Satellite 1905S303 DSDT table
Date: Tue, 4 Nov 2003 11:39:43 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031104103943.GJ21970@poupinou.org>
References: <3FA58FE8.4000409@techisa.srv.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3FA58FE8.4000409-cz9lu//xMc+vYRxJAoKWRg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Erico M Mendonca <erico-cz9lu//xMc+vYRxJAoKWRg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Nov 02, 2003 at 09:14:48PM -0200, Erico M Mendonca wrote:
> I'm currently trying to debug the DSDT table of this aforementioned 
> machine, and managed to clear all the errors, except for this one:
> =================
> Intel ACPI Component Architecture
> ASL Optimizing Compiler / AML Disassembler version 20030918 [Sep 18 2003]
> Copyright (C) 2000 - 2003 Intel Corporation
> Supports ACPI Specification Revision 2.0b
> 
> s303.asl   468:                 If(\_OSI) {
> Error    1028 -      Too few arguments ^  (\_OSI requires 1)
> 
> s303.asl   469:                     "Windows 2001"
> Error    1037 -                                  ^ parse error, 
> unexpected PARSEOP_STRING_LITERAL
> 
> ASL Input:  s303.asl - 2871 lines, 112889 bytes, 2084 keywords
> Compilation complete. 2 Errors, 0 Warnings, 0 Remarks, 538 Optimizations
> ==============
> 

FYI I have debugged a *lot* of similar models.  What is the
problem you encounter for that one?


-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
