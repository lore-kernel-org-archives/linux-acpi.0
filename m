Return-Path: <SRS0=IuZU=DV=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607C2C433DF
	for <linux-acpi@archiver.kernel.org>; Wed, 14 Oct 2020 01:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 243FE21D40
	for <linux-acpi@archiver.kernel.org>; Wed, 14 Oct 2020 01:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgJNBDu (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 13 Oct 2020 21:03:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42189 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJNBDu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Oct 2020 21:03:50 -0400
Received: from 2.general.alexhung.us.vpn ([10.172.65.255] helo=canonical.com)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <alex.hung@canonical.com>)
        id 1kSVCl-0005XB-Gz; Wed, 14 Oct 2020 01:03:48 +0000
From:   Alex Hung <alex.hung@canonical.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        alex.hung@canonical.com
Subject: [PATCH] ACPI: processor: remove unnecessary string  _UID comments
Date:   Tue, 13 Oct 2020 19:03:40 -0600
Message-Id: <20201014010340.433398-1-alex.hung@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPI 6.3 Errata A no longer allows _UID to be string except Itanium
for historical reasons as stated in section 5.2.12. Therefore, it is
redundant to comment "we don't handle string _UIDs yet" which implies a
feature is missing.

"From ACPI Specification 6.3 onward, all processor objects for all
architectures except Itanium must now use Device() objects with an _HID
of ACPI0007, and use only integer _UID values."

Signed-off-by: Alex Hung <alex.hung@canonical.com>
---
 drivers/acpi/acpi_processor.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index b51ddf3..710605f 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -264,7 +264,6 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	} else {
 		/*
 		 * Declared with "Device" statement; match _UID.
-		 * Note that we don't handle string _UIDs yet.
 		 */
 		status = acpi_evaluate_integer(pr->handle, METHOD_NAME__UID,
 						NULL, &value);
-- 
2.7.4

