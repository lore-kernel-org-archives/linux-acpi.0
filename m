From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] ACPI / PM: print physical addresses consistently with other
	parts of kernel
Date: Mon, 13 Feb 2012 17:04:43 -0700
Message-ID: <20120214000443.32491.31655.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ey0-f202.google.com ([209.85.215.202]:52779 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758429Ab2BNAEp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2012 19:04:45 -0500
Received: by mail-ey0-f202.google.com with SMTP id f13so166893eaa.1
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2012 16:04:44 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Print physical address info in a style consistent with the %pR style used
elsewhere in the kernel.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/nvs.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nvs.c b/drivers/acpi/nvs.c
index 7a2035f..266bc58 100644
--- a/drivers/acpi/nvs.c
+++ b/drivers/acpi/nvs.c
@@ -95,8 +95,8 @@ static int suspend_nvs_register(unsigned long start, unsigned long size)
 {
 	struct nvs_page *entry, *next;
 
-	pr_info("PM: Registering ACPI NVS region at %lx (%ld bytes)\n",
-		start, size);
+	pr_info("PM: Registering ACPI NVS region [mem %#010lx-%#010lx] (%ld bytes)\n",
+		start, start + size - 1, size);
 
 	while (size > 0) {
 		unsigned int nr_bytes;

