From: Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>
Subject: SMP, ACPI and USB
Date: 07 Nov 2002 00:57:03 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1036627024.811.11.camel@chevrolet>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello, 

I have an ASUS CUV266-DLS motherboard with two P3 1ghz cpu's. I have
never managed to get USB to work on this motherboard (nor did I on my
old Rioworks SDVIA smp-board, they both just said something like "device
not accepting address"). But I never had any use of usb, since my only
usb device was a Logitech Cordless Desktop, which have adapters for the
PS/2 ports. But I'm now going to buy a scanner, and thus I need to get
usb working. 

That was not easy! I found in the faq at http://www.linux-usb.org that
there are problems with smp machines. That I should try to set MPS to
1.1 instead of 1.4, that some motherboards might need a "noapic" boot
option and that ACPI sometimes confuses this.

I have a 2.4.20-rc1 kernel with the latest acpi-patch. I do need the
acpi-patch for two reasons. I'm not able to boot the pc without the acpi
patch if the secondary ide-channel is activated. And I need it to be
able to turn of the computer.

I tried the noapic boot option, which absolutely not worked. I got lots
and lots of cpu-errors, or something, and then it hung. Then I tried
MPS1.1 (What's the benefit with 1.4? I know that with 1.4 it uses irq's
above 15, but...) Still no luck. then boot option acpi=off did it. Now
my USB works quite flawlessly.

But I would very, very much like to be able to use ACPI, so I can get to
turn of my computer, without pushing the power-button for four seconds.
Am I the only one using usb on smp-machines, or are my two motherboards
just about the only ones incompatible?

Sorry for this long post, and I'm not sure if this is the right place to
post it, but I'm subscribed here, and guess you guys knows what to do :)

Best regards,
Stian Jordet



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
