From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 4/5] eeepc-laptop: add hotplug_disable parameter
Date: Wed,  6 Jan 2010 22:07:40 +0100
Message-ID: <1262812061-4119-5-git-send-email-corentincj@iksaif.net>
References: <1262812061-4119-1-git-send-email-corentincj@iksaif.net>
 <1262812061-4119-2-git-send-email-corentincj@iksaif.net>
 <1262812061-4119-3-git-send-email-corentincj@iksaif.net>
 <1262812061-4119-4-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:34106 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932817Ab0AFVHs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 Jan 2010 16:07:48 -0500
In-Reply-To: <1262812061-4119-4-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

Some new models need to disable wireless hotplug.
For the moment, we don't know excactly what models need that,
except 1005HA.
Users will be able to use that param as a workaround.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 07d7978..8ee0cd1 100644
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
1.6.6

