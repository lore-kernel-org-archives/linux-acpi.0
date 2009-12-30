From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 1/2] ACPI: SBS: Move SBS HC callback to faster Notify queue
Date: Wed, 30 Dec 2009 15:53:03 +0300
Message-ID: <20091230125303.11962.12105.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nat.nue.novell.com ([195.135.221.3]:35580 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752719AbZL3MxG (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 07:53:06 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

SBS transactions should happen in Notify work queue, to not create
a dead lock with GPE execution accessing SBS devices.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/ec.c    |    3 ++-
 drivers/acpi/sbshc.c |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)


diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 9cc3885..32517d4 100644
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

