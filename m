From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 16/21] ACPI: ibm-acpi: implement fan
	watchdog command
Date: Sat, 25 Nov 2006 18:47:17 -0200
Message-ID: <20061125204717.6604.32168.stgit@thorin.khazad-dum.debian.net>
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

This patch implements a fan control safety watchdog, by request of the
authors of userspace fan control scripts.

When the watchdog timer expires, the equivalent action of a "fan enable"
command is executed.  The watchdog timer is reset at every reception of a
fan control command that could change the state of the fan itself.

This command is meant to be used by userspace fan control daemons, to make
sure the fan is never left set to an unsafe level because of userspace
problems.

Users of the X31/X40/X41 "speed" command are on their own, the current
implementation of "speed" is just too incomplete to be used safely,
anyway.  Better to never use it, and just use the "level" command instead.

The watchdog is programmed using echo "watchdog <number>" > fan, where
number is the number of seconds to wait before doing an "enable", and zero
disables the watchdog.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---

 Documentation/ibm-acpi.txt |   20 +++++++++++++
 drivers/acpi/ibm_acpi.c    |   70 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/Documentation/ibm-acpi.txt b/Documentation/ibm-acpi.txt
index cbd3a60..0132d36 100644
--- a/Documentation/ibm-acpi.txt
+++ b/Documentation/ibm-acpi.txt
@@ -670,6 +670,26 @@ example:
 
 	modprobe ibm_acpi hotkey=enable,0xffff video=auto_disable
 
+The ibm-acpi kernel driver can be programmed to revert the fan level
+to a safe setting if userspace does not issue one of the fan commands:
+"enable", "disable", "level" or "watchdog" within a configurable
+ammount of time.  To do this, use the "watchdog" command.
+
+	echo 'watchdog <interval>' > /proc/acpi/ibm/fan
+
+Interval is the ammount of time in seconds to wait for one of the
+above mentioned fan commands before reseting the fan level to a safe
+one.  If set to zero, the watchdog is disabled (default).  When the
+watchdog timer runs out, it does the exact equivalent of the "enable"
+fan command.
+
+Note that the watchdog timer stops after it enables the fan.  It will
+be rearmed again automatically (using the same interval) when one of
+the above mentioned fan commands is received.  The fan watchdog is,
+therefore, not suitable to protect against fan mode changes made
+through means other than the "enable", "disable", and "level" fan
+commands.
+
 
 Example Configuration
 ---------------------
diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index f742c33..adf3dae 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -82,6 +82,8 @@
 #include <linux/backlight.h>
 #include <asm/uaccess.h>
 #include <linux/dmi.h>
+#include <linux/jiffies.h>
+#include <linux/workqueue.h>
 
 #include <acpi/acpi_drivers.h>
 #include <acpi/acnamesp.h>
