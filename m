From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] make acpi_chain_head static
Date: Wed, 13 Feb 2008 23:29:57 +0200
Message-ID: <20080213212957.GQ3383@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:50784 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754142AbYBMVaN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Feb 2008 16:30:13 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

acpi_chain_head can become static.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
cc3a04eb55aeb07d17bb7701b2227079b752508f diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
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

