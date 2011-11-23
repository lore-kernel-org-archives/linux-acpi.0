From: Artur Flinta <aflinta@gmail.com>
Subject: [Bugreport] Screen backllight issues on FirePro M5950 (HP EliteBook 8560w)
Date: Wed, 23 Nov 2011 21:34:05 +0100
Message-ID: <CAEPe-G+b9U-vdDmU29=GjyABab=5-MzWm4U6pBj1upRgLjH1OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42866 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120Ab1KWUeG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Nov 2011 15:34:06 -0500
Received: by yenq3 with SMTP id q3so1827222yen.19
        for <linux-acpi@vger.kernel.org>; Wed, 23 Nov 2011 12:34:05 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi!
I have HP Elitebook 8560w with FirePro M5950, Fedora 16, kernel
3.1.1,xorg ati driver 6.14.3 and issues with screen backlight - can't
dimit.I can write to /sys/class/backlight/acpi_video0/brightness
valuesfrom 0 to 20 (as stated in max_brightness), but it have no
effect onthe screen, values in brightness as well as in
actual_brightnessreflects written number.Before system boot, I can
change brightness of the screen, and itpersist in operating system.
Value of the/sys/class/backlight/acpi_video0/brightness indicates
maximumbrightness (20) even if minimal was set before boot. Kernel
radeon driver maintainers said, that backlight is driven by APCI
drivers, so I'm here to ask for help :)
How can I help to debug this issue? I'm able to recompile kernel and
apply patches, as well as do some tests. Unfortunately I'm unable to
write or correct driver code.
RegardsArtur
--=20
Ka=C5=BCdy problem ma swoje rozwi=C4=85zanie, zatem
je=C5=BCeli nie ma rozwi=C4=85zania to nie ma problemu.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
