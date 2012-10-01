From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH] acpi: fix brightness level is initialized to zero when
 BIOS does not restore the brightness value to _BQC.
Date: Mon, 01 Oct 2012 17:11:47 +0800
Message-ID: <50695E53.6030805@canonical.com>
References: <1349069987-23992-1-git-send-email-alex.hung@canonical.com>  <1349074033.24232.19.camel@linux-s257.site>  <50694027.5060902@canonical.com>  <1349075823.24232.30.camel@linux-s257.site> <1349080450.24232.35.camel@linux-s257.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:35051 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab2JAJLz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Oct 2012 05:11:55 -0400
In-Reply-To: <1349080450.24232.35.camel@linux-s257.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: rui.zhang@intel.com, linux-acpi@vger.kernel.org

On 10/01/2012 04:34 PM, joeyli wrote:
> =E6=96=BC =E4=B8=80=EF=BC=8C2012-10-01 =E6=96=BC 15:17 +0800=EF=BC=8C=
joeyli =E6=8F=90=E5=88=B0=EF=BC=9A
>> =E6=96=BC =E4=B8=80=EF=BC=8C2012-10-01 =E6=96=BC 15:03 +0800=EF=BC=8C=
Alex Hung =E6=8F=90=E5=88=B0=EF=BC=9A
>>> On 10/01/2012 02:47 PM, joeyli wrote:
>>>> Hi Alex,
>>>>
>>>> =E6=96=BC =E4=B8=80=EF=BC=8C2012-10-01 =E6=96=BC 13:39 +0800=EF=BC=
=8CAlex Hung =E6=8F=90=E5=88=B0=EF=BC=9A
>>>>> Signed-off-by: Alex Hung <alex.hung@canonical.com>
>>>>> ---
>>>>>    drivers/acpi/video.c |    4 ++++
>>>>>    1 files changed, 4 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c
>>>>> index 42b226e..eaa9573 100644
>>>>> --- a/drivers/acpi/video.c
>>>>> +++ b/drivers/acpi/video.c
>>>>> @@ -724,6 +724,10 @@ acpi_video_init_brightness(struct acpi_video=
_device *device)
>>>>>    				if (level_old =3D=3D br->levels[i])
>>>>>    					level =3D level_old;
>>>>>    		}
>>>>> +
>>>>> +		if (level =3D=3D 0)
>>>>> +			level =3D br->levels[(br->count) / 2 + 1];
>>>>
>>>> Looks here used the 50% brightness level.
>>>>
>>>> Per comment in video.c, we want set the backlight to max_level whe=
n
>>>> level_old is invalid:
>>>>
>>>>           if (!br->flags._BQC_use_index) {
>>>>                   /*
>>>>                    * Set the backlight to the initial state.
>>>>                    * On some buggy laptops, _BQC returns an uninit=
ialized value
>>>>                    * when invoked for the first time, i.e. level_o=
ld is invalid.
>>>>                    * set the backlight to max_level in this case
>>>>                    */
>>>>
>>>> I think here used max_level to fulfill it, e.g.
>>>> =09
>>>> +		if (level =3D=3D 0)
>>>> +			level =3D max_level;
>>>>
>>>> How do you think?
>>> Hi Joey,
>>>
>>> I was debating with myself which level to be set, ex. 50%, ~75% or =
100%,
>>> and I think 50% *might* be closer to normal use-case (just a person=
al
>>> guess).
>>>
>>> However, "max_level" seems to fit best if we treat the initial zero
>>> brightness in invalid. I can modify it according it that's preferre=
d.
>>>
>>> Thanks for the feedback.
>>>
>>> Cheers,
>>> Alex Hung
>>>
>>
>> hm.... I have a question for what's the BIOS's problem that causes
>> 'level =3D=3D 0'?
>> That implied the issue machine's max_level is 0?
>>
>> 		/*
>> 		 * Set the level to maximum and check if _BQC uses indexed value
>> 		 */
>> 		result =3D acpi_video_device_lcd_set_level(device, max_level);		/*=
 write max_level purposely, then read level back, compare them */
>> 		...
>> 		result =3D acpi_video_device_lcd_get_level_current(device, &level,=
 0);
>> 		...
>> 		br->flags._BQC_use_index =3D (level =3D=3D max_level ? 0 : 1);
>> 		if (!br->flags._BQC_use_index) {				/* _BQC_use_index is 0 will ru=
n into if, means level =3D=3D max_level */
>>
>> So, looks the 'level =3D=3D max_level =3D=3D 0' when level_old is in=
valid.
>>
>> Just wonder what's defect of BIOS (in _BCL?) causes problem.
>>
>>
>
> Sorry for my misunderstood!
>
> I think that's possible the level_old is 0 and there have a 0 value i=
n
> the return package from _BCL.
>

Yes, there is nothing wrong with _BCL and _BQC except that _BQC returns=
=20
a zero initially.

> Could you please share the _BCL in DSDT from issue machine? Does ther=
e
> have 0 value in _BCL?

_BCL returns below data and there is a zero in the list.

[  744.572289] Brightness[0] =3D 100
[  744.572293] Brightness[1] =3D 50
[  744.572295] Brightness[2] =3D 0
[  744.572297] Brightness[3] =3D 10
[  744.572299] Brightness[4] =3D 20
[  744.572301] Brightness[5] =3D 30
[  744.572303] Brightness[6] =3D 40
[  744.572305] Brightness[7] =3D 50
[  744.572306] Brightness[8] =3D 60
[  744.572308] Brightness[9] =3D 70
[  744.572310] Brightness[10] =3D 80
[  744.572312] Brightness[11] =3D 90
[  744.572314] Brightness[12] =3D 100

The below is the complete _BCL for references

                 Method (_BCL, 0, Serialized)
                 {
                     Name (_T_0, Zero)
                     If (_OSI ("NOT_WINP_KEY"))
                     {
                         While (One)
                         {
                             Store (LCDD, _T_0)
                             If (LEqual (_T_0, 0x303CAF06))
                             {
                                 Return (AUOL)
                             }
                             Else
                             {
                                 If (LEqual (_T_0, 0x1475AE0D))
                                 {
                                     Return (CMIL)
                                 }
                                 Else
                                 {
                                     If (LEqual (_T_0, 0x033FE430))
                                     {
                                         Return (LGDL)
                                     }
                                     Else
                                     {
                                         If (LEqual (_T_0, 0x3942A34C))
                                         {
                                             Return (SAML)
                                         }
                                         Else
                                         {
                                             Return (DEFL)
                                         }
                                     }
                                 }
                             }

                             Break
                         }
                     }
                     Else
                     {
                         Return (Package (0x0D)
                         {
                             0x64,
                             0x32,
                             Zero,
                             0x0A,
                             0x14,
                             0x1E,
                             0x28,
                             0x32,
                             0x3C,
                             0x46,
                             0x50,
                             0x5A,
                             0x64
                         })
                     }
                 }


>
>
> Thanks a lot!
> Joey Lee
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
