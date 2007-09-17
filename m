From: Thomas Renninger <trenn@suse.de>
Subject: Re: [ibm-acpi-devel] Some information about setting brightness on
	X61 Tablet with 16 levels.
Date: Mon, 17 Sep 2007 18:36:42 +0200
Message-ID: <1190047003.3222.71.camel@queen.suse.de>
References: <20070912151812.GD6339@bart.intergenia.de>
	 <20070912154947.GE6339@bart.intergenia.de>
	 <20070912160007.GF6339@bart.intergenia.de>
	 <1190039503.3222.30.camel@queen.suse.de>
	 <20070917151210.GC2409@bart.intergenia.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45279 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752712AbXIQQgt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Sep 2007 12:36:49 -0400
In-Reply-To: <20070917151210.GC2409@bart.intergenia.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maik Broemme <mbroemme@plusserver.de>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi <linux-acpi@vger.kernel.org>, Kay Sievers <kay.sievers@vrfy.org>, acpi4asus-user <acpi4asus-user@lists.sourceforge.net>

On Mon, 2007-09-17 at 17:12 +0200, Maik Broemme wrote:
> Hi,
> 
> Thomas Renninger <trenn@suse.de> wrote:
> > On Wed, 2007-09-12 at 18:00 +0200, Maik Broemme wrote:
> > > Hi,
> > > 
> > > Maik Broemme <mbroemme@plusserver.de> wrote:
> > > > Hi,
> > > > 
> > > > Maik Broemme <mbroemme@plusserver.de> wrote:
> > > > > Hi,
> > > > > 
> > > > > i have a couple of small questions. :) I own an IBM ThinkPad X40 and a
> > > > > Lenovo ThinkPad X61 Tablet and just hacked somewhere around in the
> > > > > 'thinkpad-acpi-0.16-20070904' sources.
> > > > > 
> > > > > I started my work on adding support for the brightness setup which has
> > > > > 16 level on the newer X61/X61s and X61 Tablet laptops. Well my problem
> > > > > is (or i am to stupid to understand) that setting the brightness level
> > > > > with TP_CMOS_BRIGHTNESS_UP did not set it until level 16. Is this a
> > > > > limitation of the thinkpad-acpi itself or somewhere inside the NVRAM?
> > > > > 
> > > > > As notice: With brightness mode 1 (which reads data from EC via
> > > > > acpi_ec_read) the setting of any brightness level is not working.
> > > > > 
> > > > > Maybe someone can give me a hint where i can start to track this issue
> > > > > and how to solve it. :)
> > > > > 
> > > > 
> > > > okay some other information, i am still able to set at least 15 of the
> > > > 16 levels via '/proc/acpi/video/VID/LCD0/brightness' It shows:
> > > > 
> > > > root@bart:~# cat /proc/acpi/video/VID/LCD0/brightness 
> > > > levels:  100 100 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 100
> > > > current: 90
> > > > 
> > > > If i count all values (and the 100 only one time) it are 16 levels.
> > > > Well the level 100 i can not set (kernel is stock 2.6.22.6) Well this
> > > > looks like an ACPI bug for me, or a broken firmware. If do the
> > > > following:
> > > > 
> > > > root@bart:~# for i in 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 ; do sleep 1s ; echo "${i}" > /proc/acpi/video/VID/LCD0/brightness ; done
> > > > 
> > > > i can set at least 15 brightness level. I think the best solution would
> > > > be to use the ACPI video driver to set the brightness, did anyone agree
> > > > or disagree? :)
> > > > 
> > > > If i am correct thinkpad-acpi should trac the keypress event and then
> > > > trigger some acpi function to set the brightness level.
> > > > 
> > > 
> > > Sorry a last thing which should be mentioned. :) The ACPI video driver
> > > correctly updates the CMOS NVRAM, but thinkpad-acpi can only handle
> > > values until acpi-video value 55, for example:
> > > 
> > > root@bart:~# echo 20 > /proc/acpi/video/VID/LCD0/brightness 
> > > root@bart:~# cat /proc/acpi/ibm/brightness | grep level:
> > > level:          0
> > > root@bart:~# echo 25 > /proc/acpi/video/VID/LCD0/brightness 
> > > root@bart:~# cat /proc/acpi/ibm/brightness | grep level:
> > > level:          1
> > > root@bart:~# echo 30 > /proc/acpi/video/VID/LCD0/brightness 
> > > root@bart:~# cat /proc/acpi/ibm/brightness | grep level:
> > > level:          2
> > > root@bart:~# echo 35 > /proc/acpi/video/VID/LCD0/brightness 
> > > root@bart:~# cat /proc/acpi/ibm/brightness | grep level:
> > > level:          3
> > > root@bart:~# echo 40 > /proc/acpi/video/VID/LCD0/brightness 
> > > root@bart:~# cat /proc/acpi/ibm/brightness | grep level:
> > > level:          4
> > > root@bart:~# echo 45 > /proc/acpi/video/VID/LCD0/brightness 
> > > root@bart:~# cat /proc/acpi/ibm/brightness | grep level:
> > > level:          5
> > > root@bart:~# echo 50 > /proc/acpi/video/VID/LCD0/brightness 
> > > root@bart:~# cat /proc/acpi/ibm/brightness | grep level:
> > > level:          6
> > > root@bart:~# echo 55 > /proc/acpi/video/VID/LCD0/brightness 
> > > root@bart:~# cat /proc/acpi/ibm/brightness | grep level:
> > > level:          7
> > > root@bart:~# echo 60 > /proc/acpi/video/VID/LCD0/brightness 
> > > root@bart:~# cat /proc/acpi/ibm/brightness | grep level:
> > > level:          0
> > > root@bart:~# echo 65 > /proc/acpi/video/VID/LCD0/brightness 
> > > root@bart:~# cat /proc/acpi/ibm/brightness | grep level:
> > > level:          1
> > 
> > But brightness is set correctly (not the value but the background
> > brightness itself)?
> > This is a thinkpad_acpi bug and the fact that it can only cope with 8
> > brightness levels.
> > 
> 
> The brightness is set correctly, i can set it in 16 steps. Anyway, the
> /proc stuff from acpi video has still a bug with setting 100% brightness.
> But i did not take a deeper look into this, because the sysfs stuff is
> fully working and /proc is deprecated:
Makes sense. The video module hopefully is used more (or at all...) in
future, but looking at /proc does not make much sense as the video
module has not been used much or even at all since now.
> 
> babyface@bart:~$ cat /sys/class/backlight/acpi_video1/actual_brightness 
> 20
> babyface@bart:~$ cat /sys/class/backlight/acpi_video1/max_brightness    
> 100
> 
> There is some thing missing in the sysfs part, there is no export for the
> valied values which can be used, actually on brightness up i make +5 and on
> brightness down i make -5
> 
> The acpi video itself is not setting the backlight of the LCD (is this a bug
> or a wanted behaviour, if it is normal can somebody explaing me why?) You
> still need to do some:
> 
> echo <level> > /sys/class/backlight/acpi_video1/brightness
Don't know, but this should be the interface that should be used?

