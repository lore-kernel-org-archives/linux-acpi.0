From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-5ng0By4jB+/QUPosyRRdSA@public.gmane.org>
Subject: patch-2.4.20-pre7-pre8
Date: 09 Oct 2002 00:34:11 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1034138057.1464.24.camel@darkstar.portugal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi
this email is to try organize linux development.=20
the patch-2.4.20-pre7-pre8=20
HAVE patches for drives/acpi that is shipped with kernel 2.4.19, as I
thought this brings many confusion to make acpi patches , I
investigation o little more and find this patches is basically for arch
x86_64

made by:  =20

--- linux-2.4.20-pre7/arch/x86_64/mm/numa.c Wed Dec 31 16:00:00 1969
+++ linux-2.4.20-pre8/arch/x86_64/mm/numa.c Wed Sep 25 18:21:32 2002
@@ -0,0 +1,194 @@
+/*
+ * Generic VM initialization for x86-64 NUMA setups.
+ * Copyright 2002 Andi Kleen, SuSE Labs.
+ * $Id: numa.c,v 1.4 2002/09/05 15:28:12 ak Exp $

do someone know this person (Andi Kleen) ?
this person should know about this acpi project to integrated with him
project.

thanks
S=E9rgio Basto=20



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
