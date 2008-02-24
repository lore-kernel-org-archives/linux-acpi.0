From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 4/4] ACPI: WMI: Clean up handling of spec violating data blocks
Date: Sun, 24 Feb 2008 13:34:34 +0000
Message-ID: <20080224133434.2317.84600.stgit@pacifica>
References: <20080224133412.2317.5802.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:34347 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752831AbYBXNev (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 24 Feb 2008 08:34:51 -0500
In-Reply-To: <20080224133412.2317.5802.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org

Acer violate the ACPI-WMI spec by declaring some of their data blocks as
expensive, but with no corresponding WCxx method. There is already some
workaround code in to handle the initial WCxx call (we just ignore a
failure here); but we need to properly check if the second, "clean up",
WCxx call is actually needed or not, rather than fail simply because it
isn't there.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---

 drivers/acpi/wmi.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)


diff --git a/drivers/acpi/wmi.c b/drivers/acpi/wmi.c
index efacc9f..c33b1c6 100644
--- a/drivers/acpi/wmi.c
+++ b/drivers/acpi/wmi.c
@@ -293,7 +293,7 @@ struct acpi_buffer *out)
 {
 	struct guid_block *block = NULL;
 	struct wmi_block *wblock = NULL;
-	acpi_handle handle;
+	acpi_handle handle, wc_handle;
 	acpi_status status, wc_status = AE_ERROR;
 	struct acpi_object_list input, wc_input;
 	union acpi_object wc_params[1], wq_params[1];
@@ -338,8 +338,10 @@ struct acpi_buffer *out)
 		 * expensive, but have no corresponding WCxx method. So we
 		 * should not fail if this happens.
 		 */
-		wc_status = acpi_evaluate_object(handle, wc_method,
-			&wc_input, NULL);
+		wc_status = acpi_get_handle(handle, wc_method, &wc_handle);
+		if (ACPI_SUCCESS(wc_status))
+			wc_status = acpi_evaluate_object(handle, wc_method,
+				&wc_input, NULL);
 	}
 
 	strcpy(method, "WQ");
@@ -351,7 +353,7 @@ struct acpi_buffer *out)
 	 * If ACPI_WMI_EXPENSIVE, call the relevant WCxx method, even if
 	 * the WQxx method failed - we should disable collection anyway.
 	 */
-	if ((block->flags & ACPI_WMI_EXPENSIVE) && wc_status) {
+	if ((block->flags & ACPI_WMI_EXPENSIVE) && ACPI_SUCCESS(wc_status)) {
 		wc_params[0].integer.value = 0;
 		status = acpi_evaluate_object(handle,
 		wc_method, &wc_input, NULL);

