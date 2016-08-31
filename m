From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / button: add support for tablet mode switch
Date: Thu, 1 Sep 2016 00:55:15 +0200
Message-ID: <CAJZ5v0imPfDFc=f1Phgb28QTjb0C4O49b9Xuob+eD4zDFBxBMg@mail.gmail.com>
References: <1472628817-3145-1-git-send-email-wnhuang@google.com>
 <1472630482.2273.4.camel@intel.com> <CABicQ-XJaYGiDVKgefwN-6ckcwepUAvtpjJhwQN3cw389a+12w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38248 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753364AbcHaXAd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 Aug 2016 19:00:33 -0400
In-Reply-To: <CABicQ-XJaYGiDVKgefwN-6ckcwepUAvtpjJhwQN3cw389a+12w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wei-Ning Huang <wnhuang@google.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Aug 31, 2016 at 10:52 AM, Wei-Ning Huang <wnhuang@google.com> wrote=
:
> On Wed, Aug 31, 2016 at 4:01 PM, Zhang Rui <rui.zhang@intel.com> wrote:
>> On =E4=B8=89, 2016-08-31 at 15:33 +0800, Wei-Ning Huang wrote:
>>> From: Wei-Ning Huang <wnhuang@chromium.org>
>>>
>>> ACPI PNP device HID 'PNP0C60' is a device that indicates tablet mode
>>> status. Add support for mapping this device to the SW_TABLET_MODE
>>> input
>>> event.
>>>
>>> Signed-off-by: Wei-Ning Huang <wnhuang@chromium.org>
>>> ---
>>>  drivers/acpi/button.c | 36 ++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 36 insertions(+)
>>>
>>> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
>>> index 148f4e5..50e9de6 100644
>>> --- a/drivers/acpi/button.c
>>> +++ b/drivers/acpi/button.c
>>> @@ -53,6 +53,11 @@
>>>  #define ACPI_BUTTON_DEVICE_NAME_LID  "Lid Switch"
>>>  #define ACPI_BUTTON_TYPE_LID         0x05
>>>
>>> +#define ACPI_BUTTON_SUBCLASS_TABLET  "tablet"
>>> +#define ACPI_BUTTON_HID_TABLET               "PNP0C60"
>>> +#define ACPI_BUTTON_DEVICE_NAME_TABLET       "Tablet Mode Switch"
>>> +#define ACPI_BUTTON_TYPE_TABLET              0x07
>>> +
>>>  #define ACPI_BUTTON_LID_INIT_IGNORE  0x00
>>>  #define ACPI_BUTTON_LID_INIT_OPEN    0x01
>>>  #define ACPI_BUTTON_LID_INIT_METHOD  0x02
>>> @@ -70,6 +75,7 @@ static const struct acpi_device_id
>>> button_device_ids[] =3D {
>>>       {ACPI_BUTTON_HID_SLEEPF, 0},
>>>       {ACPI_BUTTON_HID_POWER,  0},
>>>       {ACPI_BUTTON_HID_POWERF, 0},
>>> +     {ACPI_BUTTON_HID_TABLET, 0},
>>>       {"", 0},
>>>  };
>>>  MODULE_DEVICE_TABLE(acpi, button_device_ids);
>>> @@ -305,6 +311,23 @@ static void acpi_lid_initialize_state(struct
>>> acpi_device *device)
>>>       }
>>>  }
>>>
>>> +static int acpi_tablet_send_state(struct acpi_device *device)
>>> +{
>>> +     struct acpi_button *button =3D acpi_driver_data(device);
>>> +     unsigned long long state;
>>> +     acpi_status status;
>>> +
>>> +     status =3D acpi_evaluate_integer(device->handle, "_TBL", NULL,
>>> &state);
>>
>> Control methods with prefix "_" suggests this is an ACPI predefined
>> control method, but I can not find it in ACPI spec 6.1.
>> Can you illustrate me where I can find the definition of _TBL?
>
> Sorry, I'm not very familiar with ACPI's control method.

So apparently you don't really know what the patch you've posted is doing.

> '_TBL' is not a predefined ACPI control method according to the ACPI 6.1 =
spec.
> Maybe I should change it to '_LID'? As a tablet switch is sort of a
> 'inverted' lid switch.

Is that _TBL thing documented anywhere?

Thanks,
Rafael
