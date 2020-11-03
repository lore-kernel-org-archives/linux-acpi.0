Return-Path: <SRS0=EmyW=EJ=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800B3C2D0A3
	for <linux-acpi@archiver.kernel.org>; Tue,  3 Nov 2020 21:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332E322403
	for <linux-acpi@archiver.kernel.org>; Tue,  3 Nov 2020 21:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731005AbgKCVyq (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 3 Nov 2020 16:54:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:6323 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730994AbgKCUpQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Nov 2020 15:45:16 -0500
IronPort-SDR: Oi0hulbqJM8kFg3V76l95F15fpelqRohnqkG/Mk7Hw9AaXNn/X/U2Riy2GAI3baDgn6ROXp6jA
 x8OJ7Eeu2rZw==
X-IronPort-AV: E=McAfee;i="6000,8403,9794"; a="148975488"
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="148975488"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2020 12:45:16 -0800
IronPort-SDR: nSP6y8iwDiBjswdf5nW9ov4u+ApzdjzU28onuSUo/NkfKgKvtLDHjMRvgrWpfAfvzVGLJ4HuD7
 yz3NEWxJseGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,448,1596524400"; 
   d="scan'208";a="320567006"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 03 Nov 2020 12:45:14 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 177EA94B; Tue,  3 Nov 2020 22:45:11 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6 7/7] ACPI: watchdog: Replace open coded variant of resource_union()
Date:   Tue,  3 Nov 2020 22:45:10 +0200
Message-Id: <20201103204510.19154-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201103204510.19154-1-andriy.shevchenko@linux.intel.com>
References: <20201103204510.19154-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Since we have resource_union() helper, let's utilize it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Tested-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_watchdog.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
index 5c1e9ea43123..ca28183f4d13 100644
--- a/drivers/acpi/acpi_watchdog.c
+++ b/drivers/acpi/acpi_watchdog.c
@@ -151,11 +151,7 @@ void __init acpi_watchdog_init(void)
 		found = false;
 		resource_list_for_each_entry(rentry, &resource_list) {
 			if (rentry->res->flags == res.flags &&
-			    resource_overlaps(rentry->res, &res)) {
-				if (res.start < rentry->res->start)
-					rentry->res->start = res.start;
-				if (res.end > rentry->res->end)
-					rentry->res->end = res.end;
+			    resource_union(rentry->res, &res, rentry->res)) {
 				found = true;
 				break;
 			}
-- 
2.28.0

