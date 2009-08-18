From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH 2/3] Add rfkill support to compal-laptop
Date: Tue, 18 Aug 2009 08:44:38 +0100
Message-ID: <9b2b86520908180044l72cb8642j6256e246662f7971@mail.gmail.com>
References: <4A89E768.7010207@dell.com>
	 <1250558643.30166.109.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f222.google.com ([209.85.218.222]:63570 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbZHRHoi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Aug 2009 03:44:38 -0400
In-Reply-To: <1250558643.30166.109.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Mario Limonciello <mario_limonciello@dell.com>, cezary.jackiewicz@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 8/18/09, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Mario,

...

>> +static int setup_rfkill(void)
>> +{
>> +       int ret;
>> +
>> +       wifi_rfkill = rfkill_alloc("compal-wifi", NULL,
>> RFKILL_TYPE_WLAN,
>> +                                       &compal_rfkill_ops, (void *)
>> WLAN_MASK);
>> +       if (!wifi_rfkill) {
>> +               ret = -ENOMEM;
>> +               goto err_wifi;
>> +       }
>> +       ret = rfkill_register(wifi_rfkill);
>> +       if (ret)
>> +               goto err_wifi;
>> +
>> +       bluetooth_rfkill = rfkill_alloc("compal-bluetooth", NULL,
>> RFKILL_TYPE_BLUETOOTH,
>> +                                       &compal_rfkill_ops, (void *)
>> BT_MASK);
>> +       if (!bluetooth_rfkill) {
>> +               ret = -ENOMEM;
>> +               goto err_bt;
>> +       }
>> +       ret = rfkill_register(bluetooth_rfkill);
>> +       if (ret)
>> +               goto err_bt;
>> +
>> +       return 0;
>> +err_bt:
>> +       rfkill_destroy(bluetooth_rfkill);
>> +       if (bluetooth_rfkill)
>> +               rfkill_unregister(bluetooth_rfkill);
>> +err_wifi:
>> +       rfkill_destroy(wifi_rfkill);
>> +       if (wifi_rfkill)
>> +               rfkill_unregister(wifi_rfkill);
>
> I don't understand how this is not a potential NULL pointer dereference.
> There might some good luck that the pointer is still valid at that time,
> but I highly doubt it. So please unregister before destory.

Wrong as well :-).

If you fail to register wifi_rfkill, you should *only* call
rfkill_destroy().  So I think it should look like this:

+       if (wifi_rfkill)
+               rfkill_unregister(wifi_rfkill);
+err_wifi:
+       rfkill_destroy(wifi_rfkill);

...

>> @@ -420,6 +518,10 @@
>>         platform_device_unregister(compal_device);
>>         platform_driver_unregister(&compal_driver);
>>         backlight_device_unregister(compalbl_device);
>> +       if (wifi_rfkill)
>> +               rfkill_unregister(wifi_rfkill);
>> +       if (bluetooth_rfkill)
>> +               rfkill_unregister(bluetooth_rfkill);
>
> Same here. It should never ever succeeded in the first place. You can
> call it conditionally.

They're already called conditionally.  I assume you mean unconditionally here.

I agree with all your other comments.  Although I wouldn't call the
return/else style issue stupid, I'd just say it was confused :-).

Regards
Alan
