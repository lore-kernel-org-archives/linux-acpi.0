From: Felipe Alfaro Solana <felipe_alfaro-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: [RFC] enhanced psxface.c error handling
Date: Thu, 04 Dec 2003 17:02:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1070553752.14488.4.camel@glass.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-HZIZJ8eznrNoAVGDmQ4T"
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
Cc: Linux Kernel Mailinglist <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-HZIZJ8eznrNoAVGDmQ4T
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi!

This patch tries to fix the situation where an error could cause
acpi_psx_execute() to exit without releasing held references to the
elements of param[].

Thanks!

--=-HZIZJ8eznrNoAVGDmQ4T
Content-Disposition: attachment; filename=acpi.patch
Content-Type: text/x-patch; name=acpi.patch; charset=
Content-Transfer-Encoding: 7bit

diff -uNr linux-2.6.0-test11.orig/drivers/acpi/parser/psxface.c linux-2.6.0-test11/drivers/acpi/parser/psxface.c
--- linux-2.6.0-test11.orig/drivers/acpi/parser/psxface.c	2003-11-26 21:45:20.000000000 +0100
+++ linux-2.6.0-test11/drivers/acpi/parser/psxface.c	2003-12-01 09:23:18.591462114 +0100
@@ -127,7 +127,8 @@
 
 	op = acpi_ps_create_scope_op ();
 	if (!op) {
-		return_ACPI_STATUS (AE_NO_MEMORY);
+		status = AE_NO_MEMORY;
+		goto acpi_psx_parse_unref;
 	}
 
 	/*
@@ -142,14 +143,15 @@
 	walk_state = acpi_ds_create_walk_state (obj_desc->method.owning_id,
 			   NULL, NULL, NULL);
 	if (!walk_state) {
-		return_ACPI_STATUS (AE_NO_MEMORY);
+		goto acpi_psx_parse_unref;
+		status = AE_NO_MEMORY;
 	}
 
 	status = acpi_ds_init_aml_walk (walk_state, op, method_node, obj_desc->method.aml_start,
 			  obj_desc->method.aml_length, NULL, NULL, 1);
 	if (ACPI_FAILURE (status)) {
 		acpi_ds_delete_walk_state (walk_state);
-		return_ACPI_STATUS (status);
+		goto acpi_psx_parse_unref;
 	}
 
 	/* Parse the AML */
@@ -168,7 +170,8 @@
 
 	op = acpi_ps_create_scope_op ();
 	if (!op) {
-		return_ACPI_STATUS (AE_NO_MEMORY);
+		status = AE_NO_MEMORY;
+		goto acpi_psx_parse_unref;
 	}
 
 	/* Init new op with the method name and pointer back to the NS node */
@@ -180,14 +183,15 @@
 
 	walk_state = acpi_ds_create_walk_state (0, NULL, NULL, NULL);
 	if (!walk_state) {
-		return_ACPI_STATUS (AE_NO_MEMORY);
+		status = AE_NO_MEMORY;
+		goto acpi_psx_parse_unref;
 	}
 
 	status = acpi_ds_init_aml_walk (walk_state, op, method_node, obj_desc->method.aml_start,
 			  obj_desc->method.aml_length, params, return_obj_desc, 3);
 	if (ACPI_FAILURE (status)) {
 		acpi_ds_delete_walk_state (walk_state);
-		return_ACPI_STATUS (status);
+		goto acpi_psx_parse_unref;
 	}
 
 	/*
@@ -196,16 +200,6 @@
 	status = acpi_ps_parse_aml (walk_state);
 	acpi_ps_delete_parse_tree (op);
 
-	if (params) {
-		/* Take away the extra reference that we gave the parameters above */
-
-		for (i = 0; params[i]; i++) {
-			/* Ignore errors, just do them all */
-
-			(void) acpi_ut_update_object_reference (params[i], REF_DECREMENT);
-		}
-	}
-
 	/*
 	 * If the method has returned an object, signal this to the caller with
 	 * a control exception code
@@ -218,6 +212,18 @@
 		status = AE_CTRL_RETURN_VALUE;
 	}
 
+acpi_psx_parse_unref:
+
+	if (params) {
+		/* Take away the extra reference that we gave the parameters above */
+
+		for (i = 0; params[i]; i++) {
+			/* Ignore errors, just do them all */
+
+			(void) acpi_ut_update_object_reference (params[i], REF_DECREMENT);
+		}
+	}
+
 	return_ACPI_STATUS (status);
 }

--=-HZIZJ8eznrNoAVGDmQ4T--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
