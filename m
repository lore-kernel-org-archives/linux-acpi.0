From: Ben Guthro <benjamin.guthro@citrix.com>
Subject: [PATCH v6 1/5] acpi: Remove need to include linux/acpi.h in common acpica code
Date: Mon, 1 Jul 2013 07:48:49 -0400
Message-ID: <1372679333-8473-2-git-send-email-benjamin.guthro@citrix.com>
References: <1372679333-8473-1-git-send-email-benjamin.guthro@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372679333-8473-1-git-send-email-benjamin.guthro@citrix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jan Beulich <jbeulich@suse.com>, "Rafael J . Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, xen-devel@lists.xen.org
Cc: Ben Guthro <benjamin.guthro@citrix.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

Move the definition of acpi_os_prepare_sleep into the OS services layer header,
and remove the include of linux/acpi.h from common acpica code.

Signed-off-by: Ben Guthro <benjamin.guthro@citrix.com>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Bob Moore <robert.moore@intel.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 drivers/acpi/acpica/hwsleep.c |    1 -
 include/acpi/acpiosxf.h       |    6 ++++++
 include/linux/acpi.h          |    3 ---
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index e3828cc..867b947 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -43,7 +43,6 @@
  */
 
 #include <acpi/acpi.h>
-#include <linux/acpi.h>
 #include "accommon.h"
 
 #define _COMPONENT          ACPI_HARDWARE
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 64b8c76..7b402f2 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -276,4 +276,10 @@ char *acpi_os_get_next_filename(void *dir_handle);
 
 void acpi_os_close_directory(void *dir_handle);
 
+/*
+ * ACPI sleep preparation
+ */
+acpi_status acpi_os_prepare_sleep(u8 sleep_state,
+				  u32 pm1a_control, u32 pm1b_control);
+
 #endif				/* __ACPIOSXF_H__ */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 353ba25..5d5a47b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -478,9 +478,6 @@ static inline bool acpi_driver_match_device(struct device *dev,
 #ifdef CONFIG_ACPI
 void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state,
 			       u32 pm1a_ctrl,  u32 pm1b_ctrl));
-
-acpi_status acpi_os_prepare_sleep(u8 sleep_state,
-				  u32 pm1a_control, u32 pm1b_control);
 #ifdef CONFIG_X86
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
 #else
-- 
1.7.9.5
