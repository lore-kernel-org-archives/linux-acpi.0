From: Alexey Dobriyan <adobriyan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] acpi: remove whitespace before \n
Date: Tue, 27 Sep 2005 01:45:34 +0400
Message-ID: <20050926214533.GF32409@mipter.zuzino.mipt.ru>
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
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Denis Vlasenko <vda-BN/BzeNzsW2SlH3FCl+8hg@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Denis Vlasenko <vda-BN/BzeNzsW2SlH3FCl+8hg@public.gmane.org>

Signed-off-by: Alexey Dobriyan <adobriyan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---

 drivers/acpi/acpi_memhotplug.c |    2 +-
 drivers/acpi/hotkey.c          |    4 ++--
 drivers/acpi/pci_link.c        |    2 +-
 drivers/acpi/sleep/main.c      |    2 +-
 drivers/acpi/sleep/wakeup.c    |    2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -375,7 +375,7 @@ static int acpi_memory_device_add(struct
 	/* Set the device state */
 	mem_device->state = MEMORY_POWER_ON_STATE;
 
-	printk(KERN_INFO "%s \n", acpi_device_name(device));
+	printk(KERN_INFO "%s\n", acpi_device_name(device));
 
 	return_VALUE(result);
 }
--- a/drivers/acpi/hotkey.c
+++ b/drivers/acpi/hotkey.c
@@ -769,7 +769,7 @@ static ssize_t hotkey_write_config(struc
 
 	if (copy_from_user(config_record, buffer, count)) {
 		kfree(config_record);
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid data \n"));
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid data\n"));
 		return_VALUE(-EINVAL);
 	}
 	config_record[count] = 0;
@@ -826,7 +826,7 @@ static ssize_t hotkey_write_config(struc
 		else
 			free_poll_hotkey_buffer(key);
 		kfree(key);
-		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid hotkey \n"));
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid hotkey\n"));
 		return_VALUE(-EINVAL);
 	}
 
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -295,7 +295,7 @@ static int acpi_pci_link_get_current(str
 
 	link->irq.active = irq;
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Link at IRQ %d \n", link->irq.active));
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Link at IRQ %d\n", link->irq.active));
 
       end:
 	return_VALUE(result);
--- a/drivers/acpi/sleep/main.c
+++ b/drivers/acpi/sleep/main.c
@@ -52,7 +52,7 @@ static int acpi_pm_prepare(suspend_state
 	u32 acpi_state = acpi_suspend_states[pm_state];
 
 	if (!sleep_states[acpi_state]) {
-		printk("acpi_pm_prepare does not support %d \n", pm_state);
+		printk("acpi_pm_prepare does not support %d\n", pm_state);
 		return -EPERM;
 	}
 	return acpi_sleep_prepare(acpi_state);
--- a/drivers/acpi/sleep/wakeup.c
+++ b/drivers/acpi/sleep/wakeup.c
@@ -155,7 +155,7 @@ static int __init acpi_wakeup_device_ini
 
 	if (acpi_disabled)
 		return 0;
-	printk("ACPI wakeup devices: \n");
+	printk("ACPI wakeup devices:\n");
 
 	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
