From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] Video Extension patch
Date: Thu, 26 Aug 2004 18:19:25 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F84054F41CE@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

All,
Since Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> has implemented acpi video
extension filed at bug 1944.
I made some improvement against his code.=20

The patch [1/2] posted here is the original implementation of video
extension written by Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org> .
The patch [2/2] posted here is my patch on top of the patch [1/2].=20
Please give it a review, and have it a try.

Thanks=20
Luming

--- linux-2.6.3-bk-acpi/drivers/acpi/Kconfig	2004/02/12 18:31:36
1.1
+++ linux-2.6.3-bk-acpi/drivers/acpi/Kconfig	2004/02/12 18:40:27
@@ -110,6 +110,20 @@ config ACPI_BUTTON
 	  down the system.  Until then, you can cat it, and see output
when
 	  a button is pressed.
=20
+config ACPI_VIDEO
+	tristate "Video"
+	depends on ACPI_INTERPRETER
+	depends on !IA64_SGI_SN
+	default m
+	help
+	  This driver implement the ACPI Extensions For Display Adapters
+	  for integrated graphics devices on motherboard, as specified
in
+	  ACPI 2.0 Specification, Appendix B, allowing to perform some
basic
+	  control like defining the video POST device, retrieving EDID
information
+	  or to setup a video output, etc.
+	  Note that this is an ref. implementation only.  It may or may
not work
+	  for your integrated video device.
+
 config ACPI_FAN
 	tristate "Fan"
 	depends on ACPI_INTERPRETER
--- linux-2.6.3-bk-acpi/drivers/acpi/Makefile	2004/02/12 18:31:26
1.1
+++ linux-2.6.3-bk-acpi/drivers/acpi/Makefile	2004/02/12 18:41:13
@@ -38,6 +38,7 @@ obj-$(CONFIG_ACPI_BATTERY)	+=3D battery.o
 obj-$(CONFIG_ACPI_BUTTON)	+=3D button.o
 obj-$(CONFIG_ACPI_EC)		+=3D ec.o
 obj-$(CONFIG_ACPI_FAN)		+=3D fan.o
+obj-$(CONFIG_ACPI_VIDEO)	+=3D video.o
 obj-$(CONFIG_ACPI_PCI)		+=3D pci_root.o pci_link.o pci_irq.o
pci_bind.o
 obj-$(CONFIG_ACPI_POWER)	+=3D power.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+=3D processor.o
