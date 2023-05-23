Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF43C77B7A
	for <linux-acpi@archiver.kernel.org>; Tue, 23 May 2023 04:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbjEWErY (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 23 May 2023 00:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjEWEqv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 May 2023 00:46:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAF02188;
        Mon, 22 May 2023 21:46:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 784B4139F;
        Mon, 22 May 2023 21:47:29 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.42.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 80E6F3F6C4;
        Mon, 22 May 2023 21:46:38 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        Steve Clevenger <scclevenger@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH V4 5/6] coresight: platform: acpi: Ignore the absence of graph
Date:   Tue, 23 May 2023 10:15:52 +0530
Message-Id: <20230523044553.1525048-6-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230523044553.1525048-1-anshuman.khandual@arm.com>
References: <20230523044553.1525048-1-anshuman.khandual@arm.com>
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
index 475899714104..c4b4fbde8550 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -692,8 +692,12 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
 
 	pdata->nr_inport = pdata->nr_outport = 0;
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

