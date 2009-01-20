From: Holger Macht <hmacht@suse.de>
Subject: [PATCH] ACPI: dock: Don't eval _STA on every show_docked sysfs read
Date: Tue, 20 Jan 2009 12:18:24 +0100
Message-ID: <1232450304.5286.4.camel@homac.suse.de>
Reply-To: hmacht@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:57708 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757656AbZATLTW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jan 2009 06:19:22 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: stable@kernel.org, Len Brown <lenb@kernel.org>, Li@suse.de, Shaohua <shaohua.li@intel.com>, Daniel Smolik <marvin@mydatex.cz>, akpm@linux-foundation.org

Some devices trigger a DEVICE_CHECK on every evalutation of _STA. This
can also be seen in commit 8b59560a3baf2e7c24e0fb92ea5d09eca92805db
(ACPI: dock: avoid check _STA method).  If an undock is processed, the
dock driver sends a uevent and userspace might read the show_docked
property in sysfs. This causes an evaluation of _STA of the particular
device which causes the dock driver to immediately dock again.

In any case, evaluation of _STA (show_docked) does not necessarily mean
that we are docked, so check with the internal device structure.

http://bugzilla.kernel.org/show_bug.cgi?id=12360

Signed-off-by: Holger Macht <hmacht@suse.de>
---

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 5b30b8d..afd5db3 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -855,10 +855,14 @@ fdd_out:
 static ssize_t show_docked(struct device *dev,
 			   struct device_attribute *attr, char *buf)
 {
+	struct acpi_device *tmp;
+
 	struct dock_station *dock_station = *((struct dock_station **)
 		dev->platform_data);
-	return snprintf(buf, PAGE_SIZE, "%d\n", dock_present(dock_station));
 
+	if (ACPI_SUCCESS(acpi_bus_get_device(dock_station->handle, &tmp)))
+		return snprintf(buf, PAGE_SIZE, "1\n");
+	return snprintf(buf, PAGE_SIZE, "0\n");
 }
 static DEVICE_ATTR(docked, S_IRUGO, show_docked, NULL);
 

