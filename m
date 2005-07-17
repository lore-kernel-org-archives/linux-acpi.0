From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: acpi/sleep/proc.c
Date: Sun, 17 Jul 2005 21:16:37 +0200
Message-ID: <20050717191637.GA12674@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This cleans up acpi/sleep/proc.c. It removes macros used just
once. Only code change is removing duplicated code in two branches of
if().

[As a side note, this should make akpm stop patchbombing you :-)]

Signed-off-by: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>

diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -13,13 +13,6 @@
 
 #include "sleep.h"
 
-#ifdef	CONFIG_ACPI_SLEEP_PROC_SLEEP
-#define ACPI_SYSTEM_FILE_SLEEP		"sleep"
-#endif
-
-#define ACPI_SYSTEM_FILE_ALARM		"alarm"
-#define ACPI_SYSTEM_FILE_WAKEUP_DEVICE   "wakeup"
-
 #define _COMPONENT		ACPI_SYSTEM_COMPONENT
 ACPI_MODULE_NAME		("sleep")
 
@@ -378,14 +371,10 @@ acpi_system_wakeup_device_seq_show(struc
 		if (!dev->wakeup.flags.valid)
 			continue;
 		spin_unlock(&acpi_device_lock);
-		if (dev->wakeup.flags.run_wake)
-			seq_printf(seq, "%4s	%4d		%8s\n",
-				dev->pnp.bus_id, (u32) dev->wakeup.sleep_state,
-				dev->wakeup.state.enabled ? "*enabled" : "*disabled");
-		else
-			seq_printf(seq, "%4s	%4d		%8s\n",
-				dev->pnp.bus_id, (u32) dev->wakeup.sleep_state,
-				dev->wakeup.state.enabled ? "enabled" : "disabled");
+		seq_printf(seq, "%4s	%4d		%s%8s\n",
+			   dev->pnp.bus_id, (u32) dev->wakeup.sleep_state,
+			   dev->wakeup.flags.run_wake ? "*" : "",
+			   dev->wakeup.state.enabled ? "*enabled" : "*disabled");
 		spin_lock(&acpi_device_lock);
 	}
 	spin_unlock(&acpi_device_lock);
@@ -486,28 +475,25 @@ static u32 rtc_handler(void * context)
 
 static int acpi_sleep_proc_init(void)
 {
-	struct proc_dir_entry	*entry = NULL;
+	struct proc_dir_entry *entry = NULL;
 
 	if (acpi_disabled)
 		return 0;
  
 #ifdef	CONFIG_ACPI_SLEEP_PROC_SLEEP
-	/* 'sleep' [R/W]*/
-	entry = create_proc_entry(ACPI_SYSTEM_FILE_SLEEP,
-				  S_IFREG|S_IRUGO|S_IWUSR, acpi_root_dir);
+	/* 'sleep' [R/W] */
+	entry = create_proc_entry("sleep", S_IFREG|S_IRUGO|S_IWUSR, acpi_root_dir);
 	if (entry)
 		entry->proc_fops = &acpi_system_sleep_fops;
 #endif
 
 	/* 'alarm' [R/W] */
-	entry = create_proc_entry(ACPI_SYSTEM_FILE_ALARM,
-		S_IFREG|S_IRUGO|S_IWUSR, acpi_root_dir);
+	entry = create_proc_entry("alarm", S_IFREG|S_IRUGO|S_IWUSR, acpi_root_dir);
 	if (entry)
 		entry->proc_fops = &acpi_system_alarm_fops;
 
-	/* 'wakeup device' [R/W]*/
-	entry = create_proc_entry(ACPI_SYSTEM_FILE_WAKEUP_DEVICE,
-				  S_IFREG|S_IRUGO|S_IWUSR, acpi_root_dir);
+	/* 'wakeup device' [R/W] */
+	entry = create_proc_entry("wakeup", S_IFREG|S_IRUGO|S_IWUSR, acpi_root_dir);
 	if (entry)
 		entry->proc_fops = &acpi_system_wakeup_device_fops;
 

-- 
teflon -- maybe it is a trademark, but it should not be.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
