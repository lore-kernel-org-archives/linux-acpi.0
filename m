From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] ACPI / DPTF: constify attribute_group structures.
Date: Fri, 30 Jun 2017 18:32:49 +0530
Message-ID: <f7cd8c13c6585290784161c50ac25a11f421cae3.1498827720.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
    904	    496	      0	   1400	    578	drivers/acpi/dptf/dptf_power.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
    944	    432	      0	   1376	    560	drivers/acpi/dptf/dptf_power.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/acpi/dptf/dptf_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_power.c
index 734642d..e1c2425 100644
--- a/drivers/acpi/dptf/dptf_power.c
+++ b/drivers/acpi/dptf/dptf_power.c
@@ -65,7 +65,7 @@
 	NULL
 };
 
-static struct attribute_group dptf_power_attribute_group = {
+static const struct attribute_group dptf_power_attribute_group = {
 	.attrs = dptf_power_attrs,
 	.name = "dptf_power"
 };
-- 
1.9.1
