From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: [2.4] random fix, new features request. Forgot some chunk (rhaa!)
Date: Mon, 17 Feb 2003 15:54:10 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030217145410.GB25625@poup.poupinou.org>
References: <20030217134527.GA25625@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030217134527.GA25625-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Andy,

I forgot those chunks, sorry.
BTW, my cvs tree need to be updated as well :)


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





Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
