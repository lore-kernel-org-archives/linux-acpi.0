From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/18] ACPICA: MSVC: Fix MSVC6 build issues
Date: Wed, 28 Dec 2016 15:29:03 +0800
Message-ID: <d0478a08e7d8605faae73d4228da2412a49dd2e9.1482821486.git.lv.zheng@intel.com>
References: <cover.1482821486.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1482821486.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit fa0680030a2969e1085563da633713e1c321637c

Build environment has changed because of new improvements:
1. New files are split
2. New inclusion order
This patch updates MSVC project files accordingly.

Linux is not affected by this patch.

Link: https://github.com/acpica/acpica/commit/fa068003
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 include/acpi/platform/acenv.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/platform/acenv.h b/include/acpi/platform/acenv.h
index 34cce72..cf93b66 100644
--- a/include/acpi/platform/acenv.h
+++ b/include/acpi/platform/acenv.h
@@ -357,7 +357,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <ctype.h>
-#ifdef ACPI_APPLICATION
+#if defined (ACPI_APPLICATION) || defined(ACPI_LIBRARY)
 #include <stdio.h>
 #include <fcntl.h>
 #include <errno.h>
-- 
2.7.4
