From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Re: [Acpi4asus-user] DSDT table for Asus L5F00GA
Date: Tue, 8 Jun 2004 15:51:10 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040608135110.GR13782@poupinou.org>
References: <40C23B64.4070603@viktoria-poland.com.pl> <20040607212832.GA16077@hell.org.pl> <40C4E25A.8000004@viktoria-poland.com.pl> <40C4E2FC.3060502@viktoria-poland.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <40C4E2FC.3060502-SwppDJA1QMU+Zj8wmS2FlIcoqjos4MI6@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rafa? <lista-SwppDJA1QMU+Zj8wmS2FlIcoqjos4MI6@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 07, 2004 at 11:49:48PM +0200, Rafa? wrote:
> User Karol Kozimor wrote:
> 
> > Thus wrote Rafa?:
> >
> >> Hello
> >>
> >> I'm using Asus L5F00GA notebook. I checked if the DSDT table is 
> corect, as shown on http://forums.gentoo.org/viewtopic.php?t=122145 
> site. Well, it is not correct. When I try to compile table using iasl 
> compiler, I get the following error:
> >>
> >> Intel ACPI Component Architecture
> >> ASL Optimizing Compiler / AML Disassembler version 20040527 [Jun  4 
> 2004]
> >> Copyright (C) 2000 - 2004 Intel Corporation
> >> Supports ACPI Specification Revision 2.0c
> >>
> >> dsdt.dsl  7416:     If (SS1)
> >> Error    1037 -      ^ syntax error, unexpected PARSEOP_IF


I've hacked a little your ASL, though I do have some trouble with.
It give me something like that: 

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20040427 [May 19
2004]
Copyright (C) 2000 - 2004 Intel Corporation
Supports ACPI Specification Revision 2.0c

Asus_L5F00GA.dsl  2214:                 Scope (\_SB.PCI0)
Warning  2031 -                Internal compiler error ^  (Not using
optimized name - did not find node)

Asus_L5F00GA.dsl  3433:                 Scope (\_SB.PCI0)
Warning  2031 -                Internal compiler error ^  (Not using
optimized name - did not find node)

Asus_L5F00GA.dsl  3488:                 Scope (\_SB.PCI0)
Warning  2031 -                Internal compiler error ^  (Not using
optimized name - did not find node)

ASL Input:  Asus_L5F00GA.dsl - 7474 lines, 250731 bytes, 3279 keywords
AML Output: DSDT.aml - 26221 bytes 888 named objects 2391 executable
opcodes

Compilation complete. 0 Errors, 3 Warnings, 0 Remarks, 714 Optimizations


I'm not sure exactly what is the trouble yet, but perhaps someone can
help?


Note that only the first change is  important, since the method
will return _without_ releasing a mutex.


--- Asus_L5F00GA.dsl	2004/06/08 13:35:21	1.1
+++ Asus_L5F00GA.dsl	2004/06/08 13:42:48
@@ -4836,8 +4836,8 @@
                         {
                             Acquire (PSMX, 0xFFFF)
                             ISMI (\GTDD)
-                            Return (\ACTD)
                             Release (PSMX)
+                            Return (\ACTD)
                         }
 
                         Method (ADVD, 0, NotSerialized)
@@ -7413,8 +7413,6 @@
         0x00, 
         0x00
     })
-    If (SS1)
-    {
         Name (_S1, Package (0x04)
         {
             0x01, 
@@ -7422,10 +7420,7 @@
             0x00, 
             0x00
         })
-    }
 
-    If (SS3)
-    {
         Name (_S3, Package (0x04)
         {
             0x05, 
@@ -7433,10 +7428,7 @@
             0x00, 
             0x00
         })
-    }
 
-    If (SS4)
-    {
         Name (_S4, Package (0x04)
         {
             0x06, 
@@ -7444,7 +7436,6 @@
             0x00, 
             0x00
         })
-    }
 
     Name (_S5, Package (0x04)
     {

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
