From: Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH] ACPI/hotplug: Fix STARTING/DYING action in acpi_cpu_soft_notify()
Date: Thu,  8 May 2014 07:58:59 -0600
Message-ID: <1399557539-7282-1-git-send-email-toshi.kani@hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:43477 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbaEHOIL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 May 2014 10:08:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>

During CPU online/offline testing on a large system, one of the
processors got stuck after the message "bad: scheduling from the
idle thread!".  The problem is that acpi_cpu_soft_notify() calls
acpi_bus_get_device() for all action types.  CPU_STARTING and
CPU_DYING do not allow the notify handlers to sleep.  However,
acpi_bus_get_device() can sleep in acpi_ut_acquire_mutex().

Change acpi_cpu_soft_notify() to return immediately for CPU_STARTING
and CPU_DYING as they have no action in this handler.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
---
 drivers/acpi/processor_driver.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 7f70f31..4fcbd67 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -121,6 +121,13 @@ static int acpi_cpu_soft_notify(struct notifier_block *nfb,
 	struct acpi_processor *pr = per_cpu(processors, cpu);
 	struct acpi_device *device;
 
+	/*
+	 * CPU_STARTING and CPU_DYING must not sleep. Return here since
+	 * acpi_bus_get_device() may sleep.
+	 */
+	if (action == CPU_STARTING || action == CPU_DYING)
+		return NOTIFY_DONE;
+
 	if (!pr || acpi_bus_get_device(pr->handle, &device))
 		return NOTIFY_DONE;
 
