From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 20/20] ACPI: thinkpad-acpi: improve fan
	watchdog messages
Date: Sat, 21 Apr 2007 11:08:44 -0300
Message-ID: <11771645293633-git-send-email-hmh@hmh.eng.br>
References: <11771645253042-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11771645253042-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Improve some of the fan watchdog error messages to be a little more
helpful.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index e9aec87..9b4eea4 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2524,7 +2524,7 @@ static int fan_get_status(u8 *status)
 
 static void fan_exit(void)
 {
-	vdbg_printk(TPACPI_DBG_EXIT, "cancelling any pending watchdogs\n");
+	vdbg_printk(TPACPI_DBG_EXIT, "cancelling any pending fan watchdog tasks\n");
 	cancel_delayed_work(&fan_watchdog_task);
 	flush_scheduled_work();
 }
@@ -2554,9 +2554,13 @@ static int fan_get_speed(unsigned int *speed)
 
 static void fan_watchdog_fire(struct work_struct *ignored)
 {
+	int rc;
+
 	printk(IBM_NOTICE "fan watchdog: enabling fan\n");
-	if (fan_set_enable()) {
-		printk(IBM_ERR "fan watchdog: error while enabling fan\n");
+	rc = fan_set_enable();
+	if (rc < 0) {
+		printk(IBM_ERR "fan watchdog: error %d while enabling fan, "
+			"will try again later...\n", -rc);
 		/* reschedule for later */
 		fan_watchdog_reset();
 	}
-- 
1.5.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
