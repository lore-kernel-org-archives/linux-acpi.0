From: Cajus Pollmeier <C.Pollmeier-hi6Y0CQ0nG0@public.gmane.org>
Subject: kernel-2.4.20-rc3 + acpi-20021126-2.4.20-rc3
Date: Wed, 27 Nov 2002 11:41:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200211271142.03379.C.Pollmeier@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
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

Hi!

Here's a little status report for a Dell Latitude C800, Bios A21:

- does not boot with battery inserted -> see oops on server below
- battery is never detected
- "cat /proc/acpi/ac_adapter/AC/state" produces same oops if battery is
  plugged in:
    dsobject-0370: *** Warning: Buffer created with zero length in AML
    Unable to handle kernel NULL pointer dereference at virtual address 00000010
- power off does not work if battery is plugged in
- none suspend modes do work

The last acpi-patch release (20-rc1) worked fine, except for this one: I get a system freeze for
a second if I access the battery info files.

Sleep modes never worked on my laptop. S1 is the only one that produces some feedback:
A blinking power led and the system seems to sleep (display is on). Pressing the power
button wakes up the machine, but the display switches off and there's no way to get
back. I've to type something like "reboot" blindly.

You can get dsdt, kernel, oops, bootmessage, etc. here:
http://area51.mfh-iserlohn.de/polle/acpi

If I can provide any other useful informations, just drop me a note ;-)

Keep up the good work,
-Cajus



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
