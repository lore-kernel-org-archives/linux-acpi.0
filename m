From: Daniel Machon <dmachon.dev@gmail.com>
Subject: [PATCH 3/3] ACPI: custom_method.c, osl.c: Fixed coding style issues.
Date: Sun, 5 Jul 2015 20:03:37 +0200
Message-ID: <20150705180330.GA11479@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, danielmachon@live.dk
List-Id: linux-acpi@vger.kernel.org

Fixed coding style issues.

Signed-off-by: Daniel Machon <dmachon.dev@gmail.com>
---
 drivers/acpi/custom_method.c |  2 +-
 drivers/acpi/osl.c           | 32 ++++++++++++++++----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index c68e724..d0ae76c 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -19,7 +19,7 @@ static struct dentry *cm_dentry;
 
 /* /sys/kernel/debug/acpi/custom_method */
 
-static ssize_t cm_write(struct file *file, const char __user * user_buf,
+static ssize_t cm_write(struct file *file, const char __user *user_buf,
 			size_t count, loff_t *ppos)
 {
 	static char *buf;
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index c262e4a..65b3847 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -519,7 +519,7 @@ EXPORT_SYMBOL(acpi_os_unmap_generic_address);
 
 #ifdef ACPI_FUTURE_USAGE
 acpi_status
-acpi_os_get_physical_address(void *virt, acpi_physical_address * phys)
+acpi_os_get_physical_address(void *virt, acpi_physical_address *phys)
 {
 	if (!phys || !virt)
 		return AE_BAD_PARAMETER;
@@ -725,8 +725,8 @@ static void acpi_table_taint(struct acpi_table_header *table)
 
 
 acpi_status
-acpi_os_table_override(struct acpi_table_header * existing_table,
-		       struct acpi_table_header ** new_table)
+acpi_os_table_override(struct acpi_table_header *existing_table,
+		       struct acpi_table_header **new_table)
 {
 	if (!existing_table || !new_table)
 		return AE_BAD_PARAMETER;
@@ -900,7 +900,7 @@ u64 acpi_os_get_timer(void)
 	return time_ns;
 }
 
-acpi_status acpi_os_read_port(acpi_io_address port, u32 * value, u32 width)
+acpi_status acpi_os_read_port(acpi_io_address port, u32 *value, u32 width)
 {
 	u32 dummy;
 
@@ -1057,7 +1057,7 @@ acpi_os_write_memory(acpi_physical_address phys_addr, u64 value, u32 width)
 }
 
 acpi_status
-acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
+acpi_os_read_pci_configuration(struct acpi_pci_id *pci_id, u32 reg,
 			       u64 *value, u32 width)
 {
 	int result, size;
@@ -1085,11 +1085,11 @@ acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 				reg, size, &value32);
 	*value = value32;
 
-	return (result ? AE_ERROR : AE_OK);
+	return result ? AE_ERROR : AE_OK;
 }
 
 acpi_status
-acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
+acpi_os_write_pci_configuration(struct acpi_pci_id *pci_id, u32 reg,
 				u64 value, u32 width)
 {
 	int result, size;
@@ -1112,7 +1112,7 @@ acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 				PCI_DEVFN(pci_id->device, pci_id->function),
 				reg, size, value);
 
-	return (result ? AE_ERROR : AE_OK);
+	return result ? AE_ERROR : AE_OK;
 }
 
 static void acpi_os_execute_deferred(struct work_struct *work)
@@ -1258,7 +1258,7 @@ bool acpi_queue_hotplug_work(struct work_struct *work)
 }
 
 acpi_status
-acpi_os_create_semaphore(u32 max_units, u32 initial_units, acpi_handle * handle)
+acpi_os_create_semaphore(u32 max_units, u32 initial_units, acpi_handle *handle)
 {
 	struct semaphore *sem = NULL;
 
@@ -1752,7 +1752,7 @@ void acpi_os_release_lock(acpi_spinlock lockp, acpi_cpu_flags flags)
  ******************************************************************************/
 
 acpi_status
-acpi_os_create_cache(char *name, u16 size, u16 depth, acpi_cache_t ** cache)
+acpi_os_create_cache(char *name, u16 size, u16 depth, acpi_cache_t **cache)
 {
 	*cache = kmem_cache_create(name, size, 0, 0, NULL);
 	if (*cache == NULL)
@@ -1773,10 +1773,10 @@ acpi_os_create_cache(char *name, u16 size, u16 depth, acpi_cache_t ** cache)
  *
  ******************************************************************************/
 
-acpi_status acpi_os_purge_cache(acpi_cache_t * cache)
+acpi_status acpi_os_purge_cache(acpi_cache_t *cache)
 {
 	kmem_cache_shrink(cache);
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -1792,10 +1792,10 @@ acpi_status acpi_os_purge_cache(acpi_cache_t * cache)
  *
  ******************************************************************************/
 
-acpi_status acpi_os_delete_cache(acpi_cache_t * cache)
+acpi_status acpi_os_delete_cache(acpi_cache_t *cache)
 {
 	kmem_cache_destroy(cache);
-	return (AE_OK);
+	return AE_OK;
 }
 
 /*******************************************************************************
@@ -1812,10 +1812,10 @@ acpi_status acpi_os_delete_cache(acpi_cache_t * cache)
  *
  ******************************************************************************/
 
-acpi_status acpi_os_release_object(acpi_cache_t * cache, void *object)
+acpi_status acpi_os_release_object(acpi_cache_t *cache, void *object)
 {
 	kmem_cache_free(cache, object);
-	return (AE_OK);
+	return AE_OK;
 }
 #endif
 
-- 
2.1.4
