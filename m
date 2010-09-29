From: Len Brown <lenb@kernel.org>
Subject: [PATCH 15/16] ACPI: Disable Windows Vista compatibility for Toshiba
 P305D
Date: Tue, 28 Sep 2010 23:44:45 -0400
Message-ID: <337279ce3aa85d81d34c0f837d1c204df105103b.1285731809.git.len.brown@intel.com>
References: <1285731886-18321-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:58382 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352Ab0I2DyS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 23:54:18 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9H00JMZPI2KR79@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Sep 2010 22:54:07 -0500 (CDT)
In-reply-to: <1285731886-18321-1-git-send-email-lenb@kernel.org>
In-reply-to: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
References: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Disable the Windows Vista (SP1) compatibility for Toshiba P305D.

http://bugzilla.kernel.org/show_bug.cgi?id=14736

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/blacklist.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 571a003..f761960 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -243,6 +243,14 @@ static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 		     DMI_MATCH(DMI_PRODUCT_NAME, "K50IJ"),
 		},
 	},
+	{
+	.callback = dmi_disable_osi_vista,
+	.ident = "Toshiba P305D",
+	.matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P305D"),
+		},
+	},
 
 	/*
 	 * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
-- 
1.7.3.2.g9027fa

