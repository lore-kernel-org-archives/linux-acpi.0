From: Karl Hegbloom <hegbloom-tbDHPZwbsQQ@public.gmane.org>
Subject: Synaptics and keyboard losing interrupts w/ACPI ?
Date: Sat, 03 Apr 2004 18:09:09 -0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1081044549.2179.281.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I apologize if this this is an FAQ or has already been answered; the
sf.net list archive interface is... too feeble to suck.  I wish they
would switch to "lurker" (http://lurker.sourceforge.net/).

I've got a laptop that has a synaptics touchpad.  Every so often, with
every kernel I've tried up through 2.6.4, the pointer will suddenly leap
across the screen, and sometimes it will even push a GUI button there. 
Also, on occasion, a key will "stick down",,,,,,,,,,,, like that, until
I push another key.  Every now and then the keyboard quits working
entirely, and I must reboot to regain control.  When these things
happen, I see, in the logs:

Mar 29 08:04:37 localhost kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x0 on isa0060/serio0).
Mar 29 08:04:37 localhost kernel: atkbd.c: Use 'setkeycodes 00 <keycode>' to make it known.
Mar 29 08:04:37 localhost kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x0 on isa0060/serio0).
Mar 29 08:04:37 localhost kernel: atkbd.c: Use 'setkeycodes 00 <keycode>' to make it known.
Mar 29 08:04:37 localhost kernel: psmouse.c: TouchPad at isa0060/serio2/input0 lost synchronization, throwing 5 bytes away.
Mar 29 08:05:16 localhost kernel: Synaptics driver lost sync at byte 4
Mar 29 08:05:16 localhost kernel: Synaptics driver lost sync at byte 1
Mar 29 08:05:16 localhost last message repeated 3 times
Mar 29 08:05:16 localhost kernel: Synaptics driver resynced.

There is also a message about an unknown scancode that also mentions
that it's an XFree86 bug... that it should not access hardware
directly.  I also see that when I run the "console-tools" 'setkbdrate'
command, which uses /dev/port to set the key repeat rate.  The source
mentions that on some architectures there's an ioctl for doing that.  I
am fairly certain that this "XFree86 bug" is probably not related to the
other one or to ACPI.

I am not the only one who experiences this problem, and this model of
laptop is not the only one that supports this feature...  After
searching for those log messages at Google, I located several email
messages saying things like that APM introduces latency to turn it off,
and to try booting with "acpi=off" for similar reasons.

Sure enough, when I boot with "acpi=off", the problem disappears
entirely.  The touchpad works perfectly, and the keyboard is fine.

What I've decided is probably happening is that somewhere in the ACPI
system, code is running for too long with interrupts disabled, so
keyboard and touch-pad interrupts are being missed.  What I want to know
is, has this been reported before, and if so, has it been fixed since
stock 2.6.4 was released?  Will a patch from your sf site fix the
problem?

I sure wish I knew how to actually debug this kind of problem so that I
could provide more specific information or a patch.

-- 
If you feel like the machines are conspiring against you,
then it's time to perspire against the machines.




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
