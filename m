From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 21/31] ACPICA: iASL: Enhancement for constant folding.
Date: Mon, 13 Apr 2015 11:50:26 +0800
Message-ID: <38c2eec0abd74de933241dca8d23543e017aeddc.1428893938.git.lv.zheng@intel.com>
References: <cover.1428893935.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1428893935.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 4f9e950d41cd6f6c704d5d6cf518647620d65e99

Add support to fold expressions with a target operand -- these are
folded and converted to a Store operator:

Add (4, 3, INT1) --> Store (7, INT1)

Also supports ASL+ constructs:

INT1 = 4 + 3 --> Store (7, INT1)

Linux kernel is not affected by this patch.

Link: https://github.com/acpica/acpica/commit/4f9e950d
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acstruct.h |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/acpi/acpica/acstruct.h b/drivers/acpi/acpica/acstruct.h
index d14b547..87c7860 100644
--- a/drivers/acpi/acpica/acstruct.h
+++ b/drivers/acpi/acpica/acstruct.h
@@ -68,11 +68,6 @@
 #define ACPI_WALK_METHOD            0x01
 #define ACPI_WALK_METHOD_RESTART    0x02
 
-/* Flags for iASL compiler only */
-
-#define ACPI_WALK_CONST_REQUIRED    0x10
-#define ACPI_WALK_CONST_OPTIONAL    0x20
-
 struct acpi_walk_state {
 	struct acpi_walk_state *next;	/* Next walk_state in list */
 	u8 descriptor_type;	/* To differentiate various internal objs */
-- 
1.7.10
