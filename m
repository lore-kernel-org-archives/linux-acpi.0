From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: [PATCH 4/4] drm/i915: generate a KMS uevent at lid open/close time
Date: Wed, 15 Jul 2009 15:11:26 -0700
Message-ID: <1247695886-18432-5-git-send-email-jbarnes@virtuousgeek.org>
References: <1247695886-18432-1-git-send-email-jbarnes@virtuousgeek.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-16.bluehost.com ([69.89.20.231]:55897 "HELO
	outbound-mail-16.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753940AbZGOWSJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jul 2009 18:18:09 -0400
In-Reply-To: <1247695886-18432-1-git-send-email-jbarnes@virtuousgeek.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>

With all the other lid pieces in place, it's easy to generate a uevent
for the LVDS connector just like we do for other outputs.  Should make
lid open/close fit in with the rest of a userland based output
reconfiguration scheme.

Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
---
 drivers/gpu/drm/i915/intel_lvds.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_lvds.c b/drivers/gpu/drm/i915/intel_lvds.c
index 57c86fd..7cb6633 100644
--- a/drivers/gpu/drm/i915/intel_lvds.c
+++ b/drivers/gpu/drm/i915/intel_lvds.c
@@ -659,6 +659,8 @@ static int intel_lid_notify(struct notifier_block *nb, unsigned long val,
 	if (acpi_lid_open())
 		drm_helper_resume_force_mode(dev);
 
+	drm_sysfs_hotplug_event(dev_priv->dev);
+
 	return NOTIFY_OK;
 }
 
-- 
1.6.2.5

