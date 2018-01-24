From: Erik Schmauss <erik.schmauss@intel.com>
Subject: [PATCH 3/6] ACPICA: Prefer ACPI_TO_POINTER() over ACPI_ADD_PTR()
Date: Wed, 24 Jan 2018 15:42:31 -0800
Message-ID: <20180124234234.19828-4-erik.schmauss@intel.com>
References: <20180124234234.19828-1-erik.schmauss@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:51883 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932250AbeAXXnU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Jan 2018 18:43:20 -0500
In-Reply-To: <20180124234234.19828-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jung-uk Kim <jkim@FreeBSD.org>, Jung-uk Kim <jkim@free_BSD.org>, Erik Schmauss <erik.schmauss@intel.com>

From: Jung-uk Kim <jkim@FreeBSD.org>

This is more easy to read.

Signed-off-by: Jung-uk Kim <jkim@free_BSD.org>
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
---
 include/acpi/actypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index f3999ae7a43f..0b6b55f1e597 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -485,7 +485,7 @@ typedef u8 acpi_owner_id;
 /*
  * Constants with special meanings
  */
-#define ACPI_ROOT_OBJECT                ACPI_ADD_PTR (acpi_handle, (void *) 0, ACPI_MAX_PTR)
+#define ACPI_ROOT_OBJECT                ((acpi_handle) ACPI_TO_POINTER (ACPI_MAX_PTR))
 #define ACPI_WAIT_FOREVER               0xFFFF	/* u16, as per ACPI spec */
 #define ACPI_DO_NOT_WAIT                0
 
-- 
2.14.3

