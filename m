From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: Bad AC adaptateur value trought sysfst
Date: Mon, 01 Nov 2010 08:44:05 +0800
Message-ID: <1288572245.2234.88.camel@rui>
References: <AANLkTino-WkpMHfqD6amL-gk5mabiQAVbn9Low8L6joF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-k1m0f25EklyYhI+zzyaA"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:21946 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753940Ab0KAAoG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 31 Oct 2010 20:44:06 -0400
In-Reply-To: <AANLkTino-WkpMHfqD6amL-gk5mabiQAVbn9Low8L6joF@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Seblu <seblu@seblu.net>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>


--=-k1m0f25EklyYhI+zzyaA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi, Seblu,

On Mon, 2010-11-01 at 02:35 +0800, Seblu wrote:

> Got it, hal says adapter is offline...
> 
> cat /sys/devices/LNXSYSTM:00/device:00/ACPI0003:00/power_supply/AC/online
> 255
> watching dmesg show error about acpi ac adapter reading... (in pj)
> 
will you please attach the acpidump output of this laptop?

> The most strange for me, is, if i call acpitool or cat
> /proc/acpi/ac_adapter/AC/state, value in
> /sys/devices/LNXSYSTM:00/device:00/ACPI0003:00/power_supply/AC/online
> the answer goes right become 1. And so everything become ok. if i
> unplug and plug again the power cord, online state is reported
> correctly. This issue is only when the pc start with power cord
> plugged.
if you unplug the AC, is the status reported correctly?

> 
> I believe, issue come from a race condition, because if in my init
> script i access to /proc acpi file, and after hal start, status is
> reported correctly.
> 
> My current workaround is to load ac module in initrd, because, distro
> startup run udevadm trigger after and when it's done before, behaviour
> was like i said before.
> 
please try the patch attached to see if it helps.
BTW, the patch is based on today's git tree. and there may be some
conflict if you use 2.6.36 kernel.

thanks,
rui


--=-k1m0f25EklyYhI+zzyaA
Content-Disposition: attachment; filename="patch-update-AC-status-when-querying-from-sysfs"
Content-Type: text/x-vhdl; name="patch-update-AC-status-when-querying-from-sysfs"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

---
 drivers/acpi/ac.c |   45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

Index: linux-2.6/drivers/acpi/ac.c
===================================================================
--- linux-2.6.orig/drivers/acpi/ac.c
+++ linux-2.6/drivers/acpi/ac.c
@@ -100,24 +100,7 @@ static const struct file_operations acpi
 	.release = single_release,
 };
 #endif
-static int get_ac_property(struct power_supply *psy,
-			   enum power_supply_property psp,
-			   union power_supply_propval *val)
-{
-	struct acpi_ac *ac = to_acpi_ac(psy);
-	switch (psp) {
-	case POWER_SUPPLY_PROP_ONLINE:
-		val->intval = ac->state;
-		break;
-	default:
-		return -EINVAL;
-	}
-	return 0;
-}
 
-static enum power_supply_property ac_props[] = {
-	POWER_SUPPLY_PROP_ONLINE,
-};
 /* --------------------------------------------------------------------------
                                AC Adapter Management
    -------------------------------------------------------------------------- */
@@ -140,6 +123,34 @@ static int acpi_ac_get_state(struct acpi
 	return 0;
 }
 
+/* --------------------------------------------------------------------------
+                            sysfs I/F
+   -------------------------------------------------------------------------- */
+static int get_ac_property(struct power_supply *psy,
+			   enum power_supply_property psp,
+			   union power_supply_propval *val)
+{
+	struct acpi_ac *ac = to_acpi_ac(psy);
+
+	if (!ac)
+		return -EINVAL;
+
+	if (acpi_ac_get_state(ac))
+		return -ENODEV;
+
+	switch (psp) {
+	case POWER_SUPPLY_PROP_ONLINE:
+		val->intval = ac->state;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static enum power_supply_property ac_props[] = {
+	POWER_SUPPLY_PROP_ONLINE,
+};
 #ifdef CONFIG_ACPI_PROCFS_POWER
 /* --------------------------------------------------------------------------
                               FS Interface (/proc)

--=-k1m0f25EklyYhI+zzyaA--

