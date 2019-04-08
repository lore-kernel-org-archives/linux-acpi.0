Return-Path: <SRS0=s14x=SK=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518B4C10F13
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Apr 2019 20:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ABD1218EA
	for <linux-acpi@archiver.kernel.org>; Mon,  8 Apr 2019 20:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfDHUrQ (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:47:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:33548 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbfDHUrQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 8 Apr 2019 16:47:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 13:47:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,326,1549958400"; 
   d="scan'208";a="314181145"
Received: from bartok.jf.intel.com ([10.54.75.137])
  by orsmga005.jf.intel.com with ESMTP; 08 Apr 2019 13:47:15 -0700
From:   Erik Schmauss <erik.schmauss@intel.com>
To:     linux-acpi@vger.kernel.org, rjw@rjwysocki.net
Cc:     Erik Schmauss <erik.schmauss@intel.com>,
        Bob Moore <robert.moore@intel.com>
Subject: [PATCH 7/8] ACPICA: Namespace: add check to avoid null pointer dereference
Date:   Mon,  8 Apr 2019 13:36:58 -0700
Message-Id: <20190408203659.4207-8-erik.schmauss@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190408203659.4207-1-erik.schmauss@intel.com>
References: <20190408203659.4207-1-erik.schmauss@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

ACPICA commit 7586a625f9c34c3169efd88470192bf63119e31a

Some ACPICA userspace tools call acpi_ut_subsystem_shutdown() during
cleanup and dereference a null pointer when cleaning up the
namespace.

Link: https://github.com/acpica/acpica/commit/7586a625
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/nsalloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/acpica/nsalloc.c b/drivers/acpi/acpica/nsalloc.c
index 5470213b8e64..6eb63db72249 100644
--- a/drivers/acpi/acpica/nsalloc.c
+++ b/drivers/acpi/acpica/nsalloc.c
@@ -74,6 +74,10 @@ void acpi_ns_delete_node(struct acpi_namespace_node *node)
 
 	ACPI_FUNCTION_NAME(ns_delete_node);
 
+	if (!node) {
+		return_VOID;
+	}
+
 	/* Detach an object if there is one */
 
 	acpi_ns_detach_object(node);
-- 
2.17.2

