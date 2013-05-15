From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH] acpi: Fix memory leak on acpi_scan_init_hotplug() error path
Date: Wed, 15 May 2013 17:49:35 +0100
Message-ID: <1368636575-5480-1-git-send-email-catalin.marinas@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:52406 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759180Ab3EOQ4R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 May 2013 12:56:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>, Larry Finger <Larry.Finger@lwfinger.net>

Following commit 6b772e8f9 (ACPI: Update PNPID match handling for
notify), the acpi_scan_init_hotplug() calls acpi_set_pnp_ids() which
allocates acpi_hardware_id and copies a few strings (kstrdup). If the
devices does not have hardware_id set, the function exits without
freeing the previously allocated ids (and kmemleak complains). This
patch calls simply changes 'return' on error to a 'goto out' which calls
acpi_free_pnp_ids().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Toshi Kani <toshi.kani@hp.com>
---
 drivers/acpi/scan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index fe158fd..c1bc608 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1785,7 +1785,7 @@ static void acpi_scan_init_hotplug(acpi_handle handle, int type)
 	acpi_set_pnp_ids(handle, &pnp, type);
 
 	if (!pnp.type.hardware_id)
-		return;
+		goto out;
 
 	/*
 	 * This relies on the fact that acpi_install_notify_handler() will not
@@ -1800,6 +1800,7 @@ static void acpi_scan_init_hotplug(acpi_handle handle, int type)
 		}
 	}
 
+out:
 	acpi_free_pnp_ids(&pnp);
 }
 
