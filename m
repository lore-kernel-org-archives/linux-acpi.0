From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] acpi: Use kstrtoul() instead of strtoul()/simple_strtoul()
Date: Mon, 27 Jul 2015 17:32:22 -0700
Message-ID: <1438043542-2960-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:50698 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754629AbbG1Ac2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jul 2015 20:32:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org, Guenter Roeck <linux@roeck-us.net>

simple_strtoul() is deprecated; replace with kstrtoul() and kstrtouint().
Return an error if the value passed to the sysfs attribute is not
a number.

Drop the definition of strtoul() since it is no longer needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: An additional use of strtoul() was introduced with commit 4fa4616e.
    Replace it as well.

 drivers/acpi/acpica/evgpeinit.c | 5 +++--
 drivers/acpi/sysfs.c            | 8 ++++++--
 include/acpi/platform/aclinux.h | 1 -
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/evgpeinit.c b/drivers/acpi/acpica/evgpeinit.c
index ea4c0d3fca2d..aa1e8c1f2d4a 100644
--- a/drivers/acpi/acpica/evgpeinit.c
+++ b/drivers/acpi/acpica/evgpeinit.c
@@ -326,6 +326,7 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
 	u32 gpe_number;
 	char name[ACPI_NAME_SIZE + 1];
 	u8 type;
+	int err;
 
 	ACPI_FUNCTION_TRACE(ev_match_gpe_method);
 
@@ -377,8 +378,8 @@ acpi_ev_match_gpe_method(acpi_handle obj_handle,
 
 	/* 4) The last two characters of the name are the hex GPE Number */
 
-	gpe_number = strtoul(&name[2], NULL, 16);
-	if (gpe_number == ACPI_UINT32_MAX) {
+	er = kstrtouint(&name[2], 16, &gpe_number);
+	if (err < 0 || gpe_number == ACPI_UINT32_MAX) {
 
 		/* Conversion failed; invalid method, just ignore it */
 
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 0876d77b3206..d6ea5712ec57 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -616,8 +616,12 @@ static ssize_t counter_set(struct kobject *kobj,
 			all_counters[index].count = tmp;
 		else
 			result = -EINVAL;
-	} else
-		all_counters[index].count = strtoul(buf, NULL, 0);
+	} else {
+		if (!kstrtoul(buf, 0, &tmp))
+			all_counters[index].count = tmp;
+		else
+			result = -EINVAL;
+	}
 
 	if (ACPI_FAILURE(result))
 		result = -EINVAL;
diff --git a/include/acpi/platform/aclinux.h b/include/acpi/platform/aclinux.h
index 74ba46c8157a..9925c1d5d58f 100644
--- a/include/acpi/platform/aclinux.h
+++ b/include/acpi/platform/aclinux.h
@@ -119,7 +119,6 @@
 
 #define ACPI_MACHINE_WIDTH          BITS_PER_LONG
 #define ACPI_EXPORT_SYMBOL(symbol)  EXPORT_SYMBOL(symbol);
-#define strtoul                     simple_strtoul
 
 #define acpi_cache_t                        struct kmem_cache
 #define acpi_spinlock                       spinlock_t *
-- 
2.1.0

