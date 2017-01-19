From: Tomi Sarvela <tomi.p.sarvela@intel.com>
Subject: Re: [PATCH] ACPICA: Tables: Remove a hidden logic related to acpi_tb_install_standard_table()
Date: Thu, 19 Jan 2017 11:38:08 +0200
Message-ID: <4185897.PWYXmptgmv@fractal.fi.intel.com>
References: <20170112015256.GB19308@yexl-desktop> <49ac3d4571a728ae5348a6b2e93da3d45f76cd38.1484810262.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:26052 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750996AbdASJip (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 19 Jan 2017 04:38:45 -0500
In-Reply-To: <49ac3d4571a728ae5348a6b2e93da3d45f76cd38.1484810262.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Ye Xiaolong <xiaolong.ye@intel.com>

On Thursday, 19 January 2017 15:21:34 EET Lv Zheng wrote:
> There is a hidden logic for acpi_tb_install_standard_table() as it
> can be invoked from boot stage and during runtime.
> 1. When it is invoked from the OS boot stage, ACPICA mutex may not
> be available, and thus no
> acpi_ut_acquire_mutex()/acpi_ut_release_mutex() are invoked in
> these code paths:
>    acpi_initialize_tables
>      acpi_tb_parse_root_table
>        acpi_tb_install_standard_table (4 invocations)
>    acpi_install_table
>        acpi_tb_install_standard_table
> 2. When it is invoked during the runtime, ACPICA mutex is correctly
> used: acpi_ex_load_op
>      acpi_tb_install_and_load_table
>        acpi_tb_install_standard_table
>    acpi_load_table
>      acpi_tb_install_and_load_table
>        acpi_tb_install_standard_table
> So the mutex is now used in acpi_tb_install_and_load_table(), while
> it actually should be in acpi_tb_install_standard_table().
> 
> This introduces another problem in acpi_tb_install_standard_table()
> where acpi_gbl_table_handler is invoked from and the lock contexts
> are thus not consistent for the table handlers. This triggers a
> regression when acpi_get_table()/acpi_put_table() start to hold
> table mutex during runtime.
> 
> The regression is noticed by LKP as new errors reported by ACPICA
> mutex debugging facility.
> [    2.043693] ACPI Error: Mutex [ACPI_MTX_Tables] already acquired
> by this thread [497483776] (20160930/utmutex-254) [    2.054084]
> ACPI Error: Mutex [0x2] is not acquired, cannot release
> (20160930/utmutex-326)
> 
> And it triggers a dead lock:
> [  247.066214] INFO: task swapper/0:1 blocked for more than 120
> seconds. ...
> [  247.091271] Call Trace:
> ...
> [  247.121523]  down_timeout+0x47/0x50
> [  247.125065]  acpi_os_wait_semaphore+0x47/0x62
> [  247.129475]  acpi_ut_acquire_mutex+0x43/0x81
> [  247.133798]  acpi_get_table+0x2d/0x84
> [  247.137513]  acpi_table_attr_init+0xcd/0x100
> [  247.146590]  acpi_sysfs_table_handler+0x5d/0xb8
> [  247.151174]  acpi_bus_table_handler+0x23/0x2a
> [  247.155583]  acpi_tb_install_standard_table+0xe0/0x213
> [  247.164489]  acpi_tb_install_and_load_table+0x3a/0x82
> [  247.169592]  acpi_ex_load_op+0x194/0x201
> ...
> [  247.200108]  acpi_ns_evaluate+0x1bb/0x247
> [  247.204170]  acpi_evaluate_object+0x178/0x274
> [  247.213249]  acpi_processor_set_pdc+0x154/0x17b
> ...
> The table mutex is held in acpi_tb_install_and_load_table() and is
> re-visited by acpi_get_table().
> 
> Noticing that the early mutex requirement actually belongs to the
> OSL layer and has already been handled in Linux
> acpi_os_wait_semaphore()/acpi_os_signal_semaphore(). This patch then
> can fix the regression by removing this hidden logic from ACPICA
> core and leaving it to OSPMs. A documentation update should also be
> required.
> 
> Fixes: 174cc7187e6f ('ACPICA: Tables: Back port
> acpi_get_table_with_size() and early_acpi_os_unmap_memory() from
> Linux kernel') Reported-by: Tomi Sarvela <tomi.p.sarvela@intel.com>
> Reported-by: Ye Xiaolong <xiaolong.ye@intel.com>
> Cc: Tomi Sarvela <tomi.p.sarvela@intel.com>
> Cc: Ye Xiaolong <xiaolong.ye@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---

This patch helps ILK-650 testhost survive past the boot ACPI setup.

Tested-by: Tomi Sarvela <tomi.p.sarvela@intel.com>

Best regards,

Tomi Sarvela


