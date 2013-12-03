From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: 8086:2a42 [Asus UL80VT] Backlight control does not work with
 Intel integrated card, but there are entries in /sys/class/backlight
Date: Tue, 03 Dec 2013 12:25:26 +0800
Message-ID: <529D5D36.3000101@intel.com>
References: <529CBB15.7000904@crans.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:40805 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699Ab3LCEZ0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Dec 2013 23:25:26 -0500
In-Reply-To: <529CBB15.7000904@crans.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guillaume Millet <gmillet@crans.org>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

On 12/03/2013 12:53 AM, Guillaume Millet wrote:
> Hello, I report an issue, in attempting to follow the instructions at
> https://wiki.ubuntu.com/Bugs/Upstream/kernel#KernelTeam.2BAC8-KernelTeamBugPolicies.Overview_on_Reporting_Bugs_Upstream
> 
> [1.] 8086:2a42 [Asus UL80VT] Backlight control does not work with Intel 
> integrated card, but there are entries in /sys/class/backlight
> 
> [2.] The screen brightness control has apparently never worked 
> off-the-shelf on this laptop, Asus UL80VT-A1, which is an NVIDIA Optimus 
> laptop (2 graphic cards). The use of the discrete Nvidia card is managed 
> by Bumblebee (https://wiki.ubuntu.com/Bumblebee). It used to work with 
> the workaround suggested at 
> http://wiki.daviddarts.com/Ubuntu_Maverick_on_the_Asus_UL30VT#Screen_Brightness 
> which modifies asus-brn-down.sh to use the "setpci" method.
> Hotkeys are detected, showkey -s returns 0xe0 0x4c 0xe0 0xcc for Fn+F5 
> and 0xe0 0x54 0xe0 0xd4 for Fn+F6.
> When the hotkeys are triggered, there is no brightness change but the 
> KDE notification pops up with 3 or 4 levels.
> 
> [X.] Other notes
> $ ls /sys/class/backlight/
> acpi_video0  acpi_video1  intel_backlight
> 
> $ cat /sys/class/backlight/intel_backlight/max_brightness
> 2583660
> 
> $ cat /sys/class/backlight/intel_backlight/brightness
> 121584

With v3.12, does the intel_backlight interface work?
You can verify this by echoing some value to the brightness file and see
if it has any effect. The value can be echoed is 0 - max_brightness. Be
careful with very small values, it will black your screen.

If it works, you can specify intel_backlight as the control interface
for X by creating a xorg.conf file like this:
$ cat /etc/Xorg/Xorg.conf
Section "Device"
        Option     "Backlight"	"intel_backlight"
	Identifier  "Card0"
	Driver      "intel"
	BusID       "PCI:0:2:0"
EndSection
