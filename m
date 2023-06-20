Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F78EB64D7
	for <linux-acpi@archiver.kernel.org>; Tue, 20 Jun 2023 18:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjFTSqI (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 20 Jun 2023 14:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFTSqI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Jun 2023 14:46:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F344110FB
        for <linux-acpi@vger.kernel.org>; Tue, 20 Jun 2023 11:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687286719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bkYLyLPUr9pngAM+02YHEQ1kaSokFfTz5Ik3MLf5REY=;
        b=VjKekoaFHJ9rKWoF7AD2O3KCuUpmKaZKTCd4fAAkGfN6kn+NQGurVraFegFPi0lRA+eXgH
        NmD3/rz7zuyGFrxcAJkVz2MSF2C/z9hvKg9nahgAdz9AsoxlN6DEVnVfSNB95wRo+TT17p
        IQ7/nomspnOJmwbEEGIXkd+ihooEuB0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-9NuE3hXpMgSySh7wGMXMLQ-1; Tue, 20 Jun 2023 14:45:11 -0400
X-MC-Unique: 9NuE3hXpMgSySh7wGMXMLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61B10858290;
        Tue, 20 Jun 2023 18:45:06 +0000 (UTC)
Received: from x1.nl (unknown [10.39.192.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9427840C2063;
        Tue, 20 Jun 2023 18:45:05 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        raycekarneal <raycekarneal@gmail.com>
Subject: [PATCH] ACPI: video: Add backlight=native DMI quirk for Dell Studio 1569
Date:   Tue, 20 Jun 2023 20:45:04 +0200
Message-Id: <20230620184504.12451-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The Dell Studio 1569 predates Windows 8, so it defaults to using
acpi_video# for backlight control, but this is non functional on
this model.

Add a DMI quirk to use the native intel_backlight interface which
does work properly.

Reported-by: raycekarneal <raycekarneal@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index eb014c0eba42..18cc08c858cf 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -528,6 +528,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7510"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Dell Studio 1569 */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "Studio 1569"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* Acer Aspire 3830TG */
-- 
2.40.1

