From: =?ISO-8859-2?Q?Rafa=B3?= <lista-SwppDJA1QMU+Zj8wmS2FlIcoqjos4MI6@public.gmane.org>
Subject: Re: [Acpi4asus-user] DSDT table for Asus L5F00GA
Date: Mon, 07 Jun 2004 23:49:48 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40C4E2FC.3060502@viktoria-poland.com.pl>
References: <40C23B64.4070603@viktoria-poland.com.pl> <20040607212832.GA16077@hell.org.pl> <40C4E25A.8000004@viktoria-poland.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40C4E25A.8000004-SwppDJA1QMU+Zj8wmS2FlIcoqjos4MI6@public.gmane.org>
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

User Karol Kozimor wrote:

 > Thus wrote Rafa=B3:
 >
 >> Hello
 >>
 >> I'm using Asus L5F00GA notebook. I checked if the DSDT table is=20
corect, as shown on http://forums.gentoo.org/viewtopic.php?t=3D122145=20
site. Well, it is not correct. When I try to compile table using iasl=20
compiler, I get the following error:
 >>
 >> Intel ACPI Component Architecture
 >> ASL Optimizing Compiler / AML Disassembler version 20040527 [Jun  4=20
2004]
 >> Copyright (C) 2000 - 2004 Intel Corporation
 >> Supports ACPI Specification Revision 2.0c
 >>
 >> dsdt.dsl  7416:     If (SS1)
 >> Error    1037 -      ^ syntax error, unexpected PARSEOP_IF
 >
 >
 >
 > Please supply your DSDT, or (even better) post it to acpi.sf.net.
 > The error is, on the other hand, quite common, you should be safe by
 > removing the If statements (i.e. unconditionally leaving the=20
definitions).


The tables are here:

http://wujek.kolko-rozancowe.org/dsdt.dsl

I took them with the following command:

cat /proc/acpi/dsdt > /dsdt
and then:
iasl -d /dsdt

I'm not sure if this is what you meant. If you wanted not disassembled=20
tables then they are here:

http://wujek.kolko-rozancowe.org/dsdt

I removed those IF statements in dsdt.dsl file and the compile errors=20
disappeared but there were still warnings. I've put those tables
somehow into the kernel (I modified the osl.c file as shown in some=20
tutorials). Kernel compiled succesfully, it booted with no
problems and there were less "method execution failed" messages.=20
However, the sleep states still don't work, making
echo 3 > /proc/acpi/sleep does not work at all, nothing happens and no=20
error messages are displayed. I have no idea how to make it work
and get rid off all those error messages during bootup :(

Best regards,
Rafal




-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
