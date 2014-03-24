From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [asus-nb-wmi] thermal device detected by asus-nb-wmi platform
 driver
Date: Mon, 24 Mar 2014 05:11:38 -0700
Message-ID: <533020FA.1030600@roeck-us.net>
References: <532B8630.8030607@linux.intel.com> <532FB154.6020608@roeck-us.net> <532FE50F.8090909@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.active-venture.com ([67.228.131.205]:64073 "EHLO
	mail.active-venture.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbaCXMLk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Mar 2014 08:11:40 -0400
In-Reply-To: <532FE50F.8090909@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lu, Baolu" <baolu.lu@linux.intel.com>, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>

On 03/24/2014 12:55 AM, Lu, Baolu wrote:
>
> On 2014/3/24 12:15, Guenter Roeck wrote:
>> On 03/20/2014 05:22 PM, Lu, Baolu wrote:
>>> Hi,
>>>
>>> I booted Ubuntu13.10 onto ASUS T100 Tablet and upgraded it with ups=
tream
>>> kernel (3.14.0-rc7+). There is a thermal device under
>>> /sys/devices/platform/asus-nb-wmi.
>>>
>>> root@t100:~/linux# tree /sys/class/hwmon/
>>> /sys/class/hwmon/
>>> =E2=94=9C=E2=94=80=E2=94=80 hwmon0 -> ../../devices/platform/corete=
mp.0/hwmon/hwmon0
>>> =E2=94=94=E2=94=80=E2=94=80 hwmon1 -> ../../devices/platform/asus-n=
b-wmi/hwmon/hwmon1
>>>
>>> root@t100:/sys/devices/platform/asus-nb-wmi# ls
>>> cpufv driver hwmon input modalias power subsystem uevent
>>>
>>> root@t100:~/linux# sensors
>>> coretemp-isa-0000
>>> Adapter: ISA adapter
>>> Core 0: +38.0=C2=B0C (high =3D +90.0=C2=B0C, crit =3D +90.0=C2=B0C)
>>> Core 1: +38.0=C2=B0C (high =3D +90.0=C2=B0C, crit =3D +90.0=C2=B0C)
>>> Core 2: +39.0=C2=B0C (high =3D +90.0=C2=B0C, crit =3D +90.0=C2=B0C)
>>> Core 3: +38.0=C2=B0C (high =3D +90.0=C2=B0C, crit =3D +90.0=C2=B0C)
>>>
>>> asus-isa-0000
>>> Adapter: ISA adapter
>>> temp1: +6280.0=C2=B0C
>>>
>>
>> Pretty hot ;-). Not your problem, though - it looks like the tempera=
ture
>> is reported in Kelvin and the code converting from Kelvin to degrees=
 C
>> turns out to be buggy.
>>
>>> I didn't get any information about thermal interface in
>>> "Documentation/ABI/testing/sysfs-platform-asus-wmi". Is this a ther=
mal
>>> sensor? If it's the fact, how can I change the environment so that =
this
>>> sensor gives me variable data?
>>>
>>
>> I don't think I understand your question. Yes, this is a thermal sen=
sor.
>> What is it you want to do (in addition to having it report reasonabl=
e
>> temperatures) ?
>>
>> Guenter
>
> Sorry for the confusing question. I'd like to verify whether this sen=
sor works. What I want to do is to make some changes so that the sensor=
 could give me a different temperature value other than always +6280.0=C2=
=B0. I have no idea about what kind of changes should I make.
>

Difficult to say, since we don't really know what temperature is measur=
ed.
You could try checking the BIOS to find out which temperatures in addit=
ion
to the CPU temperature are measured in your system.

As mentioned before, there is a bug in the kernel which makes it hard t=
o determine
if there was a change in the first place. I submitted a patch to addres=
s that.

http://www.spinics.net/lists/kernel/msg1711403.html

Even then we don't know yet if the reported temperature is realistic in=
 the
first place; unless the code I fixed with the patch above was introduce=
d
recently this can never have reported reasonable values to start with.

Two options you have is to put load onto the CPU, and to put load onto
the graphics subsystem. Both should result in temperature changes.
But either case you'll have to have the patch above applied.

Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
