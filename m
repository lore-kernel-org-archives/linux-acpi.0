From: "David E. Box" <david.e.box@linux.intel.com>
Subject: [PATCH 2/2] ACPI / platform: Add ACPI ID for Intel IOSF-SB
Date: Thu, 21 Nov 2013 22:05:57 -0800
Message-ID: <1385100357-5459-2-git-send-email-david.e.box@linux.intel.com>
References: <1385100357-5459-1-git-send-email-david.e.box@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13428 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750765Ab3KVGJR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 22 Nov 2013 01:09:17 -0500
In-Reply-To: <1385100357-5459-1-git-send-email-david.e.box@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, rjw@sisk.pl
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>

From: "David E. Box" <david.e.box@linux.intel.com>

Adds ACPI ID for Intel IOSF-SB MailBox device found in BayTrail platforms.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/acpi/acpi_platform.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 1bde127..12aa55c 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -29,7 +29,8 @@ ACPI_MODULE_NAME("platform");
 static const struct acpi_device_id acpi_platform_device_ids[] = {
 
 	{ "PNP0D40" },
-
+	/* Intel IOSF-SB Message Bus */
+	{ "INT33BD" },
 	{ }
 };
 
-- 
1.7.10.4

