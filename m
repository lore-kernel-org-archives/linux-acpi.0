From: Len Brown <lenb@kernel.org>
Subject: Re: acpi exception with current -mm lineup (HPET)
Date: Thu, 31 May 2007 02:02:17 -0400
Message-ID: <200705310202.18124.lenb@kernel.org>
References: <20070530211759.aa083623.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45220 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758329AbXEaGC3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 May 2007 02:02:29 -0400
In-Reply-To: <20070530211759.aa083623.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-acpi@vger.kernel.org

On Thursday 31 May 2007 00:17, Andrew Morton wrote:
> initcall 0xffffffff8066281b: rtc_init+0x0/0x1aa() returned 0.
> initcall 0xffffffff8066281b ran for 0 msecs: rtc_init+0x0/0x1aa()
> Calling initcall 0xffffffff806629c5: hpet_init+0x0/0x69()
> hpet_resources: 0xfed00000 is busy
> ACPI Error (utglobal-0126): Unknown exception code: 0xFFFFFFF0 [20070126]
> 
> Call Trace:
>  [<ffffffff80384004>] acpi_format_exception+0x38/0x43
>  [<ffffffff80380ac9>] acpi_ut_status_exit+0x43/0x85
>  [<ffffffff803ad958>] hpet_resources+0x0/0x138

This stack track is actually triggered in acpi_walk_resources(),
by return_ACPI_STATUS(status);

because the return type here
static acpi_status hpet_resources(struct acpi_resource *res, void *data)

is not consistent with the return value here:
                        return -EBUSY;

>  [<ffffffff8037e341>] acpi_walk_resources+0x13c/0x14e
>  [<ffffffff803ad907>] hpet_acpi_add+0x40/0x91
>  [<ffffffff80387a27>] acpi_device_probe+0x51/0x109
>  [<ffffffff803bca00>] driver_probe_device+0xdd/0x164
>  [<ffffffff803bcbc7>] __driver_attach+0x89/0xc9
>  [<ffffffff803bcb3e>] __driver_attach+0x0/0xc9
>  [<ffffffff803bbaaa>] bus_for_each_dev+0x49/0x7a
>  [<ffffffff803bc76b>] driver_attach+0x1c/0x1e
>  [<ffffffff803bc0b2>] bus_add_driver+0x7f/0x184
>  [<ffffffff803bcf94>] driver_register+0x73/0x77
>  [<ffffffff80387bbd>] acpi_bus_register_driver+0x3e/0x40
>  [<ffffffff80662a00>] hpet_init+0x3b/0x69
>  [<ffffffff8064f8fb>] kernel_init+0x171/0x2e1
>  [<ffffffff804ed953>] _spin_unlock_irq+0x14/0x30
>  [<ffffffff8020a618>] child_rip+0xa/0x12
>  [<ffffffff8064f78a>] kernel_init+0x0/0x2e1
>  [<ffffffff8020a60e>] child_rip+0x0/0x12
> initcall 0xffffffff806629c5: hpet_init+0x0/0x69() returned 0.
> 
> This is with a git pull from this morning.  The machine is one
> of those Intel Noncna boxen.  I'm not sure how it identifies itself.

Nocona

> I put a copy of /proc/acpi/dsdt at http://userweb.kernel.org/~akpm/dsdt
> if that's any help.
> 
> Full dmesg at http://userweb.kernel.org/~akpm/dmesg-x.txt

Okay, this BIOS actually has a real HPET table:

ACPI: HPET 7FFD7460, 0038 (r1 A M I  OEMHPET   5000427 MSFT       97)

and the hpet is actually found:

Calling initcall 0xffffffff80652488: late_hpet_init+0x0/0xd1()
hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 14318180 Hz
initcall 0xffffffff80652488: late_hpet_init+0x0/0xd1() returned 0.
initcall 0xffffffff80652488 ran for 0 msecs: late_hpet_init+0x0/0xd1()
...

Perhaps Venki can comment on if the resource conflict is expected
to be fatal or not.

-Len
 
