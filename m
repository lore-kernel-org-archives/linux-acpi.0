From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH 1/2] eeepc-laptop: Fix user after free
Date: Mon, 4 Aug 2008 18:08:33 +0100
Message-ID: <20080804170833.GA9513@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45923 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377AbYHDRIg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Aug 2008 13:08:36 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

eeepc-laptop uses the hwmon struct after unregistering the device, 
causing an oops on module unload. Flip the ordering to fix.

Signed-off-by: Matthew Garrett <mjg@redhat.com>

---

diff --git a/drivers/misc/eeepc-laptop.c b/drivers/misc/eeepc-laptop.c
index 9e8d79e..facdb98 100644
--- a/drivers/misc/eeepc-laptop.c
+++ b/drivers/misc/eeepc-laptop.c
@@ -553,9 +553,9 @@ static void eeepc_hwmon_exit(void)
 	hwmon = eeepc_hwmon_device;
 	if (!hwmon)
 		return ;
-	hwmon_device_unregister(hwmon);
 	sysfs_remove_group(&hwmon->kobj,
 			   &hwmon_attribute_group);
+	hwmon_device_unregister(hwmon);
 	eeepc_hwmon_device = NULL;
 }

-- 
Matthew Garrett | mjg59@srcf.ucam.org
