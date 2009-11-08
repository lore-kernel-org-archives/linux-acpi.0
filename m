From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/12] Revert
 "eeepc-laptop: Prevent a panic when disabling RT2860 wireless when associated"
Date: Sat, 07 Nov 2009 21:57:04 -0500
Message-ID: <58ce48a9de1dd47acb5dc00e2837214d2be1d92a.1257648659.git.len.brown@intel.com>
References: <1257649034-7494-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:47238 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbZKHC5Q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Nov 2009 21:57:16 -0500
Received: from localhost.localdomain ([74.104.150.83])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KSR008IBS7KHQ5B@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 07 Nov 2009 20:57:21 -0600 (CST)
In-reply-to: <1257649034-7494-1-git-send-email-lenb@kernel.org>
In-reply-to: <52a2b11cafb1b14bacfc65a20966da5ba3a863e1.1257648659.git.len.brown@intel.com>
References: <52a2b11cafb1b14bacfc65a20966da5ba3a863e1.1257648659.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Darren Salt <linux@youmustbejoking.demon.co.uk>, Len Brown <len.brown@intel.com>

=46rom: Corentin Chary <corentincj@iksaif.net>

rt2860sta is fine with the patch as is, but iwl3945 isn't
(eeepc_rfkill_set() needs to call eeepc_rfkill_hotplug(true) =E2=80=93 =
which means
that we're back to causing the rt2860sta panic

This reverts commit b56ab33d68638e6aafdbfc694025e8354a628f49.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Darren Salt <linux@youmustbejoking.demon.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
