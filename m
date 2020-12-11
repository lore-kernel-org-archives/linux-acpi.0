Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C22FC433FE
	for <linux-acpi@archiver.kernel.org>; Fri, 11 Dec 2020 02:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F8123E55
	for <linux-acpi@archiver.kernel.org>; Fri, 11 Dec 2020 02:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389197AbgLKCH4 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 10 Dec 2020 21:07:56 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58388 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388867AbgLKCHy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Dec 2020 21:07:54 -0500
Received: from [123.114.42.209] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <hui.wang@canonical.com>)
        id 1knXpv-0000lm-Hd; Fri, 11 Dec 2020 02:07:12 +0000
From:   Hui Wang <hui.wang@canonical.com>
To:     linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com
Cc:     lenb@kernel.org, stable@vger.kernel.org
Subject: [PATCH v3] ACPI / PNP: compare the string length in the matching_id
Date:   Fri, 11 Dec 2020 10:07:02 +0800
Message-Id: <20201211020702.35576-1-hui.wang@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Recently we met a touchscreen problem on some Thinkpad machines, the
touchscreen driver (i2c-hid) is not loaded and the touchscreen can't
work.

An i2c ACPI device with the name WACF2200 is defined in the BIOS, with
the current rule in matching_id(), this device will be regarded as
a PNP device since there is WACFXXX in the acpi_pnp_device_ids[] and
this PNP device is attached to the acpi device as the 1st
physical_node, this will make the i2c bus match fail when i2c bus
calls acpi_companion_match() to match the acpi_id_table in the i2c-hid
driver.

WACF2200 is an i2c device instead of a PNP device, after adding the
string length comparing, the matching_id() will return false when
matching WACF2200 and WACFXXX, and it is reasonable to compare the
string lenth when matching two ids.

Cc: stable@vger.kernel.org
Signed-off-by: Hui Wang <hui.wang@canonical.com>
---
 drivers/acpi/acpi_pnp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index 4ed755a963aa..8f2dc176bb41 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -319,6 +319,9 @@ static bool matching_id(const char *idstr, const char *list_id)
 {
 	int i;
 
+	if (strlen(idstr) != strlen(list_id))
+		return false;
+
 	if (memcmp(idstr, list_id, 3))
 		return false;
 
-- 
2.25.1

