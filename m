From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: Re: cvs commit: src/sys/contrib/dev/acpica osunixxf.c (fwd)
Date: Mon, 11 Aug 2003 08:40:38 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030811083953.M86598@root.org>
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

FYI.  I hope Intel includes this fix in next drop.

---------- Forwarded message ----------
From: Nate Lawson <njl-HZy0K5TPuP5AfugRpC6u6w@public.gmane.org>

njl         2003/08/10 22:54:31 PDT

  FreeBSD src repository

  Modified files:        (Branch: INTEL)
    sys/contrib/dev/acpica osunixxf.c
  Log:
  Fix AcpiOsMapMemory to match the function definition.  Don't use UINT32
  as a cast for a pointer.  Change has been submitted to the vendor.

  Pointed out by:         marcel, obrien

  Revision  Changes    Path
  1.1.1.3   +2 -2      src/sys/contrib/dev/acpica/osunixxf.c


--- src/sys/contrib/dev/acpica/osunixxf.c:1.1.1.2	Thu Aug  7 11:19:12 2003
+++ src/sys/contrib/dev/acpica/osunixxf.c	Sun Aug 10 22:54:31 2003
@@ -452,10 +452,10 @@
 ACPI_STATUS
 AcpiOsMapMemory (
     ACPI_PHYSICAL_ADDRESS   where,
-    UINT32                  length,
+    ACPI_SIZE               length,
     void                    **there)
 {
-    *there = (void *) (UINT32) where;
+    *there = (void *) (uintptr_t) where;

     return AE_OK;
 }


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
