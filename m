From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: [PATCH 3/4] drm/i915: use ACPI LID status for LVDS ->detect hook
Date: Wed, 15 Jul 2009 15:11:25 -0700
Message-ID: <1247695886-18432-4-git-send-email-jbarnes@virtuousgeek.org>
References: <1247695886-18432-1-git-send-email-jbarnes@virtuousgeek.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-109.bluehost.com ([69.89.22.9]:58395 "HELO
	outbound-mail-109.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752488AbZGOWL3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jul 2009 18:11:29 -0400
In-Reply-To: <1247695886-18432-1-git-send-email-jbarnes@virtuousgeek.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>

We can't load or hotplug detect LVDS like we can other outputs, but if
there's a lid device present we can use it as a proxy.  This allows the
LFP state to be determined at ->detect time, making configurations
requiring manual intervention today "just work" assuming the lid device
status is correct.

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
---
 drivers/gpu/drm/i915/intel_lvds.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_lvds.c b/drivers/gpu/drm/i915/intel_lvds.c
index 1d0d30a..57c86fd 100644
--- a/drivers/gpu/drm/i915/intel_lvds.c
+++ b/drivers/gpu/drm/i915/intel_lvds.c
@@ -599,12 +599,18 @@ static void intel_lvds_mode_set(struct drm_encoder *encoder,
 /**
  * Detect the LVDS connection.
  *
- * This always returns CONNECTOR_STATUS_CONNECTED.  This connector should only have
- * been set up if the LVDS was actually connected anyway.
+ * Since LVDS doesn't have hotlug, we use the lid as a proxy.  Open means
+ * connected and closed means disconnected.  We also send hotplug events as
+ * needed, using lid status notification from the input layer.
  */
 static enum drm_connector_status intel_lvds_detect(struct drm_connector *connector)
 {
-	return connector_status_connected;
+	enum drm_connector_status status = connector_status_connected;
+
+	if (!acpi_lid_open())
+		status = connector_status_disconnected;
+
+	return status;
 }
 
 /**
-- 
1.6.2.5

