From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] nfit: acpi_nfit_notify(): Do not leave device locked
Date: Fri, 11 Dec 2015 23:24:10 +0300
Message-ID: <1449865450-8145-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:48074 "EHLO mail.ispras.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755419AbbLKUYW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Dec 2015 15:24:22 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

Even if dev->driver is null because we are being removed,
it is safer to not leave device locked.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/acpi/nfit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
index e7ed39bab97d..aa45d4802707 100644
--- a/drivers/acpi/nfit.c
+++ b/drivers/acpi/nfit.c
@@ -1810,7 +1810,7 @@ static void acpi_nfit_notify(struct acpi_device *adev, u32 event)
 	if (!dev->driver) {
 		/* dev->driver may be null if we're being removed */
 		dev_dbg(dev, "%s: no driver found for dev\n", __func__);
-		return;
+		goto out_unlock;
 	}
 
 	if (!acpi_desc) {
-- 
1.9.1

