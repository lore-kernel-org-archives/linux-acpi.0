From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH v2] ACPI / battery: trigger rechecking of AC adapter state
 when battery state changes.
Date: Fri, 07 Mar 2014 11:43:10 +0800
Message-ID: <5319404E.10509@intel.com>
References: <1393758159-6934-1-git-send-email-mezin.alexander@gmail.com> <1820321.2G4Ojtj5V1@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59088 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbaCGDlZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 6 Mar 2014 22:41:25 -0500
In-Reply-To: <1820321.2G4Ojtj5V1@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexander Mezin <mezin.alexander@gmail.com>
Cc: linux-acpi@vger.kernel.org

On 03/06/2014 09:15 PM, Rafael J. Wysocki wrote:
> On Sunday, March 02, 2014 06:02:39 PM Alexander Mezin wrote:
>> On HP Pavilion dv6-6179er there are no notifications when AC adapter
>> is plugged/unplugged.
>>
>> Output of acpi_listen, adapter is unplugged and then plugged in back:
>>
>> battery PNP0C0A:00 00000001 00000001
>> battery PNP0C0A:00 00000080 00000001
>>   PNP0C14:00 00000080 00000000
>> processor LNXCPU:00 00000082 00000000
>> battery PNP0C0A:00 00000000 00000001
>> battery PNP0C0A:00 00000080 00000001
>>   PNP0C14:00 00000080 00000000
>> processor LNXCPU:00 00000082 00000000
>> battery PNP0C0A:00 00000080 00000001
>>
>> The only way to trigger the notification is to read "online"
>> property in sysfs (/sys/class/power_supply/AC/online).
>>
>> This patch triggers the notification by calling get_property for
>> every mains power supply.
>>
>> Output of acpi_listen with this patch applied:
>>
>> battery PNP0C0A:00 00000001 00000001
>> battery PNP0C0A:00 00000080 00000001
>>   PNP0C14:00 00000080 00000000
>> ac_adapter ACPI0003:00 00000000 00000000
>> processor LNXCPU:00 00000082 00000000
>> battery PNP0C0A:00 00000000 00000001
>> battery PNP0C0A:00 00000080 00000001
>>   PNP0C14:00 00000080 00000000
>> ac_adapter ACPI0003:00 00000000 00000001
>> processor LNXCPU:00 00000082 00000000
>> battery PNP0C0A:00 00000080 00000001
>>
>> I'm using this patch for about a month, and didn't notice any
>> problems. I've tested it on top of both 3.13.5 and 3.14-rc4.
>>
>> Signed-off-by: Alexander Mezin <mezin.alexander@gmail.com>
>
> Tiany, do you have any more comments here?
>

Sorry for later response due to be busy on other things.

Hi Alexander:

 From the DSDT table, _Q08 is in change of notifying AC driver.
So you can check "/sys/firmware/acpi/interrupts/gpe08". Whether the 
count increases or not during plugging or unplugging AC.

According the description, the _Q08 wasn't triggered.

 >> The only way to trigger the notification is to read "online"
 >> property in sysfs (/sys/class/power_supply/AC/online).

The AC status is read and _PSR() is invoked during "online" file is 
accessed.

_PSR() compares EC AC status with previous stored value and notify AC 
driver if these values are not equal. This is why there is AC event 
after accessing "online" sysfs interface.

Method (_PSR, 0, NotSerialized)  // _PSR: Power Source
{
     Store (ACP, Local0)
     If (^^PCI0.LPCB.EC.ECOK)
     {
         Store (^^PCI0.LPCB.EC.ADP, Local0)
         If (LNotEqual (Local0, ACP))
         {
             FLPA ()
         }
     }
	.....
}


Method (FLPA, 0, NotSerialized)
{
     If (ACP)
     {
         Store (Zero, ACP)
     }
     Else
     {
         Store (One, ACP)
     }

     Notify (AC, Zero)
}


>>
>> ---
>>   v2: more verbose description
>>
>>   drivers/acpi/battery.c | 22 ++++++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index 797a693..fb548f0 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -671,9 +671,22 @@ static void acpi_battery_quirks(struct acpi_battery *battery)
>>   	}
>>   }
>>
>> +static int acpi_battery_check_ac_state(struct device *dev, void *unused)
>> +{
>> +	struct power_supply *ps = dev_get_drvdata(dev);
>> +	union power_supply_propval temp;
>> +
>> +	if (ps->type != POWER_SUPPLY_TYPE_MAINS)
>> +		return 0;
>> +
>> +	ps->get_property(ps, POWER_SUPPLY_PROP_ONLINE, &temp);
>> +	return 0;
>> +}
>> +
>>   static int acpi_battery_update(struct acpi_battery *battery)
>>   {
>>   	int result, old_present = acpi_battery_present(battery);
>> +	int old_state = battery->state;
>>   	result = acpi_battery_get_status(battery);
>>   	if (result)
>>   		return result;
>> @@ -696,6 +709,15 @@ static int acpi_battery_update(struct acpi_battery *battery)
>>   	}
>>   	result = acpi_battery_get_state(battery);
>>   	acpi_battery_quirks(battery);
>> +	if (old_state != battery->state)
>> +		/*
>> +		 * Some BIOSes don't send notifications when AC adapter
>> +		 * is plugged or unplugged.
>> +		 * If battery changes its state, this could indicate that
>> +		 * AC adapter's state has changed too.
>> +		 */
>> +		class_for_each_device(power_supply_class, NULL, NULL,
>> +				      &acpi_battery_check_ac_state);

I think you can use acpi_notifier_call_chain() here and register acpi 
notifier in the AC driver. When get the Battery change event, call 
acpi_ac_get_state(ac). From my view, this is more general than traverse 
all power supply device and call AC's get_property() callback in battery 
driver.

>>   	return result;
>>   }
>>
>>
>


-- 
Best Regards
Tianyu Lan
