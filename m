From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/11] ACPI: static acpi_chain_head
Date: Thu, 14 Feb 2008 02:02:29 -0500
Message-ID: <c8e773fa4f6a999a80d9fa3836f412e259ab6fa1.1202972422.git.len.brown@intel.com>
References: <1202972552-17953-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:35667 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756174AbYBNHKo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Feb 2008 02:10:44 -0500
In-Reply-To: <1202972552-17953-1-git-send-email-lenb@kernel.org>
In-Reply-To: <b077fbada161479d9a32a7730d2822d5e737b306.1202972422.git.len.brown@intel.com>
References: <b077fbada161479d9a32a7730d2822d5e737b306.1202972422.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Adrian Bunk <bunk@kernel.org>, Len Brown <len.brown@intel.com>

From: Adrian Bunk <bunk@kernel.org>

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index 5479dc0..abec1ca 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -110,7 +110,7 @@ static const struct file_operations acpi_system_event_ops = {
 #endif	/* CONFIG_ACPI_PROC_EVENT */
 
 /* ACPI notifier chain */
-BLOCKING_NOTIFIER_HEAD(acpi_chain_head);
+static BLOCKING_NOTIFIER_HEAD(acpi_chain_head);
 
 int acpi_notifier_call_chain(struct acpi_device *dev, u32 type, u32 data)
 {
-- 
1.5.4.1.122.gaa8d

