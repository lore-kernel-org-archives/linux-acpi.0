From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: acpi/fan.c: fix whitespace and macros used just once
Date: Sun, 17 Jul 2005 21:12:52 +0200
Message-ID: <20050717191252.GA12658@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This cleans up some whitespace in acpi/fan.c. No code changes.

Signed-off-by: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>


diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -37,11 +37,8 @@
 
 #define ACPI_FAN_COMPONENT		0x00200000
 #define ACPI_FAN_CLASS			"fan"
-#define ACPI_FAN_HID			"PNP0C0B"
 #define ACPI_FAN_DRIVER_NAME		"ACPI Fan Driver"
-#define ACPI_FAN_DEVICE_NAME		"Fan"
 #define ACPI_FAN_FILE_STATE		"state"
-#define ACPI_FAN_NOTIFY_STATUS		0x80
 
 #define _COMPONENT		ACPI_FAN_COMPONENT
 ACPI_MODULE_NAME		("acpi_fan")
@@ -56,7 +53,7 @@ static int acpi_fan_remove (struct acpi_
 static struct acpi_driver acpi_fan_driver = {
 	.name =		ACPI_FAN_DRIVER_NAME,
 	.class =	ACPI_FAN_CLASS,
-	.ids =		ACPI_FAN_HID,
+	.ids =		"PNP0C0B",
 	.ops =		{
 				.add =		acpi_fan_add,
 				.remove =	acpi_fan_remove,
@@ -76,7 +73,7 @@ static struct proc_dir_entry	*acpi_fan_d
 
 
 static int
-acpi_fan_read_state (struct seq_file *seq, void *offset)
+acpi_fan_read_state(struct seq_file *seq, void *offset)
 {
 	struct acpi_fan		*fan = seq->private;
 	int			state = 0;
@@ -99,11 +96,8 @@ static int acpi_fan_state_open_fs(struct
 }
 
 static ssize_t
-acpi_fan_write_state (
-	struct file		*file,
-	const char		__user *buffer,
-	size_t			count,
-	loff_t			*ppos)
+acpi_fan_write_state(struct file *file, const char __user *buffer, 
+		     size_t count, loff_t *ppos)
 {
 	int			result = 0;
 	struct seq_file		*m = (struct seq_file *)file->private_data;
@@ -138,8 +132,7 @@ static struct file_operations acpi_fan_s
 };
 
 static int
-acpi_fan_add_fs (
-	struct acpi_device	*device)
+acpi_fan_add_fs(struct acpi_device *device)
 {
 	struct proc_dir_entry	*entry = NULL;
 
@@ -174,8 +167,7 @@ acpi_fan_add_fs (
 
 
 static int
-acpi_fan_remove_fs (
-	struct acpi_device	*device)
+acpi_fan_remove_fs(struct acpi_device *device)
 {
 	ACPI_FUNCTION_TRACE("acpi_fan_remove_fs");
 
@@ -195,8 +187,7 @@ acpi_fan_remove_fs (
    -------------------------------------------------------------------------- */
 
 static int
-acpi_fan_add (
-	struct acpi_device	*device)
+acpi_fan_add(struct acpi_device *device)
 {
 	int			result = 0;
 	struct acpi_fan		*fan = NULL;
@@ -213,7 +204,7 @@ acpi_fan_add (
 	memset(fan, 0, sizeof(struct acpi_fan));
 
 	fan->handle = device->handle;
-	strcpy(acpi_device_name(device), ACPI_FAN_DEVICE_NAME);
+	strcpy(acpi_device_name(device), "Fan");
 	strcpy(acpi_device_class(device), ACPI_FAN_CLASS);
 	acpi_driver_data(device) = fan;
 
@@ -241,11 +232,9 @@ end:
 
 
 static int
-acpi_fan_remove (
-	struct acpi_device	*device,
-	int			type)
+acpi_fan_remove(struct acpi_device *device, int type)
 {
-	struct acpi_fan		*fan = NULL;
+	struct acpi_fan *fan = NULL;
 
 	ACPI_FUNCTION_TRACE("acpi_fan_remove");
 
@@ -263,9 +252,9 @@ acpi_fan_remove (
 
 
 static int __init
-acpi_fan_init (void)
+acpi_fan_init(void)
 {
-	int			result = 0;
+	int result = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_fan_init");
 
@@ -285,7 +274,7 @@ acpi_fan_init (void)
 
 
 static void __exit
-acpi_fan_exit (void)
+acpi_fan_exit(void)
 {
 	ACPI_FUNCTION_TRACE("acpi_fan_exit");
 

-- 
teflon -- maybe it is a trademark, but it should not be.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
