From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 02/32] ACPICA: Linuxize: Replace __FUNCTION__ with __func__.
Date: Fri, 19 Jun 2015 11:38:22 +0800
Message-ID: <c33ab7fe45f763c4f00ededfcc72723239358e3f.1434684719.git.lv.zheng@intel.com>
References: <cover.1434684719.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1434684719.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

ACPICA commit cb3d1c79f862cd368d749c9b8d9dced40111b0d0

__FUNCTION__ is MSVC only, in Linux, it is __func__. Lv Zheng.

In ACPICA, this is achieved by string replacement in release script and
this patch contains the source code difference between the Linux upstream
and ACPICA that is caused by the back porting.

Link: https://github.com/acpica/acpica/commit/cb3d1c79
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utdebug.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/utdebug.c b/drivers/acpi/acpica/utdebug.c
index 4f3f888..cd02693 100644
--- a/drivers/acpi/acpica/utdebug.c
+++ b/drivers/acpi/acpica/utdebug.c
@@ -111,8 +111,8 @@ void acpi_ut_track_stack_ptr(void)
  * RETURN:      Updated pointer to the function name
  *
  * DESCRIPTION: Remove the "Acpi" prefix from the function name, if present.
- *              This allows compiler macros such as __func__ to be used with no
- *              change to the debug output.
+ *              This allows compiler macros such as __func__ to be used
+ *              with no change to the debug output.
  *
  ******************************************************************************/
 
-- 
1.7.10
