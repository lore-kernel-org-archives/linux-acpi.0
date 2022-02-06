Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A475C43217
	for <linux-acpi@archiver.kernel.org>; Sun,  6 Feb 2022 09:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiBFJ0Q (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sun, 6 Feb 2022 04:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbiBFJ0P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Feb 2022 04:26:15 -0500
Received: from hillosipuli.retiisi.eu (hillosipuli.retiisi.eu [IPv6:2a01:4f9:c010:4572::81:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E774C0612A4;
        Sun,  6 Feb 2022 01:26:14 -0800 (PST)
Received: from lanttu.localdomain (unknown [IPv6:fd35:1bc8:1a6:d3d5::e1:3])
        by hillosipuli.retiisi.eu (Postfix) with ESMTP id 9413C634C93;
        Sun,  6 Feb 2022 11:18:24 +0200 (EET)
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 2/4] ACPI: property: Move acpi_fwnode_device_get_match_data() up
Date:   Sun,  6 Feb 2022 11:16:41 +0200
Message-Id: <20220206091643.276833-3-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220206091643.276833-1-sakari.ailus@linux.intel.com>
References: <20220206091643.276833-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Move acpi_fwnode_device_get_match_data() up below
acpi_fwnode_device_is_available() so the order matches that in struct
fwnode_operations.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/acpi/property.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 1541b318ba46..75dc22c117a5 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1253,6 +1253,13 @@ static bool acpi_fwnode_device_is_available(const struct fwnode_handle *fwnode)
 	return acpi_device_is_present(to_acpi_device_node(fwnode));
 }
 
+static const void *
+acpi_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
+				  const struct device *dev)
+{
+	return acpi_device_get_match_data(dev);
+}
+
 static bool acpi_fwnode_device_dma_supported(const struct fwnode_handle *fwnode)
 {
 	return acpi_dma_supported(to_acpi_device_node(fwnode));
@@ -1384,13 +1391,6 @@ static int acpi_fwnode_graph_parse_endpoint(const struct fwnode_handle *fwnode,
 	return 0;
 }
 
-static const void *
-acpi_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
-				  const struct device *dev)
-{
-	return acpi_device_get_match_data(dev);
-}
-
 #define DECLARE_ACPI_FWNODE_OPS(ops) \
 	const struct fwnode_operations ops = {				\
 		.device_is_available = acpi_fwnode_device_is_available, \
-- 
2.30.2

