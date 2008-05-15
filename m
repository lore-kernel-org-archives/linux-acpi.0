From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 3/5] pci-acpi: add flag to indicate query had been done
Date: Thu, 15 May 2008 15:21:16 +0900
Message-ID: <482BD65C.4070001@jp.fujitsu.com>
References: <482BD572.30504@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:45538 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbYEOGYO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 May 2008 02:24:14 -0400
In-Reply-To: <482BD572.30504@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>

Current pci-acpi implementation checks osc_data->support_stat to see
if control bits had been already queried. It is not good from the
viewpoint of easy understanding. So this patch adds new 'is_queried'
flag to indicate query had been done.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/pci/pci-acpi.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.26-rc2-git3/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.26-rc2-git3.orig/drivers/pci/pci-acpi.c
+++ linux-2.6.26-rc2-git3/drivers/pci/pci-acpi.c
@@ -23,6 +23,7 @@ struct acpi_osc_data {
 	acpi_handle handle;
 	u32 support_set;
 	u32 control_set;
+	int is_queried;
 	u32 query_result;
 	struct list_head sibiling;
 };
@@ -147,6 +148,7 @@ static acpi_status acpi_query_osc(acpi_h
 	if (ACPI_SUCCESS(status)) {
 		osc_data->support_set = support_set;
 		osc_data->query_result = osc_args.query_result;
+		osc_data->is_queried = 1;
 	}
 
 	return status;
@@ -203,7 +205,7 @@ acpi_status pci_osc_control_set(acpi_han
 	if (!ctrlset)
 		return AE_TYPE;
 
-	if (osc_data->support_set &&
+	if (osc_data->is_queried &&
 	    ((osc_data->query_result & ctrlset) != ctrlset))
 		return AE_SUPPORT;
 


