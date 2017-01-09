From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / OSL: Fix rcu synchronization logic
Date: Tue, 10 Jan 2017 00:35:03 +0100
Message-ID: <CAJZ5v0giPxnkmxbk0ubSENSBdY2vNRku_Lm_YTVjA+xkCrSTog@mail.gmail.com>
References: <1483955769-9579-1-git-send-email-lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33118 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753119AbdAIXfE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2017 18:35:04 -0500
In-Reply-To: <1483955769-9579-1-git-send-email-lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Huang Ying <ying.huang@intel.com>, Borislav Petkov <bp@alien8.de>

On Mon, Jan 9, 2017 at 10:56 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> The rcu synchronization logic is originally provided to protect
> apei_read()/apei_write() as in the APEI drivers, there is NMI event source
> requiring non spinlock based synchronization mechanism.
>
> After that, ACPI developers think FADT registers may also require same
> facility, so they moved the RCU stuffs to generic ACPI layer.
>
> So now non-task-context ACPI map lookup is only protected by RCU.
>
> This triggers problem as acpi_os_map_memory()/acpi_os_unmap_memory() can be
> used to map/unmap tables as long as to map/unmap ACPI registers. When it is
> used for the ACPI tables, the caller could invoke this very early. When it
> is invoked earlier than workqueue_init() and later than
> check_early_ioremp_leak(), invoking synchronize_rcu_expedited() can cause a
> kernel hang.
>
> Actually this facility is only used to protect non-task-context ACPI map
> lookup,

That doesn't sound quite right.

acpi_os_read/write_memory() use RCU-protected list lookups, so it's
not just non-task-context AFAICS.

> and such mappings are only introduced by
> acpi_os_map_generic_address(). So before it is invoked, there is no need to
> invoke synchronize_rcu_expedited().

That said it may be fine to start actually synchronize RCU after
acpi_os_map_generic_address() has been called for the first time.  I
need a better (or more detailed) explanation why it is fine, though.

Thanks,
Rafael
