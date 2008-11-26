From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 4/8] acpi: remove ACPI_FUNCTION_TRACE from driver files
Date: Wed, 26 Nov 2008 10:54:38 +0800
Message-ID: <1227668078.7702.93.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30053 "EHLO mga02.intel.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751668AbYKZC77 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Nov 2008 21:59:59 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>

=EF=BB=BFACPI_FUNCTION_TRACE is acpica internal used only.
Remove it from external driver files.

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/sleep/proc.c   |    6 ------
 drivers/acpi/sleep/wakeup.c |    5 -----
 2 files changed, 0 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/sleep/proc.c b/drivers/acpi/sleep/proc.c
index 4dbc227..d52e4e2 100644
--- a/drivers/acpi/sleep/proc.c
+++ b/drivers/acpi/sleep/proc.c
@@ -28,8 +28,6 @@ static int acpi_system_sleep_seq_show(struct seq_file=
 *seq, void *offset)
 {
 	int i;
=20
-	ACPI_FUNCTION_TRACE("acpi_system_sleep_seq_show");
-
 	for (i =3D 0; i <=3D ACPI_STATE_S5; i++) {
 		if (sleep_states[i]) {
 			seq_printf(seq, "S%d ", i);
@@ -93,8 +91,6 @@ static int acpi_system_alarm_seq_show(struct seq_file=
 *seq, void *offset)
 	unsigned char rtc_control =3D 0;
 	unsigned long flags;
=20
-	ACPI_FUNCTION_TRACE("acpi_system_alarm_seq_show");
-
 	spin_lock_irqsave(&rtc_lock, flags);
=20
 	sec =3D CMOS_READ(RTC_SECONDS_ALARM);
@@ -227,8 +223,6 @@ acpi_system_write_alarm(struct file *file,
 	int adjust =3D 0;
 	unsigned char rtc_control =3D 0;
=20
-	ACPI_FUNCTION_TRACE("acpi_system_write_alarm");
-
 	if (count > sizeof(alarm_string) - 1)
 		return_VALUE(-EINVAL);
=20
diff --git a/drivers/acpi/sleep/wakeup.c b/drivers/acpi/sleep/wakeup.c
index dea4c23..db325c2 100644
--- a/drivers/acpi/sleep/wakeup.c
+++ b/drivers/acpi/sleep/wakeup.c
@@ -28,8 +28,6 @@ void acpi_enable_wakeup_device_prep(u8 sleep_state)
 {
 	struct list_head *node, *next;
=20
-	ACPI_FUNCTION_TRACE("acpi_enable_wakeup_device_prep");
-
 	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =3D container_of(node,
@@ -61,7 +59,6 @@ void acpi_enable_wakeup_device(u8 sleep_state)
 	 * Caution: this routine must be invoked when interrupt is disabled=20
 	 * Refer ACPI2.0: P212
 	 */
-	ACPI_FUNCTION_TRACE("acpi_enable_wakeup_device");
 	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =3D
@@ -103,8 +100,6 @@ void acpi_disable_wakeup_device(u8 sleep_state)
 {
 	struct list_head *node, *next;
=20
-	ACPI_FUNCTION_TRACE("acpi_disable_wakeup_device");
-
 	spin_lock(&acpi_device_lock);
 	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
 		struct acpi_device *dev =3D


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
