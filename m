Return-Path: <SRS0=0Hnf=4C=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E026C3B1BD
	for <linux-acpi@archiver.kernel.org>; Fri, 14 Feb 2020 19:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468BA24677
	for <linux-acpi@archiver.kernel.org>; Fri, 14 Feb 2020 19:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387995AbgBNTI3 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:08:29 -0500
Received: from mga02.intel.com ([134.134.136.20]:26791 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388122AbgBNTI3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Feb 2020 14:08:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 11:08:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="227702893"
Received: from sibelius.jf.intel.com ([10.54.75.38])
  by orsmga008.jf.intel.com with ESMTP; 14 Feb 2020 11:08:24 -0800
From:   Erik Kaneda <erik.kaneda@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Cc:     Anchal Agarwal <anchalag@amazon.com>,
        Balbir Singh <sblbir@amazon.com>,
        Frank van der Linden <fllinden@amazon.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 04/10] ACPICA: Enable sleep button on ACPI legacy wake
Date:   Fri, 14 Feb 2020 10:47:58 -0800
Message-Id: <20200214184804.15114-5-erik.kaneda@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200214184804.15114-1-erik.kaneda@intel.com>
References: <20200214184804.15114-1-erik.kaneda@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Anchal Agarwal <anchalag@amazon.com>

ACPICA commit 9383f5b01091e432c05f802a57edc20d329eec1f

Hibernation (S4) is triggered in a guest when it recieves a sleep
trigger from the hypervisor. When the guest resumes from this power
state, it does not see the sleep_enabled bit. In otherwords, the sleep
button is not enabled on waking from an S4 state. This causes
subsequent invocation of sleep state to fail in the guest.

Fix this problem by enabling the sleep button in ACPI legacy wake.

Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
Reviewed-by: Balbir Singh <sblbir@amazon.com>
Reviewed-by: Frank van der Linden <fllinden@amazon.com>
[ ek: changelog]

Link: https://github.com/acpica/acpica/commit/9383f5b0
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Anchal Agarwal <anchalag@amazon.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/hwsleep.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index 243a25add28f..317ae870336b 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -300,6 +300,18 @@ acpi_status acpi_hw_legacy_wake(u8 sleep_state)
 				    [ACPI_EVENT_POWER_BUTTON].
 				    status_register_id, ACPI_CLEAR_STATUS);
 
+	/* Enable sleep button */
+
+	(void)
+	    acpi_write_bit_register(acpi_gbl_fixed_event_info
+				    [ACPI_EVENT_SLEEP_BUTTON].
+				    enable_register_id, ACPI_ENABLE_EVENT);
+
+	(void)
+	    acpi_write_bit_register(acpi_gbl_fixed_event_info
+				    [ACPI_EVENT_SLEEP_BUTTON].
+				    status_register_id, ACPI_CLEAR_STATUS);
+
 	acpi_hw_execute_sleep_method(METHOD_PATHNAME__SST, ACPI_SST_WORKING);
 	return_ACPI_STATUS(status);
 }
-- 
2.21.0

