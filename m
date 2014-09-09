From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH 2/2] Revert "ACPI / battery: fix wrong value of capacity_now reported when fully charged"
Date: Tue,  9 Sep 2014 10:45:18 +0200
Message-ID: <1410252318-12718-3-git-send-email-bjorn@mork.no>
References: <1410252318-12718-1-git-send-email-bjorn@mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:43778 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756071AbaIIIqD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Sep 2014 04:46:03 -0400
In-Reply-To: <1410252318-12718-1-git-send-email-bjorn@mork.no>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Mariusz Ceier <mceier+kernel@gmail.com>, Josef Gajdusek <atx@atx.name>, =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>, "3.16+" <stable@vger.kernel.org>

This reverts commit 232de5143790 ("ACPI / battery: fix wrong value of
capacity_now reported when fully charged")

There is nothing wrong or unexpected about 'capacity_now' increasing ab=
ove
the last 'full_charge_capacity' value. Different charging cycles will c=
ause
'full_charge_capacity' to vary, both up and down.  Good battery firmwar=
es
will update 'full_charge_capacity' when the current charging cycle is
complete, increasing it if necessary. It might even go above
'design_capacity' on a fresh and healthy battery.

Capping 'capacity_now' to 'full_charge_capacity' is plain wrong, and
printing a warning if this doesn't happen to match the 'design_capacity=
'
is both annoying and terribly wrong.

This results in bogus warnings on perfectly working systems/firmwares:

 [Firmware Bug]: battery: reported current charge level (39800) is high=
er than reported maximum charge level (39800).

and wrong values being reported for 'capacity_now' and
'full_charge_capacity' after the warning has been triggered.

=46ixes: 232de5143790 ("ACPI / battery: fix wrong value of capacity_now=
 reported when fully charged")
Cc: Mariusz Ceier <mceier+kernel@gmail.com>
Cc: Josef Gajdusek <atx@atx.name>
Cc: 3.16+ <stable@vger.kernel.org> # 3.16+
Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>
---
 drivers/acpi/battery.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 48bcf38a0ea8..5fdfe65fe165 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -534,20 +534,6 @@ static int acpi_battery_get_state(struct acpi_batt=
ery *battery)
 			" invalid.\n");
 	}
=20
-	/*
-	 * When fully charged, some batteries wrongly report
-	 * capacity_now =3D design_capacity instead of =3D full_charge_capaci=
ty
-	 */
-	if (battery->capacity_now > battery->full_charge_capacity
-	    && battery->full_charge_capacity !=3D ACPI_BATTERY_VALUE_UNKNOWN)=
 {
-		battery->capacity_now =3D battery->full_charge_capacity;
-		if (battery->capacity_now !=3D battery->design_capacity)
-			printk_once(KERN_WARNING FW_BUG
-				"battery: reported current charge level (%d) "
-				"is higher than reported maximum charge level (%d).\n",
-				battery->capacity_now, battery->full_charge_capacity);
-	}
-
 	if (test_bit(ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY, &battery->flags)
 	    && battery->capacity_now >=3D 0 && battery->capacity_now <=3D 100=
)
 		battery->capacity_now =3D (battery->capacity_now *
--=20
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
