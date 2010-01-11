From: Len Brown <lenb@kernel.org>
Subject: [PATCH] drm/i915: Add HP nx9020/Samsung SX20S to ACPI LID quirk list
Date: Mon, 11 Jan 2010 17:47:13 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001111744300.4076@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:57115 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944Ab0AKWrb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jan 2010 17:47:31 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KW300CAWTYRBYK4@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 11 Jan 2010 16:47:21 -0600 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dri-devel@lists.sourceforge.net, David Airlie <airlied@linux.ie>
Cc: linux-acpi@vger.kernel.org

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

Dave,
As this is an ACPI BIOS workaround bug that touches DRM code,
if you ack this I'll be happy to send this upstream w/ your ack.

thanks,
-Len

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
1.6.6.136.g637af

