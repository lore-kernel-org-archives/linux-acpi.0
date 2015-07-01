From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v1 02/10] i2c: core: Have clients point to their firmware nodes
Date: Wed,  1 Jul 2015 08:47:55 +0200
Message-ID: <1435733283-19244-3-git-send-email-tomeu.vizoso@collabora.com>
References: <1435733283-19244-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:32787 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859AbbGAGs0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2015 02:48:26 -0400
Received: by wiwl6 with SMTP id l6so154354185wiw.0
        for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2015 23:48:24 -0700 (PDT)
Received: from cizrna.lan ([109.72.12.160])
        by mx.google.com with ESMTPSA id r9sm1319220wjo.26.2015.06.30.23.48.23
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jun 2015 23:48:23 -0700 (PDT)
In-Reply-To: <1435733283-19244-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

This is needed by platform-independent code that needs to do something
with devices based on the data provided by the firmware.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

 drivers/i2c/i2c-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index 069a41f..707850a 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -1295,6 +1295,7 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 	}
 
 	info.of_node = of_node_get(node);
+	info.fwnode = info.of_node ? &info.of_node->fwnode : NULL;
 	info.archdata = &dev_ad;
 
 	if (of_get_property(node, "wakeup-source", NULL))
-- 
2.4.1

