Return-Path: <SRS0=SQMK=W2=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA9CC3A59B
	for <linux-acpi@archiver.kernel.org>; Fri, 30 Aug 2019 15:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B87623438
	for <linux-acpi@archiver.kernel.org>; Fri, 30 Aug 2019 15:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfH3PJb (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:09:31 -0400
Received: from michel.telenet-ops.be ([195.130.137.88]:54182 "EHLO
        michel.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfH3PJ3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Aug 2019 11:09:29 -0400
Received: from ramsan ([84.194.98.4])
        by michel.telenet-ops.be with bizsmtp
        id vT9T2000605gfCL06T9TG2; Fri, 30 Aug 2019 17:09:27 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i3iWl-0003jQ-1L; Fri, 30 Aug 2019 17:09:27 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1i3iWk-0005d4-VO; Fri, 30 Aug 2019 17:09:26 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ACPI / property: Fix acpi_graph_get_remote_endpoint() name in kerneldoc
Date:   Fri, 30 Aug 2019 17:09:23 +0200
Message-Id: <20190830150923.21588-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The function is called acpi_graph_get_remote_endpoint(), not
acpi_graph_get_remote_enpoint().

Fixes: 79389a83bc3888a9 ("ACPI / property: Add support for remote endpoints")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/acpi/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index ea3d700da3ca6bdb..2cb35d30cb140750 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1210,7 +1210,7 @@ static struct fwnode_handle *acpi_graph_get_child_prop_value(
 
 
 /**
- * acpi_graph_get_remote_enpoint - Parses and returns remote end of an endpoint
+ * acpi_graph_get_remote_endpoint - Parses and returns remote end of an endpoint
  * @fwnode: Endpoint firmware node pointing to a remote device
  * @endpoint: Firmware node of remote endpoint is filled here if not %NULL
  *
-- 
2.17.1

