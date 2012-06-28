From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 12/12] xo15-ebook: convert to module_acpi_driver()
Date: Thu, 28 Jun 2012 13:59:31 +0300
Message-ID: <1340881171-14811-13-git-send-email-mika.westerberg@linux.intel.com>
References: <1340881171-14811-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44116 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754250Ab2F1K6C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Jun 2012 06:58:02 -0400
In-Reply-To: <1340881171-14811-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com, khali@linux-fr.org, ben-linux@fluff.org, w.sang@pengutronix.de, dmitry.torokhov@gmail.com, eric.piel@tremplin-utc.net, mjg@redhat.com, ike.pan@canonical.com, herton@canonical.com, Mika Westerberg <mika.westerberg@linux.intel.com>

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/platform/x86/xo15-ebook.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/xo15-ebook.c
index fad153d..11a0f30 100644
--- a/drivers/platform/x86/xo15-ebook.c
+++ b/drivers/platform/x86/xo15-ebook.c
@@ -166,16 +166,4 @@ static struct acpi_driver xo15_ebook_driver = {
 		.notify = ebook_switch_notify,
 	},
 };
-
-static int __init xo15_ebook_init(void)
-{
-	return acpi_bus_register_driver(&xo15_ebook_driver);
-}
-
-static void __exit xo15_ebook_exit(void)
-{
-	acpi_bus_unregister_driver(&xo15_ebook_driver);
-}
-
-module_init(xo15_ebook_init);
-module_exit(xo15_ebook_exit);
+module_acpi_driver(xo15_ebook_driver);
-- 
1.7.10

