From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [2.4 PATCH] osl.c spinlock fix
Date: Tue, 15 Jul 2003 10:47:01 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200307151047.01178.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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

Looks like this is already in 2.5; just want to make sure it also makes
it into 2.4.

diff -Nru a/drivers/acpi/osl.c b/drivers/acpi/osl.c
--- a/drivers/acpi/osl.c	Tue Jul 15 10:52:57 2003
+++ b/drivers/acpi/osl.c	Tue Jul 15 10:52:57 2003
@@ -728,7 +728,7 @@
 	if (flags & ACPI_NOT_ISR)
 		ACPI_DISABLE_IRQS();
 
-	spin_lock(handle);
+	spin_lock((spinlock_t *)handle);
 
 	return_VOID;
 }
@@ -747,7 +747,7 @@
 	ACPI_DEBUG_PRINT ((ACPI_DB_MUTEX, "Releasing spinlock[%p] from %s level\n", handle,
 		((flags & ACPI_NOT_ISR) ? "non-interrupt" : "interrupt")));
 
-	spin_unlock(handle);
+	spin_unlock((spinlock_t *)handle);
 
 	if (flags & ACPI_NOT_ISR)
 		ACPI_ENABLE_IRQS();



-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
