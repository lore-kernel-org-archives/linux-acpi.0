From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: ACPI S3 resume only reboots
Date: Sat, 9 Oct 2004 15:06:28 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20041009130628.GA21781@elf.ucw.cz>
References: <20041004133340.76ba05ba.albeclemit@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20041004133340.76ba05ba.albeclemit-whZMOeQn8C0@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alberto <albeclemit-whZMOeQn8C0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I'm using kernel 2.6.9-rc3-bk2 + latest acpi + swsusp2
> 
> When i do
> cat -n "mem" > /sys/power/state
> the system seems to go down fine in S3 state...
> when i hit the power button it looks like trying to resume (fan starts again, noises from harddisk and cdrom) then it just reboots....
> 
> # lspci
> 0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
> 0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
> 0000:00:09.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 80)
> 0000:00:0b.0 CardBus bridge: O2 Micro, Inc. OZ6912 Cardbus Controller (rev 20)
> 0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
> 0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
> 0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
> 0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
> 0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
> 0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
> 0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
> 0000:00:11.6 Communication controller: VIA Technologies, Inc. Intel 537 [AC97 Modem] (rev 80)
> 0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf [Radeon Mobility 9000 M9] (rev 01)
> 
> I removed all the modules and tryed from runlevel 1, all the usb devices where unplugged as well...
> 
> I googled about it and i found other people with the same KT400/KT600 chipset reporting the same problem.
> 
> How could i try to debug this to give you more info?

You basically need to fix this yourself. Add infinite loops to
wakeup.S to see where it breaks.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
