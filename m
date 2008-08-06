From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH v2 1/2] eeepc-laptop: Fix user after free
Date: Wed, 6 Aug 2008 10:23:52 +0100
Message-ID: <20080806092352.GA17801@srcf.ucam.org>
References: <20080804170833.GA9513@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49233 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757377AbYHFJX4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Aug 2008 05:23:56 -0400
Content-Disposition: inline
In-Reply-To: <20080804170833.GA9513@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

eeepc-laptop uses the hwmon struct after unregistering the device, 
causing an oops on module unload. Flip the ordering to fix.
                                                                                                                                                                                                        
Signed-off-by: Matthew Garrett <mjg@redhat.com>

---

commit 95f4bc41ef256b8e3dfa94cabe1faf0776ac988c
Author: Matthew Garrett <mjg59@srcf.ucam.org>
Date:   Mon Aug 4 17:57:40 2008 +0100

    Fix use after free

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
