From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH] /sys/firmware/acpi/memory/ for showing info of ACPI
 memory object
Date: Fri, 24 Sep 2004 17:46:53 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040924174653.0e005486.tokunaga.keiich@jp.fujitsu.com>
References: <FEB6C4E97F6CAF41978FB2059D5454180F37E8@bgsmsx402.gar.corp.intel.com>
 <20040910230200.73eb0374.tokunaga.keiich@jp.fujitsu.com>
 <20040916194725.562b50f0.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20040916194725.562b50f0.tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org, haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org, matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 16 Sep 2004 19:47:25 +0900 Keiichiro Tokunaga wrote:
> On Fri, 10 Sep 2004 23:02:00 +0900 Keiichiro Tokunaga wrote:
> > On Thu, 09 Sep 2004 16:24:46 +0530 S, Naveen B wrote:
> > > Attached is an ACPI based hot plug driver patch to support physical
> > > memory hotplug. This driver supports physical hotplug operation on
> > > memory, fields notifications from firmware and notifies the VM of the
> > > affected memory ranges.  The following patch is against kernel
> > > 2.6.8.1-mm3, and works with the current memory hotplug VM patches
> > > posted at: http://sprucegoose.sr71.net/patches.  This patch has been
> > > tested on real prototype hardware in the hot-add memory case. Hot
> > > remove feature is tested in an emulated environment (by overriding
> > > ACPI DSDT). 
> > > 
> > > Please review and consider for inclusion. 
> > 
> > I would like to add a feature into drivers/acpi/memory.c.
> > 
> > Please see the patch below.  This patch is for the kernel applying
> > your patch.
> 
> I have changed the patch to create directories and files in
> /sys/firmware/acpi/memory/ from Dave's comments.  The files are
> to export the following stuffs of each ACPI memory object for the
> first version.

I have updated the patch to show just information in real need.

  o min_address_range
  o max_address_range

This patch is still for 2.6.8.1-mm3.
Naveen, if I need to update the patch, please let me know.

Thanks,
Keiichiro Tokunaga

Name: sysfs_memory.patch
Status: Tested on 2.6.8.1-mm3
Signed-off-by: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Description:
This patch is to create directory '/sys/firmware/acpi/memory/',
directories for each ACPI memory object, and files under it.  These
files are to export information of ACPI memory object.  This version
just creates two files an ACPI memory object, min_address_range and
max_address_range.  What it looks like is:
/sys/firmware/acpi/memory/MEM0/min_address_range, where MEM0 is an
ACPI memory object name.


---

 drivers/acpi/memory.c |  199 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 194 insertions(+), 5 deletions(-)

diff -puN drivers/acpi/memory.c~sysfs_memory drivers/acpi/memory.c
--- linux-2.6.8.1-mm3/drivers/acpi/memory.c~sysfs_memory	2004-09-16 10:19:00.000000000 +0900
+++ linux-2.6.8.1-mm3-kei/drivers/acpi/memory.c	2004-09-24 17:31:13.000000000 +0900
@@ -69,6 +69,15 @@ static struct acpi_driver acpi_memory_de
 			},
 };
 
+struct acpi_mem {
+	struct acpi_mem_device_ops	*ops;
+	void (*release)(struct acpi_mem *mdev);
+	struct kobject			kobj;
+};
+
+#define to_acpi_mem(n) container_of(n, struct acpi_mem, kobj)
+#define acpi_mem_to_dev(n) container_of(n, struct acpi_memory_device, amem)
+
 struct acpi_memory_device {
 	acpi_handle handle;	
 	unsigned int state;		/* State of the memory device */
@@ -76,8 +85,171 @@ struct acpi_memory_device {
 	unsigned short read_write_attribute;/* memory read/write attribute */
 	u64 start_addr;	/* Memory Range start physical addr */
 	u64 end_addr;	/* Memory Range end physical addr */
+	struct acpi_resource resource;
+	struct acpi_mem amem;
+};
+
+/*
+ * /sys/firmware/acpi/memory/
+ */
+struct acpi_mem_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct acpi_mem *, char *);
+	ssize_t (*store)(struct acpi_mem *, const char *, size_t);
+};
+
+#define to_acpi_mem_attr(n) container_of(n, struct acpi_mem_attribute, attr)
+
+static ssize_t acpi_mem_attr_show(struct kobject *kobj,
+				  struct attribute *attr, char *buf)
+{
+	struct acpi_mem *amem = to_acpi_mem(kobj);
+	struct acpi_mem_attribute *attribute = to_acpi_mem_attr(attr);
+	return attribute->show ? attribute->show(amem, buf) : 0;
+}
+
+static ssize_t acpi_mem_attr_store(struct kobject *kobj,
+				   struct attribute *attr, const char *buf,
+				   size_t len)
+{
+	struct acpi_mem *amem = to_acpi_mem(kobj);
+	struct acpi_mem_attribute *attribute = to_acpi_mem_attr(attr);
+	return attribute->store ? attribute->store(amem, buf, len) : 0;
+}
+
+static struct sysfs_ops acpi_mem_sysfs_ops = {
+	.show = acpi_mem_attr_show,
+	.store = acpi_mem_attr_store,
+};
+
+static void acpi_mem_release(struct kobject *kobj)
+{
+	sysfs_remove_dir(kobj);
+	if (kobj->kset) {
+		down_write(&kobj->kset->subsys->rwsem);
+		list_del_init(&kobj->entry);
+		up_write(&kobj->kset->subsys->rwsem);
+	}
+}
+
+static struct kobj_type acpi_mem_ktype = {
+	.sysfs_ops = &acpi_mem_sysfs_ops,
+	.release = &acpi_mem_release,
 };
 
