From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 02/21] ACPI: ibm-acpi: trivial Lindent
	cleanups
Date: Sat, 25 Nov 2006 18:42:36 -0200
Message-ID: <20061125204236.6604.33801.stgit@thorin.khazad-dum.debian.net>
References: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20061125204155.6604.35338.stgit-H32KNTuDSMjdPi8JTuvWk31TOOPCyuNQ5NbjCUgZEJk@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>

This patch just makes drives/acpi/ibm-acpi.c Lindent-clean, as requested by
Len Brown.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---

 drivers/acpi/ibm_acpi.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 9baae34..622626b 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -584,8 +584,7 @@ static int wan_status(void)
 {
 	int status;
 
-	if (!wan_supported ||
-	    !acpi_evalf(hkey_handle, &status, "GWAN", "d"))
+	if (!wan_supported || !acpi_evalf(hkey_handle, &status, "GWAN", "d"))
 		status = 0;
 
 	return status;
@@ -910,6 +909,7 @@ static int _sta(acpi_handle handle)
 
 	return status;
 }
+
 #ifdef CONFIG_ACPI_IBM_DOCK
 #define dock_docked() (_sta(dock_handle) & 1)
 
@@ -1386,12 +1386,12 @@ static int brightness_offset = 0x31;
 
 static int brightness_get(struct backlight_device *bd)
 {
-       u8 level;
-       if (!acpi_ec_read(brightness_offset, &level))
-               return -EIO;
+	u8 level;
+	if (!acpi_ec_read(brightness_offset, &level))
+		return -EIO;
 
-       level &= 0x7;
-       return level;
+	level &= 0x7;
+	return level;
 }
 
 static int brightness_read(char *p)
@@ -1992,10 +1992,10 @@ IBM_PARAM(volume);
 IBM_PARAM(fan);
 
 static struct backlight_properties ibm_backlight_data = {
-        .owner          = THIS_MODULE,
-        .get_brightness = brightness_get,
-        .update_status  = brightness_update_status,
-        .max_brightness = 7,
+	.owner = THIS_MODULE,
+	.get_brightness = brightness_get,
+	.update_status = brightness_update_status,
+	.max_brightness = 7,
 };
 
 static void acpi_ibm_exit(void)
@@ -2074,7 +2074,7 @@ static int __init acpi_ibm_init(void)
 
 	ibm_backlight_device = backlight_device_register("ibm", NULL,
 							 &ibm_backlight_data);
-        if (IS_ERR(ibm_backlight_device)) {
+	if (IS_ERR(ibm_backlight_device)) {
 		printk(IBM_ERR "Could not register ibm backlight device\n");
 		ibm_backlight_device = NULL;
 		acpi_ibm_exit();

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
