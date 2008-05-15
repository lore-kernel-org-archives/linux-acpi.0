From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: [PATCH 4/5] pci-acpi: remove unused variable in __pci_osc_support_set
Date: Thu, 15 May 2008 15:22:35 +0900
Message-ID: <482BD6AB.6080104@jp.fujitsu.com>
References: <482BD572.30504@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:45597 "EHLO
	fgwmail5.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbYEOGZX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 May 2008 02:25:23 -0400
In-Reply-To: <482BD572.30504@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, "Li, Shaohua" <shaohua.li@intel.com>

The 'retval' variable in __pci_osc_support_set() is no longer
used. Remove this unused variable.

Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>

---
 drivers/pci/pci-acpi.c |   15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

Index: linux-2.6.26-rc2-git3/drivers/pci/pci-acpi.c
===================================================================
--- linux-2.6.26-rc2-git3.orig/drivers/pci/pci-acpi.c
+++ linux-2.6.26-rc2-git3/drivers/pci/pci-acpi.c
@@ -120,7 +120,6 @@ static acpi_status acpi_query_osc(acpi_h
 				  u32 level, void *context, void **retval)
 {
 	acpi_status status;
-	acpi_status *ret_status = (acpi_status *)retval;
 	struct acpi_osc_data *osc_data;
 	u32 flags = (unsigned long)context, support_set;
 	acpi_handle tmp;
@@ -143,8 +142,6 @@ static acpi_status acpi_query_osc(acpi_h
 	osc_args.capbuf[OSC_CONTROL_TYPE] = OSC_CONTROL_MASKS;
 
 	status = acpi_run_osc(handle, &osc_args);
-	*ret_status = status;
-
 	if (ACPI_SUCCESS(status)) {
 		osc_data->support_set = support_set;
 		osc_data->query_result = osc_args.query_result;
@@ -164,15 +161,11 @@ static acpi_status acpi_query_osc(acpi_h
  **/
 acpi_status __pci_osc_support_set(u32 flags, const char *hid)
 {
-	acpi_status retval = AE_NOT_FOUND;
-
-	if (!(flags & OSC_SUPPORT_MASKS)) {
+	if (!(flags & OSC_SUPPORT_MASKS))
 		return AE_TYPE;
-	}
-	acpi_get_devices(hid,
-			acpi_query_osc,
-			(void *)(unsigned long)flags,
-			(void **) &retval );
+
+	acpi_get_devices(hid, acpi_query_osc,
+			 (void *)(unsigned long)flags, NULL);
 	return AE_OK;
 }
 