@@ -348,7 +350,8 @@ enum fan_control_access_mode {
 enum fan_control_commands {
 	IBMACPI_FAN_CMD_SPEED 	= 0x0001,	/* speed command */
 	IBMACPI_FAN_CMD_LEVEL 	= 0x0002,	/* level command  */
-	IBMACPI_FAN_CMD_ENABLE	= 0x0004,	/* enable/disable cmd */
+	IBMACPI_FAN_CMD_ENABLE	= 0x0004,	/* enable/disable cmd,
+						 * and also watchdog cmd */
 };
 
 enum {					/* Fan control constants */
@@ -1797,12 +1800,17 @@ static enum fan_control_commands fan_con
 static int fan_control_status_known;
 static u8 fan_control_initial_status;
 
+static void fan_watchdog_fire(void *ignored);
+static int fan_watchdog_maxinterval;
+static DECLARE_WORK(fan_watchdog_task, fan_watchdog_fire, NULL);
+
 static int fan_init(void)
 {
 	fan_status_access_mode = IBMACPI_FAN_NONE;
 	fan_control_access_mode = IBMACPI_FAN_WR_NONE;
 	fan_control_commands = 0;
 	fan_control_status_known = 1;
+	fan_watchdog_maxinterval = 0;
 
 	if (gfan_handle) {
 		/* 570, 600e/x, 770e, 770x */
@@ -1934,6 +1942,31 @@ static int fan_get_speed(unsigned int *s
 	return 0;
 }
 
+static void fan_exit(void)
+{
+	cancel_delayed_work(&fan_watchdog_task);
+	flush_scheduled_work();
+}
+
+static void fan_watchdog_reset(void)
+{
+	static int fan_watchdog_active = 0;
+
+	if (fan_watchdog_active)
+		cancel_delayed_work(&fan_watchdog_task);
+
+	if (fan_watchdog_maxinterval > 0) {
+		fan_watchdog_active = 1;
+		if (!schedule_delayed_work(&fan_watchdog_task,
+				msecs_to_jiffies(fan_watchdog_maxinterval
+						 * 1000))) {
+			printk(IBM_ERR "failed to schedule the fan watchdog, "
+			       "watchdog will not trigger\n");
+		}
+	} else
+		fan_watchdog_active = 0;
+}
+
 static int fan_read(char *p)
 {
 	int len = 0;
@@ -2007,7 +2040,9 @@ static int fan_read(char *p)
 	}
 
 	if (fan_control_commands & IBMACPI_FAN_CMD_ENABLE)
-		len += sprintf(p + len, "commands:\tenable, disable\n");
+		len += sprintf(p + len, "commands:\tenable, disable\n"
+			       "commands:\twatchdog <timeout> (<timeout> is 0 (off), "
+			       "1-120 (seconds))\n");
 
 	if (fan_control_commands & IBMACPI_FAN_CMD_SPEED)
 		len += sprintf(p + len, "commands:\tspeed <speed>"
@@ -2186,6 +2221,21 @@ static int fan_write_cmd_speed(const cha
 	return 1;
 }
 
+static int fan_write_cmd_watchdog(const char *cmd, int *rc)
+{
+	int interval;
+
+	if (sscanf(cmd, "watchdog %d", &interval) != 1)
+		return 0;
+
+	if (interval < 0 || interval > 120)
+		*rc = -EINVAL;
+	else
+		fan_watchdog_maxinterval = interval;
+
+	return 1;
+}
+
 static int fan_write(char *buf)
 {
 	char *cmd;
@@ -2196,16 +2246,29 @@ static int fan_write(char *buf)
 		      fan_write_cmd_level(cmd, &rc)) &&
 		    !((fan_control_commands & IBMACPI_FAN_CMD_ENABLE) &&
 		      (fan_write_cmd_enable(cmd, &rc) ||
-		       fan_write_cmd_disable(cmd, &rc))) &&
+		       fan_write_cmd_disable(cmd, &rc) ||
+		       fan_write_cmd_watchdog(cmd, &rc))) &&
 		    !((fan_control_commands & IBMACPI_FAN_CMD_SPEED) &&
 		      fan_write_cmd_speed(cmd, &rc))
 		    )
 			rc = -EINVAL;
+		else if (!rc)
+			fan_watchdog_reset();
 	}
 
 	return rc;
 }
 
+static void fan_watchdog_fire(void *ignored)
+{
+	printk(IBM_NOTICE "fan watchdog: enabling fan\n");
+	if (fan_set_enable()) {
+		printk(IBM_ERR "fan watchdog: error while enabling fan\n");
+		/* reschedule for later */
+		fan_watchdog_reset();
+	}
+}
+
 static struct ibm_struct ibms[] = {
 	{
 	 .name = "driver",
@@ -2317,6 +2380,7 @@ static struct ibm_struct ibms[] = {
 	 .read = fan_read,
 	 .write = fan_write,
 	 .init = fan_init,
+	 .exit = fan_exit,
 	 .experimental = 1,
 	 },
 };

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
