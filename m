From: =?ISO-8859-2?Q?Rafa=B3?= <lista-SwppDJA1QMU+Zj8wmS2FlIcoqjos4MI6@public.gmane.org>
Subject: DSDT table for Asus L5F00GA
Date: Fri, 04 Jun 2004 20:15:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40C0BC2D.4060907@viktoria-poland.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hello

I'm using Asus L5F00GA notebook. I checked if the DSDT table is corect, 
as shown on http://forums.gentoo.org/viewtopic.php?t=122145 site. Well, 
it is not correct. When I try to compile table using iasl compiler, I 
get the following error:

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20040527 [Jun  4 2004]
Copyright (C) 2000 - 2004 Intel Corporation
Supports ACPI Specification Revision 2.0c

dsdt.dsl  7416:     If (SS1)
Error    1037 -      ^ syntax error, unexpected PARSEOP_IF

ASL Input:  dsdt.dsl - 7426 lines, 249938 bytes, 3268 keywords
Compilation complete. 1 Errors, 0 Warnings, 0 Remarks, 0 Optimizations

DSDT table after disassembly is here: 
http://wujek.kolko-rozancowe.org/dsdt.dsl

Line nr 7416 is: "IF (SS1)" (it will be easier for you to find :) ).

Second question, I get the following error messages during bootup:

ay 31 16:43:03 laptop ACPI-1133: *** Error: Method execution failed 
[\_GPE._L1E] (Node c14d5e9c), AE_NOT_EXIST
May 31 16:43:03 laptop ACPI-0295: *** Error: AE_NOT_EXIST while 
evaluating method [_L1E] for GPE[ 0]
May 31 16:43:03 laptop ACPI-1133: *** Error: Method execution failed 
[\_GPE._L1E] (Node c14d5e9c), AE_NOT_EXIST
May 31 16:43:03 laptop ACPI-0295: *** Error: AE_NOT_EXIST while 
evaluating method [_L1E] for GPE[ 0]
May 31 16:43:03 laptop ACPI-1133: *** Error: Method execution failed 
[\_GPE._L1E] (Node c14d5e9c), AE_NOT_EXIST
May 31 16:43:03 laptop ACPI-0295: *** Error: AE_NOT_EXIST while 
evaluating method [_L1E] for GPE[ 0]
May 31 16:43:03 laptop ACPI-1133: *** Error: Method execution failed 
[\_GPE._L1E] (Node c14d5e9c), AE_NOT_EXIST
May 31 16:43:03 laptop ACPI-0295: *** Error: AE_NOT_EXIST while 
evaluating method [_L1E] for GPE[ 0]
May 31 16:43:03 laptop ACPI-1133: *** Error: Method execution failed 
[\_GPE._L1E] (Node c14d5e9c), AE_NOT_EXIST
May 31 16:43:03 laptop ACPI-0295: *** Error: AE_NOT_EXIST while 
evaluating method [_L1E] for GPE[ 0]
May 31 16:43:03 laptop ACPI-1133: *** Error: Method execution failed 
[\_GPE._L1E] (Node c14d5e9c), AE_NOT_EXIST
May 31 16:43:03 laptop ACPI-0295: *** Error: AE_NOT_EXIST while 
evaluating method [_L1E] for GPE[ 0]
May 31 16:43:03 laptop ACPI-1133: *** Error: Method execution failed 
[\_GPE._L1E] (Node c14d5e9c), AE_NOT_EXIST
May 31 16:43:03 laptop ACPI-0295: *** Error: AE_NOT_EXIST while 
evaluating method [_L1E] for GPE[ 0]
May 31 16:43:03 laptop ACPI: Interpreter enabled

What is wrong?

Sorry for my language, I hope you understood everything ;)

Best regards,
Rafal


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
