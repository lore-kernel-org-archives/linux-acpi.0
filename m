From: yauh-acpi-CDzBh2wLF5MAvxtiuMwx3w@public.gmane.org
Subject: ACPI S3 suspend and LCD backlight
Date: Sat, 12 Nov 2005 22:39:04 -0700
Message-ID: <200511130639.jAD6d42Y011608@dragonslair.panasol.com>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

	It appears something in the ACPI suspend code turns on the
LCD backlight to print out the diagnostic messages. Is there any 
way to prevent this? Alternatively, is there a place in the drive
I can add a sequence to turn off the display just before it goes
to sleep?

System - Compaq TC1000 w/nVidia GeForce2 Go; Kernel is 2.6.13.4
User space is partially FC2 but has been largely updated through
self compiled binaries.

I have a patched X.org nv driver that supports dpms enough to
disable the backlight. I suspend the system with:

sleep 1; xset dpms force suspend 
sync
hwclock --systohc
echo 3 > /proc/acpi/sleep
hwclock --hctosys


The xset turns off the backlight but as soon as it gets to the echo 3 line,
the LCD comes on and displays the ACPI status messages. It then then 
proceeds to blank the screen but does NOT turn off the backlight.
If there is no way to disable the messages, I was hoping there is a
place I can hook into to twiddle the bit needed to disable the backlight.
Loading the video support module gives me an empty /proc/acpi/video directory.

Other then this backlight problem, everything else seems to work. 

This is where I originally found the patch for backlight DPMS on the
GeForce2Go -
http://www.mail-archive.com/devel-72qDnkntNoRAfugRpC6u6w@public.gmane.org/msg06145.html

P


Thanks.

-- Hunyue


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
