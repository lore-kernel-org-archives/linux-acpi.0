From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 5/9] ACPI: thinkpad-acpi: improve fan
	control documentation
Date: Fri, 27 Apr 2007 22:00:13 -0300
Message-ID: <11777220173818-git-send-email-hmh@hmh.eng.br>
References: <11777220172751-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11777220172751-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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

Improve fan control documentation and fix one mistake.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index bca50d7..e3ad7a4 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -795,15 +795,23 @@ Sysfs notes:
 The sysfs interface follows the hwmon subsystem guidelines for the most
 part, and the exception is the fan safety watchdog.
 
+Writes to any of the sysfs attributes may return the EINVAL error if
+that operation is not supported in a given ThinkPad or if the parameter
+is out-of-bounds, and EPERM if it is forbidden.  They may also return
+EINTR (interrupted system call), and EIO (I/O error while trying to talk
+to the firmware).
+
+Features not yet implemented by the driver return ENOSYS.
+
 hwmon device attribute pwm1_enable:
 	0: PWM offline (fan is set to full-speed mode)
 	1: Manual PWM control (use pwm1 to set fan level)
 	2: Hardware PWM control (EC "auto" mode)
 	3: reserved (Software PWM control, not implemented yet)
 
-	Modes 0 and 2 are not supported by all ThinkPads, and the driver
-	is not always able to detect this.  If it does know a mode is
-	unsupported, it will return -EINVAL.
+	Modes 0 and 2 are not supported by all ThinkPads, and the
+	driver is not always able to detect this.  If it does know a
+	mode is unsupported, it will return -EINVAL.
 
 hwmon device attribute pwm1:
 	Fan level, scaled from the firmware values of 0-7 to the hwmon
@@ -826,8 +834,8 @@ driver attribute fan_watchdog:
 To stop the fan: set pwm1 to zero, and pwm1_enable to 1.
 
 To start the fan in a safe mode: set pwm1_enable to 2.  If that fails
-with ENOTSUP, set it to 1 and set pwm1 to at least 128 (255 would be the
-safest choice, though).
+with EINVAL, try to set pwm1_enable to 1 and pwm1 to at least 128 (255
+would be the safest choice, though).
 
 
 EXPERIMENTAL: WAN -- /proc/acpi/ibm/wan
-- 
1.5.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
