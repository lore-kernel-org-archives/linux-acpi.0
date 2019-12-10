Return-Path: <SRS0=4gY8=2A=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0E4C2D0C4
	for <linux-acpi@archiver.kernel.org>; Tue, 10 Dec 2019 21:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB3B206D5
	for <linux-acpi@archiver.kernel.org>; Tue, 10 Dec 2019 21:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576013332;
	bh=+3+DcNCmeecA0awtD4KHhH6/OrTIbugSArTDpBZiXKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O1BeIVY9x0BZq8rfNV10+vsejGFyglaDRV1P2zRQcBI1YvVd6VNsQr5RIq1wTLXJ1
	 p46PXTA2nSRZ/70B1zbR+kmR7CsrCUr7VziKk++ViQgTBBqKStmDu1iOp0qFgji4x4
	 jIZd9zmKb+gsDDCOjKvJGnviReZ131lHa8u+Q4D8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfLJV2h (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:28:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:60052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbfLJVKT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 10 Dec 2019 16:10:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F738246A2;
        Tue, 10 Dec 2019 21:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012219;
        bh=+3+DcNCmeecA0awtD4KHhH6/OrTIbugSArTDpBZiXKc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0hhgNchk2u08P/ah/8TYCbrgLg8uA9HPJ3/Blf2CmNjE6Ns+Smt8wRMYs+CiLADCW
         NKb3yNt3y5ENXM9QDj12vlpAYk1eseO5BFvYH/GjO8o91k2t8gWGRZ5lZ95RJM/giK
         Q3ebuyHvOnaN+RCg6viBCgpepvoPuOwSkmJ7ta0A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 169/350] ACPI: button: Add DMI quirk for Medion Akoya E2215T
Date:   Tue, 10 Dec 2019 16:04:34 -0500
Message-Id: <20191210210735.9077-130-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 932e1ba486117de2fcea3df27ad8218ad6c11470 ]

The Medion Akoya E2215T's ACPI _LID implementation is quite broken:

 1. For notifications it uses an ActiveLow Edge GpioInt, rather then
    an ActiveBoth one, meaning that the device is only notified when the
    lid is closed, not when it is opened.

2. Matching with this its _LID method simply always returns 0 (closed)

  In order for the Linux LID code to work properly with this implementation,
  the lid_init_state selection needs to be set to ACPI_BUTTON_LID_INIT_OPEN.

This commit adds a DMI quirk for this.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/button.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 4a2cde2c536a2..ce93a355bd1c8 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -78,6 +78,17 @@ static const struct dmi_system_id lid_blacklst[] = {
 			DMI_MATCH(DMI_BIOS_VERSION, "BYT70A.YNCHENG.WIN.007"),
 		},
 	},
+	{
+		/*
+		 * Medion Akoya E2215T, notification of the LID device only
+		 * happens on close, not on open and _LID always returns closed.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E2215T MD60198"),
+		},
+		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+	},
 	{}
 };
 
-- 
2.20.1

