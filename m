From: Harald Welte <laforge@gnumonks.org>
Subject: [PATCH] Panasonic Let's Note laptop extras driver
Date: Wed, 2 Jul 2008 17:00:44 +0800
Message-ID: <20080702090044.GB12272@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:46660 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349AbYGBJBF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jul 2008 05:01:05 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Hiroshi Miura <miura@da-cha.org>, hadi@cyberus.ca

Hi!

Ever since I bought my Panasonic Let's Note CF-R5 in September 2006
(like other well-known kernel hackers such as Jamal Selim and Stephen
Hemminger) I'm using the (apparently abandoned) out-of-tree pcc_acpi.c
driver.  Various changes in the kernel API's have required me to
merge/forward-port it from one kernel release to the other.

In more than three attempts (two of them in the last 6 months), I have
tried to contact the main author (Hiroshi Miura, see Cc) and asked if he
had plans to submit the driver for mainline inclusion or if he'd support
any such submission attempt by me.

The co-author David Bronaugh has promptly responded and is fine with
merging it mainline.

Though we are now in the unfortunate situation where the main author is
no longer reachable, I don't want to delay this even longer and want to
get this driver merged.  The original code was explicitly GPL licensed,
so there is no legal reason to 

For the time being, I'm also willing to be the maintainer of this
driver.

Any feedback is welcome.  Please excuse obvious mistakes.  While I have
a lot of kernel experience, I have not done any work on ACPI before.

There is one particular issue:

* in order to fully support the backlight interface and get rid of the
  clumsy separation of 'ac' (with power supply) and 'dc' (battery only) 
  brightness settings, the driver would need to receive a notification
  whenever the ACPI power supply status changes.  I know how to get to
  that notification in userspace, but in kernelspace I'm not so sure.
  Is there a notifier chain to which I can attach?

Thanks for your review,


Signed-off-by: Harald Welte <laforge@gnumonks.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f0ec46..05d449e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3108,6 +3108,11 @@ M:	olof@lixom.net
 L:	i2c@lm-sensors.org
 S:	Maintained
 
+PANASONIC LAPTOP ACPI EXTRAS DRIVER
+P:	Harald Welte
+M:	laforge@gnumonks.org
+S:	Maintained
+
 PARALLEL PORT SUPPORT
 L:	linux-parport@lists.infradead.org (subscribers-only)
 S:	Orphan
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index c52fca8..1da4bc8 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -259,6 +259,17 @@ config ACPI_ASUS
 	  NOTE: This driver is deprecated and will probably be removed soon,
 	  use asus-laptop instead.
 
+config ACPI_PANASONIC
+	tristate "Panasonic Laptop Extras"
+	depends on X86
+	select BACKLIGHT_CLASS_DEVICE
+	---help---
+	  This driver adds support for access to certain system settings
+	  on Panasonic Let's Note laptops.  
+
+	  If you have a Panasonic Let's note laptop (such as the R1(N variant),
+	  R2, R3, R5, T2, W2 and Y2 series), say Y.
+
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
 	depends on X86
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 40b0fca..04c1b5d 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_ACPI_WMI)		+= wmi.o
 obj-$(CONFIG_ACPI_ASUS)		+= asus_acpi.o
 obj-$(CONFIG_ACPI_TOSHIBA)	+= toshiba_acpi.o
 obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o
+obj-$(CONFIG_ACPI_PANASONIC)	+= pcc_acpi.o
 obj-$(CONFIG_ACPI_PROCFS_POWER)	+= cm_sbs.o
 obj-$(CONFIG_ACPI_SBS)		+= sbshc.o
 obj-$(CONFIG_ACPI_SBS)		+= sbs.o
