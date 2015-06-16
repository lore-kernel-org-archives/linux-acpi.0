From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 30/32] toshiba-acpi: Port to new backlight interface
 selection API
Date: Tue, 16 Jun 2015 14:53:42 +0200
Message-ID: <55801C56.2070401@redhat.com>
References: <1434108231-12323-1-git-send-email-hdegoede@redhat.com>	<1434108231-12323-31-git-send-email-hdegoede@redhat.com> <CAGdLNWG02EY7P4A8sn+gGzgqDLWwBKPWg5aFM9LyemqiM4QNWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <CAGdLNWG02EY7P4A8sn+gGzgqDLWwBKPWg5aFM9LyemqiM4QNWg@mail.gmail.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Azael Avalos <coproscefalo@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ben Skeggs <bskeggs@redhat.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

On 06/14/2015 05:15 AM, Azael Avalos wrote:
> Hi Hans,
>
> Sorry for the late reply, I was out of town.
>
> 2015-06-12 5:23 GMT-06:00 Hans de Goede <hdegoede@redhat.com>:
>> Port the backlight selection logic to the new backlight interface
>> selection API.
>>
>> Also fix a compiler warning about bt_present not being initialized.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/platform/x86/toshiba_acpi.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
>> index 9956b990..c484d47 100644
>> --- a/drivers/platform/x86/toshiba_acpi.c
>> +++ b/drivers/platform/x86/toshiba_acpi.c
>> @@ -2640,14 +2640,11 @@ static int toshiba_acpi_setup_backlight(struct toshiba_acpi_dev *dev)
>>           */
>>          if (dev->tr_backlight_supported ||
>>              dmi_check_system(toshiba_vendor_backlight_dmi))
>> -               acpi_video_dmi_promote_vendor();
>> +               acpi_video_set_dmi_backlight_type(acpi_backlight_vendor);
>>
>> -       if (acpi_video_backlight_support())
>> +       if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
>>                  return 0;
>>
>> -       /* acpi-video may have loaded before we called dmi_promote_vendor() */
>> -       acpi_video_unregister_backlight();
>> -
>>          memset(&props, 0, sizeof(props));
>>          props.type = BACKLIGHT_PLATFORM;
>>          props.max_brightness = HCI_LCD_BRIGHTNESS_LEVELS - 1;
>> @@ -2733,7 +2730,7 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
>>          const char *hci_method;
>>          u32 special_functions;
>>          u32 dummy;
>> -       bool bt_present;
>> +       bool bt_present = false;
>>          int ret = 0;
>>
>>          if (toshiba_acpi)
>> --
>> 2.4.2
>>
>
>
> Please drop the last chunk of this patch as commit
> 2b74103547b4dfaac10cd55464cd2bcc26022a66 removed that line,
> other than that:

Done for v3 of the patch-set

> Acked-by: Azael Avalos <coproscefalo@gmail.com>

Thanks,

Hans
