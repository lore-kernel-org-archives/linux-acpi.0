From: "Dino Klein" <dinoklein-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: patch & a question about the serial driver
Date: Sat, 19 Jun 2004 23:55:09 -0300
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <BAY16-F112kKIBXEHt30004aded@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I am interested to know whether the patch below looks like a good idea as a 
way to allow the user to specify additional HIDs that the driver should 
handle; I had to add an HID to the list when I tried to get the Wacom device 
in my tablet to work, since it was using a different HID than the standard 
one for serial ports. This patch would allow the user to specify an 
alternative string of HIDs without having to recompile the kernel.
The extra question I have is about the HIDs listed in the 8250_pnp.c file; 
shouldn't those values (some, or all) be shared with between the two 
drivers? or are they unlikely to show up through ACPI?


--- linux-2.6.7-orig/drivers/serial/8250_acpi.c	2004-06-19 
22:07:23.668416224 -0400
+++ linux-2.6.7/drivers/serial/8250_acpi.c	2004-06-19 21:45:20.000000000 
-0400
@@ -21,6 +21,13 @@
#include <asm/io.h>
#include <asm/serial.h>

+
+static char *hids = "PNP0501";
+
+MODULE_PARM(hids, "s");
+
+
+
struct serial_private {
	int	line;
	void	*iomem_base;
@@ -173,7 +180,6 @@
static struct acpi_driver acpi_serial_driver = {
	.name =		"serial",
	.class =	"",
-	.ids =		"PNP0501",
	.ops =	{
		.add =		acpi_serial_add,
		.remove =	acpi_serial_remove,
@@ -182,6 +188,7 @@

static int __init acpi_serial_init(void)
{
+	acpi_serial_driver.ids = hids;
	return acpi_bus_register_driver(&acpi_serial_driver);
}

_________________________________________________________________
MSN Messenger: instale grátis e converse com seus amigos. 
http://messenger.msn.com.br



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
