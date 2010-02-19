From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2.6.32.stable] ACPI, i915: blacklist Clevo M5x0N bad_lid state
Date: Thu, 18 Feb 2010 23:27:53 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002182325300.17638@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:17171 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183Ab0BSE2K (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Feb 2010 23:28:10 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KY200KN9N2IU7C2@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 18 Feb 2010 22:28:00 -0600 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>

upstgream 1379d2fef0ec07c7027a5e89036025ce761470c8
From: Zhang Rui <rui.zhang@intel.com>

Wrong Lid state reported.
Need to blacklist this machine for LVDS detection.

http://bugzilla.kernel.org/show_bug.cgi?id=15108

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/gpu/drm/i915/intel_lvds.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

Index: linux-2.6.32.y/drivers/gpu/drm/i915/intel_lvds.c
===================================================================
--- linux-2.6.32.y.orig/drivers/gpu/drm/i915/intel_lvds.c
+++ linux-2.6.32.y/drivers/gpu/drm/i915/intel_lvds.c
@@ -608,6 +608,13 @@ static const struct dmi_system_id bad_li
 			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire one"),
 		},
 	},
+	{
+		.ident = "Clevo M5x0N",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "CLEVO Co."),
+			DMI_MATCH(DMI_BOARD_NAME, "M5x0N"),
+		},
+	},
 	{ }
 };
 
