From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: cvs commit: src/sys/contrib/dev/acpica osunixxf.c (fwd)
Date: Tue, 12 Aug 2003 08:54:09 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030812085340.T88759@root.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

More fixes for osunixxf.c to compile on 64 bit.  This is correct since
this file didn't match acpiosxf.h before.

---------- Forwarded message ----------
Date: Mon, 11 Aug 2003 21:56:53 -0700 (PDT)
From: Nate Lawson <njl-HZy0K5TPuP5AfugRpC6u6w@public.gmane.org>

njl         2003/08/11 21:56:45 PDT

  FreeBSD src repository

  Modified files:        (Branch: INTEL)
    sys/contrib/dev/acpica osunixxf.c
  Log:
  Fix a few more s/UINT32/ACPI_SIZE issues.  iasl and acpidb now build on
  ia64.

  Tested on:      pluto2
  Pointed out by: tinderbox

  Revision  Changes    Path
  1.1.1.4   +2 -2      src/sys/contrib/dev/acpica/osunixxf.c


--- src/sys/contrib/dev/acpica/osunixxf.c:1.1.1.3	Sun Aug 10 22:54:31 2003
+++ src/sys/contrib/dev/acpica/osunixxf.c	Mon Aug 11 21:56:45 2003
@@ -478,7 +478,7 @@
 void
 AcpiOsUnmapMemory (
     void                    *where,
-    UINT32                  length)
+    ACPI_SIZE               length)
 {

     return;
@@ -499,7 +499,7 @@

 void *
 AcpiOsAllocate (
-    UINT32                  size)
+    ACPI_SIZE               size)
 {
     void                    *Mem;


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
