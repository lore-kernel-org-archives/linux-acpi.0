From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] ACPI: nfit: constify *_attribute_group.
Date: Thu, 22 Jun 2017 15:44:41 +0530
Message-ID: <4c4644aea76ce2f098719c333125ceb6a3244145.1498126084.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, dan.j.williams@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

File size before:
   text	   data	    bss	    dec	    hex	filename
  20792	   1580	    994	  23366	   5b46	drivers/acpi/nfit/core.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  20968	   1388	    994	  23350	   5b36	drivers/acpi/nfit/core.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/acpi/nfit/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 656acb5..1871bec 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1066,7 +1066,7 @@ static umode_t nfit_visible(struct kobject *kobj, struct attribute *a, int n)
 	NULL,
 };
 
-static struct attribute_group acpi_nfit_attribute_group = {
+static const struct attribute_group acpi_nfit_attribute_group = {
 	.name = "nfit",
 	.attrs = acpi_nfit_attributes,
 	.is_visible = nfit_visible,
@@ -1346,7 +1346,7 @@ static umode_t acpi_nfit_dimm_attr_visible(struct kobject *kobj,
 	return a->mode;
 }
 
-static struct attribute_group acpi_nfit_dimm_attribute_group = {
+static const struct attribute_group acpi_nfit_dimm_attribute_group = {
 	.name = "nfit",
 	.attrs = acpi_nfit_dimm_attributes,
 	.is_visible = acpi_nfit_dimm_attr_visible,
@@ -1640,7 +1640,7 @@ static ssize_t range_index_show(struct device *dev,
 	NULL,
 };
 
-static struct attribute_group acpi_nfit_region_attribute_group = {
+static const struct attribute_group acpi_nfit_region_attribute_group = {
 	.name = "nfit",
 	.attrs = acpi_nfit_region_attributes,
 };
-- 
1.9.1
