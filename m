From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: ACPI errors on Dell Latitude E5430
Date: Wed, 03 Oct 2012 12:43:11 +0200
Message-ID: <506C16BF.70100@redhat.com>
References: <5069E332.9060109@redhat.com> <506AB25D.7000900@hundeboll.net> <506ACCA1.6030908@redhat.com> <506BDCE1.4050007@hundeboll.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36956 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187Ab2JCKlw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Oct 2012 06:41:52 -0400
In-Reply-To: <506BDCE1.4050007@hundeboll.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

Hi,

On 10/03/2012 08:36 AM, Martin Hundeb=C3=B8ll wrote:
> On 2012-10-02 13:14, Hans de Goede wrote:
>> Hi,
>>
>> On 10/02/2012 11:22 AM, Martin Hundeb=C3=B8ll wrote:
>>> Hi Hans,
>>>
>>> On 2012-10-01 20:38, Hans de Goede wrote:
>>>> 2) Even with a 3.6 which shows the problematic behavior, I can
>>>> make things work by adding acpi.ec_delay=3D2000 to the kernel cmdl=
ine,
>>>> the debug traces show that the EC takes it sweet time to respond
>>>> (sometime close to 2 seconds) but it does eventually respond in al=
l
>>>> cases I've seen sofar.
>>>>
>>>> This also seems to fix a sporadic occurence of:
>>>> "ACPI: EC: input buffer is not empty aborting transaction"
>>>> Which I'm seeing with 3.5 / 3.6 in a non debug build.
>>>>
>>>> Martin, can you see if adding that helps you with the E5430 proble=
ms
>>>> too ?
>>>
>>> As far as I can tell from the attached dmesg, the errors are gone
>>> after setting acpi.ec_delay=3D2000. Thanks a lot!
>>>
>>> The only remaining issue is the fan control, which works as expecte=
d
>>> initially, but then fails to spin down after a few minutes.
>>
>> Hmm, I'm seeing the same thing, but only when charging my battery, a=
nd
>> then indeed
>> does not spin down completely, but it does step down from vacuum cle=
aner
>> mode to
>> something more pleasant after the machine was loaded for a while and
>> returns back
>> to idle.
>>
>> Also it spins up to its slowest speed by jut using the charger, so I
>> think it is
>> just bleeding of heat caused by the charging hardware in this case (=
for
>> me).
>
> For the record, my fan keeps spinning also when on battery (as report=
ed by i8k/sensors):
>
>    i8k-virtual-0
>    Adapter: Virtual device
>    Right Fan:   84000 RPM
>    CPU:          +39.0C
>
> This is not a total show-stopper, but nevertheless quite annoying whe=
n the home-office is shared with the bedroom :)

Ah right, you added acpi_enforce_resources=3Dlax to get i8k to work, ri=
ght, hint:
DO NOT DO THAT!

See: http://lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkin=
ginkernel2.6.31

So please try again without any custom kernel options, other then
acpi.ec_delay=3D2000

Regards,

Hans
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
