From: Len Brown <lenb@kernel.org>
Subject: [PATCH 31/41] ACPI: sbs: fix present rate
Date: Tue, 13 Feb 2007 00:49:33 -0500
Message-ID: <11713458211458-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org> <1171345798129-git-send-email-lenb@kernel.org> <11713457996-git-send-email-lenb@kernel.org> <11713458001192-git-send-email-lenb@kernel.org> <11713458011379-git-send-email-lenb@kernel.org> <11713458021568-git-send-email-lenb@kernel.org> <11713458031539-git-send-email-lenb@kernel.org> <11713458041996-git-send-email-lenb@kernel.org> <11713458052158-git-send-email-lenb@kernel.org> <11713458062930-git-send-email-lenb@kernel.org> <11713458071963-git-send-email
 -lenb@kernel.org> <11713458083103-git-send-email-lenb@kernel.org> <11713458101527-git-send-email-lenb@kernel.org> <11713458113695-git-send-email-lenb@kernel.org> <11713458122380-git-send-email-lenb@kernel.org> <11713458132236-git-send-email-lenb@kernel.org> <11713458143449-git-send-email-lenb@kernel.org> <11713458152188-git-send-email-lenb@kernel.org> <11713458163685-git-send-email-lenb@kernel.org> <11713458171374-git-send-email-lenb@kernel.org> <11713458183917-git-send-email-lenb@kernel.org> <11713458191475-git-send-email-lenb@kernel.org> <11713458202747-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:19853 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751066AbXBMFu1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:27 -0500
In-Reply-To: <11713458202747-git-send-email-lenb@kernel.org>
Message-Id: <e6d0f5622d30a3b98fb0ba6264d5006a18270890.1171345631.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Vladimir Lebedev <vladimir.p.lebedev@intel.com>, Len Brown <len.brown@intel.com>

From: Vladimir Lebedev <vladimir.p.lebedev@intel.com>

http://bugzilla.kernel.org/show_bug.cgi?id=7897

Signed-off-by: Vladimir Lebedev <vladimir.p.lebedev@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sbs.c |   20 +++++++++-----------
 1 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/sbs.c b/drivers/acpi/sbs.c
index f58fc74..87b48f8 100644
--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -1034,21 +1034,19 @@ static int acpi_battery_read_state(struct seq_file *seq, void *offset)
 	} else {
 		seq_printf(seq, "capacity state:          ok\n");
 	}
+
+	foo = (s16) battery->state.amperage * battery->info.ipscale;
+	if (battery->info.capacity_mode) {
+		foo = foo * battery->info.design_voltage / 1000;
+	}
 	if (battery->state.amperage < 0) {
 		seq_printf(seq, "charging state:          discharging\n");
-		foo = battery->state.remaining_capacity * cscale * 60 /
-		    (battery->state.average_time_to_empty == 0 ? 1 :
-		     battery->state.average_time_to_empty);
-		seq_printf(seq, "present rate:            %i%s\n",
-			   foo, battery->info.capacity_mode ? "0 mW" : " mA");
+		seq_printf(seq, "present rate:            %d %s\n",
+			   -foo, battery->info.capacity_mode ? "mW" : "mA");
 	} else if (battery->state.amperage > 0) {
 		seq_printf(seq, "charging state:          charging\n");
-		foo = (battery->info.full_charge_capacity -
-		       battery->state.remaining_capacity) * cscale * 60 /
-		    (battery->state.average_time_to_full == 0 ? 1 :
-		     battery->state.average_time_to_full);
-		seq_printf(seq, "present rate:            %i%s\n",
-			   foo, battery->info.capacity_mode ? "0 mW" : " mA");
+		seq_printf(seq, "present rate:            %d %s\n",
+			   foo, battery->info.capacity_mode ? "mW" : "mA");
 	} else {
 		seq_printf(seq, "charging state:          charged\n");
 		seq_printf(seq, "present rate:            0 %s\n",
-- 
1.5.0.rc4.345.gb4d2
