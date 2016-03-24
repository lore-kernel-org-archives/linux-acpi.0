From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 20/30] ACPICA: iASL/Disassembler: Improve handling of unresolved methods
Date: Thu, 24 Mar 2016 09:40:48 +0800
Message-ID: <7e80fc4817e964c9b1ff7f236c7aa1ec2da823e9.1458714003.git.lv.zheng@intel.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1458714002.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 16cd0872a070c8d3b16b8b13c1fc90a443a6b6fe

If the definition of a control method cannot be found (probably it
is in another module/SSDT), the disassembler must try to guess
at the number of arguments to that method. This change improves
the guessing heuristic.

Link: https://github.com/acpica/acpica/commit/16cd0872
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/aclocal.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 9562a10..083b16a 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -1096,6 +1096,7 @@ struct acpi_external_list {
 #define ACPI_EXT_ORIGIN_FROM_FILE           0x02	/* External came from a file */
 #define ACPI_EXT_INTERNAL_PATH_ALLOCATED    0x04	/* Deallocate internal path on completion */
 #define ACPI_EXT_EXTERNAL_EMITTED           0x08	/* External() statement has been emitted */
+#define ACPI_EXT_ORIGIN_FROM_OPCODE         0x10	/* External came from a External() opcode */
 
 struct acpi_external_file {
 	char *path;
-- 
1.7.10
