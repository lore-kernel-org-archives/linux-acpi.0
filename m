Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AACCC25B0E
	for <linux-acpi@archiver.kernel.org>; Mon, 15 Aug 2022 17:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiHOR0g (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 15 Aug 2022 13:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbiHOR0d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Aug 2022 13:26:33 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9C9E0C2;
        Mon, 15 Aug 2022 10:26:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660584390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sekAuh1Qbz9vWUXIQUHw1NblNosJkPNnwajzRulPBUI=;
        b=n+eSgJhF/JSBHnme8JjWXUs3JO5d8g6G1HTAbljJlXZRfODymnTtTa93/8xrr2onQZ1FRz
        lJV5agr4qq6nLqrrs2XrQqtBLaGZcF00BWQoL8643pUvx8RXO3WjDUA/m0mpaSjZqdVWwK
        yGkL5djzNo4Va91ccs1XXeyJ7VOKLuE=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-acpi@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 09/11] ACPI/APEI: Add missing include
Date:   Mon, 15 Aug 2022 13:26:11 -0400
Message-Id: <20220815172613.621627-10-kent.overstreet@linux.dev>
In-Reply-To: <20220815172613.621627-1-kent.overstreet@linux.dev>
References: <20220815172613.621627-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

The upcoming patch to switch tracing from seq_buf to printbuf means
we're no longer pulling in headers that we used to; this adds a missing
include so things don't break.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-acpi@vger.kernel.org
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/apei/erst-dbg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
index 8bc71cdc22..370993c9c3 100644
--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -11,6 +11,7 @@
  *   Author: Huang Ying <ying.huang@intel.com>
  */
 
+#include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
-- 
2.36.1

