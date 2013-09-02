From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v2 6/6] ACPI / processor: Remove outdated comments
Date: Mon,  2 Sep 2013 11:57:39 +0800
Message-ID: <1378094259-5922-7-git-send-email-hanjun.guo@linaro.org>
References: <1378094259-5922-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <1378094259-5922-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-ia64-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@redhat.com>, Jiang Liu <jiang.liu@huawei.com>, linux-acpi@vger.kernel.org, x86@kernel.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

acpi_get_processor_id() can be find nowhere, and the acpi id
is synchronized to APIC id when acpi_get_cpuid() is called, so
the comments can be removed.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/acpi_processor.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 7ce0750..da42892 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -240,11 +240,6 @@ static int acpi_processor_get_info(struct acpi_device *device)
 			return -ENODEV;
 		}
 
-		/*
-		 * TBD: Synch processor ID (via LAPIC/LSAPIC structures) on SMP.
-		 *      >>> 'acpi_get_processor_id(acpi_id, &id)' in
-		 *      arch/xxx/acpi.c
-		 */
 		pr->acpi_id = object.processor.proc_id;
 	} else {
 		/*
-- 
1.7.9.5

