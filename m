From: Guillaume Millet <gmillet@crans.org>
Subject: Re: 8086:2a42 [Asus UL80VT] Backlight control does not work with
 Intel integrated card, but there are entries in /sys/class/backlight
Date: Tue, 03 Dec 2013 11:10:36 +0100
Message-ID: <529DAE1C.1060501@crans.org>
References: <529CBB15.7000904@crans.org> <529D5D36.3000101@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from redisdead.crans.org ([138.231.136.39]:35803 "EHLO
	redisdead.crans.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab3LCKKm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Dec 2013 05:10:42 -0500
In-Reply-To: <529D5D36.3000101@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

Le 03/12/2013 05:25, Aaron Lu a =C3=A9crit :
> On 12/03/2013 12:53 AM, Guillaume Millet wrote:
>> Hello, I report an issue, in attempting to follow the instructions a=
t
>> https://wiki.ubuntu.com/Bugs/Upstream/kernel#KernelTeam.2BAC8-Kernel=
TeamBugPolicies.Overview_on_Reporting_Bugs_Upstream
>>
>> [1.] 8086:2a42 [Asus UL80VT] Backlight control does not work with In=
tel
>> integrated card, but there are entries in /sys/class/backlight
>>
>> [2.] The screen brightness control has apparently never worked
>> off-the-shelf on this laptop, Asus UL80VT-A1, which is an NVIDIA Opt=
imus
>> laptop (2 graphic cards). The use of the discrete Nvidia card is man=
aged
>> by Bumblebee (https://wiki.ubuntu.com/Bumblebee). It used to work wi=
th
>> the workaround suggested at
>> http://wiki.daviddarts.com/Ubuntu_Maverick_on_the_Asus_UL30VT#Screen=
_Brightness =20
>> which modifies asus-brn-down.sh to use the "setpci" method.
>> Hotkeys are detected, showkey -s returns 0xe0 0x4c 0xe0 0xcc for Fn+=
=465
>> and 0xe0 0x54 0xe0 0xd4 for Fn+F6.
>> When the hotkeys are triggered, there is no brightness change but th=
e
>> KDE notification pops up with 3 or 4 levels.
>>
>> [X.] Other notes
>> $ ls /sys/class/backlight/
>> acpi_video0  acpi_video1  intel_backlight
>>
>> $ cat /sys/class/backlight/intel_backlight/max_brightness
>> 2583660
>>
>> $ cat /sys/class/backlight/intel_backlight/brightness
>> 121584
> With v3.12, does the intel_backlight interface work?
> You can verify this by echoing some value to the brightness file and =
see
> if it has any effect. The value can be echoed is 0 - max_brightness. =
Be
> careful with very small values, it will black your screen.
>
> If it works, you can specify intel_backlight as the control interface
> for X by creating a xorg.conf file like this:
> $ cat /etc/Xorg/Xorg.conf
> Section "Device"
>          Option     "Backlight"	"intel_backlight"
> 	Identifier  "Card0"
> 	Driver      "intel"
> 	BusID       "PCI:0:2:0"
> EndSection

The intel_backlight interface does work, by echoing a value between 0=20
and 2583660.
The control interface for X also works with that addition in=20
/etc/X11/xorg.conf (Kubuntu).

Wow, the issue was immediately solved by posting here. Thanks Aaron Lu!
After, (out of curiosity) what should be modified so that X=20
automatically detect the correct control interface, in case of a new=20
installation for example ?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
