From: Brad Parker <brad-2nKKSigPee+ibv+y4V69FXNtEUiqdi9I@public.gmane.org>
Subject: hp xt1260; upgraded bios to 1.05, now no backlight w/batteries
Date: Wed, 05 Mar 2003 14:56:02 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200303051956.h25Ju2N04777@p2.parker.boston.ma.us>
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


Background:

hp xt1260, dual boot w/windows xp & linux.

I've been running various versions of linux w/acpi patches and a
"hacked" DSDT table.  Things have been generally working ok, certainly
interrupts & /proc/acpi are fine.

I recently upgraded the bios to "v1.05" because the HP web site said
it had ACPI fixes.

Once I did that the backlight stopped working when the ac power was not connected.

Oddly, this seems to be caused by running linux.  

If I boot the bios upgrade disk and flash the bios, the problem goes
away.  Everything works as expected.

I then run linux (2.4.21-pre3-acpi-20030125-swsusp18).  It boots and
works fine.  I poweroff and reboot and the problem reoccurs.  Several
seconds after the bios comes up, before grub, the backlight shuts off.
Pressing the lid button restores the light for a few seconds.  If I
plug in the ac and press the lid button is comes back on and stays on.

This linux has a "fixed" DSDT table.  The changes are very minor (one
missing global, one bad length, several bad access types).  I
originally did this because I could not see the battery or power
info. With the fixes the battery and power work as expected.

If I remove the battery and press the reset button the problem stays.  It makes
me wonder if the DSDT 'code' is wacking some persistent memory inside the
unit...  is that possible?

Should I try using the bios version of the DSDT?

Any hints?

(I've looked for all the obvious methods, like _BCM, but there isn' one)

Note that I can't "downgrade" as their web site does not have files
for the older bioses and the upgrade does not save the old one.  Too
bad.

-brad



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
