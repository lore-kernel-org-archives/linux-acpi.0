From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Add mising static's to button.c
Date: Wed, 18 Dec 2002 23:11:42 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20021218221142.GA321@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

Should be obvious, please apply,
							Pavel

--- clean/drivers/acpi/button.c	2002-11-29 21:16:33.000000000 +0100
+++ linux-sensors/drivers/acpi/button.c	2002-12-16 23:20:15.000000000 +0100
@@ -68,8 +68,8 @@
 MODULE_LICENSE("GPL");
 
 
-int acpi_button_add (struct acpi_device *device);
-int acpi_button_remove (struct acpi_device *device, int type);
+static int acpi_button_add (struct acpi_device *device);
+static int acpi_button_remove (struct acpi_device *device, int type);
 static int acpi_button_open_fs(struct inode *inode, struct file *file);
 
 static struct acpi_driver acpi_button_driver = {
@@ -234,7 +234,7 @@
 }
 
 
-int
+static int
 acpi_button_add (
 	struct acpi_device	*device)
 {
@@ -384,7 +384,7 @@
 }
 
 
-int
+static int
 acpi_button_remove (struct acpi_device *device, int type)
 {
 	acpi_status		status = 0;

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?


-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
