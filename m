From: Meelis Roos <mroos@linux.ee>
Subject: Re: 4.10 ACPI: UBSAN: Undefined behaviour in
 drivers/acpi/sysfs.c:757:33
Date: Fri, 10 Mar 2017 17:53:49 +0200 (EET)
Message-ID: <alpine.LRH.2.20.1703101752080.15226@math.ut.ee>
References: <alpine.LRH.2.20.1703101745520.15226@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.20.1703101745520.15226@math.ut.ee>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

> Tried 4.10 on a PC with Ahlon64 X2 CPU and Asun M2N-E maiboard and got 
> this UBSAN warning that was not here with 4.9:
> 
> [    0.217716] ================================================================================
> [    0.217950] UBSAN: Undefined behaviour in drivers/acpi/sysfs.c:757:33
> [    0.218082] shift exponent 64 is too large for 64-bit type 'long long unsigned int'
> [    0.218316] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.10.0 #18
> [    0.218446] Hardware name: System manufacturer System Product Name/M2N-E, BIOS ASUS M2N-E ACPI BIOS Revision 1703 01/25/2010
> [    0.218684] Call Trace:
> [    0.218815]  ? dump_stack+0x47/0x6c
> [    0.218943]  ? ubsan_epilogue+0x9/0x40
> [    0.219071]  ? __ubsan_handle_shift_out_of_bounds+0x124/0x160
> [    0.219203]  ? ktime_get+0x4d/0xf0
> [    0.219332]  ? wakeup_source_add+0x60/0x100
> [    0.219462]  ? acpi_gpe_apply_masked_gpes+0x3c/0x7d
> [    0.219592]  ? acpi_scan_init+0x261/0x287
> [    0.219721]  ? acpi_init+0x2f3/0x343
> [    0.219849]  ? acpi_sleep_proc_init+0x22/0x22
> [    0.219979]  ? do_one_initcall+0x56/0x1f0
> [    0.220000]  ? kernel_init_freeable+0x245/0x2d2
> [    0.220000]  ? rest_init+0x70/0x70
> [    0.220000]  ? kernel_init+0x6/0x110
> [    0.220000]  ? rest_init+0x70/0x70
> [    0.220000]  ? ret_from_fork+0x23/0x30
> [    0.220000] 
> ================================================================================

And the same happens on Sun Ultra 20 Opteron workstation, with a 
slightly different backtrace:

[    0.196897] ================================================================================
[    0.196927] UBSAN: Undefined behaviour in drivers/acpi/sysfs.c:757:33
[    0.196946] shift exponent 64 is too large for 64-bit type 'long long unsigned int'
[    0.196977] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.10.0-09686-g9e314890292c #21
[    0.197004] Hardware name: Sun Microsystems Sun Ultra 20 Workstation/2864, BIOS 2.3.0  05/15/2008
[    0.197032] Call Trace:
[    0.197056]  ? dump_stack+0x47/0x65
[    0.197075]  ? ubsan_epilogue+0x9/0x40
[    0.197093]  ? __ubsan_handle_shift_out_of_bounds+0xf8/0x140
[    0.197112]  ? __kmalloc_track_caller+0xb4/0x230
[    0.197131]  ? ktime_get+0x4d/0xf0
[    0.197149]  ? wakeup_source_add+0x82/0x110
[    0.197169]  ? acpi_gpe_apply_masked_gpes+0x3c/0x7d
[    0.197187]  ? acpi_scan_init+0x261/0x287
[    0.197204]  ? acpi_init+0x2f3/0x343
[    0.197222]  ? acpi_sleep_proc_init+0x22/0x22
[    0.197240]  ? do_one_initcall+0x46/0x1d0
[    0.197260]  ? kernel_init_freeable+0x245/0x2d2
[    0.197279]  ? rest_init+0x80/0x80
[    0.197296]  ? kernel_init+0x6/0x110
[    0.197313]  ? rest_init+0x80/0x80
[    0.197330]  ? ret_from_fork+0x23/0x30
[    0.197346] ================================================================================

-- 
Meelis Roos <mroos@linux.ee>
