From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 02/19] ACPI: remove null pointer checks in deferred execution
	path
Date: Fri, 31 Jul 2009 15:36:43 -0600
Message-ID: <20090731213643.29930.99159.stgit@bob.kio>
References: <20090731213501.29930.39957.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:45022 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbZGaVgp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2009 17:36:45 -0400
In-Reply-To: <20090731213501.29930.39957.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Better to oops and learn about a bug than to silently cover it up.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/osl.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 10df23d..fe73e28 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -698,18 +698,12 @@ void acpi_os_derive_pci_id(acpi_handle rhandle,	/* upper bound  */
 static void acpi_os_execute_deferred(struct work_struct *work)
 {
 	struct acpi_os_dpc *dpc = container_of(work, struct acpi_os_dpc, work);
-	if (!dpc) {
-		printk(KERN_ERR PREFIX "Invalid (NULL) context\n");
-		return;
-	}
 
 	if (dpc->wait)
 		acpi_os_wait_events_complete(NULL);
 
 	dpc->function(dpc->context);
 	kfree(dpc);
-
-	return;
 }
 
 /*******************************************************************************
@@ -738,9 +732,6 @@ static acpi_status __acpi_os_execute(acpi_execute_type type,
 			  "Scheduling function [%p(%p)] for deferred execution.\n",
 			  function, context));
 
-	if (!function)
-		return AE_BAD_PARAMETER;
-
 	/*
 	 * Allocate/initialize DPC structure.  Note that this memory will be
 	 * freed by the callee.  The kernel handles the work_struct list  in a

