From: =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
Subject: [PATCH] ACPI / LPSS: Don't abort acpi scan on missing mem resource.
Date: Fri,  4 Aug 2017 16:46:16 -0700
Message-ID: <1501890376-2662-1-git-send-email-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from chill.innovation.ch ([216.218.245.220]:51468 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754078AbdHDXzu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Aug 2017 19:55:50 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Federico Lorenzi <florenzi@gmail.com>, linux-acpi@vger.kernel.org, =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>

On MacBook8's (2015) there appears to be no memory resource for the
SPI master device. Returning an error here in this case then leads to
the acpi device being ignored completely instead of just the handler
being skipped.

This isn't an issue on later MacBook(Pro)'s because their ACPI SPI
devices don't have any CID and therefore no attempt is made to install
this handler.

Returning an error was introduced in commit d3e13ff3c1aa - this restores
the original behaviour.

Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
---
 drivers/acpi/acpi_lpss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index e51a1e98e62f..558fbdec5b38 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -452,7 +452,8 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 	acpi_dev_free_resource_list(&resource_list);
 
 	if (!pdata->mmio_base) {
-		ret = -ENOMEM;
+		/* Skip the device, but continue the namespace scan. */
+		ret = 0;
 		goto err_out;
 	}
 
-- 
2.13.3

