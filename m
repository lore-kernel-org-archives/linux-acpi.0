From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 05/10] ACPI: thinkpad-acpi: allow for
	syscall restart in sysfs handlers
Date: Sat, 13 Oct 2007 17:22:54 -0300
Message-ID: <1192306979-26886-6-git-send-email-hmh@hmh.eng.br>
References: <1192306979-26886-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1192306979-26886-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Peter Jordan <usernetwork-+wsBvAY55uc@public.gmane.org>, Richard Neill <rn214-v9/oYvjo+k2wa9SdKMSz+Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Map an mutex_lock_interruptible() error return into ERESTARTSYS, as the
only possible error from mutex_lock_interruptible is EINTR, and that will
only happen if signal_pending() causes the mutex lock attempt to abort.

This still allows signals to be delivered ASAP, which is much nicer than
just doing mutex_lock, and still shadows userspace from EINTR when
SA_RESTART is active.

Problem reported by Peter Jordan.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: Peter Jordan <usernetwork-+wsBvAY55uc@public.gmane.org>
Cc: Richard Neill <rn214-v9/oYvjo+k2wa9SdKMSz+Q@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   40 ++++++++++++++++------------------------
 1 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index dac8631..793f654 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1342,9 +1342,8 @@ static int hotkey_read(char *p)
 		return len;
 	}
 
-	res = mutex_lock_interruptible(&hotkey_mutex);
-	if (res < 0)
-		return res;
+	if (mutex_lock_interruptible(&hotkey_mutex))
+		return -ERESTARTSYS;
 	res = hotkey_get(&status, &mask);
 	mutex_unlock(&hotkey_mutex);
 	if (res)
@@ -1373,9 +1372,8 @@ static int hotkey_write(char *buf)
 	if (!tp_features.hotkey)
 		return -ENODEV;
 
-	res = mutex_lock_interruptible(&hotkey_mutex);
-	if (res < 0)
-		return res;
+	if (mutex_lock_interruptible(&hotkey_mutex))
+		return -ERESTARTSYS;
 
 	res = hotkey_get(&status, &mask);
 	if (res)
@@ -3768,9 +3766,8 @@ static ssize_t fan_pwm1_store(struct device *dev,
 	/* scale down from 0-255 to 0-7 */
 	newlevel = (s >> 5) & 0x07;
 
-	rc = mutex_lock_interruptible(&fan_mutex);
-	if (rc < 0)
-		return rc;
+	if (mutex_lock_interruptible(&fan_mutex))
+		return -ERESTARTSYS;
 
 	rc = fan_get_status(&status);
 	if (!rc && (status &
@@ -4020,9 +4017,8 @@ static int fan_get_status_safe(u8 *status)
 	int rc;
 	u8 s;
 
-	rc = mutex_lock_interruptible(&fan_mutex);
-	if (rc < 0)
-		return rc;
+	if (mutex_lock_interruptible(&fan_mutex))
+		return -ERESTARTSYS;
 	rc = fan_get_status(&s);
 	if (!rc)
 		fan_update_desired_level(s);
@@ -4156,9 +4152,8 @@ static int fan_set_level_safe(int level)
 	if (!fan_control_allowed)
 		return -EPERM;
 
-	rc = mutex_lock_interruptible(&fan_mutex);
-	if (rc < 0)
-		return rc;
+	if (mutex_lock_interruptible(&fan_mutex))
+		return -ERESTARTSYS;
 
 	if (level == TPACPI_FAN_LAST_LEVEL)
 		level = fan_control_desired_level;
@@ -4179,9 +4174,8 @@ static int fan_set_enable(void)
 	if (!fan_control_allowed)
 		return -EPERM;
 
-	rc = mutex_lock_interruptible(&fan_mutex);
-	if (rc < 0)
-		return rc;
+	if (mutex_lock_interruptible(&fan_mutex))
+		return -ERESTARTSYS;
 
 	switch (fan_control_access_mode) {
 	case TPACPI_FAN_WR_ACPI_FANS:
@@ -4235,9 +4229,8 @@ static int fan_set_disable(void)
 	if (!fan_control_allowed)
 		return -EPERM;
 
-	rc = mutex_lock_interruptible(&fan_mutex);
-	if (rc < 0)
-		return rc;
+	if (mutex_lock_interruptible(&fan_mutex))
+		return -ERESTARTSYS;
 
 	rc = 0;
 	switch (fan_control_access_mode) {
@@ -4274,9 +4267,8 @@ static int fan_set_speed(int speed)
 	if (!fan_control_allowed)
 		return -EPERM;
 
-	rc = mutex_lock_interruptible(&fan_mutex);
-	if (rc < 0)
-		return rc;
+	if (mutex_lock_interruptible(&fan_mutex))
+		return -ERESTARTSYS;
 
 	rc = 0;
 	switch (fan_control_access_mode) {
-- 
1.5.3.2


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
