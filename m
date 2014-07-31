From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH V2] ACPI/Processor: Make acpi_cpu_soft_notify() process CPU FROZEN events
Date: Thu, 31 Jul 2014 22:28:50 +0800
Message-ID: <1406816930-22138-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

CPU hotplug happens during S2RAM and CPU notify event will be CPU_XXX_FROZEN.
acpi_cpu_soft_notify() ignores to check these events. This also may make
acpi_cpu_soft_notify() fall into sleep during CPU_DYING/STARTING_FROZEN
events which don't allow callbacks to sleep. This patch is to fix it.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
Change since v1:
	unmark CPU_TASKS_FROZEN for all cpu events.

 drivers/acpi/processor_driver.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index 4fcbd67..d9f7158 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -120,6 +120,7 @@ static int acpi_cpu_soft_notify(struct notifier_block *nfb,
 	unsigned int cpu = (unsigned long)hcpu;
 	struct acpi_processor *pr = per_cpu(processors, cpu);
 	struct acpi_device *device;
+	action &= ~CPU_TASKS_FROZEN;
 
 	/*
 	 * CPU_STARTING and CPU_DYING must not sleep. Return here since
-- 
1.8.4.rc0.1.g8f6a3e5.dirty
