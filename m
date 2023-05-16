Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6B1C77B7F
	for <linux-acpi@archiver.kernel.org>; Tue, 16 May 2023 11:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjEPLsQ (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 16 May 2023 07:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjEPLsN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:48:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D63E53
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237654; x=1715773654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fkEaRIb+aCgkppCjudGHedC6J4w9GYBp7R496rzIUY4=;
  b=bh5keMYdg27wnmVxU9SAVv2wu7JASUKwMGYHGQ2/Bh0jJDFHNMPCov5f
   V3eeNzlIBxBlaEuTQEKrgCEHqaRtZmSsznkgwxUNEUHJmSQBJtVfs8boy
   pGUnil7pQeAKmuvvY4G8QBtzlshqtSChejaLMnLYE7UQWvJXrTkwPkobC
   xhEMwEd70SLSOr7R1DNKbsSvOKU1+qGo9+Fvins/vEVnYON4cEs8EXVeJ
   MK04/H3aLX+7PIPu0fqSattfxaOJNrM1/kpsCgc8Yti+ej6Uc+T1cM4xw
   1AXD7jX+TMLeObihGXo4nOP3K9hPttgYCuHQ8HiqUCwzPK3lqRSaQxyII
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111631"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111631"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731961804"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731961804"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:45 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 09/34] acpi/tiny-power-button: Move handler installing logic to driver
Date:   Tue, 16 May 2023 13:45:52 +0200
Message-Id: <20230516114617.148963-10-michal.wilczynski@intel.com>
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
 drivers/acpi/tiny-power-button.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/tiny-power-button.c b/drivers/acpi/tiny-power-button.c
index 598f548b21f3..9c8e8b8cc19f 100644
--- a/drivers/acpi/tiny-power-button.c
+++ b/drivers/acpi/tiny-power-button.c
@@ -19,18 +19,21 @@ static const struct acpi_device_id tiny_power_button_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, tiny_power_button_device_ids);
 
-static int acpi_noop_add(struct acpi_device *device)
+static void acpi_tiny_power_button_notify(acpi_handle handle, u32 event, void *data)
 {
-	return 0;
+	kill_cad_pid(power_signal, 1);
 }
 
-static void acpi_noop_remove(struct acpi_device *device)
+static int acpi_tiny_power_button_add(struct acpi_device *device)
 {
+	return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
+						 acpi_tiny_power_button_notify);
 }
 
-static void acpi_tiny_power_button_notify(struct acpi_device *device, u32 event)
+static void acpi_tiny_power_button_remove(struct acpi_device *device)
 {
-	kill_cad_pid(power_signal, 1);
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY,
+					 acpi_tiny_power_button_notify);
 }
 
 static struct acpi_driver acpi_tiny_power_button_driver = {
@@ -38,9 +41,8 @@ static struct acpi_driver acpi_tiny_power_button_driver = {
 	.class = "tiny-power-button",
 	.ids = tiny_power_button_device_ids,
 	.ops = {
-		.add = acpi_noop_add,
-		.remove = acpi_noop_remove,
-		.notify = acpi_tiny_power_button_notify,
+		.add = acpi_tiny_power_button_add,
+		.remove = acpi_tiny_power_button_remove,
 	},
 };
 
-- 
2.40.1

