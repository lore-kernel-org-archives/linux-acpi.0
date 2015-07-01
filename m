From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v1 01/10] of/platform: Set fwnode field for new devices
Date: Wed,  1 Jul 2015 08:47:54 +0200
Message-ID: <1435733283-19244-2-git-send-email-tomeu.vizoso@collabora.com>
References: <1435733283-19244-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38630 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443AbbGAGsZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2015 02:48:25 -0400
Received: by wibdq8 with SMTP id dq8so35728513wib.1
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2015 23:48:23 -0700 (PDT)
Received: from cizrna.lan ([109.72.12.160])
        by mx.google.com with ESMTPSA id r9sm1319220wjo.26.2015.06.30.23.48.22
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2015 23:48:22 -0700 (PDT)
In-Reply-To: <1435733283-19244-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

When allocating a new platform device, set the fwnode field in the
struct device to point to the device_node.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/of/platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index ddf8e42..e880f55 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -139,6 +139,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	}
 
 	dev->dev.of_node = of_node_get(np);
+	dev->dev.fwnode = &dev->dev.of_node->fwnode;
 	dev->dev.parent = parent ? : &platform_bus;
 
 	if (bus_id)
-- 
2.4.1

