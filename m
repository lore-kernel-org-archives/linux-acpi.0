From: ezra peisach <epeisach-AW32GngNFaTp5eoAjl1PXg@public.gmane.org>
Subject: Re: PROBLEM: LCD display dead after ACPI suspend to RAM (S3)
Date: Thu, 22 Jan 2004 13:11:29 -0500 (EST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200401221811.NAA274801@med-xtal.bu.edu>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: David Ford <david+challenge-response-qokYbnrgTHEgsBAKwltoeQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


>Try hitting the hardware function key that swaps the CRT/LCD and/or the 
>function key that changes the font.

>Works on my laptop.  Really annoying two-fold issue.  First, the screen 
>is blank, second, I have to blindly run setfont to change the garbage 
>font to a readable font.

>I'm not running an fb, just an nvidia card in text mode on a Dell 
>Inspiron 8200.
I have been probing this issue on an Inspiron 8200 - but with a radeon
card.

The essential problem in S3 is four fold:
a) When entering S3 - power is turned off to the video card. When 
power is restored, the vga interface is confused as to register settings, etc.
b) vgacon does have any power management handling capabilities.
c) radeonfb does not handle power management either - except for the case
   of powerbooks. 
d) On power restore, I have observed that the backlight of the display 
is turned off. If I use radeontools to turn back on the display, I can then
see what is there.

I am working on a set of patches to store the state of the VGA card
(drivers/video/vgacon.c) before power shutdown and after restore. (I have the
basics - but it needs to be cleaned up). 

What is then missing is the interface to poke at the radeon and I
suspect nvidia card to turn on the backlight. When X is running
switching away from VC 7 and back resets the flag - a better solution
is eventually needed. Perhaps radeonfb will be the way to go - but it needs
to have power handling code implemented on all platforms.

Ezra




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
