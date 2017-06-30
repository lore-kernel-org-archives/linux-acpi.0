From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] ACPI / power: constify attribute_group structures.
Date: Fri, 30 Jun 2017 17:39:05 +0530
Message-ID: <2726b2dee8cf2e4c6fe81bf8833e00c8931e1d59.1498823717.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   4622	    304	      8	   4934	   1346	drivers/acpi/power.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   4846	     80	      8	   4934	   1346	drivers/acpi/power.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/acpi/power.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 3a6c9b7..1b475bc 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -352,7 +352,7 @@ static int acpi_power_on_list(struct list_head *list)
 	NULL,
 };
 
-static struct attribute_group attr_groups[] = {
+static const struct attribute_group attr_groups[] = {
 	[ACPI_STATE_D0] = {
 		.name = "power_resources_D0",
 		.attrs = attrs,
@@ -371,14 +371,14 @@ static int acpi_power_on_list(struct list_head *list)
 	},
 };
 
-static struct attribute_group wakeup_attr_group = {
+static const struct attribute_group wakeup_attr_group = {
 	.name = "power_resources_wakeup",
 	.attrs = attrs,
 };
 
 static void acpi_power_hide_list(struct acpi_device *adev,
 				 struct list_head *resources,
-				 struct attribute_group *attr_group)
+				 const struct attribute_group *attr_group)
 {
 	struct acpi_power_resource_entry *entry;
 
@@ -397,7 +397,7 @@ static void acpi_power_hide_list(struct acpi_device *adev,
 
 static void acpi_power_expose_list(struct acpi_device *adev,
 				   struct list_head *resources,
-				   struct attribute_group *attr_group)
+				   const struct attribute_group *attr_group)
 {
 	struct acpi_power_resource_entry *entry;
 	int ret;
@@ -425,7 +425,7 @@ static void acpi_power_expose_list(struct acpi_device *adev,
 
 static void acpi_power_expose_hide(struct acpi_device *adev,
 				   struct list_head *resources,
-				   struct attribute_group *attr_group,
+				   const struct attribute_group *attr_group,
 				   bool expose)
 {
 	if (expose)
-- 
1.9.1
