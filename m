From: "Bjoern A. Zeeb" <bzeeb-lists-mt/InyFV0sMN6vK3N8ee0qxOck334EZe@public.gmane.org>
Subject: RE: [PATCH] endless loop in arch/i386/kernel/mpparse.c
Date: Mon, 30 Sep 2002 20:27:24 +0200 (CEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.BSF.4.44.0209302010500.427-100000@e0-0.zab2.int.zabbadoz.net>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DEDD@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD0236DEDD-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Linus Torvalds <torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, patch-1p+UDdvUwrrk1uMJSBkQmQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 30 Sep 2002, Grover, Andrew wrote:

Hi,

> Some change must have screwed something up for this to be hanging...

too trivial to see the first time when debugging on weekends ;-))

Linus please apply:

C fix an endless loop walking the MADT ("Bjoern A. Zeeb" <bzeeb-1p+UDdvUwrrk1uMJSBkQmQ@public.gmane.org>)

--- linux-20020930-175132/arch/i386/kernel/mpparse.c.orig	Mon Sep 30 17:55:53 2002
+++ linux-20020930-175132/arch/i386/kernel/mpparse.c	Mon Sep 30 17:57:43 2002
@@ -1038,7 +1038,7 @@
 	status = acpi_get_firmware_table("APIC", 1, ACPI_LOGICAL_ADDRESSING,
 		(acpi_table_header **) &madt);
 	if (ACPI_SUCCESS(status)) {
-		madt_end = madt + madt->header.length;
+		madt_end = (unsigned long)madt + madt->header.length;

 		entry = (struct acpi_table_int_src_ovr *)
                 ((unsigned long) madt + sizeof(struct acpi_table_madt));


else madt is incremented madt->header.length times sizeof(struct acpi_table_madt)

Thanks.

-- 
Greetings

Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
