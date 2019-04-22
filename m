Return-Path: <SRS0=2tY1=SY=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F1EC10F11
	for <linux-acpi@archiver.kernel.org>; Mon, 22 Apr 2019 17:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C86E20685
	for <linux-acpi@archiver.kernel.org>; Mon, 22 Apr 2019 17:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfDVRD1 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 22 Apr 2019 13:03:27 -0400
Received: from gateway23.websitewelcome.com ([192.185.50.141]:40452 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbfDVRD1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Apr 2019 13:03:27 -0400
X-Greylist: delayed 1430 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Apr 2019 13:03:26 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id F23FE5B37
        for <linux-acpi@vger.kernel.org>; Mon, 22 Apr 2019 11:39:35 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id IbyhhJSzlYTGMIbyhhPtsa; Mon, 22 Apr 2019 11:39:35 -0500
X-Authority-Reason: nr=8
Received: from [189.250.104.103] (port=39364 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hIbyh-001iky-5S; Mon, 22 Apr 2019 11:39:35 -0500
Date:   Mon, 22 Apr 2019 11:39:34 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ACPI: event: replace strcpy() by strscpy()
Message-ID: <20190422163934.GA2636@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.104.103
X-Source-L: No
X-Exim-ID: 1hIbyh-001iky-5S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.104.103]:39364
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 22
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org
Message-ID: <20190422163934.sPSNdHr1Qc1k62LFvq0MPxyYdiIy2Z9iUyWyOICTktM@z>

The strcpy() function is being deprecated. Replace it by the safer
strscpy() and fix the following Coverity warnings:

"You might overrun the 15-character fixed-size string event->bus_id
by copying bus_id without checking the length."

"You might overrun the 20-character fixed-size string event->device_class
by copying device_class without checking the length."

Addresses-Coverity-ID: 139001 ("Copy into fixed size buffer")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/acpi/event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index 5a127f3f2d5c..47f21599f2ab 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -131,8 +131,8 @@ int acpi_bus_generate_netlink_event(const char *device_class,
 	event = nla_data(attr);
 	memset(event, 0, sizeof(struct acpi_genl_event));
 
-	strcpy(event->device_class, device_class);
-	strcpy(event->bus_id, bus_id);
+	strscpy(event->device_class, device_class, sizeof(event->device_class));
+	strscpy(event->bus_id, bus_id, sizeof(event->bus_id));
 	event->type = type;
 	event->data = data;
 
-- 
2.21.0