+static decl_subsys_name(acpi_mem, memory, &acpi_mem_ktype, NULL);
+
+static int acpi_mem_register(struct acpi_mem *amem)
+{
+	return kobject_register(&amem->kobj);
+}
+
+int create_acpi_mem(struct acpi_memory_device *mem_device,
+			   struct acpi_device *device)
+{
+	int result;
+	struct acpi_mem *amem = &mem_device->amem;
+
+	ACPI_FUNCTION_TRACE("create_acpi_mem");
+
+	memset(amem, 0, sizeof(struct acpi_mem));
+	kobject_set_name(&amem->kobj, device->pnp.bus_id);
+	kobj_set_kset_s(amem, acpi_mem_subsys);
+	amem->kobj.parent = &acpi_mem_subsys.kset.kobj;
+
+	result = acpi_mem_register(amem);
+	if (result)
+		goto end;
+end:
+	return_VALUE(result);
+}
+
+int acpi_mem_fs_init(void)
+{
+	int result;
+	extern struct subsystem acpi_subsys;
+
+	ACPI_FUNCTION_TRACE("acpi_mem_fs_init");
+
+	acpi_mem_subsys.kset.kobj.parent = &acpi_subsys.kset.kobj;
+	result = subsystem_register(&acpi_mem_subsys);
+
+	return_VALUE(result);
+}
+
+void acpi_mem_fs_exit(void)
+{
+	ACPI_FUNCTION_TRACE("acpi_mem_fs_exit");
+
+	subsystem_unregister(&acpi_mem_subsys);
+
+	return_VOID;
+}
+
+static int get_address64(struct acpi_mem *amem,
+			 struct acpi_resource_address64 *address64)
+{
+	struct acpi_memory_device	*mem_device = acpi_mem_to_dev(amem);
+	struct acpi_resource		*resource;
+
+	if (!mem_device)
+		return -ENODEV;
+
+	resource = &mem_device->resource;
+
+	acpi_resource_to_address64(resource, address64);
+
+	if (address64->resource_type != ACPI_MEMORY_RANGE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static ssize_t min_address_range_read_file(struct acpi_mem *amem, char *buf)
+{
+	int result;
+	struct acpi_resource_address64 address64;
+
+	result = get_address64(amem, &address64);
+	if (result)
+		return result;
+
+	result = sprintf(buf, "0x%llx\n", address64.min_address_range);
+
+	return result;
+}
+
+static struct acpi_mem_attribute acpi_mem_attr_min_address_range = {
+	.attr = {.name = "min_address_range", .mode = S_IFREG | S_IRUGO},
+	.show = min_address_range_read_file,
+};
+
+static ssize_t max_address_range_read_file(struct acpi_mem *amem, char *buf)
+{
+	int result;
+	struct acpi_resource_address64 address64;
+
+	result = get_address64(amem, &address64);
+	if (result)
+		return result;
+
+	result = sprintf(buf, "0x%llx\n", address64.max_address_range);
+
+	return result;
+}
+
+static struct acpi_mem_attribute acpi_mem_attr_max_address_range = {
+	.attr = {.name = "max_address_range", .mode = S_IFREG | S_IRUGO},
+	.show = max_address_range_read_file,
+};
+
+static int fs_add_memory(struct acpi_mem *amem)
+{
+	sysfs_create_file(&amem->kobj, &acpi_mem_attr_min_address_range.attr);
+	sysfs_create_file(&amem->kobj, &acpi_mem_attr_max_address_range.attr);
+
+	return 0;
+}
 
 static int 
 acpi_memory_get_device_resources(struct acpi_memory_device *mem_device) 
@@ -97,6 +269,7 @@ acpi_memory_get_device_resources(struct 
 		return_VALUE(-EINVAL);
 
 	resource = (struct acpi_resource *) buffer.pointer;
+	mem_device->resource = *resource;
 		
 	switch (resource->id) {
 	case ACPI_RSTYPE_ADDRESS16:
@@ -413,17 +586,26 @@ acpi_memory_device_add(struct acpi_devic
 
 	/* Get the range from the _CRS */
 	result = acpi_memory_get_device_resources(mem_device);
-	if (result) {
-		kfree(mem_device);
-		return_VALUE(result);
-	}
-		
+	if (result)
+		goto errout;
+
+	result = create_acpi_mem(mem_device, device);
+	if (result)
+		goto errout;
+
+	result = fs_add_memory(&mem_device->amem);
+	if (result)
+		goto errout;
+
 	/* Set the device state */
 	mem_device->state = MEMORY_POWER_ON_STATE;
 
 	printk(KERN_INFO "%s \n", acpi_device_name(device));
 
 	return_VALUE(result);
+errout:
+	kfree(mem_device);
+	return_VALUE(result);
 }
 
 static int 
@@ -527,6 +709,10 @@ acpi_memory_device_init (void)
 
 	ACPI_FUNCTION_TRACE("acpi_memory_device_init");
 
+	result = acpi_mem_fs_init();
+	if (result)
+		return_VALUE(-ENODEV);
+
 	result = acpi_bus_register_driver(&acpi_memory_device_driver);
 
 	if (result < 0) 
@@ -540,6 +726,7 @@ acpi_memory_device_init (void)
 	if (ACPI_FAILURE (status)) {
 		ACPI_DEBUG_PRINT ((ACPI_DB_ERROR, "walk_namespace failed\n"));
 		acpi_bus_unregister_driver(&acpi_memory_device_driver);
+		acpi_mem_fs_exit();
 		return_VALUE(-ENODEV);
         }
 
@@ -567,6 +754,8 @@ acpi_memory_device_exit (void)
 
 	acpi_bus_unregister_driver(&acpi_memory_device_driver);
 
+	acpi_mem_fs_exit();
+
 	return_VOID;
 }
 

_


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
