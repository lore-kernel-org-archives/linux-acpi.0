From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: 2f47e7e19f ("x86/mm/kaiser: Use PCID feature to make user and
 .."): WARNING: CPU: 0 PID: 1 at mm/early_ioremap.c:114 __early_ioremap
Date: Mon, 27 Nov 2017 23:33:50 +0100
Message-ID: <CAJZ5v0i5E679oaKwKbqNK2mVv81kJFN5P_L2xz_oAa1pKRtY_w@mail.gmail.com>
References: <5a1aaa36.CWNgvwmmRFzeAlPc%fengguang.wu@intel.com>
 <20171127101814.jsglrh7typy3pxxp@gmail.com> <bdfdf131-ca57-68c3-3a6c-039cd21c3bb5@linux.intel.com>
 <CAJZ5v0hyAt1cPj3jpm9njOZAo02WmN-83ozeyvDF5qipBXqH=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32894 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753015AbdK0Wdv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Nov 2017 17:33:51 -0500
In-Reply-To: <CAJZ5v0hyAt1cPj3jpm9njOZAo02WmN-83ozeyvDF5qipBXqH=Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, kernel test robot <fengguang.wu@intel.com>, LKP <lkp@01.org>, kvm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, wfg@linux.intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Bjorn Helgaas <bhelgaas@google.com>

On Mon, Nov 27, 2017 at 11:13 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Nov 27, 2017 at 5:14 PM, Dave Hansen
> <dave.hansen@linux.intel.com> wrote:
>> On 11/27/2017 02:18 AM, Ingo Molnar wrote:
>>> [    0.031000] Call Trace:
>>> [    0.031000]  ? kernfs_add_one+0x1d9/0x1f0
>>> [    0.031000]  early_memremap+0x33/0x3d
>>> [    0.031000]  ? cnb20le_res+0x2f2/0x2f2
>>> [    0.031000]  __acpi_map_table+0x1d/0x28
>>> [    0.031000]  acpi_os_map_iomem+0x1cf/0x2a0
>>> [    0.031000]  ? cnb20le_res+0x2f2/0x2f2
>>> [    0.031000]  acpi_os_map_memory+0xd/0x20
>>> [    0.031000]  acpi_find_root_pointer+0x1f/0x1ec
>>> [    0.031000]  ? cnb20le_res+0x2f2/0x2f2
>>> [    0.031000]  acpi_os_get_root_pointer+0x18/0x25
>>> [    0.031000]  broadcom_postcore_init+0xc/0x6c
>>> [    0.031000]  do_one_initcall+0xc4/0x1f7
>>> [    0.031000]  kernel_init_freeable+0x1c2/0x2b2
>>> [    0.031000]  ? rest_init+0x1a0/0x1a0
>>> [    0.031000]  kernel_init+0xd/0x1bc
>>> [    0.031000]  ret_from_fork+0x1f/0x30
>>
>> I've been able to reproduce this.  The bug here (at least on my system)
>> is that we're calling into the ACPI code while 'acpi_disabled=1'.  The
>> ACPI code then notices that it hasn't been initialized (because it
>> should be off) and calls into the early_ioremap() code thinking that
>> it's in early boot.
>>
>> I don't know why the bisect pinned this on the kaiser patches, or why
>> it's only showing up now.  It's possible that some botched TLB flush
>> _caused_ ACPI to get disabled at a weird time which then caused this
>> warning.
>>
>> There are some recent changes around broadcom_postcore_init().
>>
>> ACPI folks, any suggestions on what to do here?  Should we be bailing
>> out of acpi_os_get_root_pointer() like the attached patch?
>
> No, the bug is in broadcom_postcore_init(), everything else should be fine.
>
> I'm not even sure why acpi_os_get_root_pointer() is called from there
> in the first place.  It should only be called from the ACPICA code.

This seems to be serving as a rough check whether or not ACPI is going
to be used on this platform (if we get the location of the tables, it
probably will be used) and it is missing the acpi_disabled check.

Thanks,
Rafael
