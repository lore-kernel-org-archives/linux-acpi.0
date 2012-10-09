From: Len Brown <lenb@kernel.org>
Subject: [PATCH 17/30] Fix a build error.
Date: Tue,  9 Oct 2012 01:54:07 -0400
Message-ID: <a7a3b8c86f9fb8e8d13fb51a4a8b68166893b9b5.1349761836.git.len.brown@intel.com>
References: <1349762060-25334-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349762060-25334-1-git-send-email-lenb@kernel.org>
In-Reply-To: <e3f25e6e5836c4790fbe395ff42e241f372d859d.1349761836.git.len.brown@intel.com>
References: <e3f25e6e5836c4790fbe395ff42e241f372d859d.1349761836.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Eduardo Valentin <eduardo.valentin@ti.com>

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/staging/omap-thermal/omap-thermal-common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/omap-thermal/omap-thermal-common.c b/drivers/staging/omap-thermal/omap-thermal-common.c
index d543d5c..b4cd6cc 100644
--- a/drivers/staging/omap-thermal/omap-thermal-common.c
+++ b/drivers/staging/omap-thermal/omap-thermal-common.c
@@ -120,7 +120,9 @@ static int omap_thermal_bind(struct thermal_zone_device *thermal,
 
 	/* TODO: bind with min and max states */
 	/* Simple thing, two trips, one passive another critical */
-	return thermal_zone_bind_cooling_device(thermal, 0, cdev);
+	return thermal_zone_bind_cooling_device(thermal, 0, cdev,
+						THERMAL_NO_LIMIT,
+						THERMAL_NO_LIMIT);
 }
 
 /* Unbind callback functions for thermal zone */
-- 
1.8.0.rc1
