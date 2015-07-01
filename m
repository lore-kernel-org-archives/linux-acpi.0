From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v1 03/10] mfd: Have child devices point to their firmware nodes
Date: Wed,  1 Jul 2015 08:47:56 +0200
Message-ID: <1435733283-19244-4-git-send-email-tomeu.vizoso@collabora.com>
References: <1435733283-19244-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:37859 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399AbbGAGs1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2015 02:48:27 -0400
Received: by wicgi11 with SMTP id gi11so35790705wic.0
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2015 23:48:25 -0700 (PDT)
Received: from cizrna.lan ([109.72.12.160])
        by mx.google.com with ESMTPSA id r9sm1319220wjo.26.2015.06.30.23.48.24
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2015 23:48:24 -0700 (PDT)
In-Reply-To: <1435733283-19244-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is needed by platform-independent code that needs to do something
with devices based on the data provided by the firmware.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/mfd/mfd-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 14fd5cb..e2422ea 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -158,6 +158,7 @@ static int mfd_add_device(struct device *parent, int id,
 		for_each_child_of_node(parent->of_node, np) {
 			if (of_device_is_compatible(np, cell->of_compatible)) {
 				pdev->dev.of_node = np;
+				pdev->dev.fwnode = &pdev->dev.of_node->fwnode;
 				break;
 			}
 		}
-- 
2.4.1

