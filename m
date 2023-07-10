Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81E2C0015E
	for <linux-acpi@archiver.kernel.org>; Mon, 10 Jul 2023 06:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjGJG0Y (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 10 Jul 2023 02:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjGJGZ6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Jul 2023 02:25:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51C65E78;
        Sun,  9 Jul 2023 23:25:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10BD9D75;
        Sun,  9 Jul 2023 23:26:32 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E14BB3F67D;
        Sun,  9 Jul 2023 23:25:43 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        Steve Clevenger <scclevenger@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V6 5/6] coresight: platform: acpi: Ignore the absence of graph
Date:   Mon, 10 Jul 2023 11:54:59 +0530
Message-Id: <20230710062500.45147-6-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230710062500.45147-1-anshuman.khandual@arm.com>
References: <20230710062500.45147-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Some components may not have graph connections for describing
the trace path. e.g., ETE, where it could directly use the per
CPU TRBE. Ignore the absence of graph connections

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/hwtracing/coresight/coresight-platform.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 3e2e135cb8f6..c8940314cceb 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -669,8 +669,12 @@ static int acpi_coresight_parse_graph(struct device *dev,
 	struct coresight_connection *new_conn;
 
 	graph = acpi_get_coresight_graph(adev);
+	/*
+	 * There are no graph connections, which is fine for some components.
+	 * e.g., ETE
+	 */
 	if (!graph)
-		return -ENOENT;
+		return 0;
 
 	nlinks = graph->package.elements[2].integer.value;
 	if (!nlinks)
-- 
2.25.1

