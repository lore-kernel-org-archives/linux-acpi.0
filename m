From: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Subject: [Patch v2 1/5] ACPI / LPIT: Export lpit_read_residency_count_address()
Date: Fri,  2 Feb 2018 19:13:33 +0530
Message-ID: <1517579017-19935-2-git-send-email-rajneesh.bhardwaj@intel.com>
References: <1517579017-19935-1-git-send-email-rajneesh.bhardwaj@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1517579017-19935-1-git-send-email-rajneesh.bhardwaj@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: dvhart@infradead.org, andy@infradead.org, linux-kernel@vger.kernel.org, vishwanath.somayaji@intel.com, srinivas.pandruvada@linux.intel.com, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Export lpit_read_residency_count_address(), so that it can be used from
drivers built as module. With the recent changes, the builtin_pci
functionality of the intel_pmc_core driver is removed and now it can be
built as a module to read this exported interface to calculate the PMC base
address.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Tested-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/acpi_lpit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
index e94e478dd18b..cf4fc0161164 100644
--- a/drivers/acpi/acpi_lpit.c
+++ b/drivers/acpi/acpi_lpit.c
@@ -100,6 +100,7 @@ int lpit_read_residency_count_address(u64 *address)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(lpit_read_residency_count_address);
 
 static void lpit_update_residency(struct lpit_residency_info *info,
 				 struct acpi_lpit_native *lpit_native)
-- 
2.7.4
