From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH] [1/2] Allow override acpi_gbl_pre_defined_names (aka change that _OS).
Date: Wed, 5 Feb 2003 19:43:10 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030205184310.GK1205@poup.poupinou.org>
References: <4.3.2.7.2.20030204000748.00b62270@mail.dns-host.com> <20030204094540.GE1205@poup.poupinou.org> <20030204132251.E16744@suse.de> <20030204154359.GH1205@poup.poupinou.org> <20030204164641.A31886@suse.de> <20030204155548.GI1205@poup.poupinou.org> <3E40AF32.AA177847@monetplus.cz> <20030205133049.A18324@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030205133049.A18324-l3A5Bk7waGM@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Dave Jones <davej-l3A5Bk7waGM@public.gmane.org>, =?iso-8859-1?Q?Zden=ECk_OGAR_Skal=E1k?= <skalak-Bh/+Xfn7orxQjibfaplwYw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

This patch allow an OS vendor to be able to change some values of the
acpi_gbl_pre_defined_names global variable.

The main purpose actually is to override the \_OS part, in order
to test/try etc. when a DSDT was more specifically written for
some Redmond OSes.

In order to get it to work, OS must provide an acpi_os_predefined_override()
(or AcpiOsPredefinedOverride) function.
One example is at the end of this patch.

A patch using a bootarg in order to change the \_OS string for Linux follow.



--- linux/drivers/acpi/namespace/nsaccess.c	2003/02/05 14:25:40	1.1
+++ linux/drivers/acpi/namespace/nsaccess.c	2003/02/05 15:23:59
@@ -100,6 +100,16 @@
 		 * initial value, create the initial value.
 		 */
 		if (init_val->val) {
+			acpi_string val;
+
+			status = acpi_os_predefined_override(init_val, &val);
+			if (ACPI_FAILURE (status)) {
+				ACPI_DEBUG_PRINT ((ACPI_DB_ERROR,
+					"Could not override predefined %s\n", init_val->name));
+			}
+			if (val == NULL)
+				val = init_val->val;
+
 			/*
 			 * Entry requests an initial value, allocate a
 			 * descriptor for it.
@@ -118,7 +128,7 @@
 			switch (init_val->type) {
 			case ACPI_TYPE_METHOD:
 				obj_desc->method.param_count =
-						(u8) ACPI_STRTOUL (init_val->val, NULL, 10);
+						(u8) ACPI_STRTOUL (val, NULL, 10);
 				obj_desc->common.flags |= AOPOBJ_DATA_VALID;
 
 #if defined (ACPI_NO_METHOD_EXECUTION) || defined (ACPI_CONSTANT_EVAL_ONLY)
@@ -132,7 +142,7 @@
 			case ACPI_TYPE_INTEGER:
 
 				obj_desc->integer.value =
-						(acpi_integer) ACPI_STRTOUL (init_val->val, NULL, 10);
+						(acpi_integer) ACPI_STRTOUL (val, NULL, 10);
 				break;
 
 
@@ -141,8 +151,8 @@
 				/*
 				 * Build an object around the static string
 				 */
-				obj_desc->string.length = (u32) ACPI_STRLEN (init_val->val);
-				obj_desc->string.pointer = init_val->val;
+				obj_desc->string.length = (u32) ACPI_STRLEN (val);
+				obj_desc->string.pointer = val;
 				obj_desc->common.flags |= AOPOBJ_STATIC_POINTER;
 				break;
 
@@ -151,7 +161,7 @@
 
 				obj_desc->mutex.node = new_node;
 				obj_desc->mutex.sync_level =
-						 (u16) ACPI_STRTOUL (init_val->val, NULL, 10);
+						 (u16) ACPI_STRTOUL (val, NULL, 10);
 
 				if (ACPI_STRCMP (init_val->name, "_GL_") == 0) {
 					/*
--- linux/include/acpi/acpiosxf.h	2003/02/05 15:15:11	1.1
+++ linux/include/acpi/acpiosxf.h	2003/02/05 15:25:08
@@ -93,6 +93,11 @@
 	struct acpi_pointer             *address);
 
 acpi_status
+acpi_os_predefined_override (
+	const struct acpi_predefined_names *init_val,
+	acpi_string                     *new_val);
+
+acpi_status
 acpi_os_table_override (
 	struct acpi_table_header        *existing_table,
 	struct acpi_table_header        **new_table);





--- linux/drivers/acpi/osl.c	2003/01/31 18:12:52	1.1
+++ linux/drivers/acpi/osl.c	2003/02/05 15:42:43
@@ -198,6 +198,17 @@
 
 	*phys = virt_to_phys(virt);
 
+	return AE_OK;
+}
+
+acpi_status
+acpi_os_predefined_override (const struct acpi_predefined_names *init_val,
+		             acpi_string *new_val)
+{
+	if (!init_val || !new_val)
+		return AE_BAD_PARAMETER;
+
+	*new_val = NULL;
 	return AE_OK;
 }






-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
