From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: IDE _GTM/_STM support
Date: Sun, 22 May 2005 23:35:24 +0100
Message-ID: <1116801324.29662.50.camel@tyrosine>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-+s5wm4RI5TVQwGrOdHQL"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--=-+s5wm4RI5TVQwGrOdHQL
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

Here's a lightly modified version of a patch Shaohua sent me. It does
the following:

* Calls _GTM on suspend
* Passes that information to _STM on resume
* Calls _GTF, but does *not* do anything with that information

With _GTM and _STM support, my HP nc6220 survives a suspend/resume
cycle. If I uncomment the taskfile call in the _GTF routine, the machine
freezes when it tries to perform the first taskfile write. I'm assuming
that an IDE guru needs to take a closer look at what's going on there
(it freezes at wait_for_completion in ide_do_drive_cmd).

Anyway, even without _GTF support, it looks like this patch fixes S3 on
at least some hardware. Patch is against 2.6.12-rc4-mm2.
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org

--=-+s5wm4RI5TVQwGrOdHQL
Content-Disposition: attachment; filename=ide.diff
Content-Type: text/x-patch; name=ide.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -ur linux-source-2.6.12-2.6.11.92.pristine/drivers/ide/ide.c linux-source-2.6.12-2.6.11.92/drivers/ide/ide.c
--- linux-source-2.6.12-2.6.11.92.pristine/drivers/ide/ide.c	2005-05-22 22:52:40.000000000 +0100
+++ linux-source-2.6.12-2.6.11.92/drivers/ide/ide.c	2005-05-22 22:55:23.000000000 +0100
@@ -1215,6 +1215,237 @@
 
 EXPORT_SYMBOL(system_bus_clock);
 
