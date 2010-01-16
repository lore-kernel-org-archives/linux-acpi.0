From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/16] drm/i915: Add HP nx9020/Samsung SX20S to ACPI LID quirk
 list
Date: Sat, 16 Jan 2010 02:32:55 -0500
Message-ID: <25fbdd0b66c193607ed058662e06d29345766c17.1263627123.git.len.brown@intel.com>
References: <1263627186-21384-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:50147 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab0APHdZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2010 02:33:25 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWB0026DWZBKQ47@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 Jan 2010 01:33:17 -0600 (CST)
In-reply-to: <1263627186-21384-1-git-send-email-lenb@kernel.org>
In-reply-to: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
References: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

The HP comaq nx9020/Samsung SX20S laptop always report that the LID status is
closed and we can't use it reliabily for LVDS detection. So add the two boxes
into the quirk list.

http://bugzilla.kernel.org/show_bug.cgi?id=14957
http://bugzilla.kernel.org/show_bug.cgi?id=14554

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Tested-by: Philipp Kohlbecher<xt28@gmx.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/gpu/drm/i915/intel_lvds.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_lvds.c b/drivers/gpu/drm/i915/intel_lvds.c
index f4b4aa2..160283a 100644
--- a/drivers/gpu/drm/i915/intel_lvds.c
+++ b/drivers/gpu/drm/i915/intel_lvds.c
@@ -602,6 +602,20 @@ static void intel_lvds_mode_set(struct drm_encoder *encoder,
 /* Some lid devices report incorrect lid status, assume they're connected */
 static const struct dmi_system_id bad_lid_status[] = {
 	{
+		.ident = "Compaq nx9020",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_BOARD_NAME, "3084"),
+		},
+	},
+	{
+		.ident = "Samsung SX20S",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Samsung Electronics"),
+			DMI_MATCH(DMI_BOARD_NAME, "SX20S"),
+		},
+	},
+	{
 		.ident = "Aspire One",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-- 
1.6.0.6