--- linux-2.6.3-bk-acpi/drivers/acpi/scan.c	2004/02/09 22:02:43
1.1
+++ linux-2.6.3-bk-acpi/drivers/acpi/scan.c	2004/02/10 01:38:27
@@ -198,6 +198,11 @@ acpi_bus_match (
 	int error =3D 0;
 	struct acpi_buffer buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
=20
+	if (driver->ops.match) {
+		error =3D driver->ops.match(device, driver);
+		goto Done;
+	}
+
 	if (device->flags.hardware_id)
 		if (strstr(driver->ids, device->pnp.hardware_id))
 			goto Done;
--- /dev/null	2004-01-23 16:06:49.000000000 +0100
+++ linux-2.6.3-bk-acpi/drivers/acpi/video.c	2004-02-12
20:14:18.000000000 +0100
@@ -0,0 +1,1489 @@
+/*
+ *  video.c - ACPI Video Driver ($Revision:$)
+ *
+ *  Copyright (C) 2004 Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
+ *
+ *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~
+ *
+ *  This program is free software; you can redistribute it and/or
modify
+ *  it under the terms of the GNU General Public License as published
by
+ *  the Free Software Foundation; either version 2 of the License, or
(at
+ *  your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but
+ *  WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
along
+ *  with this program; if not, write to the Free Software Foundation,
Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
+ *
+ *
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/list.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+
+#include <asm/uaccess.h>
+
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+
+#define ACPI_VIDEO_COMPONENT		0x08000000
+#define ACPI_VIDEO_CLASS		"video"
+#define ACPI_VIDEO_DRIVER_NAME		"ACPI Video Driver"
+#define ACPI_VIDEO_BUS_NAME		"Video Bus"
+#define ACPI_VIDEO_DEVICE_NAME		"Video Device"
+#define ACPI_VIDEO_NOTIFY_SWITCH	0x80
+#define ACPI_VIDEO_NOTIFY_PROBE		0x81
+
+#define ACPI_VIDEO_HEAD_INVALID		(~0ul - 1)
+#define ACPI_VIDEO_HEAD_END		(~0ul)
+
+
+#define _COMPONENT		ACPI_VIDEO_COMPONENT
+ACPI_MODULE_NAME		("acpi_video")
+
+MODULE_AUTHOR("Bruno Ducrot");
+MODULE_DESCRIPTION(ACPI_VIDEO_DRIVER_NAME);
+MODULE_LICENSE("GPL");
+
+static int acpi_video_bus_add (struct acpi_device *device);
+static int acpi_video_bus_remove (struct acpi_device *device, int
type);
+static int acpi_video_bus_match (struct acpi_device *device, struct
acpi_driver *driver);
+
+
+static struct acpi_driver acpi_video_bus =3D {
+	.name =3D		ACPI_VIDEO_DRIVER_NAME,
+	.class =3D	ACPI_VIDEO_CLASS,
+	.ops =3D		{
+				.add =3D		acpi_video_bus_add,
+				.remove =3D	acpi_video_bus_remove,
+				.match =3D	acpi_video_bus_match,
+			},
+};
+
+struct acpi_video_bus_flags {
+	u8			multihead:1;	/* can switch video
heads */
+	u8			rom:1;		/* can retrieve a video
rom */
+	u8			post:1;		/* can configure the
head to
+						 * be POSTed at boot */
+	u8			reserved:5;
+};
+
+struct acpi_video_bus {
+	acpi_handle		handle;
+	unsigned long		*device_ids;
+	struct acpi_video_bus_flags flags;
+	struct semaphore	sem;
+	struct list_head	video_driver_list;
+	struct proc_dir_entry	*dir;
+};
+
+struct acpi_video_device_flags {
+	u8			crt:1;
+	u8			lcd:1;
+	u8			tvout:1;
+	u8			bios:1;
+	u8			unknown:1;
+	u8			reserved:3;
+};
+
+struct acpi_video_device_brightness {
+	int			curr;
+	int			count;
+	int			*levels;
+};
+
+struct acpi_video_device {
+	acpi_handle		handle;
+	unsigned long		device_id;
+	struct acpi_video_device_flags	flags;
+	struct list_head	entry;
+	struct acpi_video_bus	*video;
+	struct acpi_device	*dev;
+	struct acpi_video_device_brightness *brightness;
+};
+
+
+/* bus */
+static int acpi_video_bus_info_open_fs(struct inode *inode, struct file
*file);
+static struct file_operations acpi_video_bus_info_fops =3D {
+	.open		=3D acpi_video_bus_info_open_fs,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+};
+
+static int acpi_video_bus_ROM_open_fs(struct inode *inode, struct file
*file);
+static struct file_operations acpi_video_bus_ROM_fops =3D {
+	.open		=3D acpi_video_bus_ROM_open_fs,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+};
+
+static int acpi_video_bus_POST_info_open_fs(struct inode *inode, struct
file *file);
+static struct file_operations acpi_video_bus_POST_info_fops =3D {
+	.open		=3D acpi_video_bus_POST_info_open_fs,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+};
+
+static int acpi_video_bus_POST_open_fs(struct inode *inode, struct file
*file);
+static struct file_operations acpi_video_bus_POST_fops =3D {
+	.open		=3D acpi_video_bus_POST_open_fs,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+};
+
+
+/* device */
+static int acpi_video_device_info_open_fs(struct inode *inode, struct
file *file);
+static struct file_operations acpi_video_device_info_fops =3D {
+	.open		=3D acpi_video_device_info_open_fs,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+};
+
+static int acpi_video_device_state_open_fs(struct inode *inode, struct
file *file);
+static struct file_operations acpi_video_device_state_fops =3D {
+	.open		=3D acpi_video_device_state_open_fs,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+};
+
+static int acpi_video_device_brightness_open_fs(struct inode *inode,
struct file *file);
+static struct file_operations acpi_video_device_brightness_fops =3D {
+	.open		=3D acpi_video_device_brightness_open_fs,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+};
+
+static int acpi_video_device_EDID_open_fs(struct inode *inode, struct
file *file);
+static struct file_operations acpi_video_device_EDID_fops =3D {
+	.open		=3D acpi_video_device_EDID_open_fs,
+	.read		=3D seq_read,
+	.llseek		=3D seq_lseek,
+	.release	=3D single_release,
+};
+
+
+
+/*
------------------------------------------------------------------------
--
+                               Video Management
+
------------------------------------------------------------------------
-- */
+
+/* device */
+
+static int
+acpi_video_device_query (
+	struct acpi_video_device	*device,
+	unsigned long			*state)
+{
+	int			status;
+	ACPI_FUNCTION_TRACE("acpi_video_device_query");
+	status =3D acpi_evaluate_integer(device->handle, "_DGS", NULL,
state);
+
+	return_VALUE(status);
+}
+
+static int
+acpi_video_device_get_state (
+	struct acpi_video_device	*device,
+	unsigned long			*state)
+{
+	int			status;
+	ACPI_FUNCTION_TRACE("acpi_video_device_get_output");
+	status =3D acpi_evaluate_integer(device->handle, "_DCS", NULL,
state);
+
+	return_VALUE(status);
+}
+
+static int
+acpi_video_device_set_state (
+	struct acpi_video_device	*device,
+	int			state)
+{
+	int			status;
+	union acpi_object	arg0 =3D {ACPI_TYPE_INTEGER};
+	struct acpi_object_list	args =3D {1, &arg0};
+
+	ACPI_FUNCTION_TRACE("acpi_video_device_set_output");
+
+	arg0.integer.value =3D state;
+	status =3D acpi_evaluate_integer(device->handle, "_DCS", &args,
NULL);
+
+	return_VALUE(status);
+}
+
+static int
+acpi_video_device_lcd_query_levels (
+	struct acpi_video_device	*device,
+	union acpi_object		**levels)
+{
+	int			status;
+	struct acpi_buffer	buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object	*obj;
+
+
+	ACPI_FUNCTION_TRACE("acpi_video_device_lcd_query_levels");
+
+	*levels =3D NULL;
+
+	status =3D acpi_evaluate_object(device->handle, "_BCL", NULL,
&buffer);
+	if (!ACPI_SUCCESS(status))
+		return_VALUE(status);
+	obj =3D (union acpi_object *) buffer.pointer;
+	if (!obj && (obj->type !=3D ACPI_TYPE_PACKAGE)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _BCL
data\n"));
+		status =3D -EFAULT;
+		goto err;
+	}
+
+	*levels =3D obj;
+
+	return_VALUE(0);
+
+err:
+	if (buffer.pointer)
+		kfree(buffer.pointer);
+
+	return_VALUE(status);
+}
+
+static int
+acpi_video_device_lcd_set_level (
+	struct acpi_video_device	*device,
+	int				level)
+{
+	int			status;
+	union acpi_object	arg0 =3D {ACPI_TYPE_INTEGER};
+	struct acpi_object_list	args =3D {1, &arg0};
+
+	ACPI_FUNCTION_TRACE("acpi_video_device_lcd_set_level");
+
+	arg0.integer.value =3D level;
+	status =3D acpi_evaluate_object(device->handle, "_BCM", &args,
NULL);
+
+	printk(KERN_DEBUG "set_level status: %x\n", status);
+	return_VALUE(status);
+}
+
+static int
+acpi_video_device_EDID (
+	struct acpi_video_device	*device,
+	union acpi_object		**edid,
+	ssize_t				length)
+{
+	int			status;
+	struct acpi_buffer	buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object	*obj;
+	union acpi_object	arg0 =3D {ACPI_TYPE_INTEGER};
+	struct acpi_object_list	args =3D {1, &arg0};
+
+	ACPI_FUNCTION_TRACE("acpi_video_device_get_EDID");
+
+	*edid =3D NULL;
+
+	if (!device)
+		return_VALUE(-ENODEV);
+	if (length =3D=3D 128)
+		arg0.integer.value =3D 1;
+	else if (length =3D=3D 256)
+		arg0.integer.value =3D 2;
+	else
+		return_VALUE(-EINVAL);
+
+	status =3D acpi_evaluate_object(device->handle, "_DDC", &args,
&buffer);
+	if (ACPI_FAILURE(status))
+		return_VALUE(-ENODEV);
+
+	obj =3D (union acpi_object *) buffer.pointer;
+
+	if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER)
+		*edid =3D obj;
+	else {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _DDC
data\n"));
+		status =3D -EFAULT;
+		kfree(obj);
+	}
+
+	return_VALUE(status);
+}
+
+
+/* bus */
+static int
+acpi_video_bus_get_rom (
+	struct acpi_video_bus	*video,
+	void			*buffer,
+	ssize_t			len)
+{
+	ACPI_FUNCTION_TRACE("acpi_video_bus_get_rom");
+	printk("not implemented\n");
+	return_VALUE(-ENOENT);
+}
+
+static int
+acpi_video_bus_set_POST (
+	struct acpi_video_bus	*video,
+	unsigned long		option)
+{
+	int			status;
+	unsigned long		tmp;
+	union acpi_object	arg0 =3D {ACPI_TYPE_INTEGER};
+	struct acpi_object_list	args =3D {1, &arg0};
+
+	ACPI_FUNCTION_TRACE("acpi_video_bus_post_set");
+
+	arg0.integer.value =3D option;
+
+	status =3D acpi_evaluate_integer(video->handle, "_SPD", &args,
&tmp);
+	if (ACPI_SUCCESS(status))
+		status =3D tmp ? (-EINVAL):(AE_OK);
+
+	return_VALUE(status);
+}
+
+static int
+acpi_video_bus_get_POST (
+	struct acpi_video_bus	*video,
+	unsigned long		*id)
+{
+	int status;
+
+	ACPI_FUNCTION_TRACE("acpi_video_bus_post_get");
+
+	status =3D acpi_evaluate_integer(video->handle, "_GPD", NULL, id);
+	return_VALUE(status);
+}
+
+static int
+acpi_video_bus_POST_options (
+	struct acpi_video_bus	*video,
+	unsigned long		*options)
+{
+	int			status;
+	ACPI_FUNCTION_TRACE("acpi_video_bus_post_options");
+
+	status =3D acpi_evaluate_integer(video->handle, "_VPO", NULL,
options);
+	*options &=3D 3;
+
+	return_VALUE(status);
+}
+
+static int
+acpi_video_bus_ownership (
+	struct acpi_video_bus	*video,
+	int			get,
+	int			lcd)
+{
+	acpi_integer		status;
+	union acpi_object	arg0 =3D {ACPI_TYPE_INTEGER};
+	struct acpi_object_list	args =3D {1, &arg0};
+
+	ACPI_FUNCTION_TRACE("acpi_video_bus_ownership");
+
+	arg0.integer.value =3D (lcd << 2) | (get << 0);
+
+	status =3D acpi_evaluate_object(video->handle, "_DOS", &args,
NULL);
+
+	return_VALUE(status);
+}
+
+static int
+acpi_video_bus_check (
+	struct acpi_video_bus	*video)
+{
+	acpi_status		status =3D -ENOENT;
+
+	acpi_handle		h_dummy1;
+	acpi_handle		h_dummy2;
+	acpi_handle		h_dummy3;
+
+	ACPI_FUNCTION_TRACE("acpi_video_bus_check");
+
+	if (!video)
+		return_VALUE(-EINVAL);
+
+	/* Since there is no HID, CID and so on for VGA driver, we have
+	 * to check well known required nodes.
+	 */
+
+	/* Does this device able to support video switching ? */
+	if (ACPI_SUCCESS(acpi_get_handle(video->handle, "_DOD",
&h_dummy1)) &&
+	    ACPI_SUCCESS(acpi_get_handle(video->handle, "_DOS",
&h_dummy2))) {
+		video->flags.multihead =3D 1;
+		status =3D 0;
+	}
+
+	/* Does this device able to retrieve a retrieve a video ROM ? */
+	if (ACPI_SUCCESS(acpi_get_handle(video->handle, "_ROM",
&h_dummy1))) {
+		video->flags.rom =3D 1;
+		status =3D 0;
+	}
+
+	/* Does this device able to configure which video device to POST
? */
+	if (ACPI_SUCCESS(acpi_get_handle(video->handle, "_VPO",
&h_dummy1)) &&
+	    ACPI_SUCCESS(acpi_get_handle(video->handle, "_GPD",
&h_dummy2)) &&
+	    ACPI_SUCCESS(acpi_get_handle(video->handle, "_SPD",
&h_dummy3))) {
+		video->flags.post =3D 1;
+		status =3D 0;
+	}
+
+	return_VALUE(status);
+}
+
+/*
------------------------------------------------------------------------
--
+                              FS Interface (/proc)
+
------------------------------------------------------------------------
-- */
+
+struct proc_dir_entry		*acpi_video_dir;
+
+/* video devices */
+
+static ssize_t
+acpi_video_device_info_seq_show (
+	struct seq_file		*seq,
+	void			*offset)
+{
+	struct acpi_video_device	*dev =3D (struct acpi_video_device
*) seq->private;
+
+	ACPI_FUNCTION_TRACE("acpi_video_device_info_seq_show");
+
+	if (!dev)
+		goto end;
+
+	seq_printf(seq, "device_id:    0x%04x\n", (u32) dev->device_id);
+	seq_printf(seq, "type:         ");
+	if (dev->flags.crt)
+		seq_printf(seq, "CRT\n");
+	else if (dev->flags.lcd)
+		seq_printf(seq, "LCD\n");
+	else if (dev->flags.tvout)
+		seq_printf(seq, "TVOUT\n");
+	else
+		seq_printf(seq, "UNKNOWN\n");
+
+	seq_printf(seq,"known by bios: %s\n",
+		   dev->flags.bios ? "yes":"no");
+
+end:
+	return_VALUE(0);
+}
+
+static int
+acpi_video_device_info_open_fs (
+	struct inode		*inode,
+	struct file		*file)
+{
+	return single_open(file, acpi_video_device_info_seq_show,
+			   PDE(inode)->data);
+}
+
+static ssize_t
+acpi_video_device_state_seq_show (
+	struct seq_file		*seq,
+	void			*offset)
+{
+	int			status;
+	struct acpi_video_device	*dev =3D (struct acpi_video_device
*) seq->private;
+	unsigned long		state;
+
+	ACPI_FUNCTION_TRACE("acpi_video_device_state_seq_show");
+
+	if (!dev)
+		goto end;
+
+	status =3D acpi_video_device_get_state(dev, &state);
+	seq_printf(seq, "state:     ");
+	if (ACPI_SUCCESS(status))
+		seq_printf(seq, "0x%02lx\n", state);
+	else
+		seq_printf(seq, "<not supported>\n");
+
+	status =3D acpi_video_device_query(dev, &state);
+	seq_printf(seq, "query:     ");
+	if (ACPI_SUCCESS(status))
+		seq_printf(seq, "0x%02lx\n", state);
+	else
+		seq_printf(seq, "<not supported>\n");
+
+end:
+	return_VALUE(0);
+}
+
+static int
+acpi_video_device_state_open_fs (
+	struct inode		*inode,
+	struct file		*file)
+{
+	return single_open(file, acpi_video_device_state_seq_show,
+			   PDE(inode)->data);
+}
+
+static ssize_t
+acpi_video_device_write_state (
+	struct file		*file,
+	const char		__user *buffer,
+	size_t			count,
+	loff_t			*data)
+{
+	int			status;
+	struct seq_file		*m =3D (struct seq_file *)
file->private_data;
+	struct acpi_video_device	*dev =3D (struct acpi_video_device
*) m->private;
+	char			str[12] =3D {0};
+	u32			state =3D 0;
+
+	ACPI_FUNCTION_TRACE("acpi_video_device_write_state");
+
+	if (!dev || count + 1 > sizeof str)
+		return_VALUE(-EINVAL);
+
+	if (copy_from_user(str, buffer, count))
+		return_VALUE(-EFAULT);
+
+	str[count] =3D 0;
+	state =3D simple_strtoul(str, NULL, 0);
+	state &=3D ((1ul<<31) | (1ul<<30) | (1ul<<0));
+
+	status =3D acpi_video_device_set_state(dev, state);
+
+	if (status)
+		return_VALUE(-EFAULT);
+
+	return_VALUE(count);
+}
+
+static ssize_t
+acpi_video_device_brightness_seq_show (
+	struct seq_file		*seq,
+	void			*offset)
+{
+	struct acpi_video_device	*dev =3D (struct acpi_video_device
*) seq->private;
+	int			i;
+
+	ACPI_FUNCTION_TRACE("acpi_video_device_brightness_seq_show");
+
+	if (!dev || !dev->brightness) {
+		seq_printf(seq, "<not supported>\n");
+		return_VALUE(0);
+	}
+
+	seq_printf(seq, "levels: ");
+	for (i =3D 0; i < dev->brightness->count; i++)
+		seq_printf(seq, " %d", dev->brightness->levels[i]);
+	seq_printf(seq, "\ncurrent: %d\n", dev->brightness->curr);
+
+	return_VALUE(0);
+}
+
+static int
+acpi_video_device_brightness_open_fs (
+	struct inode		*inode,
+	struct file		*file)
+{
+	return single_open(file, acpi_video_device_brightness_seq_show,
+			   PDE(inode)->data);
+}
+
+static ssize_t
+acpi_video_device_write_brightness (
+	struct file		*file,
+	const char		__user *buffer,
+	size_t			count,
+	loff_t			*data)
+{
+	struct seq_file		*m =3D (struct seq_file *)
file->private_data;
+	struct acpi_video_device	*dev =3D (struct acpi_video_device
*) m->private;
+	char			str[4] =3D {0};
+	unsigned int		level =3D 0;
+	int			i;
+
+	ACPI_FUNCTION_TRACE("acpi_video_device_write_brightness");
+
+	if (!dev || count + 1 > sizeof str)
+		return_VALUE(-EINVAL);
+
+	if (copy_from_user(str, buffer, count))
+		return_VALUE(-EFAULT);
+
+	str[count] =3D 0;
+	level =3D simple_strtoul(str, NULL, 0);
+=09
+	if (level > 100)
+		return_VALUE(-EFAULT);
+
+	/* validate though the list of available levels */
+	for (i =3D 0; i < dev->brightness->count; i++)
+		if (level =3D=3D dev->brightness->levels[i]) {
+			if
(ACPI_SUCCESS(acpi_video_device_lcd_set_level(dev, level)))
+				dev->brightness->curr =3D level;
+			break;
+		}
+
+	return_VALUE(count);
+}
+
+static ssize_t
+acpi_video_device_EDID_seq_show (
+	struct seq_file		*seq,
+	void			*offset)
+{
+	struct acpi_video_device	*dev =3D (struct acpi_video_device
*) seq->private;
+	int			status;
+	int			i;
+	union acpi_object	*edid =3D NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_video_device_EDID_seq_show");
+
+	if (!dev)
+		goto out;
+
+	status =3D acpi_video_device_EDID (dev, &edid, 128);
+	if (ACPI_FAILURE(status)) {
+		status =3D acpi_video_device_EDID (dev, &edid, 256);
+	}
+
+	if (ACPI_FAILURE(status)) {
+		goto out;
+	}
+
+	if (edid && edid->type =3D=3D ACPI_TYPE_BUFFER) {
+		for (i =3D 0; i < edid->buffer.length; i++)
+			seq_putc(seq, edid->buffer.pointer[i]);
+	}
+
+out:
+	if (!edid)
+		seq_printf(seq, "<not supported>\n");
+	else
+		kfree(edid);
+
+	return_VALUE(0);
+}
+
+static int
+acpi_video_device_EDID_open_fs (
+	struct inode		*inode,
+	struct file		*file)
+{
+	return single_open(file, acpi_video_device_EDID_seq_show,
+			   PDE(inode)->data);
+}
+
+
+static int
+acpi_video_device_add_fs (
+	struct acpi_device	*device)
+{
+	struct proc_dir_entry	*entry =3D NULL;
+	struct acpi_video_device *vid_dev;
+
+	ACPI_FUNCTION_TRACE("acpi_video_device_add_fs");
+
+	if (!device)
+		return_VALUE(-ENODEV);
+
+	vid_dev =3D (struct acpi_video_device *) acpi_driver_data(device);
+	if (!vid_dev)
+		return_VALUE(-ENODEV);
+
+	if (!acpi_device_dir(device)) {
+		acpi_device_dir(device) =3D
proc_mkdir(acpi_device_bid(device),
+				vid_dev->video->dir);
+		if (!acpi_device_dir(device))
+			return_VALUE(-ENODEV);
+	}
+
+	/* 'info' [R] */
+	entry =3D create_proc_entry("info", S_IRUGO,
acpi_device_dir(device));
+	if (!entry)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Unable to create 'info' fs entry\n"));
+	else {
+		entry->proc_fops =3D &acpi_video_device_info_fops;
+		entry->data =3D acpi_driver_data(device);
+	}
+
+	/* 'state' [R/W] */
+	entry =3D create_proc_entry("state", S_IFREG|S_IRUGO|S_IWUSR,
acpi_device_dir(device));
+	if (!entry)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Unable to create 'state' fs entry\n"));
+	else {
+		entry->proc_fops =3D &acpi_video_device_state_fops;
+		entry->proc_fops->write =3D acpi_video_device_write_state;
+		entry->data =3D acpi_driver_data(device);
+	}
+
+	/* 'brightness' [R/W] */
+	entry =3D create_proc_entry("brightness", S_IFREG|S_IRUGO|S_IWUSR,
acpi_device_dir(device));
+	if (!entry)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Unable to create 'brightness' fs entry\n"));
+	else {
+		entry->proc_fops =3D &acpi_video_device_brightness_fops;
+		entry->proc_fops->write =3D
acpi_video_device_write_brightness;
+		entry->data =3D acpi_driver_data(device);
+	}
+
+	/* 'EDID' [R] */
+	entry =3D create_proc_entry("EDID", S_IRUGO,
acpi_device_dir(device));
+	if (!entry)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Unable to create 'brightness' fs entry\n"));
+	else {
+		entry->proc_fops =3D &acpi_video_device_EDID_fops;
+		entry->data =3D acpi_driver_data(device);
+	}
+
+	return_VALUE(0);
+}
+
+static int
+acpi_video_device_remove_fs (
+	struct acpi_device	*device)
+{
+	struct acpi_video_device *vid_dev;
+	ACPI_FUNCTION_TRACE("acpi_video_device_remove_fs");
+
+	vid_dev =3D (struct acpi_video_device *) acpi_driver_data(device);
+	if (!vid_dev || !vid_dev->video || !vid_dev->video->dir)
+		return_VALUE(-ENODEV);
+
+	if (acpi_device_dir(device)) {
+		remove_proc_entry(acpi_device_bid(device),
vid_dev->video->dir);
+		acpi_device_dir(device) =3D NULL;
+	}
+
+	return_VALUE(0);
+}
+
+
+/* video bus */
+static ssize_t
+acpi_video_bus_info_seq_show (
+	struct seq_file		*seq,
+	void			*offset)
+{
+	struct acpi_video_bus	*video =3D (struct acpi_video_bus *)
seq->private;
+
+	ACPI_FUNCTION_TRACE("acpi_video_bus_info_seq_show");
+
+	if (!video)
+		goto end;
+
+	seq_printf(seq, "Switching heads:              %s\n",
+			video->flags.multihead ? "yes":"no");
+	seq_printf(seq, "Video ROM:                    %s\n",
+			video->flags.rom ? "yes":"no");
+	seq_printf(seq, "Device to be POSTed on boot:  %s\n",
+			video->flags.post ? "yes":"no");
+
+end:
+	return_VALUE(0);
+}
+
+static int
+acpi_video_bus_info_open_fs (
+	struct inode		*inode,
+	struct file		*file)
+{
+	return single_open(file, acpi_video_bus_info_seq_show,
PDE(inode)->data);
+}
+
+static ssize_t
+acpi_video_bus_ROM_seq_show (
+	struct seq_file		*seq,
+	void			*offset)
+{
+	struct acpi_video_bus	*video =3D (struct acpi_video_bus *)
seq->private;
+
+	ACPI_FUNCTION_TRACE("acpi_video_bus_ROM_seq_show");
+
+	if (!video)
+		goto end;
+
+	printk(KERN_INFO PREFIX "Please implement %s\n", __FUNCTION__);
+	seq_printf(seq, "<TODO>\n");
+
+end:
+	return_VALUE(0);
+}
+
+static int
+acpi_video_bus_ROM_open_fs (
+	struct inode		*inode,
+	struct file		*file)
+{
+	return single_open(file, acpi_video_bus_ROM_seq_show,
PDE(inode)->data);
+}
+
+static ssize_t
+acpi_video_bus_POST_info_seq_show (
+	struct seq_file		*seq,
+	void			*offset)
+{
+	struct acpi_video_bus	*video =3D (struct acpi_video_bus *)
seq->private;
+	unsigned long		options;
+	int			status;
+
+	ACPI_FUNCTION_TRACE("acpi_video_bus_POST_info_seq_show");
+
+	if (!video)
+		goto end;
+
+	status =3D acpi_video_bus_POST_options(video, &options);
+	if (ACPI_SUCCESS(status)) {
+		if (!(options & 1)) {
+			printk(KERN_WARNING PREFIX "The motherboard VGA
device is not listed as a possible POST device.\n");
+			printk(KERN_WARNING PREFIX "This indicate a BIOS
bug.  Please contact the manufacturer.\n");
+		}
+		printk("%lx\n", options);
+		seq_printf(seq, "can POST: <intgrated video>");
+		if (options & 2)
+			seq_printf(seq, " <PCI video>");
+		if (options & 4)
+			seq_printf(seq, " <AGP video>");
+		seq_putc(seq, '\n');
+	} else
+		seq_printf(seq, "<not supported>\n");
+end:
+	return_VALUE(0);
+}
+
+static int
+acpi_video_bus_POST_info_open_fs (
+	struct inode		*inode,
+	struct file		*file)
+{
+	return single_open(file, acpi_video_bus_POST_info_seq_show,
PDE(inode)->data);
+}
+
+static ssize_t
+acpi_video_bus_POST_seq_show (
+	struct seq_file		*seq,
+	void			*offset)
+{
+	struct acpi_video_bus	*video =3D (struct acpi_video_bus *)
seq->private;
+	int			status;
+	unsigned long		id;
+	char			device_decode[][30] =3D {
+					"motherboard VGA device",
+					"PCI VGA device",
+					"AGP VGA device",
+					"UNKNOWN",
+	};
+
+	ACPI_FUNCTION_TRACE("acpi_video_bus_POST_seq_show");
+
+	if (!video)
+		goto end;
+
+	status =3D acpi_video_bus_get_POST (video, &id);
+	if (!ACPI_SUCCESS(status)) {
+		seq_printf(seq, "<not supported>\n");
+		goto end;
+	}
+	seq_printf(seq, "device posted is <%s>\n",  device_decode[id &
3]);
+
+end:
+	return_VALUE(0);
+}
+
+static int
+acpi_video_bus_POST_open_fs (
+	struct inode		*inode,
+	struct file		*file)
+{
+	return single_open(file, acpi_video_bus_POST_seq_show,
PDE(inode)->data);
+}
+
+static ssize_t
+acpi_video_bus_write_POST (
+	struct file		*file,
+	const char		__user *buffer,
+	size_t			count,
+	loff_t			*data)
+{
+	int			status;
+	struct seq_file		*m =3D (struct seq_file *)
file->private_data;
+	struct acpi_video_bus	*video =3D (struct acpi_video_bus *)
m->private;
+	char			str[12] =3D {0};
+	unsigned long		opt, options;
+
+	ACPI_FUNCTION_TRACE("acpi_video_bus_write_POST");
+
+
+	if (!video || count + 1 > sizeof str)
+		return_VALUE(-EINVAL);
+
+	status =3D acpi_video_bus_POST_options(video, &options);
+	if (!ACPI_SUCCESS(status))
+		return_VALUE(-EINVAL);
+
+	if (copy_from_user(str, buffer, count))
+		return_VALUE(-EFAULT);
+
+	str[count] =3D 0;
+	opt =3D strtoul(str, NULL, 0);
+	if (opt > 3)
+		return_VALUE(-EFAULT);
+
+	/* just in case an OEM 'forget' the motherboard... */
+	options |=3D 1;
+
+	if (options & (1ul << opt)) {
+		status =3D acpi_video_bus_set_POST (video, opt);
+		if (!ACPI_SUCCESS(status))
+			return_VALUE(-EFAULT);
+
+	}
+
+
+	return_VALUE(count);
+}
+
+static int
+acpi_video_bus_add_fs (
+	struct acpi_device	*device)
+{
+	struct proc_dir_entry	*entry =3D NULL;
+	struct acpi_video_bus	*video;
+
+	ACPI_FUNCTION_TRACE("acpi_video_bus_add_fs");
+
+	video =3D (struct acpi_video_bus *) acpi_driver_data(device);
+
+	if (!acpi_device_dir(device)) {
+		acpi_device_dir(device) =3D
proc_mkdir(acpi_device_bid(device),
+				acpi_video_dir);
+		if (!acpi_device_dir(device))
+			return_VALUE(-ENODEV);
+	}
+
+	video->dir =3D acpi_device_dir(device);
+
+	/* 'info' [R] */
+	entry =3D create_proc_entry("info", S_IRUGO,
acpi_device_dir(device));
+	if (!entry)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unable to create
'info' fs entry\n"));
+	else {
+		entry->proc_fops =3D &acpi_video_bus_info_fops;
+		entry->data =3D acpi_driver_data(device);
+	}
+
+	/* 'ROM' [R] */
+	entry =3D create_proc_entry("ROM", S_IRUGO,
acpi_device_dir(device));
+	if (!entry)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unable to create 'ROM'
fs entry\n"));
+	else {
+		entry->proc_fops =3D &acpi_video_bus_ROM_fops;
+		entry->data =3D acpi_driver_data(device);
+	}
+
+	/* 'POST_info' [R] */
+	entry =3D create_proc_entry("POST_info", S_IRUGO,
acpi_device_dir(device));
+	if (!entry)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unable to create
'POST_info' fs entry\n"));
+	else {
+		entry->proc_fops =3D &acpi_video_bus_POST_info_fops;
+		entry->data =3D acpi_driver_data(device);
+	}
+
+	/* 'POST' [R/W] */
+	entry =3D create_proc_entry("POST", S_IFREG|S_IRUGO|S_IRUSR,
acpi_device_dir(device));
+	if (!entry)
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Unable to create
'POST' fs entry\n"));
+	else {
+		entry->proc_fops =3D &acpi_video_bus_POST_fops;
+		entry->proc_fops->write =3D acpi_video_bus_write_POST;
+		entry->data =3D acpi_driver_data(device);
+	}
+
+	return_VALUE(0);
+}
+
+static int
+acpi_video_bus_remove_fs (
+	struct acpi_device	*device)
+{
+	ACPI_FUNCTION_TRACE("acpi_video_bus_remove_fs");
+
+	if (acpi_device_dir(device)) {
+		remove_proc_entry(acpi_device_bid(device),
acpi_video_dir);
+		acpi_device_dir(device) =3D NULL;
+	}
+
+	return_VALUE(0);
+}
+
+/*
------------------------------------------------------------------------
--
+                                 Driver Interface
+
------------------------------------------------------------------------
-- */
+
+/* device interface */
+
+static int
+acpi_video_bus_get_one_device (
+	struct acpi_device	*device,
+	struct acpi_video_bus	*video)
+{
+	unsigned long		device_id;
+	int			status;
+	struct acpi_video_device	*data;
+
+	ACPI_FUNCTION_TRACE("acpi_video_bus_get_one_device");
+
+	if (!device || !video)
+		return_VALUE(-EINVAL);
+
+	status =3D acpi_evaluate_integer(device->handle, "_ADR", NULL,
&device_id);
+	if (ACPI_SUCCESS(status)) {
+		int i;
+		union acpi_object *obj =3D NULL;
+		struct acpi_video_device_brightness *br =3D NULL;
+
+		data =3D kmalloc(sizeof(struct acpi_video_device),
GFP_KERNEL);
+		if (!data)
+			return_VALUE(-ENOMEM);
+
+		memset(data, 0, sizeof(struct acpi_video_device));
+
+		data->handle =3D device->handle;
+		strcpy(acpi_device_name(device),
ACPI_VIDEO_DEVICE_NAME);
+		strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
+		acpi_driver_data(device) =3D data;
+
+		data->device_id =3D device_id;
+		data->video =3D video;
+		data->dev =3D device;
+
+		switch (device_id & 0xffff) {
+		case 0x0100:
+			data->flags.crt =3D 1;
+			break;
+		case 0x0110:
+			data->flags.lcd =3D 1;
+			break;
+		case 0x0200:
+			data->flags.tvout =3D 1;
+			break;
+		default:
+			data->flags.unknown =3D 1;
+			break;
+		}
+
+		for (i =3D 0; video->device_ids[i] !=3D
ACPI_VIDEO_HEAD_INVALID && i < 10; i++) {
+			if (device_id =3D=3D (video->device_ids[i] &
0xffff)) {
+				data->flags.bios =3D video->device_ids[i]
& 0x00010000 ? 1:0;
+				break;
+			}
+		}
+
+		status =3D acpi_video_device_lcd_query_levels(data, &obj);
+		if (obj && obj->type =3D=3D ACPI_TYPE_PACKAGE &&
obj->package.count >=3D 2) {
+			int count =3D 0;
+			union acpi_object *o;
+		=09
+			br =3D kmalloc(sizeof &br, GFP_KERNEL);
+			if (!br) {
+				printk(KERN_ERR "can't allocate
memory\n");
+			} else {
+				memset(br, 0, sizeof &br);
+				br->levels =3D kmalloc(obj->package.count
* sizeof &br->levels, GFP_KERNEL);
+				if (!br->levels)
+					goto out;
+
+				for (i =3D 0; i < obj->package.count; i++)
{
+					o =3D (union acpi_object *)
&obj->package.elements[i];
+					if (o->type !=3D
ACPI_TYPE_INTEGER) {
+
ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid data\n"));
+						continue;
+					}
+					br->levels[count] =3D (u32)
o->integer.value;
+					count++;
+				}
+out:
+				if (count < 2) {
+					if (br->levels)
+						kfree(br->levels);
+					kfree(br);
+				} else {
+					br->count =3D count;
+					data->brightness =3D br;
+					ACPI_DEBUG_PRINT((ACPI_DB_INFO,
"found %d brightness levels\n", count));
+				}
+			}
+		}
+
+		if (obj)
+			kfree(obj);
+
+		down(&video->sem);
+		list_add_tail(&data->entry, &video->video_driver_list);
+		up(&video->sem);
+
+		acpi_video_device_add_fs(device);
+
+		return_VALUE(0);
+	}
+
+	return_VALUE(-ENOENT);
+}
+
+static int
+acpi_video_bus_get_devices (
+	struct acpi_video_bus	*video,
+	struct acpi_device	*device)
+{
+	int			status;
+	int			count;
+	int			i;
+	unsigned long		*device_ids;
+	struct acpi_buffer	buffer =3D {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object	*dod =3D NULL;
+	union acpi_object	*obj;
+	struct list_head	*node, *next;
+
+	ACPI_FUNCTION_TRACE("acpi_video_get_devices");
+
+	status =3D acpi_evaluate_object(video->handle, "_DOD", NULL,
&buffer);
+	if (!ACPI_SUCCESS(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Error evaluating
_DOD\n"));
+		return_VALUE(status);
+	}
+
+	dod =3D (union acpi_object *) buffer.pointer;
+	if (!dod || (dod->type !=3D ACPI_TYPE_PACKAGE)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _DOD
data\n"));
+		status =3D -EFAULT;
+		goto out;
+	}
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found %d video heads in
_DOD\n",
+		dod->package.count));
+
+	device_ids =3D kmalloc(dod->package.count * sizeof(device_ids[0]),
GFP_KERNEL);
+	if (!device_ids) {
+		status =3D -ENOMEM;
+		goto out;
+	}
+
+	count =3D 0;
+	for (i =3D 0; i < dod->package.count; i++) {
+		obj =3D (union acpi_object *) &dod->package.elements[i];
+
+		if (obj->type !=3D ACPI_TYPE_INTEGER) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid _DOD
data\n"));
+			device_ids[i] =3D ACPI_VIDEO_HEAD_INVALID;
+		}
+
+		device_ids[i] =3D obj->integer.value;
+		count++;
+	}
+	device_ids[count] =3D ACPI_VIDEO_HEAD_END;
+	video->device_ids =3D device_ids;
+
+	list_for_each_safe(node, next, &device->children) {
+		struct acpi_device *dev =3D list_entry(node, struct
acpi_device, node);
+
+		if (!dev)
+			continue;
+
+		status =3D acpi_video_bus_get_one_device(dev, video);
+		if (ACPI_FAILURE(status)) {
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Cant attach
device\n"));
+			continue;
+		}
+
+	}
+
+	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found valid %d video heads\n",
count));
+
+out:
+	acpi_os_free(buffer.pointer);
+	return_VALUE(status);
+}
+
+static int
+acpi_video_bus_put_one_device(
+	struct acpi_video_device	*device)
+{
+	struct acpi_video_bus *video;
+
+	ACPI_FUNCTION_TRACE("acpi_video_bus_put_one_device");
+
+	if (!device || !device->video)
+		return (-ENOENT);
+
+	video =3D device->video;
+
+	down(&video->sem);
+	list_del(&device->entry);
+	up(&video->sem);
+	acpi_video_device_remove_fs(device->dev);
+
+	return_VALUE(0);
+}
+
+static int
+acpi_video_bus_put_devices (
+	struct acpi_video_bus	*video)
+{
+	int			status;
+	struct list_head	*node, *next;
+
+	ACPI_FUNCTION_TRACE("acpi_video_bus_put_devices");
+
+	list_for_each_safe(node, next, &video->video_driver_list) {
+		struct acpi_video_device *data =3D list_entry(node, struct
acpi_video_device, entry);
+		if (!data)
+			continue;
+
+		status =3D acpi_video_bus_put_one_device(data);
+		if(ACPI_FAILURE(status))
+			printk(KERN_WARNING PREFIX "hhuuhhuu bug in acpi
video driver.\n");
+
+		if (data->brightness)
+			kfree(data->brightness);
+
+		kfree(data);
+	}
+
+	return_VALUE(0);
+}
+
+/* acpi_video interface */
+
+static int
+acpi_video_bus_start_devices(
+	struct acpi_video_bus	*video)
+{
+	return acpi_video_bus_ownership(video, 1, 0);
+}
+
+static int
+acpi_video_bus_stop_devices(
+	struct acpi_video_bus	*video)
+{
+	return acpi_video_bus_ownership(video, 0, 1);
+}
+
+static void
+acpi_video_bus_notify (
+	acpi_handle		handle,
+	u32			event,
+	void			*data)
+{
+	struct acpi_video	*video =3D (struct acpi_video *) data;
+	struct acpi_device	*device =3D NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_video_bus_notify");
+
+	if (!video)
+		return_VOID;
+
+	if (acpi_bus_get_device(handle, &device))
+		return_VOID;
+
+	switch (event) {
+	case ACPI_VIDEO_NOTIFY_SWITCH:	/* User request that a switch
occur,
+					 * most likely via hotkey. */
+		printk(KERN_INFO "acpi_video: notify switch received:
please implement me.\n");
+
+		break;
+	case ACPI_VIDEO_NOTIFY_PROBE:	/* User plug or remove a video
+					 * connector. */
+		printk(KERN_INFO "acpi_video: notify reprobe received:
please implement me.\n");
+
+		break;
+	default:
+		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
+			"Unsupported event [0x%x]\n", event));
+		break;
+	}
+
+	return_VOID;
+}
+
+static int
+acpi_video_bus_add (
+	struct acpi_device	*device)
+{
+	int			result =3D 0;
+	acpi_status		status =3D 0;
+	struct acpi_video_bus	*video =3D NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_video_bus_add");
+=09
+	if (!device)
+		return_VALUE(-EINVAL);
+
+	video =3D kmalloc(sizeof(struct acpi_video_bus), GFP_KERNEL);
+	if (!video)
+		return_VALUE(-ENOMEM);
+	memset(video, 0, sizeof(struct acpi_video_bus));
+
+	video->handle =3D device->handle;
+	strcpy(acpi_device_name(device), ACPI_VIDEO_BUS_NAME);
+	strcpy(acpi_device_class(device), ACPI_VIDEO_CLASS);
+	acpi_driver_data(device) =3D video;
+
+	result =3D acpi_video_bus_check(video);
+	if (result)
+		goto end;
+
+	result =3D acpi_video_bus_add_fs(device);
+	if (result)
+		goto end;
+
+	init_MUTEX(&video->sem);
+	INIT_LIST_HEAD(&video->video_driver_list);
+
+	acpi_video_bus_get_devices(video, device);
+	acpi_video_bus_start_devices(video);
+
+	status =3D acpi_install_notify_handler(video->handle,
+		ACPI_DEVICE_NOTIFY, acpi_video_bus_notify, video);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Error installing notify handler\n"));
+		result =3D -ENODEV;
+		goto end;
+	}
+
+	printk(KERN_INFO PREFIX "%s [%s] (multi-head: %s  rom: %s  post:
%s)\n",
+		ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
+		video->flags.multihead ? "yes":"no",
+		video->flags.rom ? "yes":"no",
+		video->flags.post ? "yes":"no");
+
+end:
+	if (result) {
+		acpi_video_bus_remove_fs(device);
+		kfree(video);
+	}
+
+	return_VALUE(result);
+}
+
+static int
+acpi_video_bus_remove (
+	struct acpi_device	*device,
+	int			type)
+{
+	acpi_status		status =3D 0;
+	struct acpi_video_bus	*video =3D NULL;
+
+	ACPI_FUNCTION_TRACE("acpi_video_bus_remove");
+
+	if (!device || !acpi_driver_data(device))
+		return_VALUE(-EINVAL);
+
+	video =3D (struct acpi_video_bus *) acpi_driver_data(device);
+
+	acpi_video_bus_stop_devices(video);
+
+	status =3D acpi_remove_notify_handler(video->handle,
+		ACPI_DEVICE_NOTIFY, acpi_video_bus_notify);
+	if (ACPI_FAILURE(status))
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+			"Error removing notify handler\n"));
+
+	acpi_video_bus_put_devices(video);
+	acpi_video_bus_remove_fs(device);
+
+	if (video->device_ids)
+		kfree(video->device_ids);
+	kfree(video);
+
+	return_VALUE(0);
+}
+
+
+static int
+acpi_video_bus_match (
+	struct acpi_device	*device,
+	struct acpi_driver	*driver)
+{
+	acpi_handle		h_dummy1;
+	acpi_handle		h_dummy2;
+	acpi_handle		h_dummy3;
+
+	ACPI_FUNCTION_TRACE("acpi_video_bus_match");
+
+	if (!device || !driver)
+		return_VALUE(-EINVAL);
+
+	/* Since there is no HID, CID for ACPI Video drivers, we have
+	 * to check well known required nodes for each feature we
support.
+	 */
+
+	/* Does this device able to support video switching ? */
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOD",
&h_dummy1)) &&
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_DOS",
&h_dummy2)))
+		return_VALUE(0);
+
+	/* Does this device able to retrieve a video ROM ? */
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_ROM",
&h_dummy1)))
+		return_VALUE(0);
+
+	/* Does this device able to configure which video head to be
POSTed ? */
+	if (ACPI_SUCCESS(acpi_get_handle(device->handle, "_VPO",
&h_dummy1)) &&
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_GPD",
&h_dummy2)) &&
+	    ACPI_SUCCESS(acpi_get_handle(device->handle, "_SPD",
&h_dummy3)))
+		return_VALUE(0);
+
+
+	return_VALUE(-ENODEV);
+}
+
+
+static int __init
+acpi_video_init (void)
+{
+	int			result =3D 0;
+
+	ACPI_FUNCTION_TRACE("acpi_video_init");
+
+	acpi_video_dir =3D proc_mkdir(ACPI_VIDEO_CLASS, acpi_root_dir);
+	if (!acpi_video_dir)
+		return_VALUE(-ENODEV);
+
+	result =3D acpi_bus_register_driver(&acpi_video_bus);
+	if (result < 0) {
+		remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
+		return_VALUE(-ENODEV);
+	}
+
+	return_VALUE(0);
+}
+
+static void __exit
+acpi_video_exit (void)
+{
+	ACPI_FUNCTION_TRACE("acpi_video_exit");
+
+	acpi_bus_unregister_driver(&acpi_video_bus);
+
+	remove_proc_entry(ACPI_VIDEO_CLASS, acpi_root_dir);
+
+	return_VOID;
+}
+
+module_init(acpi_video_init);
+module_exit(acpi_video_exit);
--- linux-2.6.3-bk-acpi/include/acpi/acpi_bus.h	2004/02/09 22:23:14
1.1
+++ linux-2.6.3-bk-acpi/include/acpi/acpi_bus.h	2004/02/10 00:15:49
@@ -106,6 +106,7 @@ typedef int (*acpi_op_suspend)	(struct a
 typedef int (*acpi_op_resume)	(struct acpi_device *device, int state);
 typedef int (*acpi_op_scan)	(struct acpi_device *device);
 typedef int (*acpi_op_bind)	(struct acpi_device *device);
+typedef int (*acpi_op_match)	(struct acpi_device *device, struct
acpi_driver *driver);
=20
 struct acpi_device_ops {
 	acpi_op_add		add;
@@ -117,6 +118,7 @@ struct acpi_device_ops {
 	acpi_op_resume		resume;
 	acpi_op_scan		scan;
 	acpi_op_bind		bind;
+	acpi_op_match		match;
 };
=20
 struct acpi_driver {




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
