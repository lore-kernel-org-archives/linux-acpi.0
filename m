From: Xose Vazquez Perez <xose-39ZsbGIQGT7e5aOfsHch1g@public.gmane.org>
Subject: [PATCH] fix for kbuild - hotplug_acpi
Date: Thu, 23 Oct 2003 20:21:34 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3F981C2E.5070602@wanadoo.es>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020701010409000404040701"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------020701010409000404040701
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

hi,

Fix for a missing "y" in drivers/hotplug/Config.in
patch against 2.4.23-pre8.

-thanks-
-- 
HTML mails are going to trash automatically


--------------020701010409000404040701
Content-Type: text/plain;
 name="kbuild-hotplug-acpi.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kbuild-hotplug-acpi.diff"

--- linux/drivers/hotplug/Config.in	2003-08-27 17:26:39.000000000 +0200
+++ new/drivers/hotplug/Config.in	2003-10-23 20:10:20.000000000 +0200
@@ -11,7 +11,7 @@
 if [ "$CONFIG_X86_IO_APIC" = "y" ]; then
    dep_tristate '  IBM PCI Hotplug driver' CONFIG_HOTPLUG_PCI_IBM $CONFIG_HOTPLUG_PCI $CONFIG_X86_IO_APIC $CONFIG_X86
 fi
-if [ "$CONFIG_ACPI_INTERPRETER" ]; then
+if [ "$CONFIG_ACPI_INTERPRETER" = "y" ]; then
    dep_tristate '  ACPI PCI Hotplug driver' CONFIG_HOTPLUG_PCI_ACPI $CONFIG_HOTPLUG_PCI
 fi
 endmenu


--------------020701010409000404040701--



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
