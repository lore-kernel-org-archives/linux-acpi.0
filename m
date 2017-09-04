From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] platform/x86: intel_cht_int33fe: Work around BIOS bug
 on some devices
Date: Mon, 4 Sep 2017 20:01:36 +0300
Message-ID: <CAHp75VfW2K_fT7A-z3DCind3wj3haHwe3NM-xtOfGoJt5VVO6g@mail.gmail.com>
References: <20170902162040.18565-1-hdegoede@redhat.com> <1504527787.25945.219.camel@linux.intel.com>
 <3c60c7b3-a712-c61f-53b8-54dba850a8bc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:32830 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753847AbdIDRBi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Sep 2017 13:01:38 -0400
In-Reply-To: <3c60c7b3-a712-c61f-53b8-54dba850a8bc@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Sep 4, 2017 at 3:47 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 04-09-17 14:23, Andy Shevchenko wrote:
>>
>> On Sat, 2017-09-02 at 18:20 +0200, Hans de Goede wrote:
>>>
>>> At least one BIOS enumerates the max17047 both through the INT33FE
>>> ACPI
>>> device (it is right there in the resources table) as well as through a
>>> separate MAX17047 device.
>>>
>>> This commit checks for the max17047 already being enumerated through
>>> a separate MAX17047 ACPI device and if so it uses the i2c-client
>>> instantiated for this and attaches the device-props for the max17047
>>> to
>>> that i2c-client.
>>
>>
>> This one looks acceptable wrt buggy BIOS workaround, few comments below
>> (I can do it when applying)
>
>
> The suggested comments are fine with me, feel free to fix
> those up while applying.

Pushed to review-andy.

>
> Thanks & Regards,
>
> Hans
>
>
>
>
>>
>>>
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> Changes in v2:
>>> -Check acpi_companion HID instead of dev_name
>>> ---
>>>   drivers/platform/x86/intel_cht_int33fe.c | 71
>>> +++++++++++++++++++++++++++-----
>>>   1 file changed, 61 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/intel_cht_int33fe.c
>>> b/drivers/platform/x86/intel_cht_int33fe.c
>>> index da706e2c4232..a9cbc4b8ca63 100644
>>> --- a/drivers/platform/x86/intel_cht_int33fe.c
>>> +++ b/drivers/platform/x86/intel_cht_int33fe.c
>>> @@ -34,6 +34,42 @@ struct cht_int33fe_data {
>>>         struct i2c_client *pi3usb30532;
>>>   };
>>>   +/*
>>> + * Grrr I severly dislike buggy BIOS-es. At least one BIOS enumerates
>>> + * the max17047 both through the INT33FE ACPI device (it is right
>>> there
>>> + * in the resources table) as well as through a separate MAX17047
>>> device.
>>> + *
>>> + * These helpers are used to work around this by checking if an i2c-
>>> client
>>> + * for the max17047 has already been registered.
>>> + */
>>> +int cht_int33fe_check_for_max17047(struct device *dev, void *data)
>>> +{
>>> +       struct acpi_device *companion = ACPI_COMPANION(dev);
>>> +       struct i2c_client **max17047 = data;
>>> +       const char *hid;
>>> +
>>
>>
>> I would assign companion right here.
>>>
>>> +       if (!companion)
>>> +               return 0;
>>> +
>>> +       hid = acpi_device_hid(companion);
>>> +
>>> +       /* The MAX17047 ACPI node doesn't have an UID, so we don't
>>> check that */
>>
>>
>>> +       if (strcmp(hid, "MAX17047") == 0) {
>>
>>
>> if (strcmp())
>>   return 0;
>>
>> ?
>>
>>> +               *max17047 = to_i2c_client(dev);
>>> +               return 1;
>>> +       }
>>> +
>>> +       return 0;
>>> +}
>>> +
>>> +struct i2c_client *cht_int33fe_find_max17047(void)
>>> +{
>>> +       struct i2c_client *max17047 = NULL;
>>> +
>>> +       i2c_for_each_dev(&max17047, cht_int33fe_check_for_max17047);
>>> +       return max17047;
>>> +}
>>> +
>>>   static const char * const max17047_suppliers[] = { "bq24190-charger"
>>> };
>>>     static const struct property_entry max17047_props[] = {
>>> @@ -46,9 +82,10 @@ static int cht_int33fe_probe(struct i2c_client
>>> *client)
>>>         struct device *dev = &client->dev;
>>>         struct i2c_board_info board_info;
>>>         struct cht_int33fe_data *data;
>>> +       struct i2c_client *max17047;
>>>         unsigned long long ptyp;
>>>         acpi_status status;
>>> -       int fusb302_irq;
>>> +       int ret, fusb302_irq;
>>>         status = acpi_evaluate_integer(ACPI_HANDLE(dev), "PTYP",
>>> NULL, &ptyp);
>>>         if (ACPI_FAILURE(status)) {
>>> @@ -75,13 +112,25 @@ static int cht_int33fe_probe(struct i2c_client
>>> *client)
>>>         if (!data)
>>>                 return -ENOMEM;
>>>   -     memset(&board_info, 0, sizeof(board_info));
>>> -       strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
>>> -       board_info.properties = max17047_props;
>>> -
>>> -       data->max17047 = i2c_acpi_new_device(dev, 1, &board_info);
>>> -       if (!data->max17047)
>>> -               return -EPROBE_DEFER; /* Wait for the i2c-adapter to
>>> load */
>>> +       /* Work around BIOS bug, see comment on
>>> cht_int33fe_find_max17047 */
>>> +       max17047 = cht_int33fe_find_max17047();
>>> +       if (max17047) {
>>> +               /* Pre-existing i2c-client for the max17047, add
>>> device-props */
>>> +               ret = device_add_properties(&max17047->dev,
>>> max17047_props);
>>> +               if (ret)
>>> +                       return ret;
>>> +               /* And re-probe to get the new device-props applied.
>>> */
>>> +               ret = device_reprobe(&max17047->dev);
>>> +               if (ret)
>>> +                       dev_warn(dev, "Reprobing max17047 error:
>>> %d\n", ret);
>>> +       } else {
>>> +               memset(&board_info, 0, sizeof(board_info));
>>> +               strlcpy(board_info.type, "max17047", I2C_NAME_SIZE);
>>> +               board_info.properties = max17047_props;
>>> +               data->max17047 = i2c_acpi_new_device(dev, 1,
>>> &board_info);
>>> +               if (!data->max17047)
>>> +                       return -EPROBE_DEFER; /* Wait for i2c-adapter
>>> to load */
>>> +       }
>>>         memset(&board_info, 0, sizeof(board_info));
>>>         strlcpy(board_info.type, "fusb302", I2C_NAME_SIZE);
>>> @@ -106,7 +155,8 @@ static int cht_int33fe_probe(struct i2c_client
>>> *client)
>>>         i2c_unregister_device(data->fusb302);
>>>     out_unregister_max17047:
>>> -       i2c_unregister_device(data->max17047);
>>> +       if (data->max17047)
>>> +               i2c_unregister_device(data->max17047);
>>>         return -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
>>>   }
>>> @@ -117,7 +167,8 @@ static int cht_int33fe_remove(struct i2c_client
>>> *i2c)
>>>         i2c_unregister_device(data->pi3usb30532);
>>>         i2c_unregister_device(data->fusb302);
>>> -       i2c_unregister_device(data->max17047);
>>> +       if (data->max17047)
>>> +               i2c_unregister_device(data->max17047);
>>>         return 0;
>>>   }
>>
>>
>



-- 
With Best Regards,
Andy Shevchenko
