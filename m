From: Matthias Hentges <mailinglisten-H4PcyxPeSRnR7s880joybQ@public.gmane.org>
Subject: Re: S3 broken Samsung P35 - howto debug?
Date: Sun, 21 Nov 2004 20:08:53 +0100
Message-ID: <1101064133.7220.15.camel@mhcln03>
References: <200411211600.01820.od@fet.uni-hannover.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200411211600.01820.od-VRmHG7Xu4f31qYPpFx2fzhvVK+yQ3ZXh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Oliver Dawid <od-VRmHG7Xu4f31qYPpFx2fzhvVK+yQ3ZXh@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Sonntag, den 21.11.2004, 16:00 +0100 schrieb Oliver Dawid:
> Hi there,
> 
> like Matthias Hentges I have problems with my Samsung - mine is a P35. There 
> are some differences between these machines. I did not succeed to get S3 
> running yet. I can put machine to sleep with echo 3 > /proc/acpi/sleep but on 
> pushing the power button again only some devices seem to wake up.
> 
> I already got a patch to use old style resume from Matthias but this does not 
> work.

Did you say yes to "Power management options / ACPI / Use compatibily
PCI resume code" after patching?

>  Not only the display is dead but also the keyboard seems not to accept 
> anything. Network interface is not running (rtl 8139) as ping does not 
> respond. 
> 
> I am using Kernel 2.6.9 with initrd-patch for a fixed dsdt. 

For testing purposes, I'd go with the buggy Samsung DSDT.

> Any acpi based 
> feature seem to work: using the asus_acpi I am able to use the shortcuts, 
> hitting power button leads to halt the machine and so on.
> 
> Now I got several questions how to proceed:
> 
> - which modules are needed to be compiled into kernel directly? Does it 
> matter, if ide_* is loaded as module?

I don't know. I always have essential stuff like IDE compiled into the
kernel.

> - which modules are known not to work properly with acpi sleep/ resume? Which 
> should be unloaded before going to sleep?

The following things break resume on the P30 (break == freeze on resume)

- Active sound driver, be it OSS or ALSA. Must be unloaded before
suspending.
- radeonfb
- Accelerated X (DRI or fglrx)

For testing purposes I'd recommend using a minimalistic kernel .config
(no usb, firewire, preempt, AGP etc.)

> - Any idea, how to debug on low level without display, connection via ethernet 

Ethernet works fine after resume

> etc? Serial port? 

The Serial port is dead after resume.

> Printerport? Soldering a module with leds on printer port 
> to output states?

I didn't check if the parport survives resume.

> Any help would be appreciated.

Our best bet is the on-board ethernet. It works perfectly after
resuming. SSH is your friend.
I've put together a page with my experiences so
far :http://www.hentges.net/misc/howtos/samsung_p30_s3.shtml

There's a little script to restore lost PCI configuration DATA after a
resume. 
I've managed to get the backlight on, but that's it heh.

HTH
-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian SID. Geek by Nature, Linux by Choice



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
