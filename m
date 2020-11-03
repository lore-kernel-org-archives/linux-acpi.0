Return-Path: <SRS0=EmyW=EJ=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C615C00A89
	for <linux-acpi@archiver.kernel.org>; Tue,  3 Nov 2020 01:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C988E2225E
	for <linux-acpi@archiver.kernel.org>; Tue,  3 Nov 2020 01:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604366568;
	bh=OCysreUBOh/I7tKWLx+Ybyv5pIlteOzq4petGN+IfsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K1JSDcr9F4nVBS6t8phMNDPyrbnNHGOSpy9pyOcI+IB3+zD6OS5bLDgPxzUi+T4F6
	 zmR1GI2qhCk+27smM67Nyw6dnjXLW3+4MFNJeIJ0Hw1hXTN8x17toei6XzjJAyX98T
	 2uqEQoIKN6O0/BuFyY7Fi4/PgtgPXq+v2A3dtQYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbgKCBWr (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 2 Nov 2020 20:22:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728264AbgKCBUy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Nov 2020 20:20:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1CA9223EA;
        Tue,  3 Nov 2020 01:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604366453;
        bh=OCysreUBOh/I7tKWLx+Ybyv5pIlteOzq4petGN+IfsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rsXxWdBNMm47Eoze5SjH037QLHoiQNXKr3XsB2A49riZaIzoz94r3jIavwTipClG6
         wz4OZxoF/qgfCYVcWajJMun49R3OffNOpMrWuzpSsETm5QbABAUZSNzptnpKD/nyB1
         yHwG6oJxSvZ9fFRdgUmeVZBo3ZlI9EBaPC7a/TEY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhang Qilong <zhangqilong3@huawei.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-nvdimm@lists.01.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 11/11] ACPI: NFIT: Fix comparison to '-ENXIO'
Date:   Mon,  2 Nov 2020 20:20:39 -0500
Message-Id: <20201103012039.183672-11-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201103012039.183672-1-sashal@kernel.org>
References: <20201103012039.183672-1-sashal@kernel.org>
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
index dd4c7289610ec..cb88f3b43a940 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1535,7 +1535,7 @@ static ssize_t format1_show(struct device *dev,
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

