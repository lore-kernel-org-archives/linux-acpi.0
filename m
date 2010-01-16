From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/16] ACPI: SBS: Move SBS HC callback to faster Notify queue
Date: Sat, 16 Jan 2010 02:32:56 -0500
Message-ID: <f5347867c5aea94c625246eaff8f7820b0a4cd8a.1263627123.git.len.brown@intel.com>
References: <1263627186-21384-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:33846 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634Ab0APHdP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Jan 2010 02:33:15 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KWB006SOWZB9GX7@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 Jan 2010 01:33:13 -0600 (CST)
In-reply-to: <1263627186-21384-1-git-send-email-lenb@kernel.org>
In-reply-to: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
References: <a62e8f1978f49e52f87a711ff6711b323d4b12ff.1263627123.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

SBS transactions should happen in Notify work queue, to not create
a dead lock with GPE execution accessing SBS devices.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/ec.c    |    3 ++-
 drivers/acpi/sbshc.c |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 9cc3885..0473309 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -535,7 +535,8 @@ static int acpi_ec_sync_query(struct acpi_ec *ec)
 				return -ENOMEM;
 			memcpy(copy, handler, sizeof(*copy));
 			pr_debug(PREFIX "push query execution (0x%2x) on queue\n", value);
-			return acpi_os_execute(OSL_GPE_HANDLER,
+			return acpi_os_execute((copy->func) ?
+				OSL_NOTIFY_HANDLER : OSL_GPE_HANDLER,
 				acpi_ec_run, copy);
 		}
 	}
diff --git a/drivers/acpi/sbshc.c b/drivers/acpi/sbshc.c
index d933980..fd09229 100644
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -242,7 +242,7 @@ static int smbus_alarm(void *context)
 		case ACPI_SBS_CHARGER:
 		case ACPI_SBS_MANAGER:
 		case ACPI_SBS_BATTERY:
-			acpi_os_execute(OSL_GPE_HANDLER,
+			acpi_os_execute(OSL_NOTIFY_HANDLER,
 					acpi_smbus_callback, hc);
 		default:;
 	}
-- 
1.6.0.6

