Return-Path: <SRS0=5qVQ=C3=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F34DC43464
	for <linux-acpi@archiver.kernel.org>; Fri, 18 Sep 2020 03:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C074E2083B
	for <linux-acpi@archiver.kernel.org>; Fri, 18 Sep 2020 03:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600398588;
	bh=6In8Y7DkPN2i+MJDFsQhZPWyJqsgDZkvzAAX35ClLiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GuRQejmePUI3ss3XQ95qGjNEKev0xfc2KPEM4ncDkLxlcEpCP3WRLh/iG+lW7HueS
	 /fKUwMZIFW5vlB15Nuz0eccjSglFAiGhBohe6QX0pPoF/Sl1g3ZR+IdoDlK1wSliLW
	 +arnP11VB+nWRcnE0pXfv5OB0XnZOaWChikGbMQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgIRDJi (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 17 Sep 2020 23:09:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:48838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726824AbgIRCDA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 22:03:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEE6322211;
        Fri, 18 Sep 2020 02:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600394580;
        bh=6In8Y7DkPN2i+MJDFsQhZPWyJqsgDZkvzAAX35ClLiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iNzxuLd0BC7K02/nUVJcccFg7wJfuYj07NYcr/ebBM+W9iXgeOeOqldVNImKSl6p/
         HSshCx6xLUwtF5tdoreoI+RdbpS8Q1nbdFPFVCxepc2HJ9/DTM3ylM6EYk1m0B7ZvO
         Vb7paBxCDhMx4HT09tqrc0qsvg4B3sonZkTwXD28=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 091/330] ACPI: EC: Reference count query handlers under lock
Date:   Thu, 17 Sep 2020 21:57:11 -0400
Message-Id: <20200918020110.2063155-91-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918020110.2063155-1-sashal@kernel.org>
References: <20200918020110.2063155-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit 3df663a147fe077a6ee8444ec626738946e65547 ]

There is a race condition in acpi_ec_get_query_handler()
theoretically allowing query handlers to go away before refernce
counting them.

In order to avoid it, call kref_get() on query handlers under
ec->mutex.

Also simplify the code a bit while at it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/ec.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 57eacdcbf8208..1ec55345252b6 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1043,29 +1043,21 @@ void acpi_ec_unblock_transactions(void)
 /* --------------------------------------------------------------------------
                                 Event Management
    -------------------------------------------------------------------------- */
-static struct acpi_ec_query_handler *
-acpi_ec_get_query_handler(struct acpi_ec_query_handler *handler)
-{
-	if (handler)
-		kref_get(&handler->kref);
-	return handler;
-}
-
 static struct acpi_ec_query_handler *
 acpi_ec_get_query_handler_by_value(struct acpi_ec *ec, u8 value)
 {
 	struct acpi_ec_query_handler *handler;
-	bool found = false;
 
 	mutex_lock(&ec->mutex);
 	list_for_each_entry(handler, &ec->list, node) {
 		if (value == handler->query_bit) {
-			found = true;
-			break;
+			kref_get(&handler->kref);
+			mutex_unlock(&ec->mutex);
+			return handler;
 		}
 	}
 	mutex_unlock(&ec->mutex);
-	return found ? acpi_ec_get_query_handler(handler) : NULL;
+	return NULL;
 }
 
 static void acpi_ec_query_handler_release(struct kref *kref)
-- 
2.25.1

