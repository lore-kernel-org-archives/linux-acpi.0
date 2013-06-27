From: Ben Guthro <benjamin.guthro@citrix.com>
Subject: [PATCH v4 3/5] acpi: Adjust linux acpi OS functions to new extended parameter
Date: Thu, 27 Jun 2013 11:02:01 -0400
Message-ID: <1372345323-9266-4-git-send-email-benjamin.guthro@citrix.com>
References: <1372345323-9266-1-git-send-email-benjamin.guthro@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372345323-9266-1-git-send-email-benjamin.guthro@citrix.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Jan Beulich <jbeulich@suse.com>, "Rafaell J . Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, xen-devel@lists.xen.org
Cc: Ben Guthro <benjamin.guthro@citrix.com>, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

Change the function definitions of acpi_os_prepare_sleep() and
acpi_os_set_prepare_sleep() to pass along the new extended sleep
parameter.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Ben Guthro <benjamin.guthro@citrix.com>
Cc: Bob Moore <robert.moore@intel.com>
Cc: Rafaell J. Wysocki <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/osl.c   |   16 ++++++++--------
 include/linux/acpi.h |    6 +++---
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index e721863..0251c9b 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -77,8 +77,8 @@ EXPORT_SYMBOL(acpi_in_debugger);
 extern char line_buf[80];
 #endif				/*ENABLE_DEBUGGER */
 
-static int (*__acpi_os_prepare_sleep)(u8 sleep_state, u32 pm1a_ctrl,
-				      u32 pm1b_ctrl);
+static int (*__acpi_os_prepare_sleep)(u8 sleep_state, u32 val_a, u32 val_b,
+				      bool extended);
 
 static acpi_osd_handler acpi_irq_handler;
 static void *acpi_irq_context;
@@ -1757,13 +1757,13 @@ acpi_status acpi_os_terminate(void)
 	return AE_OK;
 }
 
-acpi_status acpi_os_prepare_sleep(u8 sleep_state, u32 pm1a_control,
-				  u32 pm1b_control)
+acpi_status acpi_os_prepare_sleep(u8 sleep_state, u32 val_a, u32 val_b,
+				  u8 extended)
 {
 	int rc = 0;
 	if (__acpi_os_prepare_sleep)
-		rc = __acpi_os_prepare_sleep(sleep_state,
-					     pm1a_control, pm1b_control);
+		rc = __acpi_os_prepare_sleep(sleep_state, val_a, val_b,
+					     extended);
 	if (rc < 0)
 		return AE_ERROR;
 	else if (rc > 0)
@@ -1772,8 +1772,8 @@ acpi_status acpi_os_prepare_sleep(u8 sleep_state, u32 pm1a_control,
 	return AE_OK;
 }
 
-void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state,
-			       u32 pm1a_ctrl, u32 pm1b_ctrl))
+void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state, u32 val_a,
+			       u32 val_b, bool extended))
 {
 	__acpi_os_prepare_sleep = func;
 }
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 709a2f2..26f9996 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -477,8 +477,8 @@ static inline bool acpi_driver_match_device(struct device *dev,
 #endif	/* !CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI
-void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state,
-			       u32 pm1a_ctrl,  u32 pm1b_ctrl));
+void acpi_os_set_prepare_sleep(int (*func)(u8 sleep_state, u32 val_a,
+			       u32 val_b, bool extended));
 #ifdef CONFIG_X86
 void arch_reserve_mem_area(acpi_physical_address addr, size_t size);
 #else
@@ -488,7 +488,7 @@ static inline void arch_reserve_mem_area(acpi_physical_address addr,
 }
 #endif /* CONFIG_X86 */
 #else
-#define acpi_os_set_prepare_sleep(func, pm1a_ctrl, pm1b_ctrl) do { } while (0)
+#define acpi_os_set_prepare_sleep(func, val_a, val_b, ext) do { } while (0)
 #endif
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PM_RUNTIME)
-- 
1.7.9.5
