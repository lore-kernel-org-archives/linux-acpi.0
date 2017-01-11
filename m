From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] ACPI / OSL: Fix rcu synchronization logic
Date: Wed, 11 Jan 2017 19:45:21 +0100
Message-ID: <CAJZ5v0i-Hyxq1hYQ3DA3T2NUo_DaaqGvZ1Trvou-WvXO=OJLdA@mail.gmail.com>
References: <4034dde8-ffc1-18e2-f40c-00cf37471793@intel.com> <f9f4f5b204e866a346ee335c9d1dfb39ef3a1405.1484127670.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36414 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753975AbdAKSp1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Jan 2017 13:45:27 -0500
Received: by mail-oi0-f66.google.com with SMTP id u143so27577426oif.3
        for <linux-acpi@vger.kernel.org>; Wed, 11 Jan 2017 10:45:22 -0800 (PST)
In-Reply-To: <f9f4f5b204e866a346ee335c9d1dfb39ef3a1405.1484127670.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Huang Ying <ying.huang@intel.com>, Borislav Petkov <bp@alien8.de>

On Wed, Jan 11, 2017 at 10:54 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> The rcu synchronization logic is originally provided to protect
> apei_read()/apei_write() as in the APEI drivers, there is NMI event source
> requiring non spinlock based synchronization mechanism. After that, ACPI
> developers think FADT registers may also require same facility, so they
> moved the RCU stuffs to generic ACPI layer. So now interrupt (irq, nmi)
> context ACPI map lookup is only protected by RCU.
>
> This triggers a kernel hang when ACPICA API starts to unmap unused tables
> (see Link #1 for details). The cause of the hang is
> drivers/iommu/amd_iommu_init.c calling acpi_put_table() too early and then
> land in RCU which is uninitialized yet:
>   early_amd_iommu_init()
>     acpi_put_table(ivrs_base)
>       acpi_os_unmap_memory()
>         synchronize_rcu_expedited()
> Now that function goes and sends IPIs, i.e., schedule_work() but this is
> too early - workqueue_init() hasn't been invoked. Actually, from looking
> at the callstack, we do kernel_init_freeable()->native_smp_prepare_cpus()
> and workqueue_init() comes next.
>
> Actually this facility is only used to protect interrupt context ACPI map
> lookup, and such mappings are only introduced by
> acpi_os_map_generic_address(). So before it is invoked, there is no need to
> use RCU, mutex should be used instead of.

Why should the mutex be used then?

There's nothing wrong with using RCU in all cases except when that
happens early on boot when things don't work as expected, but at that
time there's no need to do the synchronization *at* *all* as the list
protected by RCU is not even walked.

Thanks,
Rafael