diff --git a/drivers/acpi/pcc_acpi.c b/drivers/acpi/pcc_acpi.c
new file mode 100644
index 0000000..11ddc79
--- /dev/null
+++ b/drivers/acpi/pcc_acpi.c
@@ -0,0 +1,1062 @@
+/*
+ *  Panasonic HotKey and LCD brightness control driver
+ *  (C) 2004 Hiroshi Miura <miura@da-cha.org>
+ *  (C) 2004 NTT DATA Intellilink Co. http://www.intellilink.co.jp/
+ *  (C) YOKOTA Hiroshi <yokota (at) netlab. is. tsukuba. ac. jp>
+ *  (C) 2004 David Bronaugh <dbronaugh>
+ *  (C) 2006-2008 Harald Welte <laforge@gnumonks.org>
+ *
+ *  derived from toshiba_acpi.c, Copyright (C) 2002-2004 John Belmonte
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  publicshed by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *---------------------------------------------------------------------------
+ *
+ * ChangeLog:
+ *
+ *      Jun.27, 2008	Harald Welte <laforge@gnumonks.org>
+ *      	-v0.92	merge with 2.6.26-rc6 input API changes
+ *      		remove broken <= 2.6.15 kernel support
+ *      		resolve all compiler warnings
+ *      		add support for backlight api
+ *      		major code restructuring
+ *      		various coding style fixes (checkpatch.pl)
+ *
+ * 	Dac.28, 2007	Harald Welte <laforge@gnumonks.org>
+ * 		-v0.91	merge with 2.6.24-rc6 ACPI changes
+ *
+ * 	Nov.04, 2006	Hiroshi Miura <miura@da-cha.org>
+ * 		-v0.9	remove warning about section reference.
+ * 			remove acpi_os_free
+ * 			add /proc/acpi/pcc/brightness interface for HAL access
+ * 			merge dbronaugh's enhancement
+ * 			Aug.17, 2004 David Bronaugh (dbronaugh)
+ *  				- Added screen brightness setting interface
+ *				  Thanks to FreeBSD crew (acpi_panasonic.c)
+ * 				  for the ideas I needed to accomplish it
+ *
+ *	May.29, 2006	Hiroshi Miura <miura@da-cha.org>
+ *		-v0.8.4 follow to change keyinput structure
+ *			thanks Fabian Yamaguchi <fabs@cs.tu-berlin.de>,
+ *			Jacob Bower <jacob.bower@ic.ac.uk> and
+ *			Hiroshi Yokota for providing solutions.
+ *
+ *	Oct.02, 2004	Hiroshi Miura <miura@da-cha.org>
+ *		-v0.8.2	merge code of YOKOTA Hiroshi
+ *					<yokota@netlab.is.tsukuba.ac.jp>.
+ *			Add sticky key mode interface.
+ *			Refactoring acpi_pcc_generete_keyinput().
+ *
+ *	Sep.15, 2004	Hiroshi Miura <miura@da-cha.org>
+ *		-v0.8	Generate key input event on input subsystem.
+ *			This is based on yet another driver written by
+ *							Ryuta Nakanishi.
+ *
+ *	Sep.10, 2004	Hiroshi Miura <miura@da-cha.org>
+ *		-v0.7	Change proc interface functions using seq_file
+ *			facility as same as other ACPI drivers.
+ *
+ *	Aug.28, 2004	Hiroshi Miura <miura@da-cha.org>
+ *		-v0.6.4 Fix a silly error with status checking
+ *
+ *	Aug.25, 2004	Hiroshi Miura <miura@da-cha.org>
+ *		-v0.6.3 replace read_acpi_int by standard function
+ *							acpi_evaluate_integer
+ *			some clean up and make smart copyright notice.
+ *			fix return value of pcc_acpi_get_key()
+ *			fix checking return value of acpi_bus_register_driver()
+ *
+ *      Aug.22, 2004    David Bronaugh <dbronaugh@linuxboxen.org>
+ *              -v0.6.2 Add check on ACPI data (num_sifr)
+ *                      Coding style cleanups, better error messages/handling
+ *			Fixed an off-by-one error in memory allocation
+ *
+ *      Aug.21, 2004    David Bronaugh <dbronaugh@linuxboxen.org>
+ *              -v0.6.1 Fix a silly error with status checking
+ *
+ *      Aug.20, 2004    David Bronaugh <dbronaugh@linuxboxen.org>
+ *              - v0.6  Correct brightness controls to reflect reality
+ *                      based on information gleaned by Hiroshi Miura
+ *                      and discussions with Hiroshi Miura
+ *
+ *	Aug.10, 2004	Hiroshi Miura <miura@da-cha.org>
+ *		- v0.5  support LCD brightness control
+ *			based on the disclosed information by MEI.
+ *
+ *	Jul.25, 2004	Hiroshi Miura <miura@da-cha.org>
+ *		- v0.4  first post version
+ *		        add function to retrive SIFR
+ *
+ *	Jul.24, 2004	Hiroshi Miura <miura@da-cha.org>
+ *		- v0.3  get proper status of hotkey
+ *
+ *      Jul.22, 2004	Hiroshi Miura <miura@da-cha.org>
+ *		- v0.2  add HotKey handler
+ *
+ *      Jul.17, 2004	Hiroshi Miura <miura@da-cha.org>
+ *		- v0.1  start from toshiba_acpi driver written by John Belmonte
+ *
+ */
+
+#define ACPI_PCC_VERSION	"0.92"
+
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/proc_fs.h>
+#include <linux/backlight.h>
+#include <linux/ctype.h>
+#include <linux/seq_file.h>
+#include <linux/uaccess.h>
+#include <acpi/acpi_bus.h>
+#include <acpi/acpi_drivers.h>
+#include <linux/input.h>
+
+
+#ifndef ACPI_HOTKEY_COMPONENT
+#define ACPI_HOTKEY_COMPONENT	0x10000000
+#endif
+
+#define _COMPONENT		ACPI_HOTKEY_COMPONENT
+ACPI_MODULE_NAME("pcc_acpi")
+
+MODULE_AUTHOR("Hiroshi Miura, David Bronaugh and Harald Welte");
+MODULE_DESCRIPTION("ACPI HotKey driver for Panasonic Lets Note laptops");
+MODULE_LICENSE("GPL");
+
+#define LOGPREFIX "pcc_acpi: "
+
+/* Define ACPI PATHs */
+/* Lets note hotkeys */
+#define METHOD_HKEY_QUERY	"HINF"
+#define METHOD_HKEY_SQTY	"SQTY"
+#define METHOD_HKEY_SINF	"SINF"
+#define METHOD_HKEY_SSET	"SSET"
+#define HKEY_NOTIFY		 0x80
+
+/* definitions for /proc/ interface */
+#define ACPI_PCC_DRIVER_NAME	"PCC Extra Driver"
+#define ACPI_PCC_DEVICE_NAME	"PCCExtra"
+#define ACPI_PCC_CLASS		"pcc"
+#define PROC_PCC		ACPI_PCC_CLASS
+
+#define ACPI_PCC_INPUT_PHYS	"panasonic/hkey0"
+
+/* This is transitional definition */
+#ifndef KEY_BATT
+# define KEY_BATT 227
+#endif
+
+#define PROC_STR_MAX_LEN  8
+
+/* LCD_TYPEs: 0 = Normal, 1 = Semi-transparent
+   ENV_STATEs: Normal temp=0x01, High temp=0x81, N/A=0x00
+*/
+enum SINF_BITS { SINF_NUM_BATTERIES = 0,
+		 SINF_LCD_TYPE,
+		 SINF_AC_MAX_BRIGHT,
+		 SINF_AC_MIN_BRIGHT,
+		 SINF_AC_CUR_BRIGHT,
+		 SINF_DC_MAX_BRIGHT,
+		 SINF_DC_MIN_BRIGHT,
+		 SINF_DC_CUR_BRIGHT,
+		 SINF_MUTE,
+		 SINF_RESERVED,
+		 SINF_ENV_STATE,
+		 SINF_STICKY_KEY = 0x80,
+	};
+/* R1 handles SINF_AC_CUR_BRIGHT as SINF_CUR_BRIGHT, doesn't know AC state */
+
+static int acpi_pcc_hotkey_add(struct acpi_device *device);
+static int acpi_pcc_hotkey_remove(struct acpi_device *device, int type);
+static int acpi_pcc_hotkey_resume(struct acpi_device *device);
+
+static const struct acpi_device_id pcc_device_ids[] = {
+	{ "MAT0012", 0},
+	{ "MAT0013", 0},
+	{ "MAT0018", 0},
+	{ "MAT0019", 0},
+	{ "", 0},
+};
+
+static struct acpi_driver acpi_pcc_driver = {
+	.name =		ACPI_PCC_DRIVER_NAME,
+	.class =	ACPI_PCC_CLASS,
+	.ids =		pcc_device_ids,
+	.ops =		{
+				.add =		acpi_pcc_hotkey_add,
+				.remove =	acpi_pcc_hotkey_remove,
+				.resume =       acpi_pcc_hotkey_resume,
+			},
+};
+
+struct acpi_hotkey {
+	acpi_handle		handle;
+	struct acpi_device	*device;
+	struct proc_dir_entry   *proc_dir_entry;
+	unsigned long		num_sifr;
+	u32 			*sinf;
+	unsigned long		status;
+	struct input_dev	*input_dev;
+	int			sticky_mode;
+	struct backlight_device	*backlight;
+};
+
+struct pcc_keyinput {
+	struct acpi_hotkey      *hotkey;
+	int key_mode;
+};
+
+/* method access functions */
+static int acpi_pcc_write_sset(struct acpi_hotkey *hotkey, int func, int val)
+{
+	union acpi_object in_objs[] = {
+		{ .integer.type  = ACPI_TYPE_INTEGER,
+		  .integer.value = func, },
+		{ .integer.type  = ACPI_TYPE_INTEGER,
+		  .integer.value = val, },
+	};
+	struct acpi_object_list params = {
+		.count   = ARRAY_SIZE(in_objs),
+		.pointer = in_objs,
+	};
+	acpi_status status = AE_OK;
+
+	ACPI_FUNCTION_TRACE("acpi_pcc_write_sset");
+
+	status = acpi_evaluate_object(hotkey->handle, METHOD_HKEY_SSET,
+				      &params, NULL);
+
+	return status == AE_OK;
+}
+
+static inline int acpi_pcc_get_sqty(struct acpi_device *device)
+{
+	unsigned long s;
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE("acpi_pcc_get_sqty");
+
+	status = acpi_evaluate_integer(device->handle, METHOD_HKEY_SQTY,
+				       NULL, &s);
+	if (ACPI_SUCCESS(status))
+		return s;
+	else {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "evaluation error HKEY.SQTY\n"));
+		return -EINVAL;
+	}
+}
+
+static int acpi_pcc_retrieve_biosdata(struct acpi_hotkey *hotkey, u32 *sinf)
+{
+	acpi_status status;
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	union acpi_object *hkey = NULL;
+	int i;
+
+	ACPI_FUNCTION_TRACE("acpi_pcc_retrieve_biosdata");
+
+	status = acpi_evaluate_object(hotkey->handle, METHOD_HKEY_SINF, 0,
+				      &buffer);
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "evaluation error HKEY.SINF\n"));
+		return 0;
+	}
+
+	hkey = buffer.pointer;
+	if (!hkey || (hkey->type != ACPI_TYPE_PACKAGE)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Invalid HKEY.SINF\n"));
+		goto end;
+	}
+
+	if (hotkey->num_sifr < hkey->package.count) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				 "SQTY reports bad SINF length\n"));
+		status = AE_ERROR;
+		goto end;
+	}
+
+	for (i = 0; i < hkey->package.count; i++) {
+		union acpi_object *element = &(hkey->package.elements[i]);
+		if (likely(element->type == ACPI_TYPE_INTEGER)) {
+			sinf[i] = element->integer.value;
+		} else
+			ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+					 "Invalid HKEY.SINF data\n"));
+	}
+	sinf[hkey->package.count] = -1;
+
+end:
+	kfree(buffer.pointer);
+	return status == AE_OK;
+}
+
+static int acpi_pcc_read_sinf_field(struct seq_file *seq, int field)
+{
+	struct acpi_hotkey *hotkey = (struct acpi_hotkey *) seq->private;
+
+	ACPI_FUNCTION_TRACE("acpi_pcc_read_sinf_field");
+
+	if (!acpi_pcc_retrieve_biosdata(hotkey, hotkey->sinf)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				 "Couldn't retrieve BIOS data\n"));
+		return -EIO;
+	}
+
+	return seq_printf(seq, "%u\n", hotkey->sinf[field]);
+}
+
+/* backlight API interface functions */
+
+static int bl_get(struct backlight_device *bd)
+{
+	struct acpi_hotkey *hotkey = bl_get_data(bd);
+
+	if (!acpi_pcc_retrieve_biosdata(hotkey, hotkey->sinf))
+		return -EIO;
+
+	return hotkey->sinf[SINF_AC_CUR_BRIGHT];
+}
+
+static int bl_set_status(struct backlight_device *bd)
+{
+	struct acpi_hotkey *hotkey = bl_get_data(bd);
+	int bright = bd->props.brightness;
+
+	if (!acpi_pcc_retrieve_biosdata(hotkey, hotkey->sinf))
+		return -EIO;
+
+	if (bright < hotkey->sinf[SINF_AC_MIN_BRIGHT] ||
+	    bright > hotkey->sinf[SINF_AC_MAX_BRIGHT])
+		return -EINVAL;
+
+	return acpi_pcc_write_sset(hotkey, SINF_AC_CUR_BRIGHT, bright);
+}
+
+static struct backlight_ops pcc_backlight_ops = {
+	.get_brightness	= bl_get,
+	.update_status	= bl_set_status,
+};
+
+
+/* user interface functions */
+
+/* read methods */
+#define PCC_SINF_READ_F(_name_, FUNC) \
+static int _name_(struct seq_file *seq, void *offset) \
+{ \
+	return acpi_pcc_read_sinf_field(seq, (FUNC)); \
+}
+
+PCC_SINF_READ_F(acpi_pcc_numbatteries_show,      SINF_NUM_BATTERIES);
+PCC_SINF_READ_F(acpi_pcc_lcdtype_show,           SINF_LCD_TYPE);
+PCC_SINF_READ_F(acpi_pcc_ac_brightness_max_show, SINF_AC_MAX_BRIGHT);
+PCC_SINF_READ_F(acpi_pcc_ac_brightness_min_show, SINF_AC_MIN_BRIGHT);
+PCC_SINF_READ_F(acpi_pcc_ac_brightness_show,     SINF_AC_CUR_BRIGHT);
+PCC_SINF_READ_F(acpi_pcc_dc_brightness_max_show, SINF_DC_MAX_BRIGHT);
+PCC_SINF_READ_F(acpi_pcc_dc_brightness_min_show, SINF_DC_MIN_BRIGHT);
+PCC_SINF_READ_F(acpi_pcc_dc_brightness_show,     SINF_DC_CUR_BRIGHT);
+PCC_SINF_READ_F(acpi_pcc_brightness_show,        SINF_AC_CUR_BRIGHT);
+PCC_SINF_READ_F(acpi_pcc_mute_show,              SINF_MUTE);
+
+static int acpi_pcc_sticky_key_show(struct seq_file *seq, void *offset)
+{
+	struct acpi_hotkey *hotkey = seq->private;
+
+	ACPI_FUNCTION_TRACE("acpi_pcc_sticky_key_show");
+
+	if (!hotkey || !hotkey->device)
+		return 0;
+
+	seq_printf(seq, "%d\n", hotkey->sticky_mode);
+
+	return 0;
+}
+
+static int acpi_pcc_keyinput_show(struct seq_file *seq, void *offset)
+{
+	struct acpi_hotkey 	*hotkey = (struct acpi_hotkey *) seq->private;
+	struct input_dev 	*hotk_input_dev = hotkey->input_dev;
+	struct pcc_keyinput 	*keyinput = input_get_drvdata(hotk_input_dev);
+
+	ACPI_FUNCTION_TRACE("acpi_pcc_keyinput_show");
+
+	seq_printf(seq, "%d\n", keyinput->key_mode);
+
+	return 0;
+}
+
+static int acpi_pcc_version_show(struct seq_file *seq, void *offset)
+{
+	struct acpi_hotkey *hotkey = (struct acpi_hotkey *) seq->private;
+
+	ACPI_FUNCTION_TRACE("acpi_pcc_version_show");
+
+	if (!hotkey || !hotkey->device)
+		return 0;
+
+	seq_printf(seq, "%s version %s\n", ACPI_PCC_DRIVER_NAME,
+		   ACPI_PCC_VERSION);
+	seq_printf(seq, "%li functions\n", hotkey->num_sifr);
+
+	return 0;
+}
+
+/* write methods */
+static ssize_t acpi_pcc_write_single_flag(struct file *file,
+					  const char __user *buffer,
+					  size_t count, int sinf_func)
+{
+	struct seq_file	*seq = file->private_data;
+	struct acpi_hotkey *hotkey = seq->private;
+	char write_string[PROC_STR_MAX_LEN];
+	u32 val;
+
+	ACPI_FUNCTION_TRACE("acpi_pcc_write_single_flag");
+
+	if (!hotkey || (count > sizeof(write_string) - 1))
+		return -EINVAL;
+
+	if (copy_from_user(write_string, buffer, count))
+		return -EFAULT;
+
+	write_string[count] = '\0';
+
+	if (sscanf(write_string, "%i", &val) == 1 &&
+	    (val == 0 || val == 1))
+		acpi_pcc_write_sset(hotkey, sinf_func, val);
+
+	return count;
+}
+
+static unsigned long write_brightness(struct file *file,
+				      const char __user *buffer,
+				      size_t count, int min_index,
+				      int max_index, int cur_index)
+{
+	struct seq_file	*seq = (struct seq_file *)file->private_data;
+	struct acpi_hotkey *hotkey = (struct acpi_hotkey *)seq->private;
+	char write_string[PROC_STR_MAX_LEN];
+	u32 bright;
+	u32 *sinf = kmalloc(sizeof(u32) * (hotkey->num_sifr + 1), GFP_KERNEL);
+
+	ACPI_FUNCTION_TRACE("write_brightness");
+
+	if (!hotkey || (count > sizeof(write_string) - 1))
+		return -EINVAL;
+
+	if (!sinf) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Couldn't allocate %li bytes\n",
+				  sizeof(u32) * hotkey->num_sifr));
+		return -EFAULT;
+	}
+
+	if (copy_from_user(write_string, buffer, count))
+		return -EFAULT;
+
+	write_string[count] = '\0';
+
+	if (!acpi_pcc_retrieve_biosdata(hotkey, sinf)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Couldn't retrieve BIOS data\n"));
+		goto end;
+	}
+
+	if (sscanf(write_string, "%i", &bright) == 1 &&
+	    bright >= sinf[min_index] && bright <= sinf[max_index])
+			acpi_pcc_write_sset(hotkey, cur_index, bright);
+
+end:
+	kfree(sinf);
+	return count;
+}
+
+static ssize_t acpi_pcc_write_ac_brightness(struct file *file,
+					    const char __user *buffer,
+					    size_t count, loff_t *ppos)
+{
+	return write_brightness(file, buffer, count, SINF_AC_MIN_BRIGHT,
+				SINF_AC_MAX_BRIGHT, SINF_AC_CUR_BRIGHT);
+}
+
+static ssize_t acpi_pcc_write_dc_brightness(struct file *file,
+					    const char __user *buffer,
+					    size_t count, loff_t *ppos)
+{
+	return write_brightness(file, buffer, count, SINF_DC_MIN_BRIGHT,
+				SINF_DC_MAX_BRIGHT, SINF_DC_CUR_BRIGHT);
+}
+
+static ssize_t acpi_pcc_write_mute(struct file *file,
+				   const char __user *buffer,
+				   size_t count, loff_t *ppos)
+{
+	return acpi_pcc_write_single_flag(file, buffer, count, SINF_MUTE);
+}
+
+static ssize_t acpi_pcc_write_sticky_key(struct file *file,
+					 const char __user *buffer,
+					 size_t count, loff_t *ppos)
+{
+	return acpi_pcc_write_single_flag(file, buffer, count, SINF_STICKY_KEY);
+}
+
+static ssize_t acpi_pcc_write_keyinput(struct file *file,
+				       const char __user *buffer,
+				       size_t count, loff_t *ppos)
+{
+	struct seq_file		*seq = (struct seq_file *)file->private_data;
+	struct acpi_hotkey	*hotkey = (struct acpi_hotkey *)seq->private;
+	struct pcc_keyinput 	*keyinput;
+	char			write_string[PROC_STR_MAX_LEN];
+	int			key_mode;
+
+	ACPI_FUNCTION_TRACE("acpi_pcc_write_keyinput");
+
+	if (!hotkey || (count > sizeof(write_string) - 1))
+		return -EINVAL;
+
+	if (copy_from_user(write_string, buffer, count))
+		return -EFAULT;
+
+	write_string[count] = '\0';
+
+	if (sscanf(write_string, "%i", &key_mode) == 1 &&
+	    (key_mode == 0 || key_mode == 1)) {
+		keyinput = input_get_drvdata(hotkey->input_dev);
+		keyinput->key_mode = key_mode;
+	}
+
+	return count;
+}
+
+/* hotkey driver */
+static void acpi_pcc_generete_keyinput(struct acpi_hotkey *hotkey)
+{
+	struct input_dev    *hotk_input_dev = hotkey->input_dev;
+	struct pcc_keyinput *keyinput = input_get_drvdata(hotk_input_dev);
+	int hinf = hotkey->status;
+	int key_code, hkey_num;
+	const int key_map[] = {
+		/*  0 */ -1,
+		/*  1 */ KEY_BRIGHTNESSDOWN,
+		/*  2 */ KEY_BRIGHTNESSUP,
+		/*  3 */ KEY_DISPLAYTOGGLE,
+		/*  4 */ KEY_MUTE,
+		/*  5 */ KEY_VOLUMEDOWN,
+		/*  6 */ KEY_VOLUMEUP,
+		/*  7 */ KEY_SLEEP,
+		/*  8 */ -1, /* Change CPU boost: do nothing */
+		/*  9 */ KEY_BATT,
+		/* 10 */ KEY_SUSPEND,
+	};
+
+	ACPI_FUNCTION_TRACE("acpi_pcc_generete_keyinput");
+
+	if (keyinput->key_mode == 0)
+		return;
+
+	hkey_num = hinf & 0xf;
+
+	if (hkey_num < 0 || hkey_num > ARRAY_SIZE(key_map)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "hotkey number out of range: %d\n",
+				  hkey_num));
+		return;
+	}
+
+	key_code = key_map[hkey_num];
+
+	if (key_code != -1) {
+		int pushed = (hinf & 0x80) ? TRUE : FALSE;
+
+		input_report_key(hotk_input_dev, key_code, pushed);
+		input_sync(hotk_input_dev);
+	}
+}
+
+static int acpi_pcc_hotkey_get_key(struct acpi_hotkey *hotkey)
+{
+	unsigned long result;
+	acpi_status status = AE_OK;
+
+	ACPI_FUNCTION_TRACE("acpi_pcc_hotkey_get_key");
+
+	status = acpi_evaluate_integer(hotkey->handle, METHOD_HKEY_QUERY,
+				       NULL, &result);
+	if (likely(ACPI_SUCCESS(status)))
+		hotkey->status = result;
+	else
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				 "error getting hotkey status\n"));
+
+	return status == AE_OK;
+}
+
+static void acpi_pcc_hotkey_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct acpi_hotkey *hotkey = (struct acpi_hotkey *) data;
+
+	ACPI_FUNCTION_TRACE("acpi_pcc_hotkey_notify");
+
+	switch (event) {
+	case HKEY_NOTIFY:
+		if (acpi_pcc_hotkey_get_key(hotkey)) {
+			/* generate event like '"pcc HKEY 00000080 00000084"'
+			 * when Fn+F4 pressed */
+			acpi_bus_generate_proc_event(hotkey->device, event,
+						     hotkey->status);
+		}
+		acpi_pcc_generete_keyinput(hotkey);
+		break;
+	default:
+		/* nothing to do */
+		break;
+	}
+}
+
+/* "seq" initializer */
+#define SEQ_OPEN_FS(_open_func_name_, _show_func_name_) \
+static int _open_func_name_(struct inode *inode, struct file *file) \
+{								      \
+	return single_open(file, _show_func_name_, PDE(inode)->data);  \
+}
+
+/* /proc/acpi interface */
+SEQ_OPEN_FS(acpi_pcc_dc_brightness_open_fs, acpi_pcc_dc_brightness_show);
+SEQ_OPEN_FS(acpi_pcc_numbatteries_open_fs, acpi_pcc_numbatteries_show);
+SEQ_OPEN_FS(acpi_pcc_lcdtype_open_fs, acpi_pcc_lcdtype_show);
+SEQ_OPEN_FS(acpi_pcc_ac_brightness_max_open_fs,
+	    acpi_pcc_ac_brightness_max_show);
+SEQ_OPEN_FS(acpi_pcc_ac_brightness_min_open_fs,
+	    acpi_pcc_ac_brightness_min_show);
+SEQ_OPEN_FS(acpi_pcc_ac_brightness_open_fs, acpi_pcc_ac_brightness_show);
+SEQ_OPEN_FS(acpi_pcc_dc_brightness_max_open_fs,
+	    acpi_pcc_dc_brightness_max_show);
+SEQ_OPEN_FS(acpi_pcc_dc_brightness_min_open_fs,
+	    acpi_pcc_dc_brightness_min_show);
+SEQ_OPEN_FS(acpi_pcc_brightness_open_fs, acpi_pcc_brightness_show);
+SEQ_OPEN_FS(acpi_pcc_mute_open_fs, acpi_pcc_mute_show);
+SEQ_OPEN_FS(acpi_pcc_version_open_fs, acpi_pcc_version_show);
+SEQ_OPEN_FS(acpi_pcc_keyinput_open_fs, acpi_pcc_keyinput_show);
+SEQ_OPEN_FS(acpi_pcc_sticky_key_open_fs, acpi_pcc_sticky_key_show);
+
+struct _proc_item {
+	const char *name;
+	struct file_operations fops;
+	mode_t flag;
+};
+
+/* "seq" fops template for read-only files. */
+#define SEQ_FILEOPS_R(_open_func_name_) \
+{ \
+	.open	 = _open_func_name_,		  \
+	.read	 = seq_read,			  \
+	.llseek	 = seq_lseek,			  \
+	.release = single_release,		  \
+}
+
+/* "seq" fops template for read-write files. */
+#define SEQ_FILEOPS_RW(_open_func_name_, _write_func_name_) \
+{ \
+	.open	 = _open_func_name_ ,		  \
+	.read	 = seq_read,			  \
+	.write	 = _write_func_name_,		  \
+	.llseek	 = seq_lseek,			  \
+	.release = single_release,		  \
+}
+
+/* Note: These functions map *exactly* to the SINF/SSET functions */
+static struct _proc_item pcc_proc_items_sifr[] = {
+	{
+		"num_batteries",
+		SEQ_FILEOPS_R(acpi_pcc_numbatteries_open_fs),
+		S_IRUGO,
+	}, {
+		"lcd_type",
+		SEQ_FILEOPS_R(acpi_pcc_lcdtype_open_fs),
+		S_IRUGO,
+	}, {
+		"ac_brightness_max",
+		SEQ_FILEOPS_R(acpi_pcc_ac_brightness_max_open_fs),
+		S_IRUGO,
+	}, {
+		"ac_brightness_min",
+		SEQ_FILEOPS_R(acpi_pcc_ac_brightness_min_open_fs),
+		S_IRUGO,
+	}, {
+		"ac_brightness",
+		SEQ_FILEOPS_RW(acpi_pcc_ac_brightness_open_fs,
+			       acpi_pcc_write_ac_brightness),
+		S_IFREG | S_IRUGO | S_IWUSR,
+	}, {
+		"dc_brightness_max",
+		SEQ_FILEOPS_R(acpi_pcc_dc_brightness_max_open_fs),
+		S_IRUGO,
+	}, {
+		"dc_brightness_min",
+		SEQ_FILEOPS_R(acpi_pcc_dc_brightness_min_open_fs),
+		S_IRUGO,
+	}, {
+		"dc_brightness",
+		SEQ_FILEOPS_RW(acpi_pcc_dc_brightness_open_fs,
+			       acpi_pcc_write_dc_brightness),
+		S_IFREG | S_IRUGO | S_IWUSR,
+	}, {
+		"brightness",
+		SEQ_FILEOPS_RW(acpi_pcc_brightness_open_fs,
+			       acpi_pcc_write_dc_brightness),
+		S_IFREG | S_IRUGO | S_IWUSR,
+	}, {
+		"mute",
+		SEQ_FILEOPS_RW(acpi_pcc_mute_open_fs,
+			       acpi_pcc_write_mute),
+		S_IFREG | S_IRUGO | S_IWUSR,
+	},
+	{ NULL, { 0 }, 0 },
+};
+
+static struct _proc_item pcc_proc_items[] = {
+	{
+		"sticky_key",
+		SEQ_FILEOPS_RW(acpi_pcc_sticky_key_open_fs,
+				acpi_pcc_write_sticky_key),
+		S_IFREG | S_IRUGO | S_IWUSR,
+	}, {
+		"version",
+		SEQ_FILEOPS_R(acpi_pcc_version_open_fs),
+		S_IRUGO,
+	}, {
+		"keyinput",
+		SEQ_FILEOPS_RW(acpi_pcc_keyinput_open_fs,
+				acpi_pcc_write_keyinput),
+		S_IFREG | S_IRUGO | S_IWUSR,
+	},
+	{ NULL, { 0 }, 0 },
+};
+
+static int acpi_pcc_add_device(struct acpi_device *device,
+			       struct _proc_item *proc_items, int num)
+{
+	struct acpi_hotkey *hotkey = acpi_driver_data(device);
+	struct proc_dir_entry *proc;
+	struct _proc_item *item;
+	int i;
+
+	for (item = proc_items, i = 0; item->name && i < num; ++item, ++i) {
+		proc = create_proc_entry(item->name, item->flag,
+					 hotkey->proc_dir_entry);
+		if (likely(proc)) {
+			proc->proc_fops = &item->fops;
+			proc->data = hotkey;
+			proc->owner = THIS_MODULE;
+		} else {
+			while (i-- > 0) {
+				item--;
+				remove_proc_entry(item->name,
+						  hotkey->proc_dir_entry);
+			}
+			return -ENODEV;
+		}
+	}
+	return 0;
+}
+
+static int acpi_pcc_proc_init(struct acpi_device *device)
+{
+	struct proc_dir_entry *acpi_pcc_dir;
+	struct acpi_hotkey *hotkey = acpi_driver_data(device);
+	acpi_status status;
+
+	ACPI_FUNCTION_TRACE("acpi_pcc_proc_init");
+
+	acpi_pcc_dir = proc_mkdir(PROC_PCC, acpi_root_dir);
+
+	if (unlikely(!acpi_pcc_dir)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Couldn't create dir in /proc\n"));
+		return -ENODEV;
+	}
+
+	acpi_pcc_dir->owner = THIS_MODULE;
+	hotkey->proc_dir_entry = acpi_pcc_dir;
+
+	status = acpi_pcc_add_device(device, pcc_proc_items_sifr,
+				     hotkey->num_sifr);
+	status |= acpi_pcc_add_device(device, pcc_proc_items,
+			sizeof(pcc_proc_items)/sizeof(struct _proc_item));
+	if (unlikely(status)) {
+		remove_proc_entry(PROC_PCC, acpi_root_dir);
+		hotkey->proc_dir_entry = NULL;
+		return -ENODEV;
+	}
+
+	return status;
+}
+
+static void acpi_pcc_remove_device(struct acpi_device *device,
+				   struct _proc_item *proc_items, int num)
+{
+	struct acpi_hotkey *hotkey = acpi_driver_data(device);
+	struct _proc_item *item;
+	int i;
+
+	for (item = proc_items, i = 0;
+	     item->name != NULL && i < num;
+	     ++item, ++i)
+		remove_proc_entry(item->name, hotkey->proc_dir_entry);
+}
+
+static int acpi_pcc_init_input(struct acpi_hotkey *hotkey)
+{
+	struct input_dev *hotk_input_dev;
+	struct pcc_keyinput *pcc_keyinput;
+	int rc;
+
+	ACPI_FUNCTION_TRACE("acpi_pcc_init_input");
+
+	hotk_input_dev = input_allocate_device();
+	if (!hotk_input_dev) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Couldn't allocate input device for hotkey"));
+		return -ENOMEM;
+	}
+
+	pcc_keyinput = kmalloc(sizeof(struct pcc_keyinput), GFP_KERNEL);
+
+	if (pcc_keyinput == NULL) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Couldn't allocate mem for hotkey"));
+		input_free_device(hotk_input_dev);
+		return -ENOMEM;
+	}
+
+	hotk_input_dev->evbit[0] = BIT(EV_KEY);
+
+	set_bit(KEY_BRIGHTNESSDOWN, hotk_input_dev->keybit);
+	set_bit(KEY_BRIGHTNESSUP, hotk_input_dev->keybit);
+	set_bit(KEY_MUTE, hotk_input_dev->keybit);
+	set_bit(KEY_VOLUMEDOWN, hotk_input_dev->keybit);
+	set_bit(KEY_VOLUMEUP, hotk_input_dev->keybit);
+	set_bit(KEY_SLEEP, hotk_input_dev->keybit);
+	set_bit(KEY_BATT, hotk_input_dev->keybit);
+	set_bit(KEY_SUSPEND, hotk_input_dev->keybit);
+
+	hotk_input_dev->name = ACPI_PCC_DRIVER_NAME;
+	hotk_input_dev->phys = ACPI_PCC_INPUT_PHYS;
+	hotk_input_dev->id.bustype = 0x1a; /* XXX FIXME: BUS_I8042? */
+	hotk_input_dev->id.vendor = 0x0001;
+	hotk_input_dev->id.product = 0x0001;
+	hotk_input_dev->id.version = 0x0100;
+
+	pcc_keyinput->key_mode = 1; /* default on */
+	pcc_keyinput->hotkey = hotkey;
+
+	input_set_drvdata(hotk_input_dev, pcc_keyinput);
+
+	hotkey->input_dev = hotk_input_dev;
+
+	rc = input_register_device(hotk_input_dev);
+	if (rc < 0) {
+		kfree(pcc_keyinput);
+		input_free_device(hotk_input_dev);
+	}
+
+	return rc;
+}
+
+/* kernel module interface */
+
+static int acpi_pcc_hotkey_resume(struct acpi_device *device)
+{
+	struct acpi_hotkey *hotkey = acpi_driver_data(device);
+	acpi_status status = AE_OK;
+
+	ACPI_FUNCTION_TRACE("acpi_pcc_hotkey_resume");
+
+	if (device == NULL || hotkey == NULL)
+		return -EINVAL;
+
+	ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Sticky mode restore: %d\n",
+			  hotkey->sticky_mode));
+
+	status = acpi_pcc_write_sset(hotkey, SINF_STICKY_KEY,
+				     hotkey->sticky_mode);
+
+	return status == AE_OK ? 0 : -EINVAL;
+}
+
+static int acpi_pcc_hotkey_add(struct acpi_device *device)
+{
+	acpi_status status;
+	struct acpi_hotkey *hotkey;
+	int num_sifr, result;
+
+	ACPI_FUNCTION_TRACE("acpi_pcc_hotkey_add");
+
+	if (!device)
+		return -EINVAL;
+
+	num_sifr = acpi_pcc_get_sqty(device);
+
+	if (num_sifr > 255) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "num_sifr too large"));
+		return -ENODEV;
+	}
+
+	hotkey = kmalloc(sizeof(struct acpi_hotkey), GFP_KERNEL);
+	if (!hotkey) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Couldn't allocate mem for hotkey"));
+		return -ENOMEM;
+	}
+	memset(hotkey, 0, sizeof(struct acpi_hotkey));
+
+	hotkey->sinf = kmalloc(sizeof(u32) * (num_sifr + 1), GFP_KERNEL);
+	if (!hotkey->sinf) {
+		result = -ENOMEM;
+		goto out_hotkey;
+	}
+
+	hotkey->device = device;
+	hotkey->handle = device->handle;
+	hotkey->num_sifr = num_sifr;
+	acpi_driver_data(device) = hotkey;
+	strcpy(acpi_device_name(device), ACPI_PCC_DEVICE_NAME);
+	strcpy(acpi_device_class(device), ACPI_PCC_CLASS);
+
+	status = acpi_install_notify_handler (
+			hotkey->handle,
+			ACPI_DEVICE_NOTIFY,
+			acpi_pcc_hotkey_notify,
+			hotkey);
+
+	if (ACPI_FAILURE(status)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Error installing notify handler\n"));
+		result = -ENODEV;
+		goto out_sinf;
+	}
+
+	result = acpi_pcc_init_input(hotkey);
+	if (result) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Error installing keyinput handler\n"));
+		goto out_notify;
+	}
+
+	hotkey->backlight = backlight_device_register("panasonic", NULL,
+						      hotkey,
+						      &pcc_backlight_ops);
+	if (IS_ERR(hotkey->backlight))
+		goto out_input;
+
+	if (!acpi_pcc_retrieve_biosdata(hotkey, hotkey->sinf)) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				 "Couldn't retrieve BIOS data\n"));
+		goto out_backlight;
+	}
+
+	hotkey->backlight->props.max_brightness =
+					hotkey->sinf[SINF_AC_MAX_BRIGHT];
+	hotkey->backlight->props.brightness = hotkey->sinf[SINF_AC_CUR_BRIGHT];
+
+	result = acpi_pcc_proc_init(device);
+	if (result)
+		goto out_backlight;
+
+	return 0;
+
+out_backlight:
+	backlight_device_unregister(hotkey->backlight);
+out_notify:
+	acpi_remove_notify_handler(hotkey->handle, ACPI_DEVICE_NOTIFY,
+				   acpi_pcc_hotkey_notify);
+out_input:
+	input_unregister_device(hotkey->input_dev);
+	kfree(input_get_drvdata(hotkey->input_dev));
+	input_free_device(hotkey->input_dev);
+out_sinf:
+	kfree(hotkey->sinf);
+out_hotkey:
+	kfree(hotkey);
+
+	return result;
+}
+
+static int __init acpi_pcc_init(void)
+{
+	int result = 0;
+
+	ACPI_FUNCTION_TRACE("acpi_pcc_init");
+
+	if (acpi_disabled)
+		return -ENODEV;
+
+	result = acpi_bus_register_driver(&acpi_pcc_driver);
+	if (result < 0) {
+		ACPI_DEBUG_PRINT((ACPI_DB_ERROR,
+				  "Error registering hotkey driver\n"));
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int acpi_pcc_hotkey_remove(struct acpi_device *device, int type)
+{
+	struct acpi_hotkey *hotkey = acpi_driver_data(device);
+
+	ACPI_FUNCTION_TRACE("acpi_pcc_hotkey_remove");
+
+	if (!device || !hotkey)
+		return -EINVAL;
+
+	if (hotkey->proc_dir_entry) {
+		acpi_pcc_remove_device(device, pcc_proc_items_sifr,
+				       hotkey->num_sifr);
+		acpi_pcc_remove_device(device, pcc_proc_items,
+			sizeof(pcc_proc_items)/sizeof(struct _proc_item));
+		remove_proc_entry(PROC_PCC, acpi_root_dir);
+	}
+
+	backlight_device_unregister(hotkey->backlight);
+
+	acpi_remove_notify_handler(hotkey->handle, ACPI_DEVICE_NOTIFY,
+				   acpi_pcc_hotkey_notify);
+
+	input_unregister_device(hotkey->input_dev);
+	kfree(input_get_drvdata(hotkey->input_dev));
+	input_free_device(hotkey->input_dev);
+
+	kfree(hotkey->sinf);
+	kfree(hotkey);
+
+	return 0;
+}
+
+static void __exit acpi_pcc_exit(void)
+{
+	ACPI_FUNCTION_TRACE("acpi_pcc_exit");
+
+	acpi_bus_unregister_driver(&acpi_pcc_driver);
+}
+
+module_init(acpi_pcc_init);
+module_exit(acpi_pcc_exit);
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
