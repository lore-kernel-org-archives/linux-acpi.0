From: Alex Hung <alex.hung@canonical.com>
Subject: Re: [PATCH] acpi: fix brightness level is initialized to zero when
 BIOS does not restore the brightness value to _BQC.
Date: Mon, 08 Oct 2012 12:39:13 +0800
Message-ID: <507258F1.40709@canonical.com>
References: <1349069987-23992-1-git-send-email-alex.hung@canonical.com>  <1349074033.24232.19.camel@linux-s257.site>  <50694027.5060902@canonical.com>  <1349075823.24232.30.camel@linux-s257.site>  <1349080450.24232.35.camel@linux-s257.site>  <50695E53.6030805@canonical.com> <1349083153.24232.37.camel@linux-s257.site> <744357E9AAD1214791ACBA4B0B90926322D91B@SHSMSX101.ccr.corp.intel.com> <5069B631.2080904@canonical.com> <744357E9AAD1214791ACBA4B0B90926322F5AE@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:37072 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab2JHEjW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Oct 2012 00:39:22 -0400
In-Reply-To: <744357E9AAD1214791ACBA4B0B90926322F5AE@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>
Cc: joeyli <jlee@suse.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 10/08/2012 12:34 PM, Zhang, Rui wrote:
>> -----Original Message-----
>> From: Alex Hung [mailto:alex.hung@canonical.com]
>> Sent: Monday, October 01, 2012 11:27 PM
>> To: Zhang, Rui
>> Cc: joeyli; linux-acpi@vger.kernel.org
>> Subject: Re: [PATCH] acpi: fix brightness level is initialized to ze=
ro
>> when BIOS does not restore the brightness value to _BQC.
>> Importance: High
>>
>> Hi Rui,
>>
>> Yes the module parameter is used temporarily. However, we want to
>> eliminate the need of using any parameter since non-technical users
>> won't know them without any help.
>>
>> The question of whether lowest lowest brightness equals black screen=
 is
>> debatable and I heard good / bad stories from both sides and they al=
l
>> makes sense. This, however, does not necessarily play a role here. T=
he
>> patch is to fix a problem - brightness is set to lowest value (not
>> user-friendly) when it was not intended.
>>
>> I also agree that there is nothing wrong with platform setting the
>> brightness to lowest level during boot and that's a side-effect of t=
his
>> patch indeed.. In fact, it took me a few weeks to decide it may be a=
n
>> improvement for the below reasons.
>>
>> 1. In most of cases, lowest level is less desirable or less commonly
>> used. If a BIOS returns uninitialized valube such as a zero in this
>> case, Linux causes confusion and problems to users with such platfor=
ms.
>> Comparing to the side-effect, this (may) benefits more users.
>>
>> 2. I also checked ACPI sepc and it says:
>>
>> B.5.4 _BQC (Brightness Query Current level) This method returns the
>> current brightness level of a built-in display output device.
>>
>> The definition makes it hard to argue that it is a BIOS bug not to
>> restore previous brightness to _BQC. I think it is ambiguous and thi=
s
>> small fix eliminates very dim screen (whether complete black or not)=
 at
>> boot time.
>>
>> PS. This may not be relevant, but Windows restores the previous
>> brightness without BIOS's _BQC,
>
> Where does windows get the previous brightness?
It seems Windows remember the brightness before shutting down and uses=20
that value when it boots up. It was observed in Windows 7.


