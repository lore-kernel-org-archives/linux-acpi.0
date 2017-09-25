From: Jean Delvare <jdelvare@suse.de>
Subject: IA64 and drivers/acpi/bus.c
Date: Mon, 25 Sep 2017 16:51:18 +0200
Message-ID: <20170925165118.6ef312c2@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934544AbdIYOvV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 25 Sep 2017 10:51:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>, Tony Luck <tony.luck@intel.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi all,

Long ago, a warning was silenced in drivers/acpi/bus.c on IA64 with
this commit:

commit cce4f632db200aef147c59084437168174b23f11
Author: Lin Ming <ming.m.lin@intel.com>
Date:   Wed May 12 09:26:48 2010 +0800

    ACPI: fix early DSDT dmi check warnings on ia64
    
I don't think this fix was particularly elegant, but it did the job at
the time. However you should be informed that an upcoming cleanup of
the dmi subsystem will cause the warning to resurface:

https://marc.info/?l=linux-kernel&m=150113709717948&w=2

Instead of checking for dmi_initialized on individual dmi_system_id
records, it will now be done once per dmi_check_system() call. It is
much more efficient, but one side effect is that the warning will be
displayed even if the array passed to dmi_check_system() is empty.

So the time has come to fix the problem cleanly, instead of just
silencing the warning. This can be done in 2 ways:

1* Don't call dmi_check_system() at all if not on X86.

2* Initialize DMI earlier on IA64, so it is ready when ACPI support
gets started.

I will let you guys decide what is the best option.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
