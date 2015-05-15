From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 3/6] ACPI / EC: Remove irqs_disabled() check.
Date: Fri, 15 May 2015 14:16:34 +0800
Message-ID: <87e715bdb09c9c74e0aa4d6dbbef4dc21f606d1c.1431670199.git.lv.zheng@intel.com>
References: <3b6064b23b148a9c3eed58566e9361a852618556.1430900840.git.lv.zheng@intel.com> <cover.1431670199.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1431670199.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The following commit merges polling and interrupt modes for EC driver:
  Commit: 2a84cb9852f52c0cd1c48bca41a8792d44ad06cc Mon Sep 17 00:00:00 2001
  Subject: ACPI: EC: Merge IRQ and POLL modes
The irqs_disabled() check introduced in it tries to fall into busy polling
mode when the context of ec_poll() cannot sleep.

Actually ec_poll() is ensured to be invoked in the contexts that can sleep
(from a sysfs /sys/kernel/debug/ec/ec0/io access, or from
acpi_evaluate_object(), or from acpi_ec_gpe_poller()). Without the MSI
quirk, we never saw the udelay() logic invoked. Thus this check is useless
and can be removed.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/ec.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index 170d743..20bd43f 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -504,8 +504,7 @@ static int ec_poll(struct acpi_ec *ec)
 			msecs_to_jiffies(ec_delay);
 		unsigned long usecs = ACPI_EC_UDELAY_POLL;
 		do {
-			/* don't sleep with disabled interrupts */
-			if (EC_FLAGS_MSI || irqs_disabled()) {
+			if (EC_FLAGS_MSI) {
 				usecs = ACPI_EC_MSI_UDELAY;
 				udelay(usecs);
 				if (ec_transaction_completed(ec))
-- 
1.7.10
