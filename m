From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 1/2] Revert "eeepc-laptop: Prevent a panic when disabling RT2860 wireless when associated"
Date: Fri, 16 Oct 2009 22:22:46 +0200
Message-ID: <1255724567-25597-2-git-send-email-corentincj@iksaif.net>
References: <1255724567-25597-1-git-send-email-corentincj@iksaif.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:43224 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbZJPUVs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Oct 2009 16:21:48 -0400
In-Reply-To: <1255724567-25597-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>, Darren Salt <linux@youmustbejoking.demon.co.uk>

rt2860sta is fine with the patch as is, but iwl3945 isn't
(eeepc_rfkill_set() needs to call eeepc_rfkill_hotplug(true) =E2=80=93 =
which means
that we're back to causing the rt2860sta panic

This reverts commit b56ab33d68638e6aafdbfc694025e8354a628f49.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Darren Salt <linux@youmustbejoking.demon.co.uk>
---
 drivers/platform/x86/eeepc-laptop.c |   27 ++++++++-------------------
 1 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86=
/eeepc-laptop.c
index d379e74..789d6ae 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -150,8 +150,6 @@ struct eeepc_hotk {
 /* The actual device the driver binds to */
 static struct eeepc_hotk *ehotk;
=20
-static void eeepc_rfkill_hotplug(bool real);
-
 /* Platform device/driver */
 static int eeepc_hotk_thaw(struct device *device);
 static int eeepc_hotk_restore(struct device *device);
@@ -345,16 +343,7 @@ static bool eeepc_wlan_rfkill_blocked(void)
 static int eeepc_rfkill_set(void *data, bool blocked)
 {
 	unsigned long asl =3D (unsigned long)data;
-	int ret;
-
-	if (asl !=3D CM_ASL_WLAN)
-		return set_acpi(asl, !blocked);
-
-	/* hack to avoid panic with rt2860sta */
-	if (blocked)
-		eeepc_rfkill_hotplug(false);
-	ret =3D set_acpi(asl, !blocked);
-	return ret;
+	return set_acpi(asl, !blocked);
 }
=20
 static const struct rfkill_ops eeepc_rfkill_ops =3D {
@@ -654,13 +643,13 @@ static int eeepc_get_adapter_status(struct hotplu=
g_slot *hotplug_slot,
 	return 0;
 }
=20
-static void eeepc_rfkill_hotplug(bool real)
+static void eeepc_rfkill_hotplug(void)
 {
 	struct pci_dev *dev;
 	struct pci_bus *bus;
-	bool blocked =3D real ? eeepc_wlan_rfkill_blocked() : true;
+	bool blocked =3D eeepc_wlan_rfkill_blocked();
=20
-	if (real && ehotk->wlan_rfkill)
+	if (ehotk->wlan_rfkill)
 		rfkill_set_sw_state(ehotk->wlan_rfkill, blocked);
=20
 	mutex_lock(&ehotk->hotplug_lock);
@@ -703,7 +692,7 @@ static void eeepc_rfkill_notify(acpi_handle handle,=
 u32 event, void *data)
 	if (event !=3D ACPI_NOTIFY_BUS_CHECK)
 		return;
=20
-	eeepc_rfkill_hotplug(true);
+	eeepc_rfkill_hotplug();
 }
=20
 static void eeepc_hotk_notify(struct acpi_device *device, u32 event)
@@ -861,7 +850,7 @@ static int eeepc_hotk_restore(struct device *device=
)
 {
 	/* Refresh both wlan rfkill state and pci hotplug */
 	if (ehotk->wlan_rfkill)
-		eeepc_rfkill_hotplug(true);
+		eeepc_rfkill_hotplug();
=20
 	if (ehotk->bluetooth_rfkill)
 		rfkill_set_sw_state(ehotk->bluetooth_rfkill,
@@ -1004,7 +993,7 @@ static void eeepc_rfkill_exit(void)
 	 * Refresh pci hotplug in case the rfkill state was changed after
 	 * eeepc_unregister_rfkill_notifier()
 	 */
-	eeepc_rfkill_hotplug(true);
+	eeepc_rfkill_hotplug();
 	if (ehotk->hotplug_slot)
 		pci_hp_deregister(ehotk->hotplug_slot);
=20
@@ -1120,7 +1109,7 @@ static int eeepc_rfkill_init(struct device *dev)
 	 * Refresh pci hotplug in case the rfkill state was changed during
 	 * setup.
 	 */
-	eeepc_rfkill_hotplug(true);
+	eeepc_rfkill_hotplug();
=20
 exit:
 	if (result && result !=3D -ENODEV)
--=20
1.6.5.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
