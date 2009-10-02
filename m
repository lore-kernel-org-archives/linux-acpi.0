From: Rakib Mullick <rakib.mullick@gmail.com>
Subject: [PATCH] acpi: Annote acpi_processor_add with __cpuinit.
Date: Fri, 2 Oct 2009 11:15:24 +0600
Message-ID: <b9df5fa10910012215u6f6cbb8w3a8e667aec43dab4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:55390 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361AbZJBFPV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Oct 2009 01:15:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>

 Annote acpi_processor_add with cpuinit since it calls a cpuinit function
acpi_processor_power_init and fixes a section mismatch warning.

 We were warned by the following warning:

 LD      drivers/acpi/processor.o
WARNING: drivers/acpi/processor.o(.text+0x1829): Section mismatch in
reference from the function acpi_processor_add() to the function
.cpuinit.text:acpi_processor_power_init()
The function acpi_processor_add() references
the function __cpuinit acpi_processor_power_init().
This is often because acpi_processor_add lacks a __cpuinit
annotation or the annotation of acpi_processor_power_init is wrong.

-------
Signed-off-by: Rakib Mullick <rakib.mullick@gmail.com>

--- linus/drivers/acpi/processor_core.c	2009-09-28 12:04:54.000000000 +0600
+++ rakib/drivers/acpi/processor_core.c	2009-09-29 23:21:13.000000000 +0600
@@ -770,7 +770,7 @@ static struct notifier_block acpi_cpu_no
 	    .notifier_call = acpi_cpu_soft_notify,
 };

-static int acpi_processor_add(struct acpi_device *device)
+static int __cpuinit acpi_processor_add(struct acpi_device *device)
 {
 	struct acpi_processor *pr = NULL;
 	int result = 0;
