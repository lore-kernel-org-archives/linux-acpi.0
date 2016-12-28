From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 10/18] ACPICA: EFI: Add efihello demo application
Date: Wed, 28 Dec 2016 15:29:10 +0800
Message-ID: <30209c75b073b778b5a5e591ed2ad2b1432baf4f.1482821486.git.lv.zheng@intel.com>
References: <cover.1482821486.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1482821486.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 3fcc59f4755607dd066ac8ef869f0aa95e871b84

This patch adds a demo EFI application for stdin/stdout testing. This
utility can be used to narrow down root causes of porting issues. Lv Zheng.

Linux is not affected by this patch.

Link: https://github.com/acpica/acpica/commit/3fcc59f4
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/platform/acenv.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index cf93b66..926efe9 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -75,7 +75,8 @@
 	(defined ACPI_NAMES_APP)    || \
 	(defined ACPI_SRC_APP)      || \
 	(defined ACPI_XTRACT_APP)   || \
-	(defined ACPI_EXAMPLE_APP)
+	(defined ACPI_EXAMPLE_APP)  || \
+	(defined ACPI_EFI_HELLO)
 #define ACPI_APPLICATION
 #define ACPI_SINGLE_THREADED
 #define USE_NATIVE_ALLOCATE_ZEROED
-- 
2.7.4
