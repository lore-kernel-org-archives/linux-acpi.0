From: "=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=" <jprvita@gmail.com>
Subject: [PATCH] ACPI / battery: Fix reporting "Not charging" when capacity is 100%
Date: Fri,  2 Nov 2018 23:57:32 -0700
Message-ID: <20181103065732.12134-1-jprvita@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org
Cc: Daniel Drake <drake@endlessm.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-kernel@vger.kernel.org, linux@endlessm.com, =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>
List-Id: linux-acpi@vger.kernel.org

Commit 19fffc8450d4378580a8f019b195c4617083176f fixed reporting
"Discharging" on some machines when AC was connected but the battery was
not charging. But now on these machines the battery status is reported
as "Not charging" even when the battery is fully charged.

This commit takes the battery capacity into consideration when checking
if "Not charging" should be returned and "Full" is returned when the
capacity is 100%.

Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
---
 drivers/acpi/battery.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index cb97b6105f52..82e194290f01 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -217,8 +217,12 @@ static int acpi_battery_handle_discharging(struct acpi_battery *battery)
 	 * was plugged in and the device thus did not start a new charge cycle.
 	 */
 	if ((battery_ac_is_broken || power_supply_is_system_supplied()) &&
-	    battery->rate_now == 0)
+	    battery->rate_now == 0) {
+		if (battery->capacity_now && battery->full_charge_capacity &&
+		    battery->capacity_now / battery->full_charge_capacity == 1)
+			return POWER_SUPPLY_STATUS_FULL;
 		return POWER_SUPPLY_STATUS_NOT_CHARGING;
+	}
 
 	return POWER_SUPPLY_STATUS_DISCHARGING;
 }
-- 
2.19.1
