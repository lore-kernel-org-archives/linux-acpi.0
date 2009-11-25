From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/6] ACPI: Add Thinkpad T400, T500 to OSI(Linux) white-list
Date: Wed, 25 Nov 2009 01:11:57 -0500
Message-ID: <8b1edc57a617d00845806ca1fce1799c08d50920.1259129450.git.len.brown@intel.com>
References: <1259129520-8281-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:63734 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbZKYGMP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2009 01:12:15 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KTN00NBDIK54VIM@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 25 Nov 2009 00:12:05 -0600 (CST)
In-reply-to: <1259129520-8281-1-git-send-email-lenb@kernel.org>
In-reply-to: <87c687be055e67bc04189ce476690be73d16063e.1259129450.git.len.brown@intel.com>
References: <87c687be055e67bc04189ce476690be73d16063e.1259129450.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jerone Young <jerone.young@canonical.com>, Len Brown <len.brown@intel.com>

From: Jerone Young <jerone.young@canonical.com>

acpi_osi=Linux helps the mute button work properly by sending Linux
a mute key press.

http://bugzilla.kernel.org/show_bug.cgi?id=13934

Signed-off-by: Jerone Young <jerone.young@canonical.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/blacklist.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index e56b2a7..23e5a05 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -224,6 +224,7 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	 * _OSI(Linux) helps sound
 	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad R61"),
 	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T61"),
+	 * T400, T500
 	 * _OSI(Linux) has Linux specific hooks
 	 * DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X61"),
 	 * _OSI(Linux) is a NOP:
@@ -254,6 +255,22 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X61"),
 		},
 	},
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo ThinkPad T400",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T400"),
+		},
+	},
+	{
+	.callback = dmi_enable_osi_linux,
+	.ident = "Lenovo ThinkPad T500",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		     DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T500"),
+		},
+	},
 	{}
 };
 
-- 
1.6.0.6

