From: Len Brown <lenb@kernel.org>
Subject: [PATCH 14/16] eeepc-laptop: add hotplug_disable parameter
Date: Sat, 16 Jan 2010 02:33:04 -0500
Message-ID: <322a1356be96bcc4b97e8e370f6468c821330077.1263627123.git.len.brown@intel.com>
References: <1263627186-21384-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:58779 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898Ab0APHef (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2010 02:34:35 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWB00L58X1LW0J1@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 Jan 2010 01:34:34 -0600 (CST)
In-reply-to: <1263627186-21384-1-git-send-email-lenb@kernel.org>
In-reply-to: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
References: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Some new models need to disable wireless hotplug.
For the moment, we don't know excactly what models need that,
except 1005HA.
Users will be able to use that param as a workaround.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 07d7978..a959abd 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -50,6 +50,14 @@ MODULE_AUTHOR("Corentin Chary, Eric Cooper");
 MODULE_DESCRIPTION(EEEPC_LAPTOP_NAME);
 MODULE_LICENSE("GPL");
 
+static bool hotplug_disabled;
+
+module_param(hotplug_disabled, bool, 0644);
+MODULE_PARM_DESC(hotplug_disabled,
+		 "Disable hotplug for wireless device. "
+		 "If your laptop need that, please report to "
+		 "acpi4asus-user@lists.sourceforge.net.");
+
 /*
  * Definitions for Asus EeePC
  */
@@ -1356,6 +1364,8 @@ static int __devinit eeepc_acpi_add(struct acpi_device *device)
 	strcpy(acpi_device_class(device), EEEPC_ACPI_CLASS);
 	device->driver_data = eeepc;
 
+	eeepc->hotplug_disabled = hotplug_disabled;
+
 	eeepc_dmi_check(eeepc);
 
 	result = eeepc_acpi_init(eeepc, device);
-- 
1.6.0.6

