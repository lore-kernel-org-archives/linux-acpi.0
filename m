From: Nate Lawson <nate-Y6VGUYTwhu0@public.gmane.org>
Subject: acipca patches for Intel
Date: Sun, 13 Jul 2003 20:12:59 -0700 (PDT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030713200525.K15586@root.org>
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
Cc: acpi-jp-l7ZBCLq5RC066kwqclu8Pg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

When you moved the DmDecodeNode function to dmobject.c, you left the
prototype defined in two places.  This gives a warning.

--- acdisasm.h.orig	13 Jul 2003 22:41:48 -0000	1.1.1.5
+++ acdisasm.h	14 Jul 2003 02:57:14 -0000
@@ -226,10 +226,6 @@
 AcpiDmDecodeInternalObject (
     ACPI_OPERAND_OBJECT     *ObjDesc);

-void
-AcpiDmDecodeNode (
-    ACPI_NAMESPACE_NODE     *Node);
-
 UINT32
 AcpiDmBlockType (
     ACPI_PARSE_OBJECT       *Op);

We submitted this a while ago but it hasn't made it into the 0619 dist.
Use the correct register constant for HwRegisterWrite.  This fixes
messages of:
ACPI-0340: *** Error: Could not release ACPI Global Lock, AE_BAD_PARAMETER
Credit: jhb-h+KGxgPPiopAfugRpC6u6w@public.gmane.org

--- /sys/contrib/dev/acpica/hwregs.c	3 May 2003 17:16:40 -0000	1.1.1.16
+++ /sys/contrib/dev/acpica/hwregs.c	23 Jun 2003 17:38:38 -0000	1.1.1.17
@@ -510,8 +510,8 @@
         ACPI_REGISTER_INSERT_VALUE (RegisterValue, BitRegInfo->BitPosition,
                 BitRegInfo->AccessBitMask, Value);

-        Status = AcpiHwRegisterWrite (ACPI_MTX_DO_NOT_LOCK, RegisterId,
-                (UINT16) RegisterValue);
+        Status = AcpiHwRegisterWrite (ACPI_MTX_DO_NOT_LOCK,
+                ACPI_REGISTER_PM1_CONTROL, (UINT16) RegisterValue);
         break;


This patch reverts part of 0619 to fix _BST errors on IBM thinkpads (and
others.  It appears many ASL versions do not implement the alluded to 2.0C
copy semantics.

--- dsmthdat.c	Thu Jun 19 17:30:43 2003
+++ /sys/contrib/dev/a.old/dsmthdat.c	Tue Apr 29 11:36:50 2003
@@ -392,6 +392,7 @@
 {
     ACPI_STATUS             Status;
     ACPI_NAMESPACE_NODE     *Node;
+    ACPI_OPERAND_OBJECT     *NewDesc = Object;


     ACPI_FUNCTION_TRACE ("DsMethodDataSetValue");
@@ -410,17 +411,32 @@
         return_ACPI_STATUS (Status);
     }

-    /*
-     * Increment ref count so object can't be deleted while installed.
-     * NOTE: We do not copy the object in order to preserve the call by
-     * reference semantics of ACPI Control Method invocation.
-     * (See ACPI Specification 2.0C)
+    /*
+     * If the object has just been created and is not attached to anything,
+     * (the reference count is 1), then we can just store it directly into
+     * the arg/local.  Otherwise, we must copy it.
      */
-    AcpiUtAddReference (Object);
+    if (Object->Common.ReferenceCount > 1)
+    {
+        Status = AcpiUtCopyIobjectToIobject (Object, &NewDesc, WalkState);
+        if (ACPI_FAILURE (Status))
+        {
+            return_ACPI_STATUS (Status);
+        }
+
+       ACPI_DEBUG_PRINT ((ACPI_DB_EXEC, "Object Copied %p, new %p\n",
+           Object, NewDesc));
+    }
+    else
+    {
+        /* Increment ref count so object can't be deleted while installed */
+
+        AcpiUtAddReference (NewDesc);
+    }

     /* Install the object */

-    Node->Object = Object;
+    Node->Object = NewDesc;
     return_ACPI_STATUS (Status);
 }


Finally, I did not commit this change but it has been necessary in the
past.  Can you comment on the need to specify an OwnerId?

--- nsalloc.c.orig	Wed May 28 10:32:31 2003
+++ nsalloc.c	Thu Jun 19 17:30:48 2003
@@ -321,7 +321,7 @@
     ACPI_NAMESPACE_NODE     *Node,          /* New Child*/
     ACPI_OBJECT_TYPE        Type)
 {
-    UINT16                  OwnerId = TABLE_ID_DSDT;
+    UINT16                  OwnerId = 0;
     ACPI_NAMESPACE_NODE     *ChildNode;
 #ifdef ACPI_ALPHABETIC_NAMESPACE


The last two are credit: kochi-S783fYmB3Ccdnm+yROfE0A@public.gmane.org

Thanks,
Nate


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
