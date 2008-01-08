From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 09/20] ACPI: thinkpad-acpi: spring cleanup
	part 4
Date: Tue,  8 Jan 2008 13:02:46 -0200
Message-ID: <1199804577-32017-10-git-send-email-hmh@hmh.eng.br>
References: <1199804577-32017-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1199804577-32017-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Remove dead code, and anything in the old changelog that is not a thank
you credit, or a key point to track down history.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   55 +++--------------------------------------
 1 files changed, 4 insertions(+), 51 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index b6293a4..45be8e5 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -26,6 +26,8 @@
 
 /*
  *  Changelog:
+ *  2007-10-20		changelog trimmed down
+ *
  *  2007-03-27  0.14	renamed to thinkpad_acpi and moved to
  *  			drivers/misc.
  *
@@ -33,53 +35,16 @@
  *  			changelog now lives in git commit history, and will
  *  			not be updated further in-file.
  *
- *  2005-08-17  0.12	fix compilation on 2.6.13-rc kernels
  *  2005-03-17	0.11	support for 600e, 770x
  *			    thanks to Jamie Lentin <lentinj-nj/3WzNG+6vzqqTqqIgqvQ@public.gmane.org>
- *			support for 770e, G41
- *			G40 and G41 don't have a thinklight
- *			temperatures no longer experimental
- *			experimental brightness control
- *			experimental volume control
- *			experimental fan enable/disable
- *  2005-01-16	0.10	fix module loading on R30, R31
- *  2005-01-16	0.9	support for 570, R30, R31
- *			ultrabay support on A22p, A3x
- *			limit arg for cmos, led, beep, drop experimental status
- *			more capable led control on A21e, A22p, T20-22, X20
- *			experimental temperatures and fan speed
- *			experimental embedded controller register dump
- *			mark more functions as __init, drop incorrect __exit
- *			use MODULE_VERSION
+ *
+ *  2005-01-16	0.9	use MODULE_VERSION
  *			    thanks to Henrik Brix Andersen <brix-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
  *			fix parameter passing on module loading
  *			    thanks to Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
  *			    thanks to Jim Radford <radford-DoRvVqtESFCEi8DpZVb4nw@public.gmane.org>
  *  2004-11-08	0.8	fix init error case, don't return from a macro
  *			    thanks to Chris Wright <chrisw-3NddpPZAyC0@public.gmane.org>
- *  2004-10-23	0.7	fix module loading on A21e, A22p, T20, T21, X20
- *			fix led control on A21e
- *  2004-10-19	0.6	use acpi_bus_register_driver() to claim HKEY device
- *  2004-10-18	0.5	thinklight support on A21e, G40, R32, T20, T21, X20
- *			proc file format changed
- *			video_switch command
- *			experimental cmos control
- *			experimental led control
- *			experimental acpi sounds
- *  2004-09-16	0.4	support for module parameters
- *			hotkey mask can be prefixed by 0x
- *			video output switching
- *			video expansion control
- *			ultrabay eject support
- *			removed lcd brightness/on/off control, didn't work
- *  2004-08-17	0.3	support for R40
- *			lcd off, brightness control
- *			thinklight on/off
- *  2004-08-14	0.2	support for T series, X20
- *			bluetooth enable/disable
- *			hotkey events disabled by default
- *			removed fan control, currently useless
- *  2004-08-09	0.1	initial release, support for X series
  */
 
 #include <linux/kernel.h>
@@ -314,8 +279,6 @@ struct thinkpad_id_data {
 };
 static struct thinkpad_id_data thinkpad_id;
 
-#define __unused __attribute__ ((unused))
-
 static enum {
 	TPACPI_LIFE_INIT = 0,
 	TPACPI_LIFE_RUNNING,
@@ -451,16 +414,6 @@ static int acpi_evalf(acpi_handle handle,
 	return success;
 }
 
-static void __unused acpi_print_int(acpi_handle handle, char *method)
-{
-	int i;
-
-	if (acpi_evalf(handle, &i, method, "d"))
-		printk(IBM_INFO "%s = 0x%x\n", method, i);
-	else
-		printk(IBM_ERR "error calling %s\n", method);
-}
-
 static int acpi_ec_read(int i, u8 * p)
 {
 	int v;
-- 
1.5.3.7


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
