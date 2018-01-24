From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 2/6] ACPICA: Avoid NULL pointer arithmetic
Date: Wed, 24 Jan 2018 15:42:30 -0800
Message-ID: <20180124234234.19828-3-erik.schmauss@intel.com>
References: <20180124234234.19828-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51879 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932072AbeAXXnT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Jan 2018 18:43:19 -0500
In-Reply-To: <20180124234234.19828-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jung-uk Kim <jkim@FreeBSD.org>, Jung-uk Kim <jkim@free_BSD.org>, Erik Schmauss <erik.schmauss@intel.com>

From: Jung-uk Kim <jkim@FreeBSD.org>

We should not assume NULL is defined as "(void *)0" because NULL is
an implementation-defined macro.  Especially, Clang 6 complains about
it, i.e., "arithmetic on a null pointer treated as a cast from integer
to pointer is a GNU extension".

Signed-off-by: Jung-uk Kim <jkim@free_BSD.org>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 include/acpi/actypes.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 31f1be74dd16..f3999ae7a43f 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -485,7 +485,7 @@ typedef u8 acpi_owner_id;
 /*
  * Constants with special meanings
  */
-#define ACPI_ROOT_OBJECT                ACPI_ADD_PTR (acpi_handle, NULL, ACPI_MAX_PTR)
+#define ACPI_ROOT_OBJECT                ACPI_ADD_PTR (acpi_handle, (void *) 0, ACPI_MAX_PTR)
 #define ACPI_WAIT_FOREVER               0xFFFF	/* u16, as per ACPI spec */
 #define ACPI_DO_NOT_WAIT                0
 
@@ -536,9 +536,9 @@ typedef u64 acpi_integer;
 
 /* Pointer/Integer type conversions */
 
-#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) NULL,(acpi_size) i)
-#define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) NULL)
-#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) NULL)
+#define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) 0, (acpi_size) (i))
+#define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) 0)
+#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) 0)
 #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
 #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
 
-- 
2.14.3

