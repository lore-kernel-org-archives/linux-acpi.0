From: Andreas Steinmetz <ast-sy9/ueDX/ME@public.gmane.org>
Subject: 2.6.11 acpi battery state readout as source of keyboard/touchpad
 troubles
Date: Wed, 30 Mar 2005 21:10:59 +0200
Message-ID: <424AF9C3.4000905@domdv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
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
To: Linux Kernel Mailinglist <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: vojtech-AlSwsSmVLrQ@public.gmane.org, dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In traceing the source of my sporadic synaptics touchpad troubles

psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.

and keyboard troubles (sporadically lost key up/down events) on an Acer
Aspire 1520 (x86_64, latest bios v1.09) I did enable the
report_lost_ticks option which did spit out stuff like the following at
regular intervals:

time.c: Lost 17 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
time.c: Lost 8 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
time.c: Lost 19 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
time.c: Lost 8 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
time.c: Lost 18 timer tick(s)! rip handle_IRQ_event+0x20/0x60)
time.c: Lost 8 timer tick(s)! rip handle_IRQ_event+0x20/0x60)

This looked suspiciously like it happended when the the kde laptop
applet polled the battery status. So I did terminate the applet.

The result was no more lost ticks, no lost keyboard events and no more
lost touchpad sync.

To verify ACPI battery data as the source of trouble i did a simple

cat /proc/acpi/battery/BAT0/state

which instantly resulted in:

time.c: Lost 19 timer tick(s)! rip handle_IRQ_event+0x20/0x60)

So it seems ACPI battery readout does cause some long running interrupt
disable and that it causes nasty side effects for the 8042 input.

Note that doing

cat /proc/acpi/battery/BAT0/info

doesn't cause any trouble (battery alarm is unsupported).

I can ignore the lost ticks but the keyboard/touchpad problems caused by
the state readout are definitely nasty.

Any ideas?
-- 
Andreas Steinmetz                       SPAMmers use robotrap-sy9/ueDX/ME@public.gmane.org


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
