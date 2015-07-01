From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v1 10/10] core: platform: use fwnode_driver_match_device()
Date: Wed,  1 Jul 2015 08:48:03 +0200
Message-ID: <1435733283-19244-11-git-send-email-tomeu.vizoso@collabora.com>
References: <1435733283-19244-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:36204 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753342AbbGAGsd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2015 02:48:33 -0400
Received: by wguu7 with SMTP id u7so27788892wgu.3
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2015 23:48:33 -0700 (PDT)
Received: from cizrna.lan ([109.72.12.160])
        by mx.google.com with ESMTPSA id r9sm1319220wjo.26.2015.06.30.23.48.31
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2015 23:48:32 -0700 (PDT)
In-Reply-To: <1435733283-19244-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Instead of calling both of_driver_match_device() and
acpi_driver_match_device(), call fwnode_driver_match_device() which
should be able to sort out what firmware describes the device in
question.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/base/platform.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 063f0ab..a7e7757 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -843,12 +843,8 @@ static int platform_match(struct device *dev, struct device_driver *drv)
 	if (pdev->driver_override)
 		return !strcmp(pdev->driver_override, drv->name);
 
-	/* Attempt an OF style match first */
-	if (of_driver_match_device(dev, drv))
-		return 1;
-
-	/* Then try ACPI style match */
-	if (acpi_driver_match_device(dev, drv))
+	/* Attempt a firmware match first */
+	if (fwnode_driver_match_device(dev, drv))
 		return 1;
 
 	/* Then try to match against the id table */
-- 
2.4.1

