From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH 1/2] Revert "ACPI / battery: Fix warning message in acpi_battery_get_state()"
Date: Tue,  9 Sep 2014 10:45:17 +0200
Message-ID: <1410252318-12718-2-git-send-email-bjorn@mork.no>
References: <1410252318-12718-1-git-send-email-bjorn@mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:43795 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756079AbaIIIq3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Sep 2014 04:46:29 -0400
In-Reply-To: <1410252318-12718-1-git-send-email-bjorn@mork.no>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Mariusz Ceier <mceier+kernel@gmail.com>, Josef Gajdusek <atx@atx.name>, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>, "3.16+" <stable@vger.kernel.org>

This reverts commit d719870b41e0 ("ACPI / battery: Fix warning message =
in
acpi_battery_get_state()")

Capping 'capacity_now' to 'full_charge_capacity' is plain wrong. If thi=
s
is necessary to work around some buggy firmware, then the workaround ne=
eds
protection against being applied to working firmwares.

Good battery firmwares will allow 'capacity_now' to increase above
'full_charge_capacity', and will update the latter when the battery
is fully charged.  By capping 'capacity_now' we lose accurate capacity
reporting until charging is complete whenever 'full_charge_capacity'
needs to be increased.

=46ixes: d719870b41e0 ("ACPI / battery: Fix warning message in acpi_bat=
tery_get_state()")
Cc: Mariusz Ceier <mceier+kernel@gmail.com>
Cc: Josef Gajdusek <atx@atx.name>
Cc: 3.16+ <stable@vger.kernel.org> # 3.16+
Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>
---
 drivers/acpi/battery.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 1c162e7be045..48bcf38a0ea8 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -540,12 +540,12 @@ static int acpi_battery_get_state(struct acpi_bat=
tery *battery)
 	 */
 	if (battery->capacity_now > battery->full_charge_capacity
 	    && battery->full_charge_capacity !=3D ACPI_BATTERY_VALUE_UNKNOWN)=
 {
+		battery->capacity_now =3D battery->full_charge_capacity;
 		if (battery->capacity_now !=3D battery->design_capacity)
 			printk_once(KERN_WARNING FW_BUG
 				"battery: reported current charge level (%d) "
 				"is higher than reported maximum charge level (%d).\n",
 				battery->capacity_now, battery->full_charge_capacity);
-		battery->capacity_now =3D battery->full_charge_capacity;
 	}
=20
 	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags)
--=20
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
