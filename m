From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 4/4] ACPICA: Update version to 20170119
Date: Wed,  8 Feb 2017 11:00:22 +0800
Message-ID: <cd4074255878a95f120a5467c07b4b370604fa11.1486522441.git.lv.zheng@intel.com>
References: <cover.1486522441.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1486522441.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 711a8c19d3c646fdc069c38912d9037c7fa5e718

Version 20170119.

Link: https://github.com/acpica/acpica/commit/711a8c19
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index bb23cf7..3795386 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -46,7 +46,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20161222
+#define ACPI_CA_VERSION                 0x20170119
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.7.4
