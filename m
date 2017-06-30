From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] acpi: bgrt: constify attribute_group structures.
Date: Fri, 30 Jun 2017 18:06:34 +0530
Message-ID: <2d9795f4a3dbdd0b882737f384e7b11d139435a1.1498826190.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/acpi/bgrt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/bgrt.c b/drivers/acpi/bgrt.c
index df1c629..75af783 100644
--- a/drivers/acpi/bgrt.c
+++ b/drivers/acpi/bgrt.c
@@ -76,7 +76,7 @@ static ssize_t image_read(struct file *file, struct kobject *kobj,
 	NULL,
 };
 
-static struct attribute_group bgrt_attribute_group = {
+static const struct attribute_group bgrt_attribute_group = {
 	.attrs = bgrt_attributes,
 	.bin_attrs = bgrt_bin_attributes,
 };
-- 
1.9.1
