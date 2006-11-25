From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 19/21] ACPI: ibm-acpi: backlight device
	cleanup
Date: Sat, 25 Nov 2006 18:48:17 -0200
Message-ID: <20061125204817.6604.31692.stgit@thorin.khazad-dum.debian.net>
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

This patch cleans up the recently added backlight device support by Holger
Macht <hmacht-l3A5Bk7waGM@public.gmane.org> to fit well with the rest of the code, using the
ibms struct as the other "subdrivers" in ibm-acpi.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---

 drivers/acpi/ibm_acpi.c |   50 +++++++++++++++++++++++++++++------------------
 1 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 3a4dce1..649db29 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -397,7 +397,7 @@ struct ibm_struct {
 
 static struct proc_dir_entry *proc_dir = NULL;
 
-static struct backlight_device *ibm_backlight_device;
+static struct backlight_device *ibm_backlight_device = NULL;
 
 #define onoff(status,bit) ((status) & (1 << (bit)) ? "on" : "off")
 #define enabled(status,bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
@@ -1639,6 +1639,7 @@ static int brightness_get(struct backlig
 		return -EIO;
 
 	level &= 0x7;
+
 	return level;
 }
 
@@ -1713,6 +1714,33 @@ static int brightness_update_status(stru
 	return brightness_set(bd->props->brightness);
 }
 
+static struct backlight_properties ibm_backlight_data = {
+        .owner          = THIS_MODULE,
+        .get_brightness = brightness_get,
+        .update_status  = brightness_update_status,
+        .max_brightness = 7,
+};
+
+static int brightness_init(void)
+{
+	ibm_backlight_device = backlight_device_register("ibm", NULL,
+							 &ibm_backlight_data);
+	if (IS_ERR(ibm_backlight_device)) {
+		printk(IBM_ERR "Could not register backlight device\n");
+		return PTR_ERR(ibm_backlight_device);
+	}
+
+	return 0;
+}
+
+static void brightness_exit(void)
+{
+	if (ibm_backlight_device) {
+		backlight_device_unregister(ibm_backlight_device);
+		ibm_backlight_device = NULL;
+	}
+}
+
 static int volume_offset = 0x30;
 
 static int volume_read(char *p)
@@ -2377,6 +2405,8 @@ static struct ibm_struct ibms[] = {
 	 .name = "brightness",
 	 .read = brightness_read,
 	 .write = brightness_write,
+	 .init = brightness_init,
+	 .exit = brightness_exit,
 	 },
 	{
 	 .name = "volume",
@@ -2641,20 +2671,10 @@ IBM_PARAM(brightness);
 IBM_PARAM(volume);
 IBM_PARAM(fan);
 
-static struct backlight_properties ibm_backlight_data = {
-	.owner = THIS_MODULE,
-	.get_brightness = brightness_get,
-	.update_status = brightness_update_status,
-	.max_brightness = 7,
-};
-
 static void acpi_ibm_exit(void)
 {
 	int i;
 
-	if (ibm_backlight_device)
-		backlight_device_unregister(ibm_backlight_device);
-
 	for (i = ARRAY_SIZE(ibms) - 1; i >= 0; i--)
 		ibm_exit(&ibms[i]);
 
@@ -2757,14 +2777,6 @@ static int __init acpi_ibm_init(void)
 		}
 	}
 
-	ibm_backlight_device = backlight_device_register("ibm", NULL,
-							 &ibm_backlight_data);
-	if (IS_ERR(ibm_backlight_device)) {
-		printk(IBM_ERR "Could not register ibm backlight device\n");
-		ibm_backlight_device = NULL;
-		acpi_ibm_exit();
-	}
-
 	return 0;
 }
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
