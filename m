From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] ACPICA: Export mutex functions
Date: Wed, 12 Apr 2017 08:13:10 -0700
Message-ID: <1492009990-3539-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-acpi@vger.kernel.org

Mutex functions may be needed by drivers. Examples are accesses to Super-IO
SIO registers (0x2e/0x2f or 0x4e/0x4f) or Super-IO environmental monitor
registers, both which may also be accessed through DSDT.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/acpi/acpica/utxfmutex.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpica/utxfmutex.c b/drivers/acpi/acpica/utxfmutex.c
index c016211c35ae..5d20581f4b2f 100644
--- a/drivers/acpi/acpica/utxfmutex.c
+++ b/drivers/acpi/acpica/utxfmutex.c
@@ -150,6 +150,7 @@ acpi_acquire_mutex(acpi_handle handle, acpi_string pathname, u16 timeout)
 	status = acpi_os_acquire_mutex(mutex_obj->mutex.os_mutex, timeout);
 	return (status);
 }
+ACPI_EXPORT_SYMBOL(acpi_acquire_mutex)
 
 /*******************************************************************************
  *
@@ -185,3 +186,4 @@ acpi_status acpi_release_mutex(acpi_handle handle, acpi_string pathname)
 	acpi_os_release_mutex(mutex_obj->mutex.os_mutex);
 	return (AE_OK);
 }
+ACPI_EXPORT_SYMBOL(acpi_release_mutex)
-- 
2.7.4
