From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/3] ACPI processor: Fix section mismatch for processor_add()
Date: Mon, 26 Oct 2009 17:44:18 +0100
Message-ID: <1256575458-19269-4-git-send-email-trenn@suse.de>
References: <1256575458-19269-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58341 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689AbZJZQo0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Oct 2009 12:44:26 -0400
In-Reply-To: <1256575458-19269-1-git-send-email-trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Bjorn Helgaas <bjorn.helgaas@hp.com>

Due to the merge of processor_start() (declared with __cpuinit) into
processor_add(), a section mismatch warning appears:

WARNING: drivers/built-in.o(.text+0x4d59d): Section mismatch in reference
from the function acpi_processor_add() to the function
.cpuinit.text:acpi_processor_power_init()
...

This patch fixes the warning by declaring processor_add() as __cpuinit
and also declares acpi_processor_add_fs() as __cpuinit as it is only
used in acpi_processor_add().

Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Len Brown <lenb@kernel.org>
CC: linux-acpi@vger.kernel.org
---
 drivers/acpi/processor_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index c567b46..32b7d92 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -353,7 +353,7 @@ static int acpi_processor_info_open_fs(struct inode *inode, struct file *file)
 			   PDE(inode)->data);
 }
 
-static int acpi_processor_add_fs(struct acpi_device *device)
+static int __cpuinit acpi_processor_add_fs(struct acpi_device *device)
 {
 	struct proc_dir_entry *entry = NULL;
 
@@ -770,7 +770,7 @@ static struct notifier_block acpi_cpu_notifier =
 	    .notifier_call = acpi_cpu_soft_notify,
 };
 
-static int acpi_processor_add(struct acpi_device *device)
+static int __cpuinit acpi_processor_add(struct acpi_device *device)
 {
 	struct acpi_processor *pr = NULL;
 	int result = 0;
-- 
1.6.3

