From: Andy Grover <agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org>
Subject: [PATCH] ACPI compile fix
Date: Fri, 26 Jul 2002 11:42:47 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0207261130250.11912-100000@dexter.groveronline.com>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Linus,

This fixes the ACPI_DEBUG compile issue that turned up.

(acpi-devel people, I'll be updating sf.net patches with this asap)

Regards -- Andy

diff -Naur -X bin/dontdiff acpi-old/drivers/acpi/include/aclocal.h linux/drivers/acpi/include/aclocal.h
--- acpi-old/drivers/acpi/include/aclocal.h	Fri Jul 26 11:27:34 2002
+++ linux/drivers/acpi/include/aclocal.h	Fri Jul 26 11:20:05 2002
@@ -1,7 +1,7 @@
 /******************************************************************************
  *
  * Name: aclocal.h - Internal data types used across the ACPI subsystem
- *       $Revision: 172 $
+ *       $Revision: 173 $
  *
  *****************************************************************************/
 
@@ -567,7 +567,7 @@
  */
 typedef struct acpi_opcode_info
 {
-#ifdef ACPI_DISASSEMBLER
+#if defined(ACPI_DISASSEMBLER) || defined(ACPI_DEBUG)
 	NATIVE_CHAR             *name;          /* Opcode name (disassembler/debug only) */
 #endif
 	u32                     parse_args;     /* Grammar/Parse time arguments */
diff -Naur -X bin/dontdiff acpi-old/drivers/acpi/include/acmacros.h linux/drivers/acpi/include/acmacros.h
--- acpi-old/drivers/acpi/include/acmacros.h	Fri Jul 26 11:27:34 2002
+++ linux/drivers/acpi/include/acmacros.h	Fri Jul 26 11:20:05 2002
@@ -1,7 +1,7 @@
 /******************************************************************************
  *
  * Name: acmacros.h - C macros for the entire subsystem.
- *       $Revision: 125 $
+ *       $Revision: 126 $
  *
  *****************************************************************************/
 
@@ -287,11 +287,15 @@
 /*
  * Macros for the master AML opcode table
  */
-#ifdef ACPI_DISASSEMBLER
+#if defined(ACPI_DISASSEMBLER) || defined (ACPI_DEBUG)
 #define ACPI_OP(name,Pargs,Iargs,obj_type,class,type,flags)    {name,Pargs,Iargs,flags,obj_type,class,type}
-#define ACPI_DISASM_ONLY_MEMBERS(a)      a;
 #else
 #define ACPI_OP(name,Pargs,Iargs,obj_type,class,type,flags)    {Pargs,Iargs,flags,obj_type,class,type}
+#endif
+
+#ifdef ACPI_DISASSEMBLER
+#define ACPI_DISASM_ONLY_MEMBERS(a)      a;
+#else
 #define ACPI_DISASM_ONLY_MEMBERS(a)
 #endif
 
diff -Naur -X bin/dontdiff acpi-old/drivers/acpi/parser/psutils.c linux/drivers/acpi/parser/psutils.c
--- acpi-old/drivers/acpi/parser/psutils.c	Fri Jul 26 11:27:34 2002
+++ linux/drivers/acpi/parser/psutils.c	Fri Jul 26 11:20:05 2002
@@ -1,7 +1,7 @@
 /******************************************************************************
  *
  * Module Name: psutils - Parser miscellaneous utilities (Parser only)
- *              $Revision: 53 $
+ *              $Revision: 54 $
  *
  *****************************************************************************/
 
@@ -88,7 +88,7 @@
 	op->common.data_type = ACPI_DESC_TYPE_PARSER;
 	op->common.aml_opcode = opcode;
 
-	ACPI_DEBUG_ONLY_MEMBERS (ACPI_STRNCPY (op->common.aml_op_name,
+	ACPI_DISASM_ONLY_MEMBERS (ACPI_STRNCPY (op->common.aml_op_name,
 			(acpi_ps_get_opcode_info (opcode))->name, sizeof (op->common.aml_op_name)));
 }
 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
