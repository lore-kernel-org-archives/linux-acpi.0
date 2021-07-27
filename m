Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C356EC432BE
	for <linux-acpi@archiver.kernel.org>; Tue, 27 Jul 2021 16:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A110E61B97
	for <linux-acpi@archiver.kernel.org>; Tue, 27 Jul 2021 16:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhG0QSi (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 27 Jul 2021 12:18:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:29725 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229441AbhG0QSh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Jul 2021 12:18:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="192073824"
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="192073824"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 09:18:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,274,1620716400"; 
   d="scan'208";a="437372138"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jul 2021 09:18:24 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        srinivas.pandruvada@linux.intel.com
Subject: [PATCH] ACPI: DPTF: Fix reading of attributes
Date:   Tue, 27 Jul 2021 09:18:24 -0700
Message-Id: <20210727161824.425564-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The current assumption that methods to read PCH FIVR attributes will
return integer, is not correct. There is no good way to return integer
as negative numbers are also valid.

These read methods return a package of integers. The first integer returns
status, which is 0 on success and any other value for failure. When the
returned status is zero, then the second integer returns the actual value.

This change fixes this issue by replacing acpi_evaluate_integer() with
acpi_evaluate_object() and use acpi_extract_package() to extract results.

Fixes: 2ce6324eadb01 ("ACPI: DPTF: Add PCH FIVR participant driver")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: stable@vger.kernel.org # 5.10+
---
 drivers/acpi/dptf/dptf_pch_fivr.c | 51 ++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c b/drivers/acpi/dptf/dptf_pch_fivr.c
index 5fca18296bf6..550b9081fcbc 100644
--- a/drivers/acpi/dptf/dptf_pch_fivr.c
+++ b/drivers/acpi/dptf/dptf_pch_fivr.c
@@ -9,6 +9,42 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 
+struct pch_fivr_resp {
+	u64 status;
+	u64 result;
+};
+
+static int pch_fivr_read(acpi_handle handle, char *method, struct pch_fivr_resp *fivr_resp)
+{
+	struct acpi_buffer resp = { sizeof(struct pch_fivr_resp), fivr_resp};
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_buffer format = { sizeof("NN"), "NN" };
+	union acpi_object *obj;
+	acpi_status status;
+	int ret = -EFAULT;
+
+	status = acpi_evaluate_object(handle, method, NULL, &buffer);
+	if (ACPI_FAILURE(status))
+		return ret;
+
+	obj = buffer.pointer;
+	if (!obj || obj->type != ACPI_TYPE_PACKAGE)
+		goto release_buffer;
+
+	status = acpi_extract_package(obj, &format, &resp);
+	if (ACPI_FAILURE(status))
+		goto release_buffer;
+
+	if (fivr_resp->status)
+		goto release_buffer;
+
+	ret = 0;
+
+release_buffer:
+	kfree(buffer.pointer);
+	return ret;
+}
+
 /*
  * Presentation of attributes which are defined for INT1045
  * They are:
@@ -23,15 +59,14 @@ static ssize_t name##_show(struct device *dev,\
 			   char *buf)\
 {\
 	struct acpi_device *acpi_dev = dev_get_drvdata(dev);\
-	unsigned long long val;\
-	acpi_status status;\
+	struct pch_fivr_resp fivr_resp;\
+	int status;\
 \
-	status = acpi_evaluate_integer(acpi_dev->handle, #method,\
-				       NULL, &val);\
-	if (ACPI_SUCCESS(status))\
-		return sprintf(buf, "%d\n", (int)val);\
-	else\
-		return -EINVAL;\
+	status = pch_fivr_read(acpi_dev->handle, #method, &fivr_resp);\
+	if (status)\
+		return status;\
+\
+	return sprintf(buf, "%llu\n", fivr_resp.result);\
 }
 
 #define PCH_FIVR_STORE(name, method) \
-- 
2.31.1

