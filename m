From: Len Brown <lenb@kernel.org>
Subject: [PATCH 023/112] pnp: Failed to activate device 00:0a - Samsung P35 XVM 1600 III
Date: Thu,  7 Feb 2008 04:33:45 -0500
Message-ID: <856608ee5e1ea37b8976ce01ddbd19a45da88921.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:20777 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752977AbYBGJfu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:50 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Shaohua Li <shaohua.li@intel.com>

PNP_WRITE requires protocol supports .set. If ACPI doesn't support _SRS, .set ismeanless, so PNP_WRITE.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pnp/pnpacpi/core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index dada899..662b4c2 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -183,7 +183,7 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	if (ACPI_SUCCESS(status))
 		dev->capabilities |= PNP_CONFIGURABLE;
 	dev->capabilities |= PNP_READ;
-	if (device->flags.dynamic_status)
+	if (device->flags.dynamic_status && (dev->capabilities & PNP_CONFIGURABLE))
 		dev->capabilities |= PNP_WRITE;
 	if (device->flags.removable)
 		dev->capabilities |= PNP_REMOVABLE;
-- 
1.5.4.23.gef5b9

