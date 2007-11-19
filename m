From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ACPI: Always return valid 'status' from acpi_battery_get_property()
Date: Mon, 19 Nov 2007 15:46:05 +0300
Message-ID: <4741858D.9020802@gmail.com>
References: <87640d1wmi.fsf@shaolin.home.digitalvampire.org> <4732C8D3.605@suse.de> <20071108144207.GA8814@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050203040005010400000905"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hu-out-0506.google.com ([72.14.214.229]:15076 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbXKSMpi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Nov 2007 07:45:38 -0500
Received: by hu-out-0506.google.com with SMTP id 19so935903hue
        for <linux-acpi@vger.kernel.org>; Mon, 19 Nov 2007 04:45:37 -0800 (PST)
In-Reply-To: <20071108144207.GA8814@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Roland Dreier <roland@digitalvampire.org>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Rolf Eike Beer <eike-kernel@sf-tec.de>

This is a multi-part message in MIME format.
--------------050203040005010400000905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Henrique de Moraes Holschuh wrote:
> On Thu, 08 Nov 2007, Alexey Starikovskiy wrote:
>   
>>> handle explicitly.  There doesn't seem to be any status enum value
>>> defined that makes more sense than 'unknown' for a battery at a
>>> critical charge level.
>>>       
>
> Maybe one should be added?
>
>   
There is already "Critical" field for capacity.
It seems that the state should be limited to only 3 options:
    charging, discharging, and not charging.

Regards,
Alex.


--------------050203040005010400000905
Content-Type: text/x-patch;
 name="always_return_valid_status.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="always_return_valid_status.patch"

ACPI: Battery: Always return valid 'status' from get_property

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/battery.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 192c244..064d80b 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -151,8 +151,8 @@ static int acpi_battery_get_property(struct power_supply *psy,
 			val->intval = POWER_SUPPLY_STATUS_DISCHARGING;
 		else if (battery->state & 0x02)
 			val->intval = POWER_SUPPLY_STATUS_CHARGING;
-		else if (battery->state == 0)
-			val->intval = POWER_SUPPLY_STATUS_FULL;
+		else
+			val->intval = POWER_SUPPLY_STATUS_NOT_CHARGING;
 		break;
 	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval = acpi_battery_present(battery);

--------------050203040005010400000905--
