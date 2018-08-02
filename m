From: oceanhehy@gmail.com
Subject: [PATCH v2] ACPI: nfit: remove redundant assignment if nfit_mem found
Date: Thu,  2 Aug 2018 04:44:04 -0400
Message-ID: <1533199444-29607-1-git-send-email-oceanhehy@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dan.j.williams@intel.com, ross.zwisler@linux.intel.com, vishal.l.verma@intel.com, dave.jiang@intel.com, rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Ocean He <hehy1@lenovo.com>
List-Id: linux-acpi@vger.kernel.org

From: Ocean He <hehy1@lenovo.com>

When nfit_mem is found via list_for_each_entry, it has already been
assigned valid value. There is no need to assign it again in the following
codes.

Signed-off-by: Ocean He <hehy1@lenovo.com>
---
v1: https://patchwork.kernel.org/patch/10553277/
v2: Sorry for noise. I got an email problem, so I have to resend to loop 
linux-nvdimm@lists.01.org.

 drivers/acpi/nfit/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 7c47900..85dde54 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1048,9 +1048,7 @@ static int __nfit_mem_init(struct acpi_nfit_desc *acpi_desc,
 				break;
 			}
 
-		if (found)
-			nfit_mem = found;
-		else {
+		if (!found) {
 			nfit_mem = devm_kzalloc(acpi_desc->dev,
 					sizeof(*nfit_mem), GFP_KERNEL);
 			if (!nfit_mem)
-- 
1.8.3.1
