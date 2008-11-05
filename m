From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 03/11] ACPI: SBS: remove useless acpi_cm_sbs_init() initcall
Date: Wed, 05 Nov 2008 16:17:47 -0700
Message-ID: <20081105231747.26131.11491.stgit@bob.kio>
References: <20081105231710.26131.3110.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:39105 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbYKEXRs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Nov 2008 18:17:48 -0500
In-Reply-To: <20081105231710.26131.3110.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

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

