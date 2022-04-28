Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DA1C433F5
	for <linux-acpi@archiver.kernel.org>; Thu, 28 Apr 2022 10:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiD1KHH (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 28 Apr 2022 06:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiD1KG3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Apr 2022 06:06:29 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCC13EBA9;
        Thu, 28 Apr 2022 02:54:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1651139671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/LQAEssi1M6FayAPx2YBnSoMR8g+uDhzHtXD+e37qLM=;
        b=DvQ1d7ov8yXbCPR3FwSILkkwfgJNoqUIVah0qn73oswhSx+cH/Wl9nHr6zkFAccVVSTrOh
        yTomwTRctfChmMBBJFCZTm8AUO1nmQrNr8/rlLgs/g4El2CYLe4LEjDko+2QOGmS50CQLB
        qNDT9YlXdyEgVE1xhI9WMeGVmFgXyfI=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] ACPI: processor: idle: expose max_cstate/nocst/bm_check_disable read-only in sysfs
Date:   Thu, 28 Apr 2022 17:54:13 +0800
Message-Id: <20220428095413.2950758-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch exposes max_cstate/nocst/bm_check_disable in read-only sysfs.
This will allow super users to verify them when changed in grub.

The parameters "nocst/bm_check_disable" is only used to be enable/disable.
So change them from integer to bool.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 drivers/acpi/processor_idle.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index e9c84d0ac55b..6a5572a1a80c 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -38,11 +38,11 @@
 #define ACPI_IDLE_STATE_START	(IS_ENABLED(CONFIG_ARCH_HAS_CPU_RELAX) ? 1 : 0)
 
 static unsigned int max_cstate __read_mostly = ACPI_PROCESSOR_MAX_POWER;
-module_param(max_cstate, uint, 0000);
-static unsigned int nocst __read_mostly;
-module_param(nocst, uint, 0000);
-static int bm_check_disable __read_mostly;
-module_param(bm_check_disable, uint, 0000);
+module_param(max_cstate, uint, 0400);
+static bool nocst __read_mostly;
+module_param(nocst, bool, 0400);
+static bool bm_check_disable __read_mostly;
+module_param(bm_check_disable, bool, 0400);
 
 static unsigned int latency_factor __read_mostly = 2;
 module_param(latency_factor, uint, 0644);
-- 
2.25.1

