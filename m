From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch] ACPI: SBS: remove useless acpi_cm_sbs_init() initcall
Date: Wed, 29 Oct 2008 15:21:49 -0600
Message-ID: <200810291521.49923.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:22654 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668AbYJ2VVw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Oct 2008 17:21:52 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Alexey Starikovskiy <astarikovskiy@suse.de>

acpi_cm_sbs_init() doesn't do anything, so we can just remove it.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/cm_sbs.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/cm_sbs.c b/drivers/acpi/cm_sbs.c
index 4441e84..80d5c88 100644
--- a/drivers/acpi/cm_sbs.c
+++ b/drivers/acpi/cm_sbs.c
@@ -105,9 +105,3 @@ void acpi_unlock_battery_dir(struct proc_dir_entry *acpi_battery_dir_param)
 	return;
 }
 EXPORT_SYMBOL(acpi_unlock_battery_dir);
-
-static int __init acpi_cm_sbs_init(void)
-{
-	return 0;
-}
-subsys_initcall(acpi_cm_sbs_init);
