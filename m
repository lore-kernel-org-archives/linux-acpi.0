From: Colin King <colin.king@canonical.com>
Subject: [PATCH][V2] acpi: nfit: use %u format string specifier for unsigned ints
Date: Mon, 30 Jan 2017 12:08:08 +0000
Message-ID: <20170130120808.27691-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, joeyli.kernel@gmail.com, Toshi Kani <toshi.kani@hpe.com>, linux-acpi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

scrub_mode and scrub_count are both unsigned ints, however, the %d
format string specifier is being used instead of %u. Trivial fix,
use %u.  Also move the \n into the format string rather in both
literal strings.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/acpi/nfit/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 2f82b8e..5193b03 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -906,7 +906,7 @@ static ssize_t hw_error_scrub_show(struct device *dev,
 	struct nvdimm_bus_descriptor *nd_desc = to_nd_desc(nvdimm_bus);
 	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 
-	return sprintf(buf, "%d\n", acpi_desc->scrub_mode);
+	return sprintf(buf, "%u\n", acpi_desc->scrub_mode);
 }
 
 /*
@@ -967,8 +967,8 @@ static ssize_t scrub_show(struct device *dev,
 	if (nd_desc) {
 		struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 
-		rc = sprintf(buf, "%d%s", acpi_desc->scrub_count,
-				(work_busy(&acpi_desc->work)) ? "+\n" : "\n");
+		rc = sprintf(buf, "%u%s\n", acpi_desc->scrub_count,
+				(work_busy(&acpi_desc->work)) ? "+" : "");
 	}
 	device_unlock(dev);
 	return rc;
-- 
2.10.2

