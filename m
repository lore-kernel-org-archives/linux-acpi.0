From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 5/6] ACPI-battery: Replace 16 seq_printf() calls by seq_puts()
Date: Tue, 18 Apr 2017 18:55:22 +0200
Message-ID: <94dc09f1-dcd5-13c4-9b5d-a6b53cf8da94@users.sourceforge.net>
References: <077115e4-8ec3-9c6d-0374-8ffc5e0f85c0@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <077115e4-8ec3-9c6d-0374-8ffc5e0f85c0@users.sourceforge.net>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, Borislav Petkov <bp@suse.de>, Chun-Yi Lee <joeyli.kernel@gmail.com>, Colin Ian King <colin.king@canonical.com>, Dan Williams <dan.j.williams@intel.com>, Len Brown <lenb@kernel.org>, Linda Knippers <linda.knippers@hpe.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Zhang Rui <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 18 Apr 2017 18:04:22 +0200

Strings which did not contain data format specifications should be put
into a sequence. Thus use the corresponding function "seq_puts".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/acpi/battery.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 4ef1e4624b2b..d217e1c18b42 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -825,14 +825,14 @@ static int acpi_battery_print_info(struct seq_file *seq, int result)
 	if (!acpi_battery_present(battery))
 		goto end;
 	if (battery->design_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
-		seq_printf(seq, "design capacity:         unknown\n");
+		seq_puts(seq, "design capacity:         unknown\n");
 	else
 		seq_printf(seq, "design capacity:         %d %sh\n",
 			   battery->design_capacity,
 			   acpi_battery_units(battery));
 
 	if (battery->full_charge_capacity == ACPI_BATTERY_VALUE_UNKNOWN)
-		seq_printf(seq, "last full capacity:      unknown\n");
+		seq_puts(seq, "last full capacity:      unknown\n");
 	else
 		seq_printf(seq, "last full capacity:      %d %sh\n",
 			   battery->full_charge_capacity,
@@ -842,7 +842,7 @@ static int acpi_battery_print_info(struct seq_file *seq, int result)
 		   (!battery->technology)?"non-":"");
 
 	if (battery->design_voltage == ACPI_BATTERY_VALUE_UNKNOWN)
-		seq_printf(seq, "design voltage:          unknown\n");
+		seq_puts(seq, "design voltage:          unknown\n");
 	else
 		seq_printf(seq, "design voltage:          %d mV\n",
 			   battery->design_voltage);
@@ -865,7 +865,7 @@ static int acpi_battery_print_info(struct seq_file *seq, int result)
 	seq_printf(seq, "OEM info:                %s\n", battery->oem_info);
       end:
 	if (result)
-		seq_printf(seq, "ERROR: Unable to read battery info\n");
+		seq_puts(seq, "ERROR: Unable to read battery info\n");
 	return result;
 }
 
@@ -884,34 +884,34 @@ static int acpi_battery_print_state(struct seq_file *seq, int result)
 	seq_printf(seq, "capacity state:          %s\n",
 			(battery->state & 0x04) ? "critical" : "ok");
 	if ((battery->state & 0x01) && (battery->state & 0x02))
-		seq_printf(seq,
-			   "charging state:          charging/discharging\n");
+		seq_puts(seq,
+			 "charging state:          charging/discharging\n");
 	else if (battery->state & 0x01)
-		seq_printf(seq, "charging state:          discharging\n");
+		seq_puts(seq, "charging state:          discharging\n");
 	else if (battery->state & 0x02)
-		seq_printf(seq, "charging state:          charging\n");
+		seq_puts(seq, "charging state:          charging\n");
 	else
-		seq_printf(seq, "charging state:          charged\n");
+		seq_puts(seq, "charging state:          charged\n");
 
 	if (battery->rate_now == ACPI_BATTERY_VALUE_UNKNOWN)
-		seq_printf(seq, "present rate:            unknown\n");
+		seq_puts(seq, "present rate:            unknown\n");
 	else
 		seq_printf(seq, "present rate:            %d %s\n",
 			   battery->rate_now, acpi_battery_units(battery));
 
 	if (battery->capacity_now == ACPI_BATTERY_VALUE_UNKNOWN)
-		seq_printf(seq, "remaining capacity:      unknown\n");
+		seq_puts(seq, "remaining capacity:      unknown\n");
 	else
 		seq_printf(seq, "remaining capacity:      %d %sh\n",
 			   battery->capacity_now, acpi_battery_units(battery));
 	if (battery->voltage_now == ACPI_BATTERY_VALUE_UNKNOWN)
-		seq_printf(seq, "present voltage:         unknown\n");
+		seq_puts(seq, "present voltage:         unknown\n");
 	else
 		seq_printf(seq, "present voltage:         %d mV\n",
 			   battery->voltage_now);
       end:
 	if (result)
-		seq_printf(seq, "ERROR: Unable to read battery state\n");
+		seq_puts(seq, "ERROR: Unable to read battery state\n");
 
 	return result;
 }
@@ -924,18 +924,18 @@ static int acpi_battery_print_alarm(struct seq_file *seq, int result)
 		goto end;
 
 	if (!acpi_battery_present(battery)) {
-		seq_printf(seq, "present:                 no\n");
+		seq_puts(seq, "present:                 no\n");
 		goto end;
 	}
-	seq_printf(seq, "alarm:                   ");
+	seq_puts(seq, "alarm:                   ");
 	if (!battery->alarm)
-		seq_printf(seq, "unsupported\n");
+		seq_puts(seq, "unsupported\n");
 	else
 		seq_printf(seq, "%u %sh\n", battery->alarm,
 				acpi_battery_units(battery));
       end:
 	if (result)
-		seq_printf(seq, "ERROR: Unable to read battery alarm\n");
+		seq_puts(seq, "ERROR: Unable to read battery alarm\n");
 	return result;
 }
 
-- 
2.12.2
