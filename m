From: Hans de Goede <hdegoede@redhat.com>
Subject: lpss_iosf_enter_d3_state breaks PWM on Baytrail
Date: Mon, 26 Jun 2017 11:31:21 +0200
Message-ID: <f28e3a7a-1ea7-5f2d-4cfa-ab2cb85bdb45@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751390AbdFZJbY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Jun 2017 05:31:24 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

Hi Andy, et al.,

I've spend quite some time this weekend debugging an issue
an a Bay Trail laptop with a Crystal Cove PMIC which uses
the LPSS PWM for backlight control rather then the PMIC's
PWM.

The problem is lpss_iosf_enter_d3_state. Specifically when
called when the PWM runtime-suspends during i915 driver load,
during which the i915 driver disables then re-enables the PWM.

This is the only time (including normal suspend(to-idle)
and resume) when this check:

         pmc_status = (~(d3_sts_0 | func_dis)) & pmc_mask;
         if (pmc_status)
                 goto exit;

Does not hit the goto exit path and lpss_iosf_enter_d3_state
actually executes these 3 statements:

         iosf_mbi_modify(LPSS_IOSF_UNIT_LPIO1, MBI_CFG_WRITE,
                         LPSS_IOSF_PMCSR, value2, mask2);

         iosf_mbi_modify(LPSS_IOSF_UNIT_LPIO2, MBI_CFG_WRITE,
                         LPSS_IOSF_PMCSR, value2, mask2);

         iosf_mbi_modify(LPSS_IOSF_UNIT_LPIOEP, MBI_CR_WRITE,
                         LPSS_IOSF_GPIODEF0, value1, mask1);

If I comment out these 3 statements then everything works fine,
with these 3 statements in place though, then the PWM controller
gets stuck when the i915 driver tries to re-enable it (and it
runtime-resumes). After these 3 statements have been run once
then any subsequent reads from the PWM's control register
always return 0x00010000 and writes seem to be ignored.

Given the past troubles with the LPSS DMA controller suspend,
see all the links in this commit message (which introduces
the current fix) :
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eebb3e8d8aaf2

I'm tempted to just rip out lpss_iosf_enter_d3_state,
especially since it does not seem to do anything other
then during early boot when not all drivers are loaded yet.

Note that on Bay Trail devices with an AXP288 PMIC (most new
Bay Trail devices) and on any Cherry Trail device the LPSS I2C
controller connected to the PMIC will never suspend because
some DSTDs make ACPI OpRegion calls during late suspend /
early resume and as such we need to keep the I2C bus alive
the whole time. This means that the check in
lpss_iosf_enter_d3_state will always hit the goto exit path
on these devices, leaving just (older) Bay Trail + non AXP288
PMIC devices as potentially hitting the code path where
lpss_iosf_enter_d3_state actually does something and these are
exactly the devices with which people are having a lot of
problems with freezes / hangs.

So I believe that the best approach would be to simply remove
lpss_iosf_enter_d3_state. Which leaves me wondering what it
actually does. It would be nice for the future if undocumented
(not publicly documented) registers are used that some comments
are added describing what each register write actually does.

These seem to simply put the DMA controller into D3:

         u32 value2 = LPSS_PMCSR_D3hot;
         u32 mask2 = LPSS_PMCSR_Dx_MASK;

         iosf_mbi_modify(LPSS_IOSF_UNIT_LPIO1, MBI_CFG_WRITE,
                         LPSS_IOSF_PMCSR, value2, mask2);

         iosf_mbi_modify(LPSS_IOSF_UNIT_LPIO2, MBI_CFG_WRITE,
                         LPSS_IOSF_PMCSR, value2, mask2);

But what does this one do?   :

         u32 value1 = 0;
         u32 mask1 = LPSS_GPIODEF0_DMA_D3_MASK | LPSS_GPIODEF0_DMA_LLP;

         iosf_mbi_modify(LPSS_IOSF_UNIT_LPIOEP, MBI_CR_WRITE,
                         LPSS_IOSF_GPIODEF0, value1, mask1);

I guess this turns on(?) the automatically down powering of the
DMA controllers ? If so then why not just do only that ?

And if this turns it on then lpss_iosf_exit_d3_state turns the
automagic off, if that is true, then there is an ordering issue.
lpss_iosf_exit_d3_state gets only run on (runtime)resume, not
on the initial probe of LPSS devices, so that would mean that between
the initial probe and the first resume we have the undesirable
auto-off feature active ?

Regards,

Hans

