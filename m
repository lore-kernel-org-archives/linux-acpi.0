From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] acpi: scan: Fix a possible data race in acpi_scan_hotplug_enabled
Date: Tue,  8 May 2018 11:08:11 +0800
Message-ID: <20180508030811.12256-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: linux-acpi@vger.kernel.org

The write operation to "hotplug->enabled" is protected by
the lock on line 1760, but the read operation to
this data on line 1755 is not protected by the lock.
Thus, there may exist a data race for "hotplug->enabled".

To fix this data race, the read operation to "hotplug->enabled" is 
also protected by the lock.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/acpi/scan.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 970dd87d347c..e21d7b0f7179 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1752,11 +1752,13 @@ static struct acpi_scan_handler *acpi_scan_match_handler(const char *idstr,
 
 void acpi_scan_hotplug_enabled(struct acpi_hotplug_profile *hotplug, bool val)
 {
-	if (!!hotplug->enabled == !!val)
-		return;
-
 	mutex_lock(&acpi_scan_lock);
 
+	if (!!hotplug->enabled == !!val) {
+		mutex_unlock(&acpi_scan_lock);
+		return;
+	}
+
 	hotplug->enabled = val;
 
 	mutex_unlock(&acpi_scan_lock);
-- 
2.17.0
