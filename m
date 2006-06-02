From: akpm@osdl.org
Subject: [patch 13/13] Support enable/disable of WAN module in ibm_acpi
Date: Thu, 01 Jun 2006 20:18:53 -0700
Message-ID: <200606020314.k523EYG4028343@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:17329 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751183AbWFBDOj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2006 23:14:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, jeremy@goop.org, borislav@users.sourceforge.net


From: Jeremy Fitzhardinge <jeremy@goop.org>

The WAN (Sierra Wireless EV-DO) module is very similar to the Bluetooth
module.  It appears on the USB bus when enabled.  It can be controlled via
hot key, or directly via ACPI.  This change enables direct control via
ACPI.

I have tested it on my Lenovo Thinkpad X60; I guess it will probably work
on other Thinkpad models which come with this module installed.

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>
Acked-by: Borislav Deianov <borislav@users.sourceforge.net>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/ibm_acpi.c |   69 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff -puN drivers/acpi/ibm_acpi.c~support-enable-disable-of-wan-module-in-ibm_acpi drivers/acpi/ibm_acpi.c
--- devel/drivers/acpi/ibm_acpi.c~support-enable-disable-of-wan-module-in-ibm_acpi	2006-06-01 20:17:11.000000000 -0700
+++ devel-akpm/drivers/acpi/ibm_acpi.c	2006-06-01 20:17:11.000000000 -0700
@@ -630,6 +630,68 @@ static int wan_write(char *buf)
 	return 0;
 }
 
+static int wan_supported;
+
+static int wan_init(void)
+{
+	wan_supported = hkey_handle &&
+	    acpi_evalf(hkey_handle, NULL, "GWAN", "qv");
+
+	return 0;
+}
+
+static int wan_status(void)
+{
+	int status;
+
+	if (!wan_supported || !acpi_evalf(hkey_handle, &status, "GWAN", "d"))
+		status = 0;
+
+	return status;
+}
+
+static int wan_read(char *p)
+{
+	int len = 0;
+	int status = wan_status();
+
+	if (!wan_supported)
+		len += sprintf(p + len, "status:\t\tnot supported\n");
+	else if (!(status & 1))
+		len += sprintf(p + len, "status:\t\tnot installed\n");
+	else {
+		len += sprintf(p + len, "status:\t\t%s\n", enabled(status, 1));
+		len += sprintf(p + len, "commands:\tenable, disable\n");
+	}
+
+	return len;
+}
+
+static int wan_write(char *buf)
+{
+	int status = wan_status();
+	char *cmd;
+	int do_cmd = 0;
+
+	if (!wan_supported)
+		return -ENODEV;
+
+	while ((cmd = next_cmd(&buf))) {
+		if (strlencmp(cmd, "enable") == 0) {
+			status |= 2;
+		} else if (strlencmp(cmd, "disable") == 0) {
+			status &= ~2;
+		} else
+			return -EINVAL;
+		do_cmd = 1;
+	}
+
+	if (do_cmd && !acpi_evalf(hkey_handle, NULL, "SWAN", "vd", status))
+		return -EIO;
+
+	return 0;
+}
+
 static int video_supported;
 static int video_orig_autosw;
 
@@ -1633,6 +1695,13 @@ static struct ibm_struct ibms[] = {
 	 .experimental = 1,
 	 },
 	{
+	 .name = "wan",
+	 .init = wan_init,
+	 .read = wan_read,
+	 .write = wan_write,
+	 .experimental = 1,
+	 },
+	{
 	 .name = "video",
 	 .init = video_init,
 	 .read = video_read,
_
