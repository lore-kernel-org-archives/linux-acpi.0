From: Mattia Dongili <malattia@linux.it>
Subject: Re: no brightness with acpi video since 3.3 [was Re: Issues with the
 sony-platform module]
Date: Sat, 16 Jun 2012 07:37:12 +0900
Message-ID: <20120615223711.GA31180@kamineko.org>
References: <4FDA2051.3050108@babioch.de>
 <20120614203914.GA2645@kamineko.org>
 <4FDAE7FE.5030706@babioch.de>
 <20120615113637.GA5904@kamineko.org>
 <4FDB5202.706@babioch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4FDB5202.706@babioch.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Karol Babioch <karol@babioch.de>
Cc: platform-driver-x86@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 15, 2012 at 05:17:22PM +0200, Karol Babioch wrote:
> Hi again,
> 
> Am 15.06.2012 13:36, schrieb Mattia Dongili:
> > could you please test it?
> Well, I've applied the patch (as well as the six others you submitted to
> Matthew since the inclusion into 3.5-rc1 found here [1]), but it still
> doesn't work. It's just the same as before. When booting without any
> special parameters I'll get the brightness pop up when pressing the
> appropriate fn keys.
> 
> With "acpi_backlight=vendor" I don't get this pop-up at all.

ok, let's forget about gnome popups for a moment, can you try using the
sysfs files directly?

i.e.:
$ grep .  /sys/class/backlight/sony/*
/sys/class/backlight/sony/actual_brightness:206
/sys/class/backlight/sony/bl_power:0
/sys/class/backlight/sony/brightness:206
/sys/class/backlight/sony/max_brightness:206
grep: /sys/class/backlight/sony/power: Is a directory
grep: /sys/class/backlight/sony/subsystem: Is a directory
/sys/class/backlight/sony/type:platform

$ echo 150 | sudo tee /sys/class/backlight/sony/brightness
150

Could you then include (in your mail please) the dmesg output after
this test?

Thanks!
-- 
mattia
:wq!
