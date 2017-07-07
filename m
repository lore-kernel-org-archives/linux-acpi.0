From: Meelis Roos <mroos@linux.ee>
Subject: UBSAN: Undefined behaviour in drivers/acpi/sysfs.c:760:33
Date: Fri, 7 Jul 2017 12:30:55 +0300 (EEST)
Message-ID: <alpine.LRH.2.20.1707071225160.605@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

I am seeing the warning below on multiple machines - at least 2 
different Sun opteron boxes (X2100 and U20), maybe more. It has been 
there in 4.11.0 and 4.12.0.

[    0.187132] ================================================================================
[    0.187331] UBSAN: Undefined behaviour in drivers/acpi/sysfs.c:760:33
[    0.187450] shift exponent 64 is too large for 64-bit type 'long long unsigned int'
[    0.187648] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.12.0 #102
[    0.187766] Hardware name: Sun Microsystems Sun Fire(TM) X2100      /2864, BIOS 1.1.8  05/15/2008
[    0.187968] Call Trace:
[    0.188000]  ? dump_stack+0x47/0x6b
[    0.188000]  ? ubsan_epilogue+0x9/0x40
[    0.188000]  ? __ubsan_handle_shift_out_of_bounds+0xf8/0x140
[    0.188000]  ? do_fast_syscall_32+0x446/0x470
[    0.188000]  ? ktime_get+0x64/0x110
[    0.188000]  ? wakeup_source_add+0x82/0x100
[    0.188000]  ? acpi_gpe_apply_masked_gpes+0x39/0x7a
[    0.188000]  ? acpi_scan_init+0x2b2/0x2da
[    0.188000]  ? acpi_init+0x2fe/0x349
[    0.188000]  ? acpi_sleep_proc_init+0x22/0x22
[    0.188000]  ? do_one_initcall+0x46/0x1c0
[    0.188000]  ? kernel_init_freeable+0x24a/0x2d2
[    0.188000]  ? rest_init+0x70/0x70
[    0.188000]  ? do_syscall_64+0x9d/0x2e0
[    0.188000]  ? kernel_init+0x6/0x110
[    0.188000]  ? rest_init+0x70/0x70
[    0.188000]  ? ret_from_fork+0x22/0x30
[    0.188000] ================================================================================

((u64)1<<gpe seems to be the culprit here - ACPI_MASKABLE_GPE_MAX is 128 
but we only have 64-bit unsigned long long, and we are hitting 64-bit 
shift in practice on these machines.


#define ACPI_MASKABLE_GPE_MAX   0x80

static u64 __initdata acpi_masked_gpes;

[...]

void __init acpi_gpe_apply_masked_gpes(void)
{
        acpi_handle handle;
        acpi_status status;
        u8 gpe;

        for (gpe = 0;
             gpe < min_t(u8, ACPI_MASKABLE_GPE_MAX, acpi_current_gpe_count);
             gpe++) {
                if (acpi_masked_gpes & ((u64)1<<gpe)) {
                        status = acpi_get_gpe_device(gpe, &handle);
                        if (ACPI_SUCCESS(status)) {
                                pr_info("Masking GPE 0x%x.\n", gpe);
                                (void)acpi_mask_gpe(handle, gpe, TRUE);
                        }
                }
        }
}



-- 
Meelis Roos (mroos@linux.ee)
