From: John Belmonte <jvb-ZFKsivP1bGvOQU1ULcgDhA@public.gmane.org>
Subject: [PATCH] Toshiba ACPI Extras 0.15
Date: Sat, 17 May 2003 11:40:13 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3EC657DD.5040502@prairienet.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090607090408010908000803"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel <acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------090607090408010908000803
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Andy,

This is a patch for version 0.15 of my driver.  Please apply it to both the 2.5 
and 2.4 trees.

Changes:

     * Workaround sporatic problem on some machines where hotkey status stops
       working

     * Minor cleanup


Regards,
-John



-- 
http:// if   l .o  /


--------------090607090408010908000803
Content-Type: text/plain;
 name="toshiba_acpi_0.15-linux_2.5.69.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="toshiba_acpi_0.15-linux_2.5.69.patch"

--- toshiba_acpi.c.old	2003-05-17 11:15:06.000000000 -0400
+++ toshiba_acpi.c	2003-05-17 11:21:11.000000000 -0400
@@ -33,7 +33,7 @@
  *
  */
 
-#define TOSHIBA_ACPI_VERSION	"0.14"
+#define TOSHIBA_ACPI_VERSION	"0.15"
 #define PROC_INTERFACE_VERSION	1
 
 #include <linux/kernel.h>
@@ -172,9 +172,7 @@
 	for (i = 0; i < HCI_WORDS; ++i) {
 		in_objs[i].type = ACPI_TYPE_INTEGER;
 		in_objs[i].integer.value = in[i];
-		/*printk("%04x ", in[i]);*/
 	}
-	/*printk("\n");*/
 
 	results.length = sizeof(out_objs);
 	results.pointer = out_objs;
@@ -184,9 +182,7 @@
 	if ((status == AE_OK) && (out_objs->package.count <= HCI_WORDS)) {
 		for (i = 0; i < out_objs->package.count; ++i) {
 			out[i] = out_objs->package.elements[i].integer.value;
-			/*printk("%04x ", out[i]);*/
 		}
-		/*printk("\n");*/
 	}
 
 	return status;
@@ -226,7 +222,7 @@
 
 typedef struct _ProcItem
 {
-	char* name;
+	const char* name;
 	char* (*read_func)(char*);
 	unsigned long (*write_func)(const char*, unsigned long);
 } ProcItem;
@@ -284,10 +280,8 @@
 write_lcd(const char* buffer, unsigned long count)
 {
 	int value;
-	/*int byte_count;*/
 	u32 hci_result;
 
-	/* ISSUE: %i doesn't work with hex values as advertised */
 	if (snscanf(buffer, count, " brightness : %i", &value) == 1 &&
 			value >= 0 && value < HCI_LCD_BRIGHTNESS_LEVELS) {
 		value = value << HCI_LCD_BRIGHTNESS_SHIFT;
@@ -414,6 +408,11 @@
 			last_key_event = value;
 		} else if (hci_result == HCI_EMPTY) {
 			/* better luck next time */
+		} else if (hci_result == HCI_NOT_SUPPORTED) {
+			/* This is a workaround for an unresolved issue on
+			 * some machines where system events sporadically
+			 * become disabled. */
+			hci_write1(HCI_SYSTEM_EVENT, 1, &hci_result);
 		} else {
 			p += sprintf(p, "ERROR\n");
 			goto end;

--------------090607090408010908000803--



-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
