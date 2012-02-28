From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] PM/Sleep,
 ACPI: Teach acpi_cpu_soft_notify() to handle CPU hotplug in
 suspend/resume path
Date: Tue, 28 Feb 2012 21:56:04 +0530
Message-ID: <20120228155137.3061.97133.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e28smtp08.in.ibm.com ([122.248.162.8]:51214 "EHLO
	e28smtp08.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019Ab2B1Q0g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Feb 2012 11:26:36 -0500
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Tue, 28 Feb 2012 21:56:34 +0530
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, rjw@sisk.pl
Cc: deepthi@linux.vnet.ibm.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com

acpi_cpu_soft_notify handles only CPU_ONLINE and CPU_DEAD events. However,
during a system-wide suspend/hibernation operation, CPU_ONLINE_FROZEN and
CPU_DEAD_FROZEN events are sent as part of CPU hotplug.

Those events are really no different from regular CPU hotplug in this context,
and hence acpi shouldn't ignore them. So, teach acpi_cpu_soft_notify() to
handle those events as well.

Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
---

I am no ACPI expert! So requesting a thorough review of this patch..

 drivers/acpi/processor_driver.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 2801b41..3a87b13 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -422,6 +422,12 @@ static int acpi_cpu_soft_notify(struct notifier_block *nfb,
 	unsigned int cpu = (unsigned long)hcpu;
 	struct acpi_processor *pr = per_cpu(processors, cpu);
 
+	/*
+	 * Regular CPU hotplug, and CPU hotplug as part of the suspend/resume
+	 * sequence are really no different for us. So, let us handle both.
+	 */
+	action &= ~CPU_TASKS_FROZEN;
+
 	if (action == CPU_ONLINE && pr) {
 		/* CPU got physically hotplugged and onlined the first time:
 		 * Initialize missing things

