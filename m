From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 2/5] acpi, nfit: add support for acpi 6.1 dimm state flags
Date: Fri, 14 Apr 2017 09:58:22 -0700
Message-ID: <149218910195.3926.13927602427357940056.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <149218909065.3926.1234846095650907678.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:36043 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751960AbdDNREG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 Apr 2017 13:04:06 -0400
In-Reply-To: <149218909065.3926.1234846095650907678.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, vishal.l.verma@intel.com

Add support for the ACPI_NFIT_MEM_MAP_FAILED ("map_fail") and
ACPI_NFIT_MEM_HEALTH_ENABLED ("smart_notify") health state flags. The
"map_fail" flag identifies DIMMs that were not mapped into one or more
physical address ranges. The "health_notify" flag indicates whether
platform firmware will send notifications when there is new SMART health
data to consume.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 53943d6f4214..05829de43b1d 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1246,12 +1246,14 @@ static ssize_t flags_show(struct device *dev,
 {
 	u16 flags = to_nfit_memdev(dev)->flags;
 
-	return sprintf(buf, "%s%s%s%s%s\n",
+	return sprintf(buf, "%s%s%s%s%s%s%s\n",
 		flags & ACPI_NFIT_MEM_SAVE_FAILED ? "save_fail " : "",
 		flags & ACPI_NFIT_MEM_RESTORE_FAILED ? "restore_fail " : "",
 		flags & ACPI_NFIT_MEM_FLUSH_FAILED ? "flush_fail " : "",
 		flags & ACPI_NFIT_MEM_NOT_ARMED ? "not_armed " : "",
-		flags & ACPI_NFIT_MEM_HEALTH_OBSERVED ? "smart_event " : "");
+		flags & ACPI_NFIT_MEM_HEALTH_OBSERVED ? "smart_event " : "",
+		flags & ACPI_NFIT_MEM_MAP_FAILED ? "map_fail " : "",
+		flags & ACPI_NFIT_MEM_HEALTH_ENABLED ? "smart_notify " : "");
 }
 static DEVICE_ATTR_RO(flags);
 

