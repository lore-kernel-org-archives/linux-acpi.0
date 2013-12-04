From: Guillaume Millet <gmillet@crans.org>
Subject: Re: 8086:2a42 [Asus UL80VT] Backlight control does not work with
 Intel integrated card, but there are entries in /sys/class/backlight
Date: Wed, 04 Dec 2013 18:12:00 +0100
Message-ID: <529F6260.1080100@crans.org>
References: <529CBB15.7000904@crans.org> <529D5D36.3000101@intel.com> <529DAE1C.1060501@crans.org> <529E827A.7030803@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from redisdead.crans.org ([138.231.136.39]:45269 "EHLO
	redisdead.crans.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932766Ab3LDRMI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Dec 2013 12:12:08 -0500
In-Reply-To: <529E827A.7030803@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

https://bugzilla.kernel.org/show_bug.cgi?id=3D66501

Le 04/12/2013 02:16, Aaron Lu a =C3=A9crit :
> On 12/03/2013 06:10 PM, Guillaume Millet wrote:
>> Le 03/12/2013 05:25, Aaron Lu a =C3=A9crit :
>>> On 12/03/2013 12:53 AM, Guillaume Millet wrote:
>>>> Hello, I report an issue, in attempting to follow the instructions=
 at
>>>> https://wiki.ubuntu.com/Bugs/Upstream/kernel#KernelTeam.2BAC8-Kern=
elTeamBugPolicies.Overview_on_Reporting_Bugs_Upstream
>>>>
>>>> [1.] 8086:2a42 [Asus UL80VT] Backlight control does not work with =
Intel
>>>> integrated card, but there are entries in /sys/class/backlight
>>>>
>>>> [2.] The screen brightness control has apparently never worked
>>>> off-the-shelf on this laptop, Asus UL80VT-A1, which is an NVIDIA O=
ptimus
>>>> laptop (2 graphic cards). The use of the discrete Nvidia card is m=
anaged
>>>> by Bumblebee (https://wiki.ubuntu.com/Bumblebee). It used to work =
with
>>>> the workaround suggested at
>>>> http://wiki.daviddarts.com/Ubuntu_Maverick_on_the_Asus_UL30VT#Scre=
en_Brightness
>>>> which modifies asus-brn-down.sh to use the "setpci" method.
>>>> Hotkeys are detected, showkey -s returns 0xe0 0x4c 0xe0 0xcc for F=
n+F5
>>>> and 0xe0 0x54 0xe0 0xd4 for Fn+F6.
>>>> When the hotkeys are triggered, there is no brightness change but =
the
>>>> KDE notification pops up with 3 or 4 levels.
>>>>
>>>> [X.] Other notes
>>>> $ ls /sys/class/backlight/
>>>> acpi_video0  acpi_video1  intel_backlight
>>>>
>>>> $ cat /sys/class/backlight/intel_backlight/max_brightness
>>>> 2583660
>>>>
>>>> $ cat /sys/class/backlight/intel_backlight/brightness
>>>> 121584
>>> With v3.12, does the intel_backlight interface work?
>>> You can verify this by echoing some value to the brightness file an=
d see
>>> if it has any effect. The value can be echoed is 0 - max_brightness=
=2E Be
>>> careful with very small values, it will black your screen.
>>>
>>> If it works, you can specify intel_backlight as the control interfa=
ce
>>> for X by creating a xorg.conf file like this:
>>> $ cat /etc/Xorg/Xorg.conf
>>> Section "Device"
>>>           Option     "Backlight"	"intel_backlight"
>>> 	Identifier  "Card0"
>>> 	Driver      "intel"
>>> 	BusID       "PCI:0:2:0"
>>> EndSection
>>
>> The intel_backlight interface does work, by echoing a value between =
0
>> and 2583660.
>> The control interface for X also works with that addition in
>> /etc/X11/xorg.conf (Kubuntu).
>>
>> Wow, the issue was immediately solved by posting here. Thanks Aaron =
Lu!
>> After, (out of curiosity) what should be modified so that X
>> automatically detect the correct control interface, in case of a new
>> installation for example ?
>
> Please file a bug to https://bugzilla.kernel.org, choose
> ACPI-Power/Video category.
>
> Please provide these information when filing the bug:
> 1 attach dmesg.
> 2 attach acpidump output.
> 3 attach dmidecode output.
> 4 of those backlight control interfaces, which works and which don't.
> 5 attach /var/log/Xorg.0.log when you do not use the customized xorg.=
conf,
>    I want to know which interface is picked up by X driver by default=
=2E
>
> Thanks,
> Aaron
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
