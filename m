Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60E4C7618A
	for <linux-acpi@archiver.kernel.org>; Mon, 20 Mar 2023 16:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjCTQWK (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 20 Mar 2023 12:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbjCTQVq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Mar 2023 12:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66FAC671
        for <linux-acpi@vger.kernel.org>; Mon, 20 Mar 2023 09:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679328783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FjiBYtKIW9PEe2MIQHjUtN2ET/X3WYegoPO7Dau7mT8=;
        b=D30j7+cOXpy3OHIA8JGJk0zXzc8FFfrg7ptgbwJIjPnqe717sekJL7NGMEwxdKOSeu99/Q
        BTRZgajTlhxpQH1M7ytQ5x0sms+5Y0WBx3FnSE10sVJ7xMxHxFt2rtEnn3SwcucRPd7n+y
        u/+vGR7YlQ4mjB5lafeDNqXqRmXWrmM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-226-Me841i5_MVeLh42EzOpvDw-1; Mon, 20 Mar 2023 11:59:48 -0400
X-MC-Unique: Me841i5_MVeLh42EzOpvDw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 125863815EE3;
        Mon, 20 Mar 2023 15:59:48 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22363C15BA0;
        Mon, 20 Mar 2023 15:59:47 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: video: Add backlight=native DMI quirk for Acer Aspire 3830TG
Date:   Mon, 20 Mar 2023 16:59:46 +0100
Message-Id: <20230320155946.489863-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Acer Aspire 3830TG predates Windows 8, so it defaults to using
acpi_video# for backlight control, but this is non functional on
this model.

Add a DMI quirk to use the native backlight interface which does
work properly.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 710ac640267d..c69b42a60427 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -495,6 +495,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7510"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Acer Aspire 3830TG */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 3830TG"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* Acer Aspire 4810T */
-- 
2.39.1

