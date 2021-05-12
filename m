Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3227FC433ED
	for <linux-acpi@archiver.kernel.org>; Wed, 12 May 2021 12:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9BCF61177
	for <linux-acpi@archiver.kernel.org>; Wed, 12 May 2021 12:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhELM5w (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Wed, 12 May 2021 08:57:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232218AbhELM4h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 12 May 2021 08:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620824129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Tc8mQDAbJHENH7lcv2Ene1EyzKbcts8k9beVWkDL3jU=;
        b=VSZpmxaxYqCWKJaiGe+QiWbqM2teI1T1EN+WVdINStRF299RAHhi4r95mnfiteGzhkY0Cz
        ZCpZ2bZoHubKsOKck+mf4JnrR+2yoYIEPrOk2Avl4DlZxkE8EIrjoPUvtZPZ5uByVk0RnB
        jG64gzhkK/6YXu8yHvV1ENbxE9NsQGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-a0r2CM30NsKyocm2T4IYUg-1; Wed, 12 May 2021 08:55:27 -0400
X-MC-Unique: a0r2CM30NsKyocm2T4IYUg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCEED107ACC7;
        Wed, 12 May 2021 12:55:25 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-30.ams2.redhat.com [10.36.112.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA04861094;
        Wed, 12 May 2021 12:55:24 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 0/1] platform/x86: intel_int0002_vgpio: Only call enable_irq_wake() when using s2idle
Date:   Wed, 12 May 2021 14:55:22 +0200
Message-Id: <20210512125523.55215-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi All,

This is a rewrite of a patch which I wrote a while ago:
https://www.spinics.net/lists/kernel/msg3474327.html

The old version got nacked because it was changing behavior based on whether
s2idle or s3 suspend was used at probe-time, while this can be changed at
run-time.

This new version instead delays calling enable_irq_wake() until the drivers'
suspend call-back is called, at which point we know for sure which type of
suspend is being used (for this suspend/resume cycle), thus addressing the
problem with the old version.

Regards,

Hans


Hans de Goede (1):
  platform/x86: intel_int0002_vgpio: Only call enable_irq_wake() when
    using s2idle

 drivers/platform/x86/Kconfig               |  2 +-
 drivers/platform/x86/intel_int0002_vgpio.c | 80 +++++++++++++++-------
 2 files changed, 57 insertions(+), 25 deletions(-)

-- 
2.31.1

