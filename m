From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/2] ACPI processor: Remove unneeded variable passed by acpi_processor_hotadd_init V2
Date: Tue, 17 Jan 2012 22:40:07 +0100
Message-ID: <1326836408-23177-2-git-send-email-trenn@suse.de>
References: <1326836408-23177-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53860 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755210Ab2AQVkP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Jan 2012 16:40:15 -0500
In-Reply-To: <1326836408-23177-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, lenb@kernel.org
Cc: shaohua.li@intel.com, Thomas Renninger <trenn@suse.de>, Bjorn Helgaas <bhelgaas@google.com>, "Jiang, Yunhong" <yunhong.jiang@intel.com>

V2: Fix typo: pr->handle -> pr, here: acpi_processor_hotadd_init(pr)

This is a very small part taken from patches which afaik
are coming from Yunhong Jiang (for a Xen not a Linus repo?).

Cleanup only: no functional change.

Advantage (beside cleanup) is that other data of the pr (acpi_processor) struct
in the acpi_processor_hotadd_init() is needed later, for example a newly
introduced flag:
pr->flags.need_hotplug_init

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Len Brown <lenb@kernel.org>
CC: linux-acpi@vger.kernel.org
CC: Bjorn Helgaas <bhelgaas@google.com>
CC: Jiang, Yunhong <yunhong.jiang@intel.com>
---
 drivers/acpi/processor_driver.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 90719d1..cf48090 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -82,7 +82,7 @@ MODULE_LICENSE("GPL");
 static int acpi_processor_add(struct acpi_device *device);
 static int acpi_processor_remove(struct acpi_device *device, int type);
 static void acpi_processor_notify(struct acpi_device *device, u32 event);
-static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu);
+static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr);
 static int acpi_processor_handle_eject(struct acpi_processor *pr);
 
 
@@ -324,10 +324,8 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	 *  they are physically not present.
 	 */
 	if (pr->id == -1) {
-		if (ACPI_FAILURE
-		    (acpi_processor_hotadd_init(pr->handle, &pr->id))) {
+		if (ACPI_FAILURE(acpi_processor_hotadd_init(pr)))
 			return -ENODEV;
-		}
 	}
 	/*
 	 * On some boxes several processors use the same processor bus id.
@@ -721,18 +719,19 @@ processor_walk_namespace_cb(acpi_handle handle,
 	return (AE_OK);
 }
 
-static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu)
+static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr)
 {
+	acpi_handle handle = pr->handle;
 
 	if (!is_processor_present(handle)) {
 		return AE_ERROR;
 	}
 
-	if (acpi_map_lsapic(handle, p_cpu))
+	if (acpi_map_lsapic(handle, &pr->id))
 		return AE_ERROR;
 
-	if (arch_register_cpu(*p_cpu)) {
-		acpi_unmap_lsapic(*p_cpu);
+	if (arch_register_cpu(pr->id)) {
+		acpi_unmap_lsapic(pr->id);
 		return AE_ERROR;
 	}
 
@@ -749,7 +748,7 @@ static int acpi_processor_handle_eject(struct acpi_processor *pr)
 	return (0);
 }
 #else
-static acpi_status acpi_processor_hotadd_init(acpi_handle handle, int *p_cpu)
+static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr)
 {
 	return AE_ERROR;
 }
-- 
1.7.6.1

