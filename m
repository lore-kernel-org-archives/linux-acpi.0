From: Hans de Goede <hdegoede@redhat.com>
Subject: 4.12-rc1 REGRESSION "ACPI / sleep: Ignore spurious SCI wakeups from
 suspend-to-idle" causes system to not wakeup
Date: Tue, 23 May 2017 21:58:49 +0200
Message-ID: <e267ef96-4ca4-6432-311b-4af0c2786f9a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37626 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758599AbdEWT6x (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 May 2017 15:58:53 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Thorsten Leemhuis (regressions address)" <regressions@leemhuis.info>

Hi,

On (some?) Cherry Trail devices the system can be woken up
by pressing a key on the USB attached keyboard (even on some tablets
with an external USB keyboard).

This has never worked properly, with 4.11 it works once, followed
by a "irq 9: nobody cared" message, after which other wakeup
methods will need to be used (luckily irq 9 is otherwise unused).

Since commit eed4d47efe95("ACPI / sleep: Ignore spurious SCI wakeups
from suspend-to-idle") the first wakeup by USB-keyboard also no longer
works.

Worse, trying to wake up the system through an USB-keyboard (or in
case of laptop models _the_ keyboard) seems to result in the
system no longer waking up at all, not even through other wake-up
sources.

While testing I got the system to wake-up once after trying a wakeup
with the usb-keyb first. I managed to get it to wake-up by repeatedly
pressing the power-button without pressing it long enough for the
system to do a hard-poweroff. Here is what I found in dmesg in this
case:

[   99.987110] PM: Preparing system for sleep (freeze)
[   99.990133] Freezing user space processes ... (elapsed 0.003 seconds) done.
[   99.993359] OOM killer disabled.
[   99.993360] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   99.994592] PM: Suspending system (freeze)
[   99.994594] Suspending console(s) (use no_console_suspend to debug)
[  100.005486] serial 00:01: disabled
[  101.133291] PM: suspend of devices complete after 1135.306 msecs
[  101.133296] PM: suspend devices took 1.139 seconds
[  101.155819] PM: late suspend of devices complete after 22.522 msecs
[  101.183734] PM: noirq suspend of devices complete after 27.902 msecs
[  101.183746] PM: suspend-to-idle
[  106.750715] Suspended for 5.203 seconds
[  106.751155] PM: resume from suspend-to-idle
[  106.777022] PM: noirq resume of devices complete after 25.650 msecs
[  106.805621] PM: noirq suspend of devices complete after 27.745 msecs
[  106.830932] PM: noirq resume of devices complete after 25.309 msecs
[  106.858605] PM: noirq suspend of devices complete after 27.023 msecs
<repeated lots (really lots) of times>
[  146.693603] irq 9: nobody cared (try booting with the "irqpoll" option)
<backtrace about irq>
[  146.693861] Disabling IRQ #9
[  149.179549] PM: noirq suspend of devices complete after 3857.221 msecs
[  149.179563] PM: suspend-to-idle
[ 2519.926892] Suspended for 2371.000 seconds
[ 2519.927373] PM: resume from suspend-to-idle
[ 2519.953064] PM: noirq resume of devices complete after 25.272 msecs
[ 2521.066390] PM: early resume of devices complete after 1113.460 msecs
[ 2521.067464] pcieport 0000:00:1c.0: System wakeup disabled by ACPI
[ 2521.068616] rtc_cmos 00:04: System wakeup disabled by ACPI
<unrelated i915 unclaimed register access oops>
[ 2521.131849] PM: resume of devices complete after 65.482 msecs
[ 2521.132828] PM: resume devices took 0.066 seconds
[ 2521.132895] PM: Finishing wakeup.
[ 2521.132896] OOM killer enabled.
[ 2521.132897] Restarting tasks ... done.

I have a fix for the "irq 9: nobody cared" issue and I actually found
this regression(ish) while trying to test this fix.

The "irq 9: nobody cared" issue is caused by Linux not having a driver
for the INT0002 ACPI device, let me quote the commit message for the
driver for this device which fixes this with 4.11:

"Some peripherals on Baytrail and Cherrytrail platforms signal PME to the
PMC to wakeup the system. When this happens software needs to clear the
PME_B0_STS bit in the GPE0a_STS register to avoid an IRQ storm on IRQ 9.

This is modeled in ACPI through the INT0002 ACPI device.

This commit adds a driver which will bind to that device, call the
ACPI event handler for the wakeup and clear the interrupt source
avoiding the irq storm."

The int0002 driver shares irq 9 / the SCI with the ACPI subsys, it
detects if the interrupt is for it by doing the following:

         gpe_sts_reg = inl(GPE0A_STS_PORT);
         if (!(gpe_sts_reg & GPE0A_PME_B0_STS_BIT))
                 return IRQ_NONE;

Looking at the "ACPI / sleep: Ignore spurious SCI wakeups from
suspend-to-idle" commit I've added a pm_wakeup_hard_event()
to the int0002 driver when the GPE0A_PME_B0_STS_BIT is set and
with this change the fix works for 4.12-rc1 too and fixes the
issue with the system more or less hanging on the first wakeup
attempt by USB-keyboard.

So the question now is how to move forward with this, although
this may not really count as a regression the change from wakeup
by USB-keyboard working once, to it more or less hanging the
system certainly does not make things better.

As such I think it might be a good idea to merge the int0002 driver
during the 4.12 cycle ?

The int0002 driver was a platform/x86 driver, but various people
have asked to redo it as a gpio driver. I will post the new
version shortly and put everyone who is getting this mail on
the CC.

Regards,

Hans


