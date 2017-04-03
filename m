From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Subject: [PATCH] ACPI: emits change uevents to all physical companion devices of container's children
Date: Mon,  3 Apr 2017 23:55:33 +0800
Message-ID: <20170403155533.30283-1-jlee@suse.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36129 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbdDCPzl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Apr 2017 11:55:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Lee, Chun-Yi" <jlee@suse.com>, Michal Hocko <mhocko@suse.com>, Jiri Kosina <jkosina@suse.cz>

The caa73ea1 patch, "ACPI / hotplug / driver core: Handle containers
in a special way", introduced the offline callback of acpi container.
In the patch description, it mentions:

    For ACPI containers that callback simply walks the list of ACPI
    device objects right below the container object (its children) and
    checks if all of their physical companion devices are offline.  If
    that's not the case, it returns -EBUSY and the container system
    devivce cannot be put offline.  Consequently, to put the container
    system device offline, it is necessary to put all of the physical
    devices depending on its ACPI companion object offline beforehand.

Looks that it means acpi_container_offline() should walks all physical
companion devices of container's children and checks their offline
state. And, the comment in source code is "Check all of the dependent
devices' physical companions", which means it should checks _all_
physical companions.

But, the checking code just stops at the first not-offlined physical
companion device of the first not-offlined child, then kernel only
emits KOBJ_CHANGE uevent to the one device. It doesn't really walk
all children's all physical companion devices and doesn't send change
uevent to them.

This causes that usespace can only receive one uevent for one physical
companion device in acpi container when acpi container offline is
triggered.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 drivers/acpi/container.c | 5 +++--
 drivers/acpi/scan.c      | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 12c2409..1f1537d 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -43,13 +43,14 @@ static int acpi_container_offline(struct container_dev *cdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&cdev->dev);
 	struct acpi_device *child;
+	int ret = 0;
 
 	/* Check all of the dependent devices' physical companions. */
 	list_for_each_entry(child, &adev->children, node)
 		if (!acpi_scan_is_offline(child, false))
-			return -EBUSY;
+			ret = -EBUSY;
 
-	return 0;
+	return ret;
 }
 
 static void acpi_container_release(struct device *dev)
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1926918..1a9055c 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -134,7 +134,6 @@ bool acpi_scan_is_offline(struct acpi_device *adev, bool uevent)
 				kobject_uevent(&pn->dev->kobj, KOBJ_CHANGE);
 
 			offline = false;
-			break;
 		}
 
 	mutex_unlock(&adev->physical_node_lock);
-- 
2.10.2

