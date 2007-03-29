From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: toshiba video brightness
Date: Thu, 29 Mar 2007 15:43:56 +0800
Message-ID: <3877989d0703290043y42a1bda6va0dbaa8826625dc4@mail.gmail.com>
References: <200703281450.30165.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.183]:65369 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965312AbXC2Hn7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Mar 2007 03:43:59 -0400
Received: by ik-out-1112.google.com with SMTP id c21so80641ika
        for <linux-acpi@vger.kernel.org>; Thu, 29 Mar 2007 00:43:58 -0700 (PDT)
In-Reply-To: <200703281450.30165.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Hi Len,

There are three issues according to your description.
Issue 1:
The missing of /sys/backlight on your Toshiba seems just due to
the sysfs backlight requires bios expose _BCL, _BCM, and _BQC
for returning levels supported, controlling brightness, querying the current
brightness respectively. I checked the DSDT of the Toshiba box. There is
NO _BQC. Without _BQC, the sysfs backlight driver will lose the capability
of returning the current brightness level to user space. Maybe it is
just not important, and need to loose the condition check to register
into back light sysfs layer anyway.

Issue 2: Only the values of 0 and 40 have any effect, the others are a NOP
I will take a closer look at the related methods to check if that is
expected by the BIOS.

Issue 3: cannot remove video module
It is NOT reproducible on my napa. I will see if it is the consequence
of the previous two issues.

Thanks,
Luming

On 3/29/07, Len Brown <lenb@kernel.org> wrote:
> Luming
> I've got 2.6.21-rc5 running on a Toshiba Satellite Pro laptop.
> The ACPI video drivers seems to supply 2 brightness levels in proc,
> but nothing in /sys/backlight, and the toshiba_acpi driver
> seems to supply 8 levels in /proc.
>
> what am I missing?
>
> thanks,
> -Len
>
>
> loading the video driver, I see this:
> lenb@toshiba:/proc/acpi/video> ls -R
> .:
> VGA
>
> ./VGA:
> CRT  DOS  info  LCD  POST  POST_info  ROM  TV
>
> ./VGA/CRT:
> brightness  EDID  info  state
>
> ./VGA/LCD:
> brightness  EDID  info  state
>
> ./VGA/TV:
> brightness  EDID  info  state
>
> lenb@toshiba:/proc/acpi/video/VGA/LCD> cd /proc/acpi/video/VGA/LCD
> lenb@toshiba:/proc/acpi/video/VGA/LCD> su
> Password:
> toshiba:/proc/acpi/video/VGA/LCD # echo 0 > brightness
>
> (this dimmed the screen to minimum)
>
> toshiba:/proc/acpi/video/VGA/LCD # echo 40 > brightness
>
> (this make the screen max brightness)
>
> toshiba:/proc/acpi/video/VGA/LCD # echo 100 > brightness
> bash: echo: write error: Invalid argument
> toshiba:/proc/acpi/video/VGA/LCD # echo 20 > brightness
> toshiba:/proc/acpi/video/VGA/LCD # echo 10 > brightness
> toshiba:/proc/acpi/video/VGA/LCD # echo 0 > brightness
> toshiba:/proc/acpi/video/VGA/LCD # echo 40 > brightness
> toshiba:/proc/acpi/video/VGA/LCD # echo 50 > brightness
> toshiba:/proc/acpi/video/VGA/LCD # echo 30 > brightness
>
> Only the values of 0 and 40 have any effect, the others are a NOP
>
> toshiba:/proc/acpi/video/VGA/LCD # cd /proc/acpi/toshiba/
> toshiba:/proc/acpi/toshiba # ls
> fan  keys  lcd  version  video
> toshiba:/proc/acpi/toshiba # cat lcd
> brightness:              3
> brightness_levels:       8
> toshiba:/proc/acpi/toshiba # echo brightness:0 > lcd
> toshiba:/proc/acpi/toshiba # echo brightness:2 > lcd
> toshiba:/proc/acpi/toshiba # echo brightness:3 > lcd
> toshiba:/proc/acpi/toshiba # echo brightness:4 > lcd
> toshiba:/proc/acpi/toshiba # echo brightness:5 > lcd
> toshiba:/proc/acpi/toshiba # echo brightness:6 > lcd
> toshiba:/proc/acpi/toshiba # echo brightness:7 > lcd
> toshiba:/proc/acpi/toshiba # echo brightness:8 > lcd
> bash: echo: write error: Invalid argument
> toshiba:/proc/acpi/toshiba #
>
> All of these 8 give a different brightness
>
> video.c: brightness 0 = toshiba_acpi brightness 0
> video.c: brightness 40 = toshiba_acpi brightness 3
>
> rmmod toshiba_acpi makes no difference.
>
> toshiba:/proc/acpi/video/VGA/LCD # ls /sys/class/backlight/
> toshiba:/proc/acpi/video/VGA/LCD #
>
> toshiba:/proc/acpi/video/VGA/LCD # gunzip -dc /proc/config.gz |grep BACKLIGHT
> CONFIG_BACKLIGHT_LCD_SUPPORT=y
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> # CONFIG_BACKLIGHT_PROGEAR is not set
> CONFIG_FB_BACKLIGHT=y
> CONFIG_FB_RADEON_BACKLIGHT=y
>
>
