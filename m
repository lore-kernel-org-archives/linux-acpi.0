Return-Path: <SRS0=5qVQ=C3=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77CFC43464
	for <linux-acpi@archiver.kernel.org>; Fri, 18 Sep 2020 02:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0AC6235F7
	for <linux-acpi@archiver.kernel.org>; Fri, 18 Sep 2020 02:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600396123;
	bh=zA3Vrt0z8gU9vN84bjsr48+OaxxhATuVfIAJFGDbVVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UlhROyxLsu1sapkcLQgabjFNEkncESf0pwiAgzsznsGvQ369+u9cHyFrqK5jotY+Q
	 jtZAkpVdM+77SlxuiGq2BtgKESolv50nyL+ruMdqx1JKwhZaU3XXjQOjCv4MHUwvG2
	 uSWVjp4VAgFZTAPDCmlICoouFM/6eTuGXdnQDJnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgIRC2n (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:28:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:44124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729205AbgIRCPW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Sep 2020 22:15:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CEB823A03;
        Fri, 18 Sep 2020 02:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600395321;
        bh=zA3Vrt0z8gU9vN84bjsr48+OaxxhATuVfIAJFGDbVVA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pcMfhJgHV6sHdvN/pvk41qrZLgPIxDSC8Xq5AA2F9xJQxf/1NOTOE55EEWvE+wDkN
         FrfSU20Xl7rkvTEDTzE70t5Ya8GH8Va38pbdi7cJGDcW+CGG2j53W2fcYGWTk00f/t
         xlkjIOHuMGeHHXNvIFgQZbzFjwn12KDmkaB7hT3E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 22/90] ACPI: EC: Reference count query handlers under lock
Date:   Thu, 17 Sep 2020 22:13:47 -0400
Message-Id: <20200918021455.2067301-22-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918021455.2067301-1-sashal@kernel.org>
References: <20200918021455.2067301-1-sashal@kernel.org>
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
index 307b3e28f34ce..8781b5dc97f1c 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1049,29 +1049,21 @@ void acpi_ec_unblock_transactions(void)
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

