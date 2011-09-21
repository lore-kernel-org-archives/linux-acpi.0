From: Rakib Mullick <rakib.mullick@gmail.com>
Subject: [PATCH] acpi: Fix possible recursive locking in hwregs.c
Date: Thu, 22 Sep 2011 00:09:49 +0600
Message-ID: <1316628589.7341.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Calling pm-suspend might trigger a recursive lock in it's code path. In function acpi_hw_clear_acpi_status, 
acpi_os_release_lock holds the lock acpi_gbl_hardware_lock before calling acpi_hw_register_write(), then 
without releasing acpi_gbl_hardware_lock, this function calls acpi_ev_walk_gpe_list, which also tries to 
hold acpi_gbl_hardware_lock and thus causes possible recursive lock. 

Following patch fixes this scenario by just releasing acpi_gbl_hardware_lock before calling acpi_ev_walk_gpe_list.

[This patch was created against 3.0-rc3. Since kernel.org is down, I don't have the updated tree. So, before applying
it might require some adjustment.]

Signed-off-by: Rakib Mullick <rakib.mullick@gmail.com>
---

diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 55accb7..e3110ac 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -269,6 +269,9 @@ acpi_status acpi_hw_clear_acpi_status(void)
 
 	status = acpi_hw_register_write(ACPI_REGISTER_PM1_STATUS,
 					ACPI_BITMASK_ALL_FIXED_STATUS);
+
+	acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags);
+
 	if (ACPI_FAILURE(status)) {
 		goto unlock_and_exit;
 	}
@@ -278,7 +281,6 @@ acpi_status acpi_hw_clear_acpi_status(void)
 	status = acpi_ev_walk_gpe_list(acpi_hw_clear_gpe_block, NULL);
 
       unlock_and_exit:
-	acpi_os_release_lock(acpi_gbl_hardware_lock, lock_flags);
 	return_ACPI_STATUS(status);
 }
 
