From: Irene Zubarev <zubarev-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: small status catching patch
Date: Thu, 13 Mar 2003 17:13:36 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <OFA9812763.63F0B8C8-ON87256CE8.007843A2@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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





Hello, I'm not sure if anyone caught this, but it seems that in nswalk.c,
in acpi_ns_walk_namespace, there should be an extra variable for status,
otherwise, we always think it is a good status.  (this is on the 2nd "if
(unlock_before_callback)" statement).  Please see patch below (against
2/28/2003 version):

diff -Nru 1/drivers/acpi/namespace/nswalk.c 2/drivers/acpi/namespace/nswalk.c
--- 1/drivers/acpi/namespace/nswalk.c     Thu Mar 13 19:58:30 2003
+++ 2/drivers/acpi/namespace/nswalk.c     Thu Mar 13 19:59:02 2003
@@ -164,6 +164,7 @@
      void                            **return_value)
 {
      acpi_status                     status;
+     acpi_status             unlock_status;
      struct acpi_namespace_node      *child_node;
      struct acpi_namespace_node      *parent_node;
      acpi_object_type                child_type;
@@ -221,9 +222,9 @@
                                     context, return_value);

                        if (unlock_before_callback) {
-                             status = acpi_ut_acquire_mutex (ACPI_MTX_NAMESPACE);
-                             if (ACPI_FAILURE (status)) {
-                                   return_ACPI_STATUS (status);
+                             unlock_status = acpi_ut_acquire_mutex (ACPI_MTX_NAMESPACE);
+                             if (ACPI_FAILURE (unlock_status)) {
+                                   return_ACPI_STATUS (unlock_status);
                              }
                        }

Thanks,

Irene Zubarev



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
