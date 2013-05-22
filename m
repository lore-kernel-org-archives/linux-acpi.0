From: Michael Marineau <mike@marineau.org>
Subject: ACPI v5 sleep registers broken on Toshiba laptops
Date: Wed, 22 May 2013 09:39:12 -0400
Message-ID: <CAHW-aUcG7kT6uMFwbjUJ4DnvU=c+aj-Z8vaq94Gnt_UbJ6QRjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:59435 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468Ab3EVNjP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 22 May 2013 09:39:15 -0400
Received: by mail-we0-f177.google.com with SMTP id n57so1248431wev.22
        for <linux-acpi@vger.kernel.org>; Wed, 22 May 2013 06:39:14 -0700 (PDT)
Received: from mail-wi0-x235.google.com (mail-wi0-x235.google.com [2a00:1450:400c:c05::235])
        by mx.google.com with ESMTPSA id eq15sm29009241wic.4.2013.05.22.06.39.12
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 22 May 2013 06:39:13 -0700 (PDT)
Received: by mail-wi0-f181.google.com with SMTP id hi5so1211279wib.8
        for <linux-acpi@vger.kernel.org>; Wed, 22 May 2013 06:39:12 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Greetings,

On the recently released Toshiba Kirabook and kernels >= 3.4
suspend/resume only works once. After resume input from things like
the power button, brightness buttons, lid switch, etc. no longer work
and the laptop simply hangs when suspended for a second time. This
appears to also impact other recent Toshiba laptops (although the bug
claims the hang is during the second resume rather than the second
suspend as is my case).
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1094800

Suspend/resume and all the buttons work just fine on v3.3. I bisected
the v3.3->v3.4 change (with the help of patching in a kvm clock fix as
needed) and tracked it down to this commit:

commit 2feec47d4c5f80b05f1650f5a24865718978eea4
Author: Bob Moore <robert.moore@intel.com>
Date: Tue Feb 14 15:00:53 2012 +0800

    ACPICA: ACPI 5: Support for new FADT SleepStatus, SleepControl registers

    Adds sleep and wake support for systems with these registers.
    One new file, hwxfsleep.c

    Signed-off-by: Bob Moore <robert.moore@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

Specifically, when the sleep status/control registeres are detected
they are used instead of the traditional registers. The failure to
resume a second time is triggered by this write in the new
acpi_hw_extended_wake_prep function:

    status = acpi_get_sleep_type_data(ACPI_STATE_S0,
                      &acpi_gbl_sleep_type_a,
                      &acpi_gbl_sleep_type_b);
    if (ACPI_SUCCESS(status)) {
        sleep_type_value =
            ((acpi_gbl_sleep_type_a << ACPI_X_SLEEP_TYPE_POSITION) &
             ACPI_X_SLEEP_TYPE_MASK);

        (void)acpi_write((u64)(sleep_type_value | ACPI_X_SLEEP_ENABLE),
                 &acpi_gbl_FADT.sleep_control);
    }

Replacing that write with the corresponding code from
acpi_hw_legacy_wake_prep while leaving the other acpi_hw_extended_*
functions alone gets suspend/resume working consistantly. That isn't
quite enough as events don't seem to get re-enabled so acpi buttons
and such don't work after resume. Copying the enable power button code
from acpi_hw_legacy_wake to acpi_hw_extended_wake at least gets the
power button back but lid, brightness, etc remain dead.

At the moment I've hacked these changes into v3.10.0-rc2 along with
another hack to fix a video regression and it seems to behave
reasonably well (minus the brightness keys and lid). I'm not sure what
the apropriate fix is. Maybe find some way beyond their presence to
detect if these registers are safe to use or just a device blacklist?

--
Michael Marineau
