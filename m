From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 4/5] ACPI: Missing _S0W shouldn't disable runtime PM
Date: Mon,  4 Oct 2010 14:22:28 -0400
Message-ID: <1286216549-5438-5-git-send-email-mjg@redhat.com>
References: <1286216549-5438-1-git-send-email-mjg@redhat.com>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1286216549-5438-1-git-send-email-mjg@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-acpi@vger.kernel.org

A failure to evaluate _S0W will effectively result in the suspend state
for PCI devices being set to D0. We should limit that to genuine failures
rather than doing so if the method isn't present.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/acpi/sleep.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index cf82989..ab0ba78 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -609,9 +609,9 @@ int acpi_pm_device_sleep_state(struct device *dev, int *d_min_p)
 		acpi_method[3] = 'W';
 		status = acpi_evaluate_integer(handle, acpi_method, NULL,
 						&d_max);
-		if (ACPI_FAILURE(status)) {
+		if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
 			d_max = d_min;
-		} else if (d_max < d_min) {
+		} else if (ACPI_SUCCESS(status) && d_max < d_min) {
 			/* Warn the user of the broken DSDT */
 			printk(KERN_WARNING "ACPI: Wrong value from %s\n",
 				acpi_method);
-- 
1.7.3.1
