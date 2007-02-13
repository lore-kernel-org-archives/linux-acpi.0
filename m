From: Len Brown <lenb@kernel.org>
Subject: [PATCH 30/41] ACPI: battery: check for battery present on /proc/battery access
Date: Tue, 13 Feb 2007 00:49:32 -0500
Message-ID: <11713458202747-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org> <11713458052158-git-send-email-lenb@kernel.org> <11713458062930-git-send-email-lenb@kernel.org> <11713458071963-git-send-email
 -lenb@kernel.org> <11713458083103-git-send-email-lenb@kernel.org> <11713458101527-git-send-email-lenb@kernel.org> <11713458113695-git-send-email-lenb@kernel.org> <11713458122380-git-send-email-lenb@kernel.org> <11713458132236-git-send-email-lenb@kernel.org> <11713458143449-git-send-email-lenb@kernel.org> <11713458152188-git-send-email-lenb@kernel.org> <11713458163685-git-send-email-lenb@kernel.org> <11713458171374-git-send-email-lenb@kernel.org> <11713458183917-git-send-email-lenb@kernel.org> <11713458191475-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:17992 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751085AbXBMFuX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:23 -0500
In-Reply-To: <11713458191475-git-send-email-lenb@kernel.org>
Message-Id: <4bd35cdb1e2d1a1bbbe4b75132718e79b80519ab.1171345631.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Vladimir Lebedev <vladimir.p.lebedev@intel.com>, Len Brown <len.brown@intel.com>

From: Vladimir Lebedev <vladimir.p.lebedev@intel.com>

http://bugzilla.kernel.org/show_bug.cgi?id=7200

Signed-off-by: Vladimir Lebedev <vladimir.p.lebedev@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 2f4521a..0d7a32e 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -324,6 +324,13 @@ static int acpi_battery_check(struct acpi_battery *battery)
 	return result;
 }
 
+static void acpi_battery_check_present(struct acpi_battery *battery)
+{
+	if (!battery->flags.present) {
+		acpi_battery_check(battery);
+	}
+}
+
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)
    -------------------------------------------------------------------------- */
@@ -340,6 +347,8 @@ static int acpi_battery_read_info(struct seq_file *seq, void *offset)
 	if (!battery)
 		goto end;
 
+	acpi_battery_check_present(battery);
+
 	if (battery->flags.present)
 		seq_printf(seq, "present:                 yes\n");
 	else {
@@ -424,6 +433,8 @@ static int acpi_battery_read_state(struct seq_file *seq, void *offset)
 	if (!battery)
 		goto end;
 
+	acpi_battery_check_present(battery);
+
 	if (battery->flags.present)
 		seq_printf(seq, "present:                 yes\n");
 	else {
@@ -499,6 +510,8 @@ static int acpi_battery_read_alarm(struct seq_file *seq, void *offset)
 	if (!battery)
 		goto end;
 
+	acpi_battery_check_present(battery);
+
 	if (!battery->flags.present) {
 		seq_printf(seq, "present:                 no\n");
 		goto end;
@@ -536,6 +549,8 @@ acpi_battery_write_alarm(struct file *file,
 	if (!battery || (count > sizeof(alarm_string) - 1))
 		return -EINVAL;
 
+	acpi_battery_check_present(battery);
+
 	if (!battery->flags.present)
 		return -ENODEV;
 
-- 
1.5.0.rc4.345.gb4d2
