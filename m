From: Sebastian Kemper <Sebastian.Kemper-S0/GAf8tV78@public.gmane.org>
Subject: Compaq Armada E500: tried to fix dsdt; need a little help
Date: Fri, 16 Jan 2004 09:55:15 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <4007A6F3.2030809@web.de>
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

Hello again,

with the help of a HowTo at Gentoo's forum I was able to fix most of the 
errors. But some remain and I would like you to take a look. I would 
really appreciate it if you read the full story in the Gentoo forum, 
because the formatting is better so you get a better insight in this 
matter and I already fixed many bugs but I'm not sure if my fixes are 
good. So If you would go to 
http://forums.gentoo.org/viewtopic.php?t=122145&postdays=0&postorder=asc&start=27 
I really appreciate it. Thanks!

This is what iasl now says:

micmobil iasl-linux-20030918 # ./iasl -tc dsdt.dsl

Intel ACPI Component Architecture
ASL Optimizing Compiler / AML Disassembler version 20030918 [Sep 18 2003]
Copyright (C) 2000 - 2003 Intel Corporation
Supports ACPI Specification Revision 2.0b

dsdt.dsl  2163:                     Store (Package (0x00) {}, Local0)
Warning  2018 -   Effective AML package length is zero ^

dsdt.dsl  2200:                     Store (Package (0x00) {}, Local0)
Warning  2018 -   Effective AML package length is zero ^

dsdt.dsl  2237:                     Store (Package (0x00) {}, Local0)
Warning  2018 -   Effective AML package length is zero ^

ASL Input:  dsdt.dsl - 5121 lines, 155964 bytes, 2995 keywords
AML Output: DSDT.aml - 22660 bytes 691 named objects 2304 executable opcodes

Compilation complete. 0 Errors, 3 Warnings, 0 Remarks, 1133 Optimizations
micmobil iasl-linux-20030918 #

The interesting parts in dsdt.dsl look like this:

2159 Method (_PCL, 0, NotSerialized)
2160             {
2161                 If (\_SB.C005.C013.C059.C08A ())
2162                 {
2163                     Store (Package (0x00) {}, Local0)
2164                 }
2165                 Else
2166                 {
2167                     Store (Package (0x01)
2168                         {
2169                             \_SB
2170                         }, Local0)
2171                 }
2172
2173                 Return (Local0)
2174             }

And I don't have a clue what to do here. I tried to change 'Package 
(0x00)' to 'Package (0x02)' and the warnings dissappeared. But I didn't 
know what I was really doing so I reversed my changes.

Another one is this:

dsdt.dsl   735:                 Return (^C08E (Arg0, Arg1, Arg2))
Error    1029 -                             ^ Called method returns no value


I read something about about "Return(Package(0x02){0x00, 0x00})" and 
thought "Hey, I gotta have one of these"

Code:

Method (C08E, 3, NotSerialized)
             {
                 Acquire (^C082, 0xFFFF)
                 Acquire (\_GL, 0xFFFF)
                 ^C08B ()
                 Store (0x07, C05B)
                 Store (Arg0, C05C)
                 Store (Arg1, C05B)
                 Store (Arg2, C05C)
                 ^C08C ()
                 Release (\_GL)
                 Release (^C082)
             }

             Method (C08F, 2, NotSerialized)
             {
                     Return (^C08D (Arg0, Arg1))
             }

             Method (C090, 3, NotSerialized)
             {
                 Return (^C08E (Arg0, Arg1, Arg2))
             }


changed to

Code:

Method (C08E, 3, NotSerialized)
             {
                 Acquire (^C082, 0xFFFF)
                 Acquire (\_GL, 0xFFFF)
                 ^C08B ()
                 Store (0x07, C05B)
                 Store (Arg0, C05C)
                 Store (Arg1, C05B)
                 Store (Arg2, C05C)
                 ^C08C ()
                 Release (\_GL)
                 Release (^C082)
              Return(Package(0x02){0x00, 0x00})
             }

             Method (C08F, 2, NotSerialized)
             {
                     Return (^C08D (Arg0, Arg1))
             }

             Method (C090, 3, NotSerialized)
             {
                 Return (^C08E (Arg0, Arg1, Arg2))
             }

But the writer of the dsdt HowTo at Gentoos forum said this may be not a 
good fix. What do you think?

Thanks

Sebastian


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
