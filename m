From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: ACPI errors on Dell Latitude E5430
Date: Wed, 03 Oct 2012 14:52:46 +0200
Message-ID: <506C351E.10806@redhat.com>
References: <5069E332.9060109@redhat.com> <506AB25D.7000900@hundeboll.net> <506ACCA1.6030908@redhat.com> <506BDCE1.4050007@hundeboll.net> <506C16BF.70100@redhat.com> <506C2629.30902@hundeboll.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44150 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154Ab2JCMv0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Oct 2012 08:51:26 -0400
In-Reply-To: <506C2629.30902@hundeboll.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

Hi,

On 10/03/2012 01:48 PM, Martin Hundeb=C3=B8ll wrote:
> On 2012-10-03 12:43, Hans de Goede wrote:
>> Hi,
>>
>> On 10/03/2012 08:36 AM, Martin Hundeb=C3=B8ll wrote:
>>> On 2012-10-02 13:14, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 10/02/2012 11:22 AM, Martin Hundeb=C3=B8ll wrote:
>>>>> Hi Hans,
>>>>>
>>>>> On 2012-10-01 20:38, Hans de Goede wrote:
>>>>>> 2) Even with a 3.6 which shows the problematic behavior, I can
>>>>>> make things work by adding acpi.ec_delay=3D2000 to the kernel cm=
dline,
>>>>>> the debug traces show that the EC takes it sweet time to respond
>>>>>> (sometime close to 2 seconds) but it does eventually respond in =
all
>>>>>> cases I've seen sofar.
>>>>>>
>>>>>> This also seems to fix a sporadic occurence of:
>>>>>> "ACPI: EC: input buffer is not empty aborting transaction"
>>>>>> Which I'm seeing with 3.5 / 3.6 in a non debug build.
>>>>>>
>>>>>> Martin, can you see if adding that helps you with the E5430 prob=
lems
>>>>>> too ?
>>>>>
>>>>> As far as I can tell from the attached dmesg, the errors are gone
>>>>> after setting acpi.ec_delay=3D2000. Thanks a lot!
>>>>>
>>>>> The only remaining issue is the fan control, which works as expec=
ted
>>>>> initially, but then fails to spin down after a few minutes.
>>>>
>>>> Hmm, I'm seeing the same thing, but only when charging my battery,=
 and
>>>> then indeed
>>>> does not spin down completely, but it does step down from vacuum c=
leaner
>>>> mode to
>>>> something more pleasant after the machine was loaded for a while a=
nd
>>>> returns back
>>>> to idle.
>>>>
>>>> Also it spins up to its slowest speed by jut using the charger, so=
 I
>>>> think it is
>>>> just bleeding of heat caused by the charging hardware in this case=
 (for
>>>> me).
>>>
>>> For the record, my fan keeps spinning also when on battery (as
>>> reported by i8k/sensors):
>>>
>>>    i8k-virtual-0
>>>    Adapter: Virtual device
>>>    Right Fan:   84000 RPM
>>>    CPU:          +39.0C
>>>
>>> This is not a total show-stopper, but nevertheless quite annoying w=
hen
>>> the home-office is shared with the bedroom :)
>>
>> Ah right, you added acpi_enforce_resources=3Dlax to get i8k to work,
>> right, hint:
>> DO NOT DO THAT!
>>
>> See:
>> http://lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkingi=
nkernel2.6.31
>
> Unfortunately, no. I only tried those paramters to see no effect and =
thus removed them again before sending my initial mail. The description=
 in my previous mail was given with only:
>   cat /proc/cmdline
>   BOOT_IMAGE=3D/boot/vmlinuz-linux root=3DUUID=3Def14a89c-443d-4d51-9=
9b8-bff7a90f1015 ro quiet acpi.ec_delay=3D2000
>

Hmm, so the i8k driver loads without acpi_enforce_resources=3Dlax, ok. =
But you do need
to load it manually right, or does it auto - load ?

Either way could you try without the i8k driver? Blacklisting it if nec=
essary ?

Also how fast does the fan spin ? And does it go faster if you load the=
 machine,
and back to a lower speed again when you remove the load ?

And does your machine have a discrete gpu ? Or does it only use the gra=
phics
integrated into the CPU ?

Regards,

Hans



> Thanks again!
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
