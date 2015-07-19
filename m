From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 1/2] ACPI / processor: remove bogus __refdata annotations
Date: Sun, 19 Jul 2015 18:50:38 +0200
Message-ID: <1437324639-18118-2-git-send-email-minipli@googlemail.com>
References: <1437324639-18118-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437324639-18118-1-git-send-email-minipli@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Mathias Krause <minipli@googlemail.com>, Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: linux-acpi@vger.kernel.org

The processor_handler structure does not reference any __init / __exit
code or data. Therefore the __refdata annotation is not needed. It used
to be prior to commit fe7bf106ebc2 ("acpi: delete __cpuinit usage from
all acpi files") due to the __cpuinit annotation of acpi_processor_add().
But with that commit in place that requirement has gone.

The same is true for the acpi_cpu_notifier notifier block.
acpi_cpu_soft_notify() used to be marked __cpuinit but lost its
annotation in the above mentioned commit as well. Therefore the __refdata
annotation isn't needed there either.

Just drop the unneded __refdata annotations to be able to catch future
section mismatches.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/acpi/acpi_processor.c   |    2 +-
 drivers/acpi/processor_driver.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 92a5f738e370..985b8a83184e 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -485,7 +485,7 @@ static const struct acpi_device_id processor_device_ids[] = {
 	{ }
 };
 
-static struct acpi_scan_handler __refdata processor_handler = {
+static struct acpi_scan_handler processor_handler = {
 	.ids = processor_device_ids,
 	.attach = acpi_processor_add,
 #ifdef CONFIG_ACPI_HOTPLUG_CPU
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index d9f71581b79b..cc820d840c61 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -159,7 +159,7 @@ static int acpi_cpu_soft_notify(struct notifier_block *nfb,
 	return NOTIFY_OK;
 }
 
-static struct notifier_block __refdata acpi_cpu_notifier = {
+static struct notifier_block acpi_cpu_notifier = {
 	    .notifier_call = acpi_cpu_soft_notify,
 };
 
-- 
1.7.10.4
