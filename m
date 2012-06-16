From: Mattia Dongili <malattia@linux.it>
Subject: Re: no brightness with acpi video since 3.3 [was Re: Issues with the
 sony-platform module]
Date: Sat, 16 Jun 2012 11:52:24 +0900
Message-ID: <20120616025223.GA5200@kamineko.org>
References: <4FDA2051.3050108@babioch.de>
 <20120614203914.GA2645@kamineko.org>
 <4FDAE7FE.5030706@babioch.de>
 <20120615113637.GA5904@kamineko.org>
 <4FDB5202.706@babioch.de>
 <20120615223711.GA31180@kamineko.org>
 <4FDBC183.7050203@babioch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4FDBC183.7050203@babioch.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Karol Babioch <karol@babioch.de>
Cc: platform-driver-x86@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Jun 16, 2012 at 01:13:07AM +0200, Karol Babioch wrote:
> Hi,
> 
> Am 16.06.2012 00:37, schrieb Mattia Dongili:
> > ok, let's forget about gnome popups for a moment, can you try using the
> > sysfs files directly?
> I suppose you expect me to use the "acpi_backlight=vendor" parameter?

yes correct.

> Because when leaving it out, I don't have any sony subdirectory within
> /sys/class/backlight. The only directory is
> /sys/class/backlight/acpi_video0, but changing the brightness directly
> there doesn't change anything.

basically that vendor parameter forces acpi to give up backlight control
to the platform driver.

> With the "acpi_backlight=vendor" boot paramater I got a sony sub
> directory (as well as a "nv" subdirectory), but see yourself:
> 
> [johnpatcher@vpcs ~]$ ls -l /sys/class/backlight/
> insgesamt 0
> lrwxrwxrwx 1 root root 0 16. Jun 2012  nv_backlight ->
> ../../devices/pci0000:00/0000:00:01.0/0000:01:00.0/drm/card0/card0-LVDS-1/nv_backlight
> lrwxrwxrwx 1 root root 0 16. Jun 01:00 sony ->
> ../../devices/virtual/backlight/sony
> 
> I tried to change the brightness via sysfs with the following command:
> 
> [root@vpcs sony]# cat actual_brightness brightness max_brightness
> -13
> -13
> 242

This is a known issue (at least to me) but it shouldn't really be a
problem as it existed for quite some time. Reading the brightness level
at boot returns an uninitialized value so the driver displays that
negative number. After echoing below you should see the actual value you
set.

> [root@vpcs sony]# echo 150 > brightness
> 
> But nothing changed. dmesg reports the following:
...
> [  461.256523] sony_laptop: found handle 0x0137 (offset: 0x0b)
> [  461.386744] sony_laptop: __call_snc_method: [SN07:0x0000000000a3010b]
> [  461.386746] sony_laptop: called SN07 with 0xa3010b (result: 0x0000)

this looks ok. I'm wondering if the nouveau driver may be getting in the
way somehow or if I broke backlight support in sony-laptop.

Can you try applying the sony-laptop patches on 3.2, boot with
acpi_backlight=vendor and see what is the state there?

> Interestingly enough I can change the brightness via
> /sys/class/backlight/nv_backlight:
...
> To be honest, I don't understand what is going on here. Why are there

there are various (potentially conflicting) ways to control the
brightness levels, acpi, platform and raw (via the video driver).

-- 
mattia
:wq!
