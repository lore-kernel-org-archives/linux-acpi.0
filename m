From: Martin Michlmayr <tbm-R+vWnYXSFMfQT0dZR+AlfA@public.gmane.org>
Subject: Re: Toshiba Satellite 1905S303 DSDT table
Date: Mon, 3 Nov 2003 21:13:15 +1100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031103101315.GA2100@deprecation.cyrius.com>
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

* Erico M Mendonca <erico-cz9lu//xMc+vYRxJAoKWRg@public.gmane.org> [2003-11-02 21:14]:
> machine, and managed to clear all the errors, except for this one:

> s303.asl   468:                 If(\_OSI) {
> Error    1028 -      Too few arguments ^  (\_OSI requires 1)
> s303.asl   469:                     "Windows 2001"
> Error    1037 -                                  ^ parse error, 

I managed to fix this error with the following change:

--- dsdt.asl.orig	2003-10-25 18:43:53.000000000 +1000
+++ dsdt.asl	2003-10-25 18:47:02.000000000 +1000
@@ -144,8 +144,7 @@
         }
         If(LOr(LEqual(C006, 0x0), LEqual(C006, 0x3))) {
             If(CondRefOf(\_OSI, Local0)) {
-                If(\_OSI) {
-                    "Windows 2001"
+                If(\_OSI ("Windows 2001")) {
                     Store(0x4, C006)
                 }
             }

This is basically in line with some other DSDTs I've seen on the net.
-- 
Martin Michlmayr
tbm-R+vWnYXSFMfQT0dZR+AlfA@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