+#if 1
+#include <linux/acpi.h>
+#define DBG(x...) printk(x)
+static int ide_acpi_find_device(struct device *dev, acpi_handle *handle)
+{
+	int i, tmp;
+	acpi_integer addr;
+
+	if (sscanf(dev->bus_id, "%u.%u", &tmp, &i) != 2)
+		return -ENODEV;
+
+	addr = i;
+	*handle = acpi_get_child(DEVICE_ACPI_HANDLE(dev->parent), addr);
+	if (!*handle)
+		return -ENODEV;
+	return 0;
+}
+
+/* This assumes the ide controller is a PCI device */
+static int ide_acpi_find_channel(struct device *dev, acpi_handle *handle)
+{
+	int num;
+	int channel;
+	acpi_integer addr;
+
+	num = sscanf(dev->bus_id, "ide%x", &channel);
+
+	if (num != 1 || !dev->parent)
+		return -ENODEV;
+	addr = channel;
+	*handle = acpi_get_child(DEVICE_ACPI_HANDLE(dev->parent), addr);
+	if (!*handle)
+		return -ENODEV;
+	return 0;
+}
+
+static struct acpi_bus_type ide_acpi_bus = {
+	.bus = &ide_bus_type,
+	.find_device = ide_acpi_find_device,
+	.find_bridge = ide_acpi_find_channel,
+};
+
+static int __init ide_acpi_init(void)
+{
+	return register_acpi_bus_type(&ide_acpi_bus);
+}
+
+#define MAX_DEVICES 10
+#define GTM_LEN (sizeof(u32) * 5)
+static struct acpi_ide_stat {
+	acpi_handle handle; /* channel device's handle */
+	u32	gtm[GTM_LEN/sizeof(u32)]; /* info from _GTM */
+	struct hd_driveid id_buff[2];
+	int channel_handled;
+} device_state[MAX_DEVICES];
+
+static struct acpi_ide_stat *ide_get_acpi_state(acpi_handle handle)
+{
+	int i;
+	for (i = 0; i < MAX_DEVICES; i ++)
+		if (device_state[i].handle == handle)
+			break;
+	if (i < MAX_DEVICES)
+		return &device_state[i];
+	for (i = 0; i < MAX_DEVICES; i ++)
+		if (device_state[i].handle == NULL)
+			break;
+	if (i >= MAX_DEVICES)
+		return NULL;
+
+	memset(&device_state[i], 0, sizeof(struct acpi_ide_stat));
+	return &device_state[i];
+}
+
+int acpi_ide_suspend(struct device *dev)
+{
+	acpi_handle handle, parent_handle;
+	struct acpi_ide_stat *stat;
+	acpi_status	status;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *package;
+	ide_drive_t *drive = dev->driver_data;
+	int drive_id = 0;
+
+	handle = DEVICE_ACPI_HANDLE(dev);
+	if (!handle) {
+		DBG("IDE device ACPI handler is NULL\n");
+		return -ENODEV;
+	}
+	if (ACPI_FAILURE(acpi_get_parent(handle, &parent_handle))) {
+		printk(KERN_ERR "ACPI get parent handler error\n");
+		return -ENODEV;
+	}
+	stat = ide_get_acpi_state(parent_handle);
+	if (stat == NULL)
+		return -ENODEV;
+	if (stat->channel_handled) {
+		drive_id = 1;
+		goto id;
+	}
+
+	status = acpi_evaluate_object(parent_handle, "_GTM", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR "Error evaluating _GTM\n");
+		return -ENODEV;
+	}
+	package = (union acpi_object *) buffer.pointer;
+	if (package->buffer.length != GTM_LEN) {
+		printk(KERN_ERR "Buffer length returned by _GTM is wrong\n");
+		acpi_os_free(buffer.pointer);
+		return -ENODEV;
+	}
+	memcpy(stat->gtm, package->buffer.pointer, GTM_LEN);
+	stat->handle = parent_handle;
+	stat->channel_handled = 1;
+	acpi_os_free(buffer.pointer);
+id:
+	taskfile_lib_get_identify(drive, &stat->id_buff[drive_id]);
+	DBG("GTM info %x,%x,%x,%x,%x\n", stat->gtm[0],
+		stat->gtm[1], stat->gtm[2],
+		stat->gtm[3], stat->gtm[4]);
+	return 0;
+}
+
+static int acpi_ide_stm(struct acpi_ide_stat *stat)
+{
+	struct acpi_object_list input;
+	union acpi_object params[3];
+	acpi_status status;
+
+	input.count = 3;
+	input.pointer = params;
+	params[0].type = ACPI_TYPE_BUFFER;
+	params[0].buffer.length = sizeof(stat->gtm);
+	params[0].buffer.pointer = (char*)stat->gtm;
+
+	params[1].type = ACPI_TYPE_BUFFER;
+	params[1].buffer.length = sizeof(stat->id_buff[0]);
+	params[1].buffer.pointer = (char *)&stat->id_buff[0];
+
+	params[2].type = ACPI_TYPE_BUFFER;
+	params[2].buffer.length = sizeof(stat->id_buff[1]);
+	params[2].buffer.pointer = (char *)&stat->id_buff[1];
+
+	status = acpi_evaluate_object(stat->handle, "_STM", &input, NULL);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR "Evaluating _STM error\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static int acpi_ide_gtf(acpi_handle handle, ide_drive_t *drive)
+{
+	struct acpi_buffer	output = {ACPI_ALLOCATE_BUFFER, NULL};
+	ide_task_t	args;
+	int index = 0;
+	unsigned char *data;
+	union acpi_object	*package = NULL;
+	acpi_status status;
+
+	status = acpi_evaluate_object(handle, "_GTF", NULL, &output);
+	if (ACPI_FAILURE(status)) {
+		printk(KERN_ERR "evaluate _GTF error\n");
+		return -ENODEV;
+	}
+	package = (union acpi_object *) output.pointer;
+	if (package->type != ACPI_TYPE_BUFFER
+		|| (package->buffer.length % 7) != 0) {
+		acpi_os_free(output.pointer);
+		printk(KERN_ERR "_GTF returned value is wrong\n");
+		return -ENODEV;
+	}
+	printk("start GTF\n");
+
+	data = package->buffer.pointer;
+	while (index < package->buffer.length) {
+		memset(&args, 0, sizeof(ide_task_t));
+		args.tfRegister[IDE_ERROR_OFFSET] = data[index];
+		args.tfRegister[IDE_NSECTOR_OFFSET] = data[index + 1];
+		args.tfRegister[IDE_SECTOR_OFFSET] = data[index + 2];
+		args.tfRegister[IDE_LCYL_OFFSET] = data[index + 3];
+		args.tfRegister[IDE_HCYL_OFFSET] = data[index + 4];
+		args.tfRegister[IDE_SELECT_OFFSET] = data[index + 5];
+		args.tfRegister[IDE_STATUS_OFFSET] = data[index + 6];
+		args.command_type = IDE_DRIVE_TASK_NO_DATA;
+		args.handler = &task_no_data_intr;
+		printk("data %x,%x,%x,%x,%x,%x,%x\n",
+			data[index], data[index+1], data[index+2],
+			data[index+3],data[index+4],data[index+5],
+			data[index+6]);
+		/* submit command request */
+//		printk("return value %d\n", ide_raw_taskfile(drive, &args, NULL));
+		index += 7;
+	}
+	acpi_os_free(output.pointer);
+	return 0;
+}
+
+int acpi_ide_resume(struct device *dev)
+{
+	acpi_handle handle, parent_handle;
+	struct acpi_ide_stat *stat;
+	ide_drive_t *drive = dev->driver_data;
+
+	handle = DEVICE_ACPI_HANDLE(dev);
+	if (!handle) {
+		DBG("IDE device ACPI handler is NULL\n");
+		return -ENODEV;
+	}
+	if (ACPI_FAILURE(acpi_get_parent(handle, &parent_handle))) {
+		printk(KERN_ERR "ACPI get parent handler error\n");
+		return -ENODEV;
+	}
+	stat = ide_get_acpi_state(parent_handle);
+	if (stat == NULL || stat->handle != parent_handle)
+		return -ENODEV;
+
+	if (stat->channel_handled == 0) {
+		stat->handle = NULL;
+		goto gtf;
+	}
+DBG("Start STM\n");
+	if (acpi_ide_stm(stat))
+		return -ENODEV;
+	stat->channel_handled = 0;
+gtf:
+	return acpi_ide_gtf(handle, drive);
+}
+#endif
+
 static int generic_ide_suspend(struct device *dev, pm_message_t state)
 {
 	ide_drive_t *drive = dev->driver_data;
@@ -1230,7 +1461,7 @@
 	rq.pm = &rqpm;
 	rqpm.pm_step = ide_pm_state_start_suspend;
 	rqpm.pm_state = state;
-
+acpi_ide_suspend(dev);
 	return ide_do_drive_cmd(drive, &rq, ide_wait);
 }
 
@@ -1240,7 +1471,7 @@
 	struct request rq;
 	struct request_pm_state rqpm;
 	ide_task_t args;
-
+	acpi_ide_resume(dev);
 	memset(&rq, 0, sizeof(rq));
 	memset(&rqpm, 0, sizeof(rqpm));
 	memset(&args, 0, sizeof(args));
@@ -1923,6 +2154,7 @@
 	devfs_mk_dir("ide");
 	system_bus_speed = ide_system_bus_speed();
 
+ide_acpi_init();
 	bus_register(&ide_bus_type);
 
 	init_ide_data();
Only in linux-source-2.6.12-2.6.11.92/drivers/ide/: ide.c.orig

--=-+s5wm4RI5TVQwGrOdHQL--



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
