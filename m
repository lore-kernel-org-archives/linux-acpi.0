Return-Path: <SRS0=OwHM=EC=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B22C2D0A3
	for <linux-acpi@archiver.kernel.org>; Tue, 27 Oct 2020 00:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA19D20791
	for <linux-acpi@archiver.kernel.org>; Tue, 27 Oct 2020 00:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603757630;
	bh=eONOVyCllnp+Quhgihumpyr20gBFaLPlhRxyAqoL7CM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eBJXr0tkFJQeJFOZexOMQpp+/ZiFHvW8byNL3KnckAZwCVmHGLGR9Dq8FO9wt7aoA
	 C4XcLtcrN1xrpASezi3bF3trFRNLdTPxFrWBdc+KSoeEpF6kOzoMWe4v8erEQDo0ao
	 THoPnkmidL2n2y/H0DM7BzYY0duFbjmEw8BrcZlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439283AbgJ0ALk (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 26 Oct 2020 20:11:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439275AbgJ0ALj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Oct 2020 20:11:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3897520754;
        Tue, 27 Oct 2020 00:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603757499;
        bh=eONOVyCllnp+Quhgihumpyr20gBFaLPlhRxyAqoL7CM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nRKLfiCwW+OiOwV9jsr6JJwhhUVnwneyDNW6UC/jGLvt7bDwTgAs/PmQ0x0OQmGic
         HH43KiBJ46Q0eppf1U8ovxbBWERInSRRZgU/5daOdnOQG1SfebDNE30ZJonpD4L8U3
         CkFHKyBPJWWa4I3O9YtZ4z/hw/E/S72+MGABZRq0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 12/25] ACPI: Add out of bounds and numa_off protections to pxm_to_node()
Date:   Mon, 26 Oct 2020 20:11:10 -0400
Message-Id: <20201027001123.1027642-12-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027001123.1027642-1-sashal@kernel.org>
References: <20201027001123.1027642-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit 8a3decac087aa897df5af04358c2089e52e70ac4 ]

The function should check the validity of the pxm value before using
it to index the pxm_to_node_map[] array.

Whilst hardening this code may be good in general, the main intent
here is to enable following patches that use this function to replace
acpi_map_pxm_to_node() for non SRAT usecases which should return
NO_NUMA_NODE for PXM entries not matching with those in SRAT.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
index 2946e2846573b..15a506c2d20a0 100644
--- a/drivers/acpi/numa.c
+++ b/drivers/acpi/numa.c
@@ -46,7 +46,7 @@ unsigned char acpi_srat_revision __initdata;
 
 int pxm_to_node(int pxm)
 {
-	if (pxm < 0)
+	if (pxm < 0 || pxm >= MAX_PXM_DOMAINS || numa_off)
 		return NUMA_NO_NODE;
 	return pxm_to_node_map[pxm];
 }
-- 
2.25.1

