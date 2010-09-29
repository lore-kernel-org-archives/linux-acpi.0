From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/16] ACPI: add DMI entry to work around another insane
 Toshiba BIOS
Date: Tue, 28 Sep 2010 23:44:46 -0400
Message-ID: <b4b8edbdb198b3dfe633de9c93a014b22e3ec014.1285731809.git.len.brown@intel.com>
References: <1285731886-18321-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:58382 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753673Ab0I2DyR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 23:54:17 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9H00JMZPI2KR79@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Sep 2010 22:54:03 -0500 (CDT)
In-reply-to: <1285731886-18321-1-git-send-email-lenb@kernel.org>
In-reply-to: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
References: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Toshiba Satellite C655D-S5048

https://bugzilla.kernel.org/show_bug.cgi?id=14679

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/bus.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 5c221ab..5d48332 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -99,6 +99,14 @@ static struct dmi_system_id dsdt_dmi_table[] __initdata = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite L505D"),
 		},
 	},
+	{
+	 .callback = set_copy_dsdt,
+	 .ident = "TOSHIBA Satellite C655D-S5048",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Satellite C655D"),
+		},
+	},
 	{}
 };
 #else
-- 
1.7.3.2.g9027fa

