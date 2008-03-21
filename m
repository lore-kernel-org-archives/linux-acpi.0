From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH  3/16][BUG] ACPI pci_slot: Fix _STA evaluation (Not for mainline!)
Date: Fri, 21 Mar 2008 13:11:25 +0900
Message-ID: <47E3356D.6010509@jp.fujitsu.com>
References: <20080318210539.GA30421@ldl.fc.hp.com> <47E33472.1000602@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:44900 "EHLO
	fgwmail7.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751879AbYCUEOJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Mar 2008 00:14:09 -0400
In-Reply-To: <47E33472.1000602@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>, Greg KH <gregkh@suse.de>
Cc: Gary Hade <garyhade@us.ibm.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Matthew Wilcox <matthew@wil.cx>, warthog19@eaglescrag.net, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

Fix the problem that pci slots that doesn't have _STA are not
detected. If the device doesn't have _STA, we must assume it is always
there.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
---
 drivers/acpi/pci_slot.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: linux-2.6.25-rc6/drivers/acpi/pci_slot.c
===================================================================
--- linux-2.6.25-rc6.orig/drivers/acpi/pci_slot.c
+++ linux-2.6.25-rc6/drivers/acpi/pci_slot.c
@@ -76,9 +76,8 @@ check_slot(acpi_handle handle, int *devi
 
 	if (check_sta_before_sun) {
 		/* If SxFy doesn't have _STA, we just assume it's there */
-		acpi_evaluate_integer(handle, "_STA", NULL, &sta);
-
-		if (!(sta & ACPI_STA_DEVICE_PRESENT)) {
+		status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
+		if (ACPI_SUCCESS(status) && !(sta & ACPI_STA_DEVICE_PRESENT)) {
 			retval = -1;
 			goto out;
 		}


