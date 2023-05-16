Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377CBC77B7F
	for <linux-acpi@archiver.kernel.org>; Tue, 16 May 2023 11:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbjEPLuL (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 16 May 2023 07:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjEPLt4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:49:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B1C6EA5
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237780; x=1715773780;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X4jzIxNcptBRjTuITcQhS+P6UWBqr7/Y+dzVNs5Qp3I=;
  b=e1FvoJOC7slhhawFxvgoJUBOGsSHt0VPfUVZo84WI6ouw4OrVZb2BA/l
   l7RdvuRRg4JbrayvbOdI8dw3sMo5Q+FMS/Zoyn2hGeLO7ol5uNy5CFPsI
   h+2RjS1pEcfsh1bLFM0S4MtLSoGsC8VZN0gXY5lNwbZVeJy/qXWt2qaj4
   EIoxIi5JbpDsXLD1vjADSoNNZ/45lFHaTKClE5fqRkCkSGJ2XAJq4IIwM
   YxlmIHcVb4bwQPJDVDahUpT6WMU+NX77NQzf8popk6SGUIWlplluI3XFh
   tl+UdUxLPwk8zgr0jXb0TlulrVoZstDLFV0Yd0EJzYt6VUefn9u70OlAv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111735"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111735"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731961989"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731961989"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:10 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 29/34] platform/x86/wireless-hotkey: Move handler installing logic to driver
Date:   Tue, 16 May 2023 13:46:12 +0200
Message-Id: <20230516114617.148963-30-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230516114617.148963-1-michal.wilczynski@intel.com>
References: <20230516114617.148963-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently logic for installing notifications from ACPI devices is
implemented using notify callback in struct acpi_driver. Preparations
are being made to replace acpi_driver with more generic struct
platform_driver, which doesn't contain notify callback. Furthermore
as of now handlers are being called indirectly through
acpi_notify_device(), which decreases performance.

Call acpi_device_install_event_handler() at the end of .add() callback.
Call acpi_device_remove_event_handler() at the beginning of .remove()
callback. Change arguments passed to the notify callback to match with
what's required by acpi_device_install_event_handler().

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/platform/x86/wireless-hotkey.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/wireless-hotkey.c b/drivers/platform/x86/wireless-hotkey.c
index 4422863f47bb..51169509fea1 100644
--- a/drivers/platform/x86/wireless-hotkey.c
+++ b/drivers/platform/x86/wireless-hotkey.c
@@ -68,9 +68,12 @@ static void wireless_input_destroy(struct acpi_device *device)
 	kfree(button);
 }
 
-static void wl_notify(struct acpi_device *acpi_dev, u32 event)
+static void wl_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct wl_button *button = acpi_driver_data(acpi_dev);
+	struct acpi_device *acpi_dev = data;
+	struct wl_button *button;
+
+	button = acpi_driver_data(acpi_dev);
 
 	if (event != 0x80) {
 		pr_info("Received unknown event (0x%x)\n", event);
@@ -95,16 +98,24 @@ static int wl_add(struct acpi_device *device)
 	device->driver_data = button;
 
 	err = wireless_input_setup(device);
-	if (err) {
-		pr_err("Failed to setup wireless hotkeys\n");
-		kfree(button);
-	}
+	if (err)
+		goto fail;
 
+	err = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, wl_notify);
+	if (err)
+		goto fail;
+
+	return err;
+
+fail:
+	pr_err("Failed to setup wireless hotkeys\n");
+	kfree(button);
 	return err;
 }
 
 static void wl_remove(struct acpi_device *device)
 {
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, wl_notify);
 	wireless_input_destroy(device);
 }
 
-- 
2.40.1

