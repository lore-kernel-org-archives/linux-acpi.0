From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI: add kernel tainting after overriding an ACPI control
 method
Date: Mon, 14 Dec 2009 11:24:18 +0800
Message-ID: <1260761058.27069.329.camel@rzhang1-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:26230 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932181AbZLNDWT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Dec 2009 22:22:19 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Thomas Renninger <trenn@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>

Add kernel tainting after overriding an ACPI control method successfully.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/debug.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6/drivers/acpi/debug.c
===================================================================
--- linux-2.6.orig/drivers/acpi/debug.c
+++ linux-2.6/drivers/acpi/debug.c
@@ -239,6 +239,7 @@ static ssize_t cm_write(struct file *fil
 		kfree(buf);
 		if (ACPI_FAILURE(status))
 			return -EINVAL;
+		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE);
 	}
 
 	return count;


