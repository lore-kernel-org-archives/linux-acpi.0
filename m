From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: 2f47e7e19f ("x86/mm/kaiser: Use PCID feature to make user and
 .."): WARNING: CPU: 0 PID: 1 at mm/early_ioremap.c:114 __early_ioremap
Date: Mon, 27 Nov 2017 23:13:43 +0100
Message-ID: <CAJZ5v0hyAt1cPj3jpm9njOZAo02WmN-83ozeyvDF5qipBXqH=Q@mail.gmail.com>
References: <5a1aaa36.CWNgvwmmRFzeAlPc%fengguang.wu@intel.com>
 <20171127101814.jsglrh7typy3pxxp@gmail.com> <bdfdf131-ca57-68c3-3a6c-039cd21c3bb5@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bdfdf131-ca57-68c3-3a6c-039cd21c3bb5@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@kernel.org>, kernel test robot <fengguang.wu@intel.com>, LKP <lkp@01.org>, kvm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, wfg@linux.intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 27, 2017 at 5:14 PM, Dave Hansen
<dave.hansen@linux.intel.com> wrote:
> On 11/27/2017 02:18 AM, Ingo Molnar wrote:
>> [    0.031000] Call Trace:
>> [    0.031000]  ? kernfs_add_one+0x1d9/0x1f0
>> [    0.031000]  early_memremap+0x33/0x3d
>> [    0.031000]  ? cnb20le_res+0x2f2/0x2f2
>> [    0.031000]  __acpi_map_table+0x1d/0x28
>> [    0.031000]  acpi_os_map_iomem+0x1cf/0x2a0
>> [    0.031000]  ? cnb20le_res+0x2f2/0x2f2
>> [    0.031000]  acpi_os_map_memory+0xd/0x20
>> [    0.031000]  acpi_find_root_pointer+0x1f/0x1ec
>> [    0.031000]  ? cnb20le_res+0x2f2/0x2f2
>> [    0.031000]  acpi_os_get_root_pointer+0x18/0x25
>> [    0.031000]  broadcom_postcore_init+0xc/0x6c
>> [    0.031000]  do_one_initcall+0xc4/0x1f7
>> [    0.031000]  kernel_init_freeable+0x1c2/0x2b2
>> [    0.031000]  ? rest_init+0x1a0/0x1a0
>> [    0.031000]  kernel_init+0xd/0x1bc
>> [    0.031000]  ret_from_fork+0x1f/0x30
>
> I've been able to reproduce this.  The bug here (at least on my system)
> is that we're calling into the ACPI code while 'acpi_disabled=1'.  The
> ACPI code then notices that it hasn't been initialized (because it
> should be off) and calls into the early_ioremap() code thinking that
> it's in early boot.
>
> I don't know why the bisect pinned this on the kaiser patches, or why
> it's only showing up now.  It's possible that some botched TLB flush
> _caused_ ACPI to get disabled at a weird time which then caused this
> warning.
>
> There are some recent changes around broadcom_postcore_init().
>
> ACPI folks, any suggestions on what to do here?  Should we be bailing
> out of acpi_os_get_root_pointer() like the attached patch?

No, the bug is in broadcom_postcore_init(), everything else should be fine.

I'm not even sure why acpi_os_get_root_pointer() is called from there
in the first place.  It should only be called from the ACPICA code.

Thanks,
Rafael
