From: Len Brown <len.brown@intel.com>
Subject: Re: Allow userspace do something special on overtemp
Date: 12 Aug 2004 11:19:05 -0400
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1092323945.5028.177.camel@dhcppc4>
References: <20040811085326.GA11765@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268587AbUHLPTb@vger.kernel.org>
In-Reply-To: <20040811085326.GA11765@elf.ucw.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: trenn@suse.de, seife@suse.de, Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

Simpler to delete the usermode call and rely on the (flexible)
acpid event, yes?

 thermal.c |   29 +----------------------------
 1 files changed, 1 insertion(+), 28 deletions(-)

cheers,
-Len


===== drivers/acpi/thermal.c 1.34 vs edited =====
--- 1.34/drivers/acpi/thermal.c	Thu Jul  8 01:56:01 2004
+++ edited/drivers/acpi/thermal.c	Thu Aug 12 11:13:59 2004
@@ -61,7 +61,6 @@
 #define ACPI_THERMAL_MODE_ACTIVE	0x00
 #define ACPI_THERMAL_MODE_PASSIVE	0x01
 #define ACPI_THERMAL_MODE_CRT   	0xff
-#define ACPI_THERMAL_PATH_POWEROFF	"/sbin/poweroff"
 
 #define ACPI_THERMAL_MAX_ACTIVE	10
 
@@ -422,30 +421,6 @@
 
 
 static int
-acpi_thermal_call_usermode (
-	char			*path)
-{
-	char			*argv[2] = {NULL, NULL};
-	char			*envp[3] = {NULL, NULL, NULL};
-
-	ACPI_FUNCTION_TRACE("acpi_thermal_call_usermode");
-
-	if (!path)
-		return_VALUE(-EINVAL);
-
-	argv[0] = path;
-
-	/* minimal command environment */
-	envp[0] = "HOME=/";
-	envp[1] = "PATH=/sbin:/bin:/usr/sbin:/usr/bin";
-	
-	call_usermodehelper(argv[0], argv, envp, 0);
-
-	return_VALUE(0);
-}
-
-
-static int
 acpi_thermal_critical (
 	struct acpi_thermal	*tz)
 {
@@ -468,10 +443,8 @@
 	if (result)
 		return_VALUE(result);
 
-	printk(KERN_EMERG "Critical temperature reached (%ld C), shutting
down.\n", KELVIN_TO_CELSIUS(tz->temperature));
+	printk(KERN_EMERG "Critical temperature reached (%ld C).\n",
KELVIN_TO_CELSIUS(tz->temperature));
 	acpi_bus_generate_event(device, ACPI_THERMAL_NOTIFY_CRITICAL,
tz->trips.critical.flags.enabled);
-
-	acpi_thermal_call_usermode(ACPI_THERMAL_PATH_POWEROFF);
 
 	return_VALUE(0);
 }