> In case of high loads this is very unusable to wait in userspace for a kernel
> event and make some action from userspace to kernelspace again.
This should be ok.
> 
> > I have two ideas on how the thinkpad_acpi driver could handle these
> > machines:
> >   - set brightness levels from current up to max (until it does not
> >     change anymore) -> disadvantage: unspecified values are written
> >     and a SMI with a undefined value will be fired (e.g. a value of
> >     8 for < X61/T61 and a value of 16 for X61/T61...)
> >   - Use dmi decode again and set max brightness levels to 0-15 in
> >     X61/T61/.. case.
> > 
> > Both are really ugly workarounds and should only be added if there is no
> > time for doing it right for the next bigger kernel release.
> > Doing it right is IMO, ripping out brightness control for *Lenovo*
> > ThinkPads only and let the video module do brightness control instead.
> > This should also be done for the video ThinkPad extensions or the
> > ThinkPad video extensions might interfere with the video driver.
> > 
> 
> My guess is also the same. Let the video module the hand over the
> brightness control. But anyway, actually this is still in early stage of
> development and also with acpi video extension not all things are working.

Yep. This is because video module got written down based on specs some
time ago. Vendor specific drivers worked more or less on more and more
machines. As the video module was known to be broken it was not tried to
be loaded at all and it didn't get the field testing and little fixups
to get it working reliable.
IMO it needs more "easy to do" sanity checks as every vendor is doing it
a bit differently (e.g. Alexey recently fixed a minor bug for Toshiba
laptops, if I understood correctly Toshibas return a value of e.g. 43 if
you set brightness to 42 or similar which confused the module).

Hopefully people will have a closer look at this with ACPI autoloading.
Before, userspace had to simply try to load all ACPI modules on all
machines and it was too risky to do that with the video module.
With ACPI autoloading the video module only gets loaded on machines
supporting the video extensions. Some laptop models probably still need
fixups in the video module to work correctly, hopefully things stabilize
soon when the video module starts to get used...
What could be a bit tricky is to figure out on which machines the video
extensions and on what machines the vendor specific drivers work better
and to let both work together. This will not only get a problem for
ThinkPads but also for Asus laptops (and more?), where both drivers (in
fact not the drivers, but the underlying BIOS implementation) might
interfere here and there...

I don't have a good idea how to distinguish whether video or vendor
specific module should be used as you don't know which one got loaded
first. Maybe the uevent for the video module should get delayed to
ensure vendor specific modules are tried first. There you can add some
blacklisting or whatever magic. If the vendor specific module called
backlight_device_register, the video module should fail to load if it
tries to do so also later.
Maybe the implementation to ensure video module is tried to get loaded
after vendor specific ones can also be done in udev userspace code, Kay
may know that. All this is not perfect, but should work...

   Thomas

