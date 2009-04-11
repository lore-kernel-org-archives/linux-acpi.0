From: akpm@linux-foundation.org
Subject: [patch 3/4] dell-laptop: fix uninitialized/wrong return value
Date: Fri, 10 Apr 2009 23:16:31 -0700
Message-ID: <200904110616.n3B6GVJ5026161@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48586 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755597AbZDKGU7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Apr 2009 02:20:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, ilpo.jarvinen@helsinki.fi, khali@linux-fr.org, len.brown@intel.com

=46rom: Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi>

Seriously, a helper would be much nicer here instead of all that copy
paste but I leave that as future work item.

Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@helsinki.fi>
Cc: Len Brown <len.brown@intel.com>
Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/dell-laptop.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff -puN drivers/platform/x86/dell-laptop.c~dell-laptop-fix-uninitiali=
zed-wrong-return-value drivers/platform/x86/dell-laptop.c
--- a/drivers/platform/x86/dell-laptop.c~dell-laptop-fix-uninitialized-=
wrong-return-value
+++ a/drivers/platform/x86/dell-laptop.c
@@ -249,8 +249,10 @@ static int dell_setup_rfkill(void)
=20
 	if ((status & (1<<2|1<<8)) =3D=3D (1<<2|1<<8)) {
 		wifi_rfkill =3D rfkill_allocate(NULL, RFKILL_TYPE_WLAN);
-		if (!wifi_rfkill)
+		if (!wifi_rfkill) {
+			ret =3D -ENOMEM;
 			goto err_wifi;
+		}
 		wifi_rfkill->name =3D "dell-wifi";
 		wifi_rfkill->toggle_radio =3D dell_wifi_set;
 		wifi_rfkill->get_state =3D dell_wifi_get;
@@ -261,8 +263,10 @@ static int dell_setup_rfkill(void)
=20
 	if ((status & (1<<3|1<<9)) =3D=3D (1<<3|1<<9)) {
 		bluetooth_rfkill =3D rfkill_allocate(NULL, RFKILL_TYPE_BLUETOOTH);
-		if (!bluetooth_rfkill)
+		if (!bluetooth_rfkill) {
+			ret =3D -ENOMEM;
 			goto err_bluetooth;
+		}
 		bluetooth_rfkill->name =3D "dell-bluetooth";
 		bluetooth_rfkill->toggle_radio =3D dell_bluetooth_set;
 		bluetooth_rfkill->get_state =3D dell_bluetooth_get;
@@ -273,8 +277,10 @@ static int dell_setup_rfkill(void)
=20
 	if ((status & (1<<4|1<<10)) =3D=3D (1<<4|1<<10)) {
 		wwan_rfkill =3D rfkill_allocate(NULL, RFKILL_TYPE_WWAN);
-		if (!wwan_rfkill)
+		if (!wwan_rfkill) {
+			ret =3D -ENOMEM;
 			goto err_wwan;
+		}
 		wwan_rfkill->name =3D "dell-wwan";
 		wwan_rfkill->toggle_radio =3D dell_wwan_set;
 		wwan_rfkill->get_state =3D dell_wwan_get;
_
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
