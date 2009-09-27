From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/5] ACPI: Clarify resource conflict message
Date: Sun, 27 Sep 2009 04:32:42 -0400
Message-ID: <14f03343ad1080c2fea29ab2c13f05b976c4584e.1254040242.git.len.brown@intel.com>
References: <1254040365-18971-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:60112 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509AbZI0Icq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Sep 2009 04:32:46 -0400
Received: from localhost.localdomain ([74.104.150.83])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KQM0099JFQPY8I4@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 27 Sep 2009 03:32:50 -0500 (CDT)
In-reply-to: <1254040365-18971-1-git-send-email-lenb@kernel.org>
In-reply-to: <b684a3637e0887683a0a3d6fd471fc41d7c1606a.1254040242.git.len.brown@intel.com>
References: <b684a3637e0887683a0a3d6fd471fc41d7c1606a.1254040242.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.de>, Thomas Renninger <trenn@suse.de>, Alan Jenkins <sourcejedi.lkml@googlemail.com>, Len Brown <len.brown@intel.com>

From: Jean Delvare <jdelvare@suse.de>

The message "ACPI: Device needs an ACPI driver" is misleading. The
device _may_ need an ACPI driver, if the BIOS implemented a custom
API for the device in question (which, AFAIK, can't be checked.) If
not, then either a generic ACPI driver may be used (for example
"thermal"), or nothing can be done (other than a white list).

I propose to reword the message to:

ACPI: If an ACPI driver is available for this device, you should use
it instead of the native driver

which I think is more correct. Comments and suggestions welcome.

I also added a message warning about possible problems and system
instability when users pass acpi_enforce_resources=lax, as suggested
by Len.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Thomas Renninger <trenn@suse.de>
Cc: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5633b86..7c1c59e 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1161,7 +1161,13 @@ int acpi_check_resource_conflict(struct resource *res)
 			       res_list_elem->name,
 			       (long long) res_list_elem->start,
 			       (long long) res_list_elem->end);
-			printk(KERN_INFO "ACPI: Device needs an ACPI driver\n");
+			if (acpi_enforce_resources == ENFORCE_RESOURCES_LAX)
+				printk(KERN_NOTICE "ACPI: This conflict may"
+				       " cause random problems and system"
+				       " instability\n");
+			printk(KERN_INFO "ACPI: If an ACPI driver is available"
+			       " for this device, you should use it instead of"
+			       " the native driver\n");
 		}
 		if (acpi_enforce_resources == ENFORCE_RESOURCES_STRICT)
 			return -EBUSY;
-- 
1.6.0.6

