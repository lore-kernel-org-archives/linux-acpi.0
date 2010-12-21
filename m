From: =?UTF-8?q?Jan=20F=C3=BCsting?= <jan.fuesting@gmx.de>
Subject: [PATCH 2/2] ACPI: Fixed some coding style issues in fan.c and battery.c
Date: Tue, 21 Dec 2010 22:41:20 +0100
Message-ID: <1292967680-14208-1-git-send-email-jan.fuesting@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.22]:38492 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753221Ab0LUVli (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Dec 2010 16:41:38 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Jan=20F=C3=BCsting?= <jan.fuesting@gmx.de>

=46ixed some coding style issues in fan.c and battery.c

Signed-off-by: Jan F=C3=BCsting <jan.fuesting@gmx.de>
---
 drivers/acpi/battery.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 16fc4df..35d0c6f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -580,7 +580,7 @@ static void acpi_battery_quirks(struct acpi_battery=
 *battery)
 {
 	if (dmi_name_in_vendors("Acer") && battery->power_unit)
 		set_bit(ACPI_BATTERY_QUIRK_SIGNED16_CURRENT, &battery->flags);
-}=09
+}
=20
 /*
  * According to the ACPI spec, some kinds of primary batteries can
--=20
1.7.2.3

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
