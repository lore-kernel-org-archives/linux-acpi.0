From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: assumptions in acpi drivers
Date: Sat, 10 Oct 2009 14:16:49 +0100
Message-ID: <9b2b86520910100616n38e842e2m9cf306eb4e812077@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:59596 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932070AbZJJNR1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 10 Oct 2009 09:17:27 -0400
Received: by bwz6 with SMTP id 6so2179497bwz.37
        for <linux-acpi@vger.kernel.org>; Sat, 10 Oct 2009 06:16:50 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org

>> @@ -315,9 +312,6 @@ static int lis3lv02d_add(struct acpi_device *device)
>>
>>  static int lis3lv02d_remove(struct acpi_device *device, int type)
>>  {
>> -	if (!device)
>> -		return -EINVAL;
>> -
>>  	lis3lv02d_joystick_disable();
>>  	lis3lv02d_poweroff(&lis3_dev);
>
> Same basic issue as the kfree comments below; the fact that this
> remove method doesn't reference "device" is a symptom of a driver
> structure problem (beyond the scope of this patch, obviously).
>

>> @@ -1306,9 +1303,6 @@ end:
>>
>>  static int asus_hotk_remove(struct acpi_device *device, int type)
>>  {
>> -	if (!device || !acpi_driver_data(device))
>> -		return -EINVAL;
>> -
>>  	kfree(hotk->name);
>>  	kfree(hotk);
>
> Separate issue: we should kfree acpi_driver_data(device) here,
> not "hotk".  In general, the "remove" should deal with per-device
> data, not globals.  This driver only deals with a single instance,
> so they happen to be the same in this case, but you have to read
> more of the driver to verify that.
>

>> @@ -1276,9 +1274,6 @@ fail_platform_driver:
>>
>>  static int eeepc_hotk_remove(struct acpi_device *device, int type)
>>  {
>> -	if (!device || !acpi_driver_data(device))
>> -		return -EINVAL;
>> -
>>  	eeepc_backlight_exit();
>>  	eeepc_rfkill_exit();
>>  	eeepc_input_exit();
>
> The current upstream version of this function also has the kfree
> issue.  You're patching a different version, so it might be fixed
> there already.  But it seems like all these hotkey drivers (and the
> accelerometer driver) use the same pattern of assuming they'll only
> see a single device, and then they make assumptions like "hotk ==
> acpi_driver_data(device)".  That's just a bad example for people
> to follow, and might not even be true for things like accelerometers
> where you could imagine having more than one.

I've been thinking about this.  Frankly, I can't imagine a machine
having multiple ACPI accelerometer devices with the same interface.
It doesn't make sense to have multiple instances of any of the drivers
under /platform/.  And many of them create platform devices with fixed
names, so we can't pretend it would work.

Perhaps the best approach is to remove the references to
device->driverdata, and consistently use "hotk" or equivalent.  The
_core_ acpi devices would always provide correct examples of how to
use driverdata.

But we do need to make sure we don't crash if some strange machine has
multiple matching acpi devices.  Something like this -

static atomic_t device_present;

add():
        if (atomic_inc_return(&device_present) != 1)
                 return -EBUSY;

remove():
        atomic_dec(&device_present);


Regards
Alan
