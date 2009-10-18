From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/7] acpi: processor: fix section mismatch
Date: Mon, 19 Oct 2009 01:54:31 +0300
Message-ID: <1255906474-25091-5-git-send-email-felipe.contreras@gmail.com>
References: <1255906474-25091-1-git-send-email-felipe.contreras@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:62235 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755440AbZJRW5j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 18 Oct 2009 18:57:39 -0400
In-Reply-To: <1255906474-25091-1-git-send-email-felipe.contreras@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-kernel@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Myron Stowe <myron.stowe@hp.com>, linux-acpi@vger.kernel.org

WARNING: drivers/acpi/processor.o(.text+0x99a): Section mismatch in
reference from the function acpi_processor_add() to the function
.cpuinit.text:acpi_processor_power_init()

acpi_processor_add replaced acpi_processor_start which had __cpuinit.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/acpi/processor_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index c567b46..ec742a4 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -770,7 +770,7 @@ static struct notifier_block acpi_cpu_notifier =
 	    .notifier_call = acpi_cpu_soft_notify,
 };
 
-static int acpi_processor_add(struct acpi_device *device)
+static int __cpuinit acpi_processor_add(struct acpi_device *device)
 {
 	struct acpi_processor *pr = NULL;
 	int result = 0;
-- 
1.6.5.1

