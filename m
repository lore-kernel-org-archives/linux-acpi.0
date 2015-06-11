From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 20/32] dell-wmi: Port to new backlight interface selection
 API
Date: Thu, 11 Jun 2015 14:19:11 +0200
Message-ID: <55797CBF.8090301@redhat.com>
References: <1433941292-21530-1-git-send-email-hdegoede@redhat.com> <1433941292-21530-21-git-send-email-hdegoede@redhat.com> <20150611114330.GC19820@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20150611114330.GC19820@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Darren Hart <dvhart@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ben Skeggs <bskeggs@redhat.com>, Azael Avalos <coproscefalo@gmail.com>, Corentin Chary <corentin.chary@gmail.com>, Lee Chun-Yi <jlee@suse.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Ike Panhc <ike.pan@canonical.com>, Anisse Astier <anisse@astier.eu>, Mattia Dongili <malattia@linux.it>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, platform-driver-x86@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, acpi4asus-user@lists.sourceforge.net, dri-devel@lists.freedesktop.org, Aaron Lu <aaron.lu@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

On 11-06-15 13:43, Pali Roh=C3=A1r wrote:
> On Wednesday 10 June 2015 15:01:20 Hans de Goede wrote:
>> Port the backlight selection logic to the new backlight interface
>> selection API.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/platform/x86/dell-wmi.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/=
dell-wmi.c
>> index 6512a06..f2d77fe 100644
>> --- a/drivers/platform/x86/dell-wmi.c
>> +++ b/drivers/platform/x86/dell-wmi.c
>> @@ -35,6 +35,7 @@
>>   #include <linux/acpi.h>
>>   #include <linux/string.h>
>>   #include <linux/dmi.h>
>> +#include <acpi/video.h>
>>
>>   MODULE_AUTHOR("Matthew Garrett <mjg@redhat.com>");
>>   MODULE_DESCRIPTION("Dell laptop WMI hotkeys driver");
>> @@ -397,7 +398,7 @@ static int __init dell_wmi_init(void)
>>   	}
>>
>>   	dmi_walk(find_hk_type, NULL);
>> -	acpi_video =3D acpi_video_backlight_support();
>> +	acpi_video =3D acpi_video_get_backlight_type() !=3D acpi_backlight=
_vendor;
>>
>>   	err =3D dell_wmi_input_setup();
>>   	if (err)
>
> Hello,
>
> to make sure that nothing will be broken I will try to explain curren=
t
> code. Variable acpi_video is global boolean (for this module) and whe=
n
> is set to true it is expected that ACPI generate brightness up/down k=
ey
> events via ACPI input device. When is acpi_video boolean variable is =
set
> to false then ACPI input device should not send brightness up/down ke=
ys
> to userspace. And dell-wmi.ko driver send those two keys via dell-wmi
> input device.

I know.

> So please check that your change does not change above behaviour.

I've already checked this.

 > Maybe it would make sense to rename "acpi_video" variable to somethi=
ng better.

There is another driver which has a similar construction. I believe tha=
t it
would be good to add an acpi_video_handles_key_presses() helper to the
acpi-video code which can be used for this instead of abusing
acpi_video_get_backlight_type() for this. I've put this on my todo list
to do as a further cleanup once the initial series is merged.

Regards,

Hans
