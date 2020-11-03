Return-Path: <SRS0=EmyW=EJ=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D16C00A89
	for <linux-acpi@archiver.kernel.org>; Tue,  3 Nov 2020 01:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06EC022277
	for <linux-acpi@archiver.kernel.org>; Tue,  3 Nov 2020 01:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604366813;
	bh=Y4pk0+NtOTsiLWykNqOh9dUwM35ghrHdAdWuyBg1o/c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NrhXjcDEjnjZy3gJVv0dAlnCNzg+GLVcSqCy/UleeEjBSY7oFU8mSKRp9Cix6YdNx
	 kSwvHN5PQL23olb29TfSBpJ1ZQ6ehDP2tZ8G1t1w0FS2GtUwKr64fw3zv8Rp18uuII
	 ZHxCGDTMH7oBVFbf+gNfTc1xh1cT3kTV3lORv9H4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgKCBTX (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 2 Nov 2020 20:19:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:33088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727703AbgKCBTW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Nov 2020 20:19:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B1D4222B9;
        Tue,  3 Nov 2020 01:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604366362;
        bh=Y4pk0+NtOTsiLWykNqOh9dUwM35ghrHdAdWuyBg1o/c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pEcTlAaEG7NdrnvRteNZcgGm3xw6uRhTyCn4UqjT9jaNOnAZrkhf9H7G+2VlFnqOd
         e+pGIdFODpJhrrD8T1D17jHj2oA+Ab6/VASkitZsbVKgu5Ed2gTdZrRI0TjunHJ2x/
         dvggI7YFDRl4c/wPE85Ro40CnYN+DYdrcoJ//lUU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Qilong <zhangqilong3@huawei.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.9 31/35] ACPI: NFIT: Fix comparison to '-ENXIO'
Date:   Mon,  2 Nov 2020 20:18:36 -0500
Message-Id: <20201103011840.182814-31-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201103011840.182814-1-sashal@kernel.org>
References: <20201103011840.182814-1-sashal@kernel.org>
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
index 26dd208a0d636..103ae7401f957 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1564,7 +1564,7 @@ static ssize_t format1_show(struct device *dev,
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