>
>> and therefore it does not suffer from
>> very dim / black screen.
>>
>> Cheers,
>> Alex Hung
>>
>>
>> On 10/01/2012 09:36 PM, Zhang, Rui wrote:
>>> I think this is probably what you're looking for,
>>>
>>> /*
>>>    * Some BIOSes claim they use minimum backlight at boot,
>>>    * and this may bring dimming screen after boot
>>>    */
>>> static bool use_bios_initial_backlight =3D 1;
>>> module_param(use_bios_initial_backlight, bool, 0644);
>>>
>>>
>>> Lowest brightness level does not equal black screen.
>>> It is not a bug if a platform wants to set its brightness to lowest
>> brightness level during boot.
>>> If it IS in your case, you can use this module parameter to ignore
>> the initial _BQC value and use max_level instead.
>>>
>>> Thanks,
>>> rui
>>>
>>>> -----Original Message-----
>>>> From: joeyli [mailto:jlee@suse.com]
>>>> Sent: Monday, October 01, 2012 5:19 PM
>>>> To: Alex Hung
>>>> Cc: Zhang, Rui; linux-acpi@vger.kernel.org
>>>> Subject: Re: [PATCH] acpi: fix brightness level is initialized to
>>>> zero when BIOS does not restore the brightness value to _BQC.
>>>> Importance: High
>>>>
>>>> =E6=96=BC =E4=B8=80=EF=BC=8C2012-10-01 =E6=96=BC 17:11 +0800=EF=BC=
=8CAlex Hung =E6=8F=90=E5=88=B0=EF=BC=9A
>>>>> On 10/01/2012 04:34 PM, joeyli wrote:
>>>>>> =E6=96=BC =E4=B8=80=EF=BC=8C2012-10-01 =E6=96=BC 15:17 +0800=EF=BC=
=8Cjoeyli =E6=8F=90=E5=88=B0=EF=BC=9A
>>>>>>> =E6=96=BC =E4=B8=80=EF=BC=8C2012-10-01 =E6=96=BC 15:03 +0800=EF=
=BC=8CAlex Hung =E6=8F=90=E5=88=B0=EF=BC=9A
>>>>>>>> On 10/01/2012 02:47 PM, joeyli wrote:
>>>>>>>>> Hi Alex,
>>>>>>>>>
>>>>>>>>> =E6=96=BC =E4=B8=80=EF=BC=8C2012-10-01 =E6=96=BC 13:39 +0800=EF=
=BC=8CAlex Hung =E6=8F=90=E5=88=B0=EF=BC=9A
>>>>>>>>>> Signed-off-by: Alex Hung <alex.hung@canonical.com>
>>>>>>>>>> ---
>>>>>>>>>>      drivers/acpi/video.c |    4 ++++
>>>>>>>>>>      1 files changed, 4 insertions(+), 0 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/acpi/video.c b/drivers/acpi/video.c ind=
ex
>>>>>>>>>> 42b226e..eaa9573 100644
>>>>>>>>>> --- a/drivers/acpi/video.c
>>>>>>>>>> +++ b/drivers/acpi/video.c
>>>>>>>>>> @@ -724,6 +724,10 @@ acpi_video_init_brightness(struct
>>>> acpi_video_device *device)
>>>>>>>>>>      				if (level_old =3D=3D br->levels[i])
>>>>>>>>>>      					level =3D level_old;
>>>>>>>>>>      		}
>>>>>>>>>> +
>>>>>>>>>> +		if (level =3D=3D 0)
>>>>>>>>>> +			level =3D br->levels[(br->count) / 2 + 1];
>>>>>>>>>
>>>>>>>>> Looks here used the 50% brightness level.
>>>>>>>>>
>>>>>>>>> Per comment in video.c, we want set the backlight to max_leve=
l
>>>>>>>>> when level_old is invalid:
>>>>>>>>>
>>>>>>>>>             if (!br->flags._BQC_use_index) {
>>>>>>>>>                     /*
>>>>>>>>>                      * Set the backlight to the initial state=
=2E
>>>>>>>>>                      * On some buggy laptops, _BQC returns an
>>>> uninitialized value
>>>>>>>>>                      * when invoked for the first time, i.e.
>>>> level_old is invalid.
>>>>>>>>>                      * set the backlight to max_level in this
>> case
>>>>>>>>>                      */
>>>>>>>>>
>>>>>>>>> I think here used max_level to fulfill it, e.g.
>>>>>>>>>
>>>>>>>>> +		if (level =3D=3D 0)
>>>>>>>>> +			level =3D max_level;
>>>>>>>>>
>>>>>>>>> How do you think?
>>>>>>>> Hi Joey,
>>>>>>>>
>>>>>>>> I was debating with myself which level to be set, ex. 50%, ~75=
%
>>>> or
>>>>>>>> 100%, and I think 50% *might* be closer to normal use-case (ju=
st
>>>> a
>>>>>>>> personal guess).
>>>>>>>>
>>>>>>>> However, "max_level" seems to fit best if we treat the initial
>>>>>>>> zero brightness in invalid. I can modify it according it that'=
s
>>>> preferred.
>>>>>>>>
>>>>>>>> Thanks for the feedback.
>>>>>>>>
>>>>>>>> Cheers,
>>>>>>>> Alex Hung
>>>>>>>>
>>>>>>>
>>>>>>> hm.... I have a question for what's the BIOS's problem that
>> causes
>>>>>>> 'level =3D=3D 0'?
>>>>>>> That implied the issue machine's max_level is 0?
>>>>>>>
>>>>>>> 		/*
>>>>>>> 		 * Set the level to maximum and check if _BQC uses
>> indexed
>>>> value
>>>>>>> 		 */
>>>>>>> 		result =3D acpi_video_device_lcd_set_level(device,
>> max_level);
>>>> 		/* write max_level purposely, then read level back, compare
>> them */
>>>>>>> 		...
>>>>>>> 		result =3D
>> acpi_video_device_lcd_get_level_current(device,
>>>> &level, 0);
>>>>>>> 		...
>>>>>>> 		br->flags._BQC_use_index =3D (level =3D=3D max_level ? 0 :
>> 1);
>>>>>>> 		if (!br->flags._BQC_use_index) {
>> 	/*
>>>> _BQC_use_index is 0 will run into if, means level =3D=3D max_level=
 */
>>>>>>>
>>>>>>> So, looks the 'level =3D=3D max_level =3D=3D 0' when level_old =
is invalid.
>>>>>>>
>>>>>>> Just wonder what's defect of BIOS (in _BCL?) causes problem.
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Sorry for my misunderstood!
>>>>>>
>>>>>> I think that's possible the level_old is 0 and there have a 0
>> value
>>>>>> in the return package from _BCL.
>>>>>>
>>>>>
>>>>> Yes, there is nothing wrong with _BCL and _BQC except that _BQC
>>>>> returns a zero initially.
>>>>>
>>>>>> Could you please share the _BCL in DSDT from issue machine? Does
>>>>>> there have 0 value in _BCL?
>>>>>
>>>>> _BCL returns below data and there is a zero in the list.
>>>>>
>>>>> [  744.572289] Brightness[0] =3D 100
>>>>> [  744.572293] Brightness[1] =3D 50
>>>>> [  744.572295] Brightness[2] =3D 0
>>>>> [  744.572297] Brightness[3] =3D 10
>>>>> [  744.572299] Brightness[4] =3D 20
>>>>> [  744.572301] Brightness[5] =3D 30
>>>>> [  744.572303] Brightness[6] =3D 40
>>>>> [  744.572305] Brightness[7] =3D 50
>>>>> [  744.572306] Brightness[8] =3D 60
>>>>> [  744.572308] Brightness[9] =3D 70
>>>>> [  744.572310] Brightness[10] =3D 80
>>>>> [  744.572312] Brightness[11] =3D 90
>>>>> [  744.572314] Brightness[12] =3D 100
>>>>>
>>>>> The below is the complete _BCL for references
>>>>>
>>>>>                    Method (_BCL, 0, Serialized)
>>>>>                    {
>>>>>                        Name (_T_0, Zero)
>>>>>                        If (_OSI ("NOT_WINP_KEY"))
>>>>>                        {
>>>>>                            While (One)
>>>>>                            {
>>>>>                                Store (LCDD, _T_0)
>>>>>                                If (LEqual (_T_0, 0x303CAF06))
>>>>>                                {
>>>>>                                    Return (AUOL)
>>>>>                                }
>>>>>                                Else
>>>>>                                {
>>>>>                                    If (LEqual (_T_0, 0x1475AE0D))
>>>>>                                    {
>>>>>                                        Return (CMIL)
>>>>>                                    }
>>>>>                                    Else
>>>>>                                    {
>>>>>                                        If (LEqual (_T_0, 0x033FE4=
30))
>>>>>                                        {
>>>>>                                            Return (LGDL)
>>>>>                                        }
>>>>>                                        Else
>>>>>                                        {
>>>>>                                            If (LEqual (_T_0,
>>>> 0x3942A34C))
>>>>>                                            {
>>>>>                                                Return (SAML)
>>>>>                                            }
>>>>>                                            Else
>>>>>                                            {
>>>>>                                                Return (DEFL)
>>>>>                                            }
>>>>>                                        }
>>>>>                                    }
>>>>>                                }
>>>>>
>>>>>                                Break
>>>>>                            }
>>>>>                        }
>>>>>                        Else
>>>>>                        {
>>>>>                            Return (Package (0x0D)
>>>>>                            {
>>>>>                                0x64,
>>>>>                                0x32,
>>>>>                                Zero,
>>>>
>>>> Yes, have Zero value in _BCL return package.
>>>>
>>>>>                                0x0A,
>>>>>                                0x14,
>>>>>                                0x1E,
>>>>>                                0x28,
>>>>>                                0x32,
>>>>>                                0x3C,
>>>>>                                0x46,
>>>>>                                0x50,
>>>>>                                0x5A,
>>>>>                                0x64
>>>>>                            })
>>>>>                        }
>>>>>                    }
>>>>>
>>>>>
>>>>
>>>> According to the above information, it make sense now!
>>>>
>>>>
>>>> Thank a lot!
>>>> Joey Lee
>>>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
