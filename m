From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 1/2] ACPICA: GPEs: Do not allow enable for GPEs that have no handler(s).
Date: Wed, 23 Jul 2014 13:11:59 +0800
Message-ID: <59c10d99d34a9d5f8e62715869763622c8e62fbc.1406092278.git.lv.zheng@intel.com>
References: <7323172.bFe2jdDKx7@vostro.rjw.lan>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40043 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932348AbaGWFMO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Jul 2014 01:12:14 -0400
In-Reply-To: <7323172.bFe2jdDKx7@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

ACPICA release patch.

------------------

commit 23b5a8542283af28c3a3a4e3f81096d6e2569faa upstream

There is no point in enabling a GPE that has no handler or
GPE method. At worst, it can cause GPE floods.
Rafael Wysocki.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evxfgpe.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index cb534fa..82e5c14 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -126,11 +126,19 @@ acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
 
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
-	/* Ensure that we have a valid GPE number */
-
+	/*
+	 * Ensure that we have a valid GPE number and that there is some way
+	 * of handling the GPE (handler or a GPE method). In other words, we
+	 * won't allow a valid GPE to be enabled if there is no way to handle it.
+	 */
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
 	if (gpe_event_info) {
-		status = acpi_ev_add_gpe_reference(gpe_event_info);
+		if ((gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK) !=
+		    ACPI_GPE_DISPATCH_NONE) {
+			status = acpi_ev_add_gpe_reference(gpe_event_info);
+		} else {
+			status = AE_NO_HANDLER;
+		}
 	}
 
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
-- 
1.7.10

