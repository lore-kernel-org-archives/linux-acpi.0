From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: IA64 and drivers/acpi/bus.c
Date: Fri, 29 Sep 2017 04:42:52 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E886CF6F749@SHSMSX101.ccr.corp.intel.com>
References: <20170925165118.6ef312c2@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1354 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751076AbdI2Em4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 29 Sep 2017 00:42:56 -0400
In-Reply-To: <20170925165118.6ef312c2@endymion>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>, Lin Ming <ming.m.lin@intel.com>, "Luck, Tony" <tony.luck@intel.com>, "Brown, Len" <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Yu, Fenghua" <fenghua.yu@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

I wonder if we can just remove copy_dsdt quirk now.
As the old bug report was not fully root caused and the situation might be changed.
Probably that is the simplest way for cleaning this up.

Thanks
Lv

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Jean
> Delvare
> Subject: IA64 and drivers/acpi/bus.c
> 
> Hi all,
> 
> Long ago, a warning was silenced in drivers/acpi/bus.c on IA64 with
> this commit:
> 
> commit cce4f632db200aef147c59084437168174b23f11
> Author: Lin Ming <ming.m.lin@intel.com>
> Date:   Wed May 12 09:26:48 2010 +0800
> 
>     ACPI: fix early DSDT dmi check warnings on ia64
> 
> I don't think this fix was particularly elegant, but it did the job at
> the time. However you should be informed that an upcoming cleanup of
> the dmi subsystem will cause the warning to resurface:
> 
> https://marc.info/?l=linux-kernel&m=150113709717948&w=2
> 
> Instead of checking for dmi_initialized on individual dmi_system_id
> records, it will now be done once per dmi_check_system() call. It is
> much more efficient, but one side effect is that the warning will be
> displayed even if the array passed to dmi_check_system() is empty.
> 
> So the time has come to fix the problem cleanly, instead of just
> silencing the warning. This can be done in 2 ways:
> 
> 1* Don't call dmi_check_system() at all if not on X86.
> 
> 2* Initialize DMI earlier on IA64, so it is ready when ACPI support
> gets started.
> 
> I will let you guys decide what is the best option.
> 
> Thanks,
> --
> Jean Delvare
> SUSE L3 Support
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
