From: akpm@linux-foundation.org
Subject: [patch 10/12] thermal: disable polling if passive_delay and polling_delay are both unset
Date: Tue, 17 Nov 2009 14:27:36 -0800
Message-ID: <200911172227.nAHMRaVZ023449@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36327 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756291AbZKQWhT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Nov 2009 17:37:19 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, elendil@planet.nl, mjg@redhat.com, rui.zhang@intel.com

From: Frans Pop <elendil@planet.nl>

Otherwise polling will continue for the thermal zone even when it is no
longer needed, for example because forced passive cooling was disabled.

Signed-off-by: Frans Pop <elendil@planet.nl>
Acked-by: Matthew Garrett <mjg@redhat.com>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/thermal/thermal_sys.c |    2 ++
 1 file changed, 2 insertions(+)

diff -puN drivers/thermal/thermal_sys.c~thermal-disable-polling-if-passive_delay-and-polling_delay-are-both-unset drivers/thermal/thermal_sys.c
--- a/drivers/thermal/thermal_sys.c~thermal-disable-polling-if-passive_delay-and-polling_delay-are-both-unset
+++ a/drivers/thermal/thermal_sys.c
@@ -1019,6 +1019,8 @@ void thermal_zone_device_update(struct t
 		thermal_zone_device_set_polling(tz, tz->passive_delay);
 	else if (tz->polling_delay)
 		thermal_zone_device_set_polling(tz, tz->polling_delay);
+	else
+		thermal_zone_device_set_polling(tz, 0);
 	mutex_unlock(&tz->lock);
 }
 EXPORT_SYMBOL(thermal_zone_device_update);
_
