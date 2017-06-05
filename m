From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 35/53] ACPICA: Export the public mutex interfaces
Date: Mon,  5 Jun 2017 16:40:39 +0800
Message-ID: <0d57b720cf56d6663a70f394b321ef15bdc25865.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:9299 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751636AbdFEIkm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:40:42 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit ff09dcf9eb69fe9318034c60c377436030e7feea

These interfaces are intended to be used by device drivers.

Link: https://github.com/acpica/acpica/commit/ff09dcf9
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/utxfmutex.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utxfmutex.c b/drivers/acpi/acpica/utxfmutex.c
index c016211..0b85f11 100644
--- a/drivers/acpi/acpica/utxfmutex.c
+++ b/drivers/acpi/acpica/utxfmutex.c
@@ -151,6 +151,8 @@ acpi_acquire_mutex(acpi_handle handle, acpi_string pathname, u16 timeout)
 	return (status);
 }
 
+ACPI_EXPORT_SYMBOL(acpi_acquire_mutex)
+
 /*******************************************************************************
  *
  * FUNCTION:    acpi_release_mutex
@@ -167,7 +169,6 @@ acpi_acquire_mutex(acpi_handle handle, acpi_string pathname, u16 timeout)
  *              not both.
  *
  ******************************************************************************/
-
 acpi_status acpi_release_mutex(acpi_handle handle, acpi_string pathname)
 {
 	acpi_status status;
@@ -185,3 +186,5 @@ acpi_status acpi_release_mutex(acpi_handle handle, acpi_string pathname)
 	acpi_os_release_mutex(mutex_obj->mutex.os_mutex);
 	return (AE_OK);
 }
+
+ACPI_EXPORT_SYMBOL(acpi_release_mutex)
-- 
2.7.4

