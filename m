From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/3] ACPI / LPSS: Get rid of custom ICPU() macro
Date: Wed,  9 Jan 2019 18:57:53 +0200
Message-ID: <20190109165754.90072-2-andriy.shevchenko@linux.intel.com>
References: <20190109165754.90072-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109165754.90072-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-acpi@vger.kernel.org

Replace custom grown macro with generic INTEL_CPU_FAM6_NODATA() one.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_lpss.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 5f94c35d165f..633a528bb6ea 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -311,11 +311,9 @@ static const struct lpss_device_desc bsw_spi_dev_desc = {
 	.setup = lpss_deassert_reset,
 };
 
-#define ICPU(model)	{ X86_VENDOR_INTEL, 6, model, X86_FEATURE_ANY, }
-
 static const struct x86_cpu_id lpss_cpu_ids[] = {
-	ICPU(INTEL_FAM6_ATOM_SILVERMONT),	/* Valleyview, Bay Trail */
-	ICPU(INTEL_FAM6_ATOM_AIRMONT),	/* Braswell, Cherry Trail */
+	INTEL_CPU_FAM6_NODATA(ATOM_SILVERMONT),	/* Valleyview, Bay Trail */
+	INTEL_CPU_FAM6_NODATA(ATOM_AIRMONT),	/* Braswell, Cherry Trail */
 	{}
 };
 
-- 
2.20.1
