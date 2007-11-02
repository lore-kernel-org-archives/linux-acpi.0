From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [2.6.24-rc1][BUG] Oops on battery removal
Date: Fri, 02 Nov 2007 16:00:03 +0300
Message-ID: <472B1F53.5080902@suse.de>
References: <200711020803.49608.eike-kernel@sf-tec.de> <200711020937.33672.eike-kernel@sf-tec.de> <472AEDEC.1090606@suse.de> <200711021250.03555.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090000060109000600050005"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:40997 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753764AbXKBNAK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Nov 2007 09:00:10 -0400
In-Reply-To: <200711021250.03555.eike-kernel@sf-tec.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090000060109000600050005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Rolf Eike Beer wrote:
> Alexey Starikovskiy wrote:
>> Rolf Eike Beer wrote:
>>> Rolf Eike Beer wrote:
>>>> Hi,
>>>>
>>>> this happened while I removed my battery on bootup. Complete dmesg is
>>>> attached. Kernel is 2.6.24-rc1-git of yesterday (last commit was
>>>> d919fd433b5823d1cf9d0688eb2eec183de9b74c).
>>> Ok, I found out that it has nothing to do with the actual removal as it
>>> seems. When I start the laptop with battery already detached I get the
>>> same error.
> 
>> Please check if this patch helps.
> 
> It made things worse:
How about this patch?

--------------090000060109000600050005
Content-Type: text/x-patch;
 name="remove_cycle_at_battery_removal.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="remove_cycle_at_battery_removal.patch"

ACPI: Battery: remove cycle from battery removal.

From:  <>

get_property() should not call battery_update() on absent battery to
avoid cycle and oops.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/battery.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index c2ce0ad..50cdf6f 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -140,10 +140,11 @@ static int acpi_battery_get_property(struct power_supply *psy,
 {
 	struct acpi_battery *battery = to_acpi_battery(psy);
 
-	if ((!acpi_battery_present(battery)) &&
-	     psp != POWER_SUPPLY_PROP_PRESENT)
+	if (acpi_battery_present(battery)) {
+		/* run battery update only if it is present */
+		acpi_battery_update(battery);
+	} else if (psp != POWER_SUPPLY_PROP_PRESENT)
 		return -ENODEV;
-	acpi_battery_update(battery);
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
 		if (battery->state & 0x01)

--------------090000060109000600050005--
