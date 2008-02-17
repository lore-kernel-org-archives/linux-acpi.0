From: Fabien Crespel <fabien-czgx1wgAc3rR7s880joybQ@public.gmane.org>
Subject: [PATCH] asus-laptop: add suspend/resume handlers
Date: Sun, 17 Feb 2008 17:48:51 +0100
Message-ID: <47B86573.9080202@crespel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

here is a patch to add platform suspend/resume handlers to the asus-laptop 
driver, for WLAN/Bluetooth LEDs.

Please note that it needs to be applied after my previous patch "asus-laptop add 
kill switch support", posted in the linux-acpi and acpi4asus mailing lists.

I tested it on my laptop (ASUS F3JC) with s2ram and s2disk, and it works well. 
It's quite simple, so it should work on most (if not all) ASUS laptops without 
any problem.

Regards,
- Fabien.

---
From: Fabien Crespel <fabien-czgx1wgAc3rR7s880joybQ@public.gmane.org>

This patch adds simple suspend/resume handlers to store/restore the 
WLAN/Bluetooth LEDs status.

Signed-off-by: Fabien Crespel <fabien-czgx1wgAc3rR7s880joybQ@public.gmane.org>
---
  asus-laptop.git.suspend.c |   41 ++++++++++++++++++++++++++++++++++++++++-
  1 file changed, 40 insertions(+), 1 deletion(-)

--- a/drivers/misc/asus-laptop.c	2008-02-17 16:41:02.000000000 +0100
+++ b/drivers/misc/asus-laptop.c	2008-02-17 16:52:08.000000000 +0100
@@ -31,7 +31,7 @@
   *  Josh Green     - Light Sens support
   *  Thomas Tuttle  - His first patch for led support was very helpfull
   *  Sam Lin        - GPS support
- *  Fabien Crespel - Kill Switch support
+ *  Fabien Crespel - Kill Switch and suspend/resume support
   */

  #include <linux/kernel.h>
@@ -926,7 +926,12 @@ static struct attribute_group asuspf_att
  	.attrs = asuspf_attributes
  };

+static int asus_hotk_suspend(struct platform_device *dev, pm_message_t state);
+static int asus_hotk_resume(struct platform_device *dev);
+
  static struct platform_driver asuspf_driver = {
+	.suspend = asus_hotk_suspend,
+	.resume = asus_hotk_resume,
  	.driver = {
  		   .name = ASUS_HOTK_FILE,
  		   .owner = THIS_MODULE,
@@ -1211,6 +1216,40 @@ static int asus_hotk_remove(struct acpi_
  	return 0;
  }

+static int asus_hotk_suspend(struct platform_device *dev, pm_message_t state)
+{
+	/* Refresh the internal status before suspending, to restore it later */
+	if (!read_killswitch_status()) {
+		write_status(NULL, read_wireless_status(BT_ON), BT_ON);
+		write_status(NULL, read_wireless_status(WL_ON), WL_ON);
+	}
+
+	return 0;
+}
+
+static int asus_hotk_resume(struct platform_device *dev)
+{
+	if (read_killswitch_status()) {
+		/* Make sure to turn off the LEDs if Kill Switch is ON */
+		if (write_acpi_int(wl_switch_handle, NULL, 0, NULL))
+			printk(ASUS_WARNING "resume: failed to disable WLAN\n");
+		if (write_acpi_int(bt_switch_handle, NULL, 0, NULL))
+			printk(ASUS_WARNING "resume: failed to disable BT\n");
+	} else {
+		/* Restore the previous status */
+		int status;
+		status = hotk->status & WL_ON ? 1 : 0;
+		if (write_acpi_int(wl_switch_handle, NULL, status, NULL))
+			printk(ASUS_WARNING "resume: failed to restore WLAN\n");
+
+		status = hotk->status & BT_ON ? 1 : 0;
+		if (write_acpi_int(bt_switch_handle, NULL, status, NULL))
+			printk(ASUS_WARNING "resume: failed to restore BT\n");
+	}
+
+	return 0;
+}
+
  static void asus_backlight_exit(void)
  {
  	if (asus_backlight_device)


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
