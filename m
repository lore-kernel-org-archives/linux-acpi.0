From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: battery: current a factor of 10 off?
Date: Fri, 21 Nov 2008 22:41:01 +0800
Message-ID: <4926C87D.20308@gmail.com>
References: <87skplx6ho.fsf@szonett.ki.iif.hu> <8f8ff01d0811202009r2d1fedcct9a383f9362c5a064@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020607010209060500070605"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.191]:51772 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292AbYKUOl2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Nov 2008 09:41:28 -0500
Received: by ti-out-0910.google.com with SMTP id b6so652294tic.23
        for <linux-acpi@vger.kernel.org>; Fri, 21 Nov 2008 06:41:26 -0800 (PST)
In-Reply-To: <8f8ff01d0811202009r2d1fedcct9a383f9362c5a064@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------020607010209060500070605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ferenc,
This patch should be better -- no integer overflow.

Regards,
Alex.

Alexey Starikovskiy wrote:
> Hi Ferenc,
>
> Good catch.
> ACPI battery interface report its state either in mW or in mA, and
> discharge rate
> in your case is reported in mW. power_supply interface does not have
> such a parameter,
> so current_now parameter is used for all cases. But in case of mW,
> reported discharge should
> be converted into mA.
>
> Please test the attached patch.
>
> Thanks,
> Alex.
>
> On Fri, Nov 21, 2008 at 3:33 AM, Ferenc Wagner <wferi@niif.hu> wrote:
>   
>> Hi,
>>
>> on my ThinkPad R50e the current_now reading seems something like 10
>> times the actual value.  Documentation/power/power_supply_class.txt
>> says it's in uA, and a tipical discharge value is around 15259000,
>> that is, 15 A on my system.  At the same time voltage is 11756000,
>> that is, 12 V, which sounds reasonable, but then the power is 15*12 VA,
>> ie 180 W, which is insane.  However, the numerical derivative of
>> energy_now gives 18 W, which is both reasonable and consistent with
>> the assumed factor of 10 error in current_now.  Is this possibly a bug
>> in 2.6.26.6?  During a quick glance over battery.c nothing obvious
>> jumped at me, but I'm no expert on this.
>> --
>> Thanks,
>> Feri.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>     


--------------020607010209060500070605
Content-Type: text/x-diff;
 name="convert_discharge_energy_to_current.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="convert_discharge_energy_to_current.patch"

ACPI:battery: Convert discharge energy rate to current properly

From: Alexey Starikovskiy <astarikovskiy@suse.de>

ACPI battery interface reports its state either in mW or in mA, and 
discharge rate in your case is reported in mW. power_supply interface 
does not have such a parameter, so current_now parameter is used 
for all cases. But in case of mW, reported discharge should
be converted into mA.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/battery.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)


diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 1423b0c..0ebc04c 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -174,6 +174,15 @@ static int acpi_battery_get_property(struct power_supply *psy,
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		val->intval = battery->current_now * 1000;
+		/* if power units are mW, convert to mA by 
+		   dividing by current voltage (mV/1000) */
+		if (!battery->power_unit) { 
+			if (battery->voltage_now) {
+				val->intval /= battery->voltage_now;
+				val->intval *= 1000;
+			} else 
+				val->intval = -1;
+		}
 		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
 	case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:

--------------020607010209060500070605--
