From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/17] ACPICA: Remove a redundant cast to acpi_size for ACPI_OFFSET() macro.
Date: Wed, 30 Jul 2014 12:20:33 +0800
Message-ID: <8c0eb1a4a91a54436da56083a65aaf9f72683b92.1406689494.git.lv.zheng@intel.com>
References: <cover.1406689493.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1406689493.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

It is already casted to acpi_size by ACPI_PTR_DIFF() macro.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/actypes.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 608a040..4d9b29c 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -517,7 +517,7 @@ typedef u64 acpi_integer;
 
 #define ACPI_TO_POINTER(i)              ACPI_ADD_PTR (void, (void *) NULL,(acpi_size) i)
 #define ACPI_TO_INTEGER(p)              ACPI_PTR_DIFF (p, (void *) NULL)
-#define ACPI_OFFSET(d, f)               (acpi_size) ACPI_PTR_DIFF (&(((d *)0)->f), (void *) NULL)
+#define ACPI_OFFSET(d, f)               ACPI_PTR_DIFF (&(((d *) 0)->f), (void *) NULL)
 #define ACPI_PHYSADDR_TO_PTR(i)         ACPI_TO_POINTER(i)
 #define ACPI_PTR_TO_PHYSADDR(i)         ACPI_TO_INTEGER(i)
 
-- 
1.7.10
