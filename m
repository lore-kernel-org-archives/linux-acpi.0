From: =?UTF-8?B?TWFydGluIEh1bmRlYsO4bGw=?= <martin@hundeboll.net>
Subject: Re: ACPI errors on Dell Latitude E5430
Date: Wed, 03 Oct 2012 13:48:57 +0200
Message-ID: <506C2629.30902@hundeboll.net>
References: <5069E332.9060109@redhat.com> <506AB25D.7000900@hundeboll.net> <506ACCA1.6030908@redhat.com> <506BDCE1.4050007@hundeboll.net> <506C16BF.70100@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.hundeboll.net ([95.211.44.99]:58837 "EHLO
	mail.hundeboll.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753611Ab2JCLtc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Oct 2012 07:49:32 -0400
In-Reply-To: <506C16BF.70100@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On 2012-10-03 12:43, Hans de Goede wrote:
> Hi,
>
> On 10/03/2012 08:36 AM, Martin Hundeb=C3=B8ll wrote:
>> On 2012-10-02 13:14, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 10/02/2012 11:22 AM, Martin Hundeb=C3=B8ll wrote:
>>>> Hi Hans,
>>>>
>>>> On 2012-10-01 20:38, Hans de Goede wrote:
>>>>> 2) Even with a 3.6 which shows the problematic behavior, I can
>>>>> make things work by adding acpi.ec_delay=3D2000 to the kernel cmd=
line,
>>>>> the debug traces show that the EC takes it sweet time to respond
>>>>> (sometime close to 2 seconds) but it does eventually respond in a=
ll
>>>>> cases I've seen sofar.
>>>>>
>>>>> This also seems to fix a sporadic occurence of:
>>>>> "ACPI: EC: input buffer is not empty aborting transaction"
>>>>> Which I'm seeing with 3.5 / 3.6 in a non debug build.
>>>>>
>>>>> Martin, can you see if adding that helps you with the E5430 probl=
ems
>>>>> too ?
>>>>
>>>> As far as I can tell from the attached dmesg, the errors are gone
>>>> after setting acpi.ec_delay=3D2000. Thanks a lot!
>>>>
>>>> The only remaining issue is the fan control, which works as expect=
ed
>>>> initially, but then fails to spin down after a few minutes.
>>>
>>> Hmm, I'm seeing the same thing, but only when charging my battery, =
and
>>> then indeed
>>> does not spin down completely, but it does step down from vacuum cl=
eaner
>>> mode to
>>> something more pleasant after the machine was loaded for a while an=
d
>>> returns back
>>> to idle.
>>>
>>> Also it spins up to its slowest speed by jut using the charger, so =
I
>>> think it is
>>> just bleeding of heat caused by the charging hardware in this case =
(for
>>> me).
>>
>> For the record, my fan keeps spinning also when on battery (as
>> reported by i8k/sensors):
>>
>>    i8k-virtual-0
>>    Adapter: Virtual device
>>    Right Fan:   84000 RPM
>>    CPU:          +39.0C
>>
>> This is not a total show-stopper, but nevertheless quite annoying wh=
en
>> the home-office is shared with the bedroom :)
>
> Ah right, you added acpi_enforce_resources=3Dlax to get i8k to work,
> right, hint:
> DO NOT DO THAT!
>
> See:
> http://lm-sensors.org/wiki/FAQ/Chapter3#Mysensorshavestoppedworkingin=
kernel2.6.31

Unfortunately, no. I only tried those paramters to see no effect and=20
thus removed them again before sending my initial mail. The description=
=20
in my previous mail was given with only:
  cat /proc/cmdline
  BOOT_IMAGE=3D/boot/vmlinuz-linux=20
root=3DUUID=3Def14a89c-443d-4d51-99b8-bff7a90f1015 ro quiet acpi.ec_del=
ay=3D2000

Thanks again!

--=20
Kind Regards
Martin Hundeb=C3=B8ll
=46rederiks All=C3=A9 99, 1.th
8000 Aarhus C
Denmark

+45 61 65 54 61
martin@hundeboll.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
