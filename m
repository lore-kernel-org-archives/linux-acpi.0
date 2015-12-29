From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 15/42] ACPICA: Add comment explaining _SUB removal
Date: Tue, 29 Dec 2015 13:56:14 +0800
Message-ID: <c44a2c86b81f8e0a5cb981394b5de856035e8526.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 81a89968f83bfc3b1d0f0f80f2da08ea69646053

Adds a lengthy comment to acpi_get_object_info explaining the removal
of _SUB and why no complex methods can be added ever to this
interface.

Link: https://github.com/acpica/acpica/commit/81a89968
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/nsxfname.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 0e4e6b7..669e0f1 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -267,6 +267,13 @@ static char *acpi_ns_copy_device_id(struct acpi_pnp_device_id *dest,
  *
  * Note: Allocates the return buffer, must be freed by the caller.
  *
+ * Note: This interface is intended to be used during the initial device
+ * discovery namespace traversal. Therefore, no complex methods can be
+ * executed, especially those that access operation regions. Therefore, do
+ * not add any additional methods that could cause problems in this area.
+ * this was the fate of the _SUB method which was found to cause such
+ * problems and was removed (11/2015).
+ *
  ******************************************************************************/
 
 acpi_status
-- 
1.7.10
