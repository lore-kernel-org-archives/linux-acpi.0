From: Randy Dunlap <rdunlap@xenotime.net>
Subject: [PATCH] acpi: cm_sbs: use NULL instead of 0 for ptr
Date: Mon, 25 Sep 2006 21:47:20 -0700
Message-ID: <20060925214720.2f9778f9.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:61158 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750758AbWIZEul (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Sep 2006 00:50:41 -0400
Received: from midway.site ([71.117.233.155]) by xenotime.net for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2006 21:50:36 -0700
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com, akpm <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org, viro <viro@zeniv.linux.org.uk>

From: Randy Dunlap <rdunlap@xenotime.net>

Use NULL instead of 0 for pointer value, eliminate sparse warnings.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/acpi/cm_sbs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2618-g4.orig/drivers/acpi/cm_sbs.c
+++ linux-2618-g4/drivers/acpi/cm_sbs.c
@@ -67,7 +67,7 @@ void acpi_unlock_ac_dir(struct proc_dir_
 		lock_ac_dir_cnt--;
 	if (lock_ac_dir_cnt == 0 && acpi_ac_dir_param && acpi_ac_dir) {
 		remove_proc_entry(ACPI_AC_CLASS, acpi_root_dir);
-		acpi_ac_dir = 0;
+		acpi_ac_dir = NULL;
 	}
 	mutex_unlock(&cm_sbs_mutex);
 }
@@ -99,7 +99,7 @@ void acpi_unlock_battery_dir(struct proc
 	if (lock_battery_dir_cnt == 0 && acpi_battery_dir_param
 	    && acpi_battery_dir) {
 		remove_proc_entry(ACPI_BATTERY_CLASS, acpi_root_dir);
-		acpi_battery_dir = 0;
+		acpi_battery_dir = NULL;
 	}
 	mutex_unlock(&cm_sbs_mutex);
 	return;


---
