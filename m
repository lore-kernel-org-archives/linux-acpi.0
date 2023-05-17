Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A2FC77B7A
	for <linux-acpi@archiver.kernel.org>; Wed, 17 May 2023 09:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjEQJZA (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 17 May 2023 05:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjEQJYs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 05:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B70A171F
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 02:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684315443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zdFT329sqcN7TtmdIwyQK3IMQ6JXpEFnn5wtli0gSRU=;
        b=Zl10xgbHJw0qaZIAhRUzj+1K93QQNVRvwIDdvWjegH8/2Te1cMoedhxzLcp+NeHnxK96OB
        HAi2TJQHlqcYSEqMA7/GKS4m0AqS5L8g9RGywBLdpxU5ZHeOIRhDE+gTsotus00GW48fAe
        1nNpAeOQH5HJXcMkjW2fmhlT0fon/CE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-19HjKSGCOqaAO9aizKLKNg-1; Wed, 17 May 2023 05:24:02 -0400
X-MC-Unique: 19HjKSGCOqaAO9aizKLKNg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD145867942;
        Wed, 17 May 2023 09:24:01 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.195.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 575BE492B00;
        Wed, 17 May 2023 09:24:01 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] ACPI: video: Add backlight=native DMI quirk for Lenovo ThinkPad X131e (3371 AMD version)
Date:   Wed, 17 May 2023 11:23:59 +0200
Message-Id: <20230517092359.73840-3-hdegoede@redhat.com>
In-Reply-To: <20230517092359.73840-1-hdegoede@redhat.com>
References: <20230517092359.73840-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Linux defaults to picking the non-working ACPI video backlight interface
on the Lenovo ThinkPad X131e (3371 AMD version).

Add a DMI quirk to pick the working native radeon_bl0 interface instead.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/video_detect.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 61586caebb01..b87783c5872d 100644
--- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -470,6 +470,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "82BK"),
 		},
 	},
+	{
+	 .callback = video_detect_force_native,
+	 /* Lenovo ThinkPad X131e (3371 AMD version) */
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "3371"),
+		},
+	},
 	{
 	 .callback = video_detect_force_native,
 	 /* Apple iMac11,3 */
-- 
2.40.1

