From: Ow Mun Heng <Ow.Mun.Heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Re: current ACPI status in 2.6.7 kernel
Date: Thu, 12 Aug 2004 13:34:56 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1092342896.15144.25.camel@neuromancer.home.net>
References: <411881B1.9000903@ti.com>
	 <1092132146.2666.3.camel@laptop.cunninghams> <4118D40D.5030404@ti.com>
	 <4118F918.7070909@optonline.net>  <411A2EA9.6000000@optonline.net>
	 <1092282496.7765.148.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1092282496.7765.148.camel@dhcppc4>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2004-08-11 at 20:48, Len Brown wrote:
> Alexander,
> The status of ACPI S3 suspend/resume in 2.6.7 is...
> 
> Run the latest ACPI patch on top of 2.6.7
> (indeed, you still need the latest patch for 2.6.8)
> 
> build EHCI as a module, and unload it first
> 
> echo 3 >/proc/acpi/sleep
> 
> (yes, it is on the list to move to sysfs...)
> 

Here's a top Snipped portion of my acpid handle.pl script. Notice It's
on S4?

Unload all the USB modules/ network and stops MySql.

S4 works. S3 No. Screen does not come back. POST issue I guess.

Have not experimented with S3_bios

D600 Radeon 9000

#! /usr/bin/perl -w 

use strict;

        my $first_arg = shift (@ARGV);

        if ($first_arg =~ /^button\/lid$/) {
                system ('/usr/X11R6/bin/xset -display :0 dpms force off');
        }

        if ($first_arg =~ /^button\/sleep$/) {
                shift (@ARGV);
                shift (@ARGV);
                if (check_ignore ('/etc/acpi/flags/suspend')) {
                        clear_ignore ('/etc/acpi/flags/suspend');
                } else {
                        set_ignore ('/etc/acpi/flags/suspend');
                        system ('/usr/X11R6/bin/xset -display :0 dpms force off');
                        system ('rmmod tg3');
                        system ('rmmod usb_storage usbhid uhci_hcd ehci_hcd');
                        system ('/sbin/service mysqld stop');
                        system ('echo 4 > /proc/acpi/sleep && hwclock --hctosys');
                        system ('echo "Resuming proceses....');
                        system ('modprobe tg3');
                        system ('modprobe usb_storage');
                        system ('modprobe ehci_hcd');
                        system ('modprobe uhci_hcd');
                        system ('modprobe usbhid');
                        system ('/sbin/service mysqld start');
                        }






> some systems get a double event if wakeup with power button.
> I use the LID to wake up my system and that works fine.
> 
> many systems come back up from S3, but don't re-enable
> the LCD, or some re-enable it, but in the wrong mode.
> Sometimes you can wake it up by running X.
> Sometiems you can wake it up by switching
> virtual consoles.
> There is a lot of experimentation in this area, but
> we don't really have fixes for this yet that are
> universally positive -- ie fix platforms w/o breaking others.
> 
> in summary, YMMV;-)
> 
> cheers,
> -Len
> 
> 
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
> 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
> Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
> http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

-- 
Ow Mun Heng
Fedora GNU/Linux Core 2 on D600 1.4Ghz CPU kernel
2.6.7-2.jul1-interactive 
Neuromancer 04:32:53 up 4:34, 4 users, load average: 0.61, 0.54, 0.37 


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
