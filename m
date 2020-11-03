Return-Path: <SRS0=EmyW=EJ=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AB4C388F2
	for <linux-acpi@archiver.kernel.org>; Tue,  3 Nov 2020 01:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F147A2225E
	for <linux-acpi@archiver.kernel.org>; Tue,  3 Nov 2020 01:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604366525;
	bh=joCXeRGwe21RpZNQk673bdZlBSD3CKvOS7m04EABw/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Oj7RQ3yGIfm1bx+6Gq/JrfbhNOrjwggPrFjNwAw7ELiRy1syLd9GinyBowiqXZbis
	 rJ050U2L5lIULjXLQY8dTxDngKF0gl3GJ6KkCoWMpVHQeGNamFn9sZfMcgWsxHgqqa
	 60RGJia/SGHk3n/CEposzmPLuP2giWtBiDJyjhHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgKCBV7 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 2 Nov 2020 20:21:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727618AbgKCBVS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Nov 2020 20:21:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F65B222B9;
        Tue,  3 Nov 2020 01:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604366478;
        bh=joCXeRGwe21RpZNQk673bdZlBSD3CKvOS7m04EABw/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vwdE2jQHCQ1lxsvTTyPyydV950nwQX+uDwW2hjOHN/8VTZoshC2rsvERe3FWJTdU4
         1Q/rRmSM+O5c/kGAqHMltP8DANpJ1Zu6mhqM64KaJPHRIyWqqi4clMYFsNAEtykjtE
         wbrclkvKGDT0Iu+OSPel0INiJW/FzmARCJa/7zZg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Qilong <zhangqilong3@huawei.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 7/7] ACPI: NFIT: Fix comparison to '-ENXIO'
Date:   Mon,  2 Nov 2020 20:21:08 -0500
Message-Id: <20201103012108.183942-7-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201103012108.183942-1-sashal@kernel.org>
References: <20201103012108.183942-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Zhang Qilong <zhangqilong3@huawei.com>

[ Upstream commit 85f971b65a692b68181438e099b946cc06ed499b ]

Initial value of rc is '-ENXIO', and we should
use the initial value to check it.

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
[ rjw: Subject edit ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 31a07609f7a23..b7fd8e00b346b 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1219,7 +1219,7 @@ static ssize_t format1_show(struct device *dev,
 					le16_to_cpu(nfit_dcr->dcr->code));
 			break;
 		}
-		if (rc != ENXIO)
+		if (rc != -ENXIO)
 			break;
 	}
 	mutex_unlock(&acpi_desc->init_mutex);
-- 
2.27.0

