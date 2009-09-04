From: Xiaotian Feng <dfeng@redhat.com>
Subject: [PATCH] drivers/acpi: fix memory leak in acpi_device_set_id
Date: Fri,  4 Sep 2009 15:00:19 +0800
Message-ID: <1252047619-2924-1-git-send-email-dfeng@redhat.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933037AbZIDHAM@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: len.brown@intel.com, rui.zhang@intel.com, yakui.zhao@intel.com, bjorn.helgaas@hp.com, ak@linux.intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Xiaotian Feng <dfeng@redhat.com>
List-Id: linux-acpi@vger.kernel.org

In acpi_device_set_id, if cid_list is allocated by ACPI_ALLOCATE_ZEROED,
it is never freed. This patch fixes the memory leak. 

Signed-off-by: Xiaotian Feng <dfeng@redhat.com>
---
 drivers/acpi/scan.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 781435d..a0102ad 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1010,6 +1010,7 @@ static void acpi_device_set_id(struct acpi_device *device,
 	struct acpi_compatible_id_list *cid_list = NULL;
 	const char *cid_add = NULL;
 	acpi_status status;
+	int free_cid_list = 0;
 
 	switch (type) {
 	case ACPI_BUS_TYPE_DEVICE:
@@ -1098,6 +1099,7 @@ static void acpi_device_set_id(struct acpi_device *device,
 				kfree(buffer.pointer);
 				return;
 			} else {
+				free_cid_list = 1;
 				cid_list->count = 0;
 				cid_list->size = size;
 			}
@@ -1124,6 +1126,8 @@ static void acpi_device_set_id(struct acpi_device *device,
 			printk(KERN_ERR PREFIX "Memory allocation error\n");
 	}
 
+	if (free_cid_list)
+		ACPI_FREE(cid_list);
 	kfree(buffer.pointer);
 }
 
-- 
1.6.2.5
