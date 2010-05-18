From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 1/3] ACPICA: make ObjectCount to be UINT32
Date: Wed, 19 May 2010 00:25:24 +0400
Message-ID: <20100518202524.29771.96252.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:44487 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260Ab0ERUZ1 (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 18 May 2010 16:25:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

SGI UV machine does not fit into UINT16 count

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 source/components/dispatcher/dsinit.c |    2 +-
 source/components/namespace/nsinit.c  |    2 +-
 source/include/acstruct.h             |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/source/components/dispatcher/dsinit.c b/source/components/dispatcher/dsinit.c
index 4525a0b..349c774 100644
--- a/source/components/dispatcher/dsinit.c
+++ b/source/components/dispatcher/dsinit.c
@@ -297,7 +297,7 @@ AcpiDsInitializeObjects (
     }
 
     ACPI_DEBUG_PRINT_RAW ((ACPI_DB_INIT,
-        "\nTable [%4.4s](id %4.4X) - %hd Objects with %hd Devices %hd Methods %hd Regions\n",
+        "\nTable [%4.4s](id %4.4X) - %d Objects with %hd Devices %hd Methods %hd Regions\n",
         Table->Signature, OwnerId, Info.ObjectCount,
         Info.DeviceCount, Info.MethodCount, Info.OpRegionCount));
 
diff --git a/source/components/namespace/nsinit.c b/source/components/namespace/nsinit.c
index 770235e..e59eb8e 100644
--- a/source/components/namespace/nsinit.c
+++ b/source/components/namespace/nsinit.c
@@ -194,7 +194,7 @@ AcpiNsInitializeObjects (
 
     ACPI_DEBUG_PRINT_RAW ((ACPI_DB_INIT,
         "\nInitialized %hd/%hd Regions %hd/%hd Fields %hd/%hd "
-        "Buffers %hd/%hd Packages (%hd nodes)\n",
+        "Buffers %hd/%hd Packages (%d nodes)\n",
         Info.OpRegionInit,  Info.OpRegionCount,
         Info.FieldInit,     Info.FieldCount,
         Info.BufferInit,    Info.BufferCount,
diff --git a/source/include/acstruct.h b/source/include/acstruct.h
index d4696b8..8f9c550 100644
--- a/source/include/acstruct.h
+++ b/source/include/acstruct.h
@@ -218,7 +218,7 @@ typedef struct acpi_init_walk_info
     UINT16                          FieldInit;
     UINT16                          BufferInit;
     UINT16                          PackageInit;
-    UINT16                          ObjectCount;
+    UINT32                          ObjectCount;
     ACPI_OWNER_ID                   OwnerId;
     UINT32                          TableIndex;
 

