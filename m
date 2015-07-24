From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] acpi: Use kstrtoul() instead of strtoul()/simple_strtoul()
Date: Fri, 24 Jul 2015 09:51:57 -0700
Message-ID: <1437756717-11730-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48954 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbbGXQwC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jul 2015 12:52:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org, Guenter Roeck <linux@roeck-us.net>

simple_strtoul() is deprecated; replace with kstrtoul().
Return an error if the value passed to the sysfs attribute
is not a number.

Drop the definition of strtoul() since it is no longer needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/acpi/sysfs.c            | 8 ++++++--
 include/acpi/platform/aclinux.h | 1 -
 2 files changed, 6 insertions(+), 3 deletions(-)

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

