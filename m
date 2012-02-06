From: Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 2/5] ACPI: Make ACPI interrupt threaded
Date: Mon,  6 Feb 2012 08:17:09 -0800
Message-ID: <1328545032-21373-3-git-send-email-andi@firstfloor.org>
References: <1328545032-21373-1-git-send-email-andi@firstfloor.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1328545032-21373-1-git-send-email-andi@firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mjg@redhat.com, Andi Kleen <andi@firstfloor.org>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Some ACPI interrupt actions may need to wait, and it's easiest to
have a thread context for this. So turn the ACPI interrupt
into a threaded interrupt.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 drivers/acpi/osl.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 412a1e0..f3f6ff7 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -595,7 +595,8 @@ acpi_os_install_interrupt_handler(u32 gsi, acpi_osd_handler handler,
 
 	acpi_irq_handler = handler;
 	acpi_irq_context = context;
-	if (request_irq(irq, acpi_irq, IRQF_SHARED, "acpi", acpi_irq)) {
+	if (request_threaded_irq(irq, NULL, acpi_irq, IRQF_SHARED, "acpi", 
+				 acpi_irq)) {
 		printk(KERN_ERR PREFIX "SCI (IRQ%d) allocation failed\n", irq);
 		acpi_irq_handler = NULL;
 		return AE_NOT_ACQUIRED;
-- 
1.7.7
