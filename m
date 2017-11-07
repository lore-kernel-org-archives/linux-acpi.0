From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ACPI / PM: fix build regression
Date: Tue,  7 Nov 2017 11:48:44 +0100
Message-ID: <20171107104913.3303452-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The XPS13 workaround caused a build regression in configurations without
CONFIG_ACPI_SLEEP.

drivers/acpi/sleep.c:95:5: error: redefinition of 'acpi_target_system_state'
 u32 acpi_target_system_state(void)
     ^~~~~~~~~~~~~~~~~~~~~~~~
In file included from include/linux/acpi.h:44:0,
                 from drivers/acpi/sleep.c:20:
include/acpi/acpi_bus.h:661:19: note: previous definition of 'acpi_target_system_state' was here
 static inline u32 acpi_target_system_state(void) { return ACPI_STATE_S0; }
                   ^~~~~~~~~~~~~~~~~~~~~~~~
drivers/acpi/sleep.c:495:13: error: 'acpi_pm_end' defined but not used [-Werror=unused-function]

This adds back the #ifdef checks required to make it build cleanly again.
The patch that caused the regression is marked for backports to v4.13, the
same should apply to this one.

Fixes: 8d7a4756fef9 ("ACPI / PM: Blacklist Low Power S0 Idle _DSM for Dell XPS13 9360")
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I have not tried to verify that the new version makes sense, only that
it builds cleanly. Please have a look and apply either this patch, or
whatever else makes more sense here.
---
 drivers/acpi/sleep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 01ac769e51c9..374f995dbd0a 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -90,6 +90,7 @@ static bool acpi_sleep_state_supported(u8 sleep_state)
 			&& acpi_gbl_FADT.sleep_status.address));
 }
 
+#ifdef CONFIG_ACPI_SLEEP
 static u32 acpi_target_sleep_state = ACPI_STATE_S0;
 
 u32 acpi_target_system_state(void)
@@ -99,6 +100,7 @@ u32 acpi_target_system_state(void)
 EXPORT_SYMBOL_GPL(acpi_target_system_state);
 
 static bool pwr_btn_event_pending;
+#endif
 
 /*
  * The ACPI specification wants us to save NVS memory regions during hibernation
@@ -376,6 +378,7 @@ static void __init acpi_sleep_dmi_check(void)
 	dmi_check_system(acpisleep_dmi_table);
 }
 
+#ifdef CONFIG_ACPI_SLEEP
 /**
  * acpi_pm_freeze - Disable the GPEs and suspend EC transactions.
  */
@@ -503,6 +506,7 @@ static void acpi_pm_end(void)
 	acpi_target_sleep_state = ACPI_STATE_S0;
 	acpi_sleep_tts_switch(acpi_target_sleep_state);
 }
+#endif
 
 #ifdef CONFIG_SUSPEND
 static u32 acpi_suspend_states[] = {
-- 
2.9.0
