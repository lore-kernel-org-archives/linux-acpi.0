Return-Path: <SRS0=pU6J=XR=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0038C3A5A2
	for <linux-acpi@archiver.kernel.org>; Sun, 22 Sep 2019 19:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CEF21907
	for <linux-acpi@archiver.kernel.org>; Sun, 22 Sep 2019 19:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179731;
	bh=eAjUJp1E2xHVDiwJ3NWPs36uLgMPOkY1v8U/SjReQOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vB3YtxmRTzE7vcDZ8WvknEwd6iXI7n1iXELpOhVGL+px06vF1a9JbidOAweZqodw5
	 OQoO7JjL7Q8sj39tEfeWh3y9PXSzvUHzSLKg0DVQi62jGLyBIsA+bVpnkFLFMJf6zi
	 +5L7hYs2uwkmg/Sh167AYUoY4Tp+/ED5fd/cbJPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfIVTP1 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:15:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408207AbfIVS4g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 22 Sep 2019 14:56:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D12C2184D;
        Sun, 22 Sep 2019 18:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178595;
        bh=eAjUJp1E2xHVDiwJ3NWPs36uLgMPOkY1v8U/SjReQOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rIpfXKYl5vineCSTWa8eq4NNAKZaSRu0liNk1HPqB7x/A6h4U1KYOgVVjV7rb3PrY
         t1camPsaQxu0aBDTRvqo5+kNLp+ddgq1FrB6YYTS4wQsGDq+PHZMtfvxosGwGD/zII
         A2YRZVhLKYexqf5lV53ttVqywl7+Ul4SJhCcu+HA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 100/128] ACPI: custom_method: fix memory leaks
Date:   Sun, 22 Sep 2019 14:53:50 -0400
Message-Id: <20190922185418.2158-100-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185418.2158-1-sashal@kernel.org>
References: <20190922185418.2158-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit 03d1571d9513369c17e6848476763ebbd10ec2cb ]

In cm_write(), 'buf' is allocated through kzalloc(). In the following
execution, if an error occurs, 'buf' is not deallocated, leading to memory
leaks. To fix this issue, free 'buf' before returning the error.

Fixes: 526b4af47f44 ("ACPI: Split out custom_method functionality into an own driver")
Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/custom_method.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index e967c1173ba32..222ea3f12f41e 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -48,8 +48,10 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 	if ((*ppos > max_size) ||
 	    (*ppos + count > max_size) ||
 	    (*ppos + count < count) ||
-	    (count > uncopied_bytes))
+	    (count > uncopied_bytes)) {
+		kfree(buf);
 		return -EINVAL;
+	}
 
 	if (copy_from_user(buf + (*ppos), user_buf, count)) {
 		kfree(buf);
@@ -69,6 +71,7 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
 	}
 
+	kfree(buf);
 	return count;
 }
 
-- 
2.20.1

