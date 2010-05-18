From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 2/3] ACPICA: Keep track of method changes to namespace
Date: Wed, 19 May 2010 00:25:31 +0400
Message-ID: <20100518202531.29771.18173.stgit@thinkpad>
References: <20100518202524.29771.96252.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:33718 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260Ab0ERUZd (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 18 May 2010 16:25:33 -0400
In-Reply-To: <20100518202524.29771.96252.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Try to delete nodes from namespace only if method really added them

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 source/components/dispatcher/dsmethod.c |    5 ++++-
 source/components/namespace/nsalloc.c   |    4 ++++
 source/include/acobject.h               |    1 +
 3 files changed, 9 insertions(+), 1 deletions(-)


diff --git a/source/components/dispatcher/dsmethod.c b/source/components/dispatcher/dsmethod.c
index 969c9ca..fe7a9a8 100644
--- a/source/components/dispatcher/dsmethod.c
+++ b/source/components/dispatcher/dsmethod.c
@@ -700,7 +700,10 @@ AcpiDsTerminateControlMethod (
          */
         if (!(MethodDesc->Method.Flags & AOPOBJ_MODULE_LEVEL))
         {
-            AcpiNsDeleteNamespaceByOwner (MethodDesc->Method.OwnerId);
+            if (MethodDesc->Method.UsesNamespace)
+            {
+                AcpiNsDeleteNamespaceByOwner (MethodDesc->Method.OwnerId);
+            }
         }
     }
 
diff --git a/source/components/namespace/nsalloc.c b/source/components/namespace/nsalloc.c
index aadafbf..16bcdd3 100644
--- a/source/components/namespace/nsalloc.c
+++ b/source/components/namespace/nsalloc.c
@@ -343,6 +343,10 @@ AcpiNsInstallNode (
     if (WalkState)
     {
         OwnerId = WalkState->OwnerId;
+        if (WalkState->MethodDesc)
+        {
+            WalkState->MethodDesc->Method.UsesNamespace = 1;
+        }
     }
 
     /* Link the new entry into the parent and existing children */
diff --git a/source/include/acobject.h b/source/include/acobject.h
index f86f839..502132a 100644
--- a/source/include/acobject.h
+++ b/source/include/acobject.h
@@ -296,6 +296,7 @@ typedef struct acpi_object_method
 
     UINT32                          AmlLength;
     UINT8                           ThreadCount;
+    UINT8                           UsesNamespace;
     ACPI_OWNER_ID                   OwnerId;
 
 } ACPI_OBJECT_METHOD;

