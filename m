Return-Path: <SRS0=pU6J=XR=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171B1C4740C
	for <linux-acpi@archiver.kernel.org>; Sun, 22 Sep 2019 19:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61DA208C2
	for <linux-acpi@archiver.kernel.org>; Sun, 22 Sep 2019 19:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179555;
	bh=/H6WitFJUI+gMgZD6uHf8ltL8tBdlaYkFbuJZGnmxxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=znMmgyNJ4h0P+TFlwP5ZSNfBzWrxSnWU3gKQ6LFl9XkuwtJ3GUDLd3GKUIRPuv7rv
	 8j7b05HftRR4dzfwuhjhSJlch2IqoP/4S4CpvGPZBoDx+Jba4DjyN+ukbIYnEs8Lp2
	 yGF58w8RdaDYnM+qO61VukbuTAsnqrjuel0PUTfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436725AbfIVTMa (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:12:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438709AbfIVS6C (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 22 Sep 2019 14:58:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59CC32184D;
        Sun, 22 Sep 2019 18:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178682;
        bh=/H6WitFJUI+gMgZD6uHf8ltL8tBdlaYkFbuJZGnmxxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WoW+F+bl+fu/trBaow+iSWgi3h+XzOaVPd0PiKEVoqNrIC9TMK3QsBzZHCkeTJ1Da
         rApJccjzvgeCOXGIW0ZN/4mU+eAFUb/FA8eagPXM0WYBt8t842RHXquFD9Hpbv8FqD
         tTSLrjutPcJCDDCllleoEtCLRSlUuGc7GqFe3J+o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiri Slaby <jslaby@suse.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 28/89] ACPI / processor: don't print errors for processorIDs == 0xff
Date:   Sun, 22 Sep 2019 14:56:16 -0400
Message-Id: <20190922185717.3412-28-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185717.3412-1-sashal@kernel.org>
References: <20190922185717.3412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>

[ Upstream commit 2c2b005f549544c13ef4cfb0e4842949066889bc ]

Some platforms define their processors in this manner:
    Device (SCK0)
    {
	Name (_HID, "ACPI0004" /* Module Device */)  // _HID: Hardware ID
	Name (_UID, "CPUSCK0")  // _UID: Unique ID
	Processor (CP00, 0x00, 0x00000410, 0x06){}
	Processor (CP01, 0x02, 0x00000410, 0x06){}
	Processor (CP02, 0x04, 0x00000410, 0x06){}
	Processor (CP03, 0x06, 0x00000410, 0x06){}
	Processor (CP04, 0x01, 0x00000410, 0x06){}
	Processor (CP05, 0x03, 0x00000410, 0x06){}
	Processor (CP06, 0x05, 0x00000410, 0x06){}
	Processor (CP07, 0x07, 0x00000410, 0x06){}
	Processor (CP08, 0xFF, 0x00000410, 0x06){}
	Processor (CP09, 0xFF, 0x00000410, 0x06){}
	Processor (CP0A, 0xFF, 0x00000410, 0x06){}
	Processor (CP0B, 0xFF, 0x00000410, 0x06){}
...

The processors marked as 0xff are invalid, there are only 8 of them in
this case.

So do not print an error on ids == 0xff, just print an info message.
Actually, we could return ENODEV even on the first CPU with ID 0xff, but
ACPI spec does not forbid the 0xff value to be a processor ID. Given
0xff could be a correct one, we would break working systems if we
returned ENODEV.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_processor.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index ccf07674a2a09..f81c434ce4c59 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -281,9 +281,13 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	}
 
 	if (acpi_duplicate_processor_id(pr->acpi_id)) {
-		dev_err(&device->dev,
-			"Failed to get unique processor _UID (0x%x)\n",
-			pr->acpi_id);
+		if (pr->acpi_id == 0xff)
+			dev_info_once(&device->dev,
+				"Entry not well-defined, consider updating BIOS\n");
+		else
+			dev_err(&device->dev,
+				"Failed to get unique processor _UID (0x%x)\n",
+				pr->acpi_id);
 		return -ENODEV;
 	}
 
-- 
2.20.1

