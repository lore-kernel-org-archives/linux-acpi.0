From: Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>
Subject: Really weird usb problem with acpi.
Date: 28 Mar 2003 19:59:48 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1048877988.32560.26.camel@chevrolet.hybel>
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
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I have tried several kernel version, and it is the same with all of
them. This is with 2.5.65. The same applies for all recent 2.4.x
kernels.

I have the following usb hardware:

HP DeskJet 990Cxi - printer
Epson Perfection 1260 - scanner
3com 3CREB96 - Bluetooth adapter
Sony Ericsson DCU-10 - serial adapter
Logitech Cordless desktop - Keyboard/mouse

With acpi enabled, everything works perfect, EXCEPT the keyboard/mouse.
I just get the infamous "device not accepting address" message.

But if I boot the computer with ps/2 keyboard and mouse. Pulls out the
ps/2 keyboard and mouse, and plugs in the usb-cable, the
usb-keyboard/mouse works. But if I then restart the computer with the
usb keyboard/mouse still attached, I'm back to "device not accepting
adress".

If I compile acpi with "CPU-enumeration only" there is no problem at
all. Neither if ACPI is disabled.

This is an ASUS CUV266-DLS Dual P3 motherboard.

Hope someone cares and/or knows what to do. I would like to have full
ACPI-support...

Best regards,
Stian



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
