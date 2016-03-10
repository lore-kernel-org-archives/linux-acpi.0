From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 0/2] ACPI, APEI: Memory leaks
Date: Thu, 10 Mar 2016 23:51:49 +0100
Message-ID: <3605684.qBtSSaxB6s@vostro.rjw.lan>
References: <1457452332-2673-1-git-send-email-johunt@akamai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51094 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932089AbcCJWtz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Mar 2016 17:49:55 -0500
In-Reply-To: <1457452332-2673-1-git-send-email-johunt@akamai.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joshua Hunt <johunt@akamai.com>, tony.luck@intel.com, Borislav Petkov <bp@suse.de>
Cc: gong.chen@intel.com, linux-acpi@vger.kernel.org, lenb@kernel.org, ying.huang@intel.com, linux-kernel@vger.kernel.org

On Tuesday, March 08, 2016 10:52:10 AM Joshua Hunt wrote:
> While investigating a possible memory leak using kmemleak I came across the
> following five leaks coming from APEI and ERST:
> 
> unreferenced object 0xffff880402b6ee80 (size 32):
>   comm "swapper/0", pid 1, jiffies 4294669373 (age 318.183s)
>   hex dump (first 32 bytes):
>     58 fe ab fa 03 88 ff ff 58 fe ab fa 03 88 ff ff  X.......X.......
>     18 50 ea dc 00 00 00 00 3f 50 ea dc 00 00 00 00  .P......?P......
>   backtrace:
>     [<ffffffff82195c33>] create_object+0x103/0x2c0
>     [<ffffffff826868b2>] kmemleak_alloc+0x82/0xc0
>     [<ffffffff8218248b>] kmem_cache_alloc_trace+0x17b/0x210
>     [<ffffffff8241a6fa>] apei_res_add+0x19a/0x200
>     [<ffffffff8241a7e2>] collect_res_callback+0x82/0xa0
>     [<ffffffff8241a225>] apei_exec_for_each_entry+0x85/0xb0
>     [<ffffffff8241a26a>] apei_exec_collect_resources+0x1a/0x20
>     [<ffffffff82afe532>] erst_init+0x3d6/0x3e5
>     [<ffffffff820004bd>] do_one_initcall+0x19d/0x1d0
>     [<ffffffff82ac1152>] kernel_init_freeable+0x13d/0x1d6
>     [<ffffffff82684a8e>] kernel_init+0xe/0xf0
>     [<ffffffff826909d2>] ret_from_fork+0x42/0x70
>     [<ffffffffffffffff>] 0xffffffffffffffff
> unreferenced object 0xffff880402b6ee40 (size 32):
>   comm "swapper/0", pid 1, jiffies 4294670231 (age 317.326s)
>   hex dump (first 32 bytes):
>     68 fe ab fa 03 88 ff ff 68 fe ab fa 03 88 ff ff  h.......h.......
>     b2 00 00 00 00 00 00 00 b3 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff82195c33>] create_object+0x103/0x2c0
>     [<ffffffff826868b2>] kmemleak_alloc+0x82/0xc0
>     [<ffffffff8218248b>] kmem_cache_alloc_trace+0x17b/0x210
>     [<ffffffff8241a6fa>] apei_res_add+0x19a/0x200
>     [<ffffffff8241a7fc>] collect_res_callback+0x9c/0xa0
>     [<ffffffff8241a225>] apei_exec_for_each_entry+0x85/0xb0
>     [<ffffffff8241a26a>] apei_exec_collect_resources+0x1a/0x20
>     [<ffffffff82afe532>] erst_init+0x3d6/0x3e5
>     [<ffffffff820004bd>] do_one_initcall+0x19d/0x1d0
>     [<ffffffff82ac1152>] kernel_init_freeable+0x13d/0x1d6
>     [<ffffffff82684a8e>] kernel_init+0xe/0xf0
>     [<ffffffff826909d2>] ret_from_fork+0x42/0x70
>     [<ffffffffffffffff>] 0xffffffffffffffff
> unreferenced object 0xffff880402b6ee20 (size 32):
>   comm "swapper/0", pid 1, jiffies 4294672240 (age 315.317s)
>   hex dump (first 32 bytes):
>     88 fd ab fa 03 88 ff ff 00 ee b6 02 04 88 ff ff  ................
>     00 d0 15 cd 00 00 00 00 00 40 16 cd 00 00 00 00  .........@......
>   backtrace:
>     [<ffffffff82195c33>] create_object+0x103/0x2c0
>     [<ffffffff826868b2>] kmemleak_alloc+0x82/0xc0
>     [<ffffffff8218248b>] kmem_cache_alloc_trace+0x17b/0x210
>     [<ffffffff8241a6fa>] apei_res_add+0x19a/0x200
>     [<ffffffff8241a81a>] apei_get_res_callback+0x1a/0x20
>     [<ffffffff823d0f8b>] acpi_nvs_for_each_region+0x2b/0x50
>     [<ffffffff8241ae95>] apei_resources_request+0x95/0x380
>     [<ffffffff82afe23e>] erst_init+0xe2/0x3e5
>     [<ffffffff820004bd>] do_one_initcall+0x19d/0x1d0
>     [<ffffffff82ac1152>] kernel_init_freeable+0x13d/0x1d6
>     [<ffffffff82684a8e>] kernel_init+0xe/0xf0
>     [<ffffffff826909d2>] ret_from_fork+0x42/0x70
>     [<ffffffffffffffff>] 0xffffffffffffffff
> unreferenced object 0xffff880402b6ee00 (size 32):
>   comm "swapper/0", pid 1, jiffies 4294672400 (age 315.157s)
>   hex dump (first 32 bytes):
>     20 ee b6 02 04 88 ff ff 88 fd ab fa 03 88 ff ff   ...............
>     00 80 f3 dc 00 00 00 00 00 60 a9 dd 00 00 00 00  .........`......
>   backtrace:
>     [<ffffffff82195c33>] create_object+0x103/0x2c0
>     [<ffffffff826868b2>] kmemleak_alloc+0x82/0xc0
>     [<ffffffff8218248b>] kmem_cache_alloc_trace+0x17b/0x210
>     [<ffffffff8241a6fa>] apei_res_add+0x19a/0x200
>     [<ffffffff8241a81a>] apei_get_res_callback+0x1a/0x20
>     [<ffffffff823d0f8b>] acpi_nvs_for_each_region+0x2b/0x50
>     [<ffffffff8241ae95>] apei_resources_request+0x95/0x380
>     [<ffffffff82afe23e>] erst_init+0xe2/0x3e5
>     [<ffffffff820004bd>] do_one_initcall+0x19d/0x1d0
>     [<ffffffff82ac1152>] kernel_init_freeable+0x13d/0x1d6
>     [<ffffffff82684a8e>] kernel_init+0xe/0xf0
>     [<ffffffff826909d2>] ret_from_fork+0x42/0x70
>     [<ffffffffffffffff>] 0xffffffffffffffff
> unreferenced object 0xffff880402b6ede0 (size 32):
>   comm "swapper/0", pid 1, jiffies 4294672863 (age 314.698s)
>   hex dump (first 32 bytes):
>     a8 fd ab fa 03 88 ff ff a8 fd ab fa 03 88 ff ff  ................
>     00 00 00 f8 00 00 00 00 00 00 00 fc 00 00 00 00  ................
>   backtrace:
>     [<ffffffff82195c33>] create_object+0x103/0x2c0
>     [<ffffffff826868b2>] kmemleak_alloc+0x82/0xc0
>     [<ffffffff8218248b>] kmem_cache_alloc_trace+0x17b/0x210
>     [<ffffffff8241a6fa>] apei_res_add+0x19a/0x200
>     [<ffffffff8241a81a>] apei_get_res_callback+0x1a/0x20
>     [<ffffffff82582d61>] pci_mmcfg_for_each_region+0x51/0x60
>     [<ffffffff8241b14a>] apei_resources_request+0x34a/0x380
>     [<ffffffff82afe23e>] erst_init+0xe2/0x3e5
>     [<ffffffff820004bd>] do_one_initcall+0x19d/0x1d0
>     [<ffffffff82ac1152>] kernel_init_freeable+0x13d/0x1d6
>     [<ffffffff82684a8e>] kernel_init+0xe/0xf0
>     [<ffffffff826909d2>] ret_from_fork+0x42/0x70
>     [<ffffffffffffffff>] 0xffffffffffffffff
> 
> The issue has been reported a handful of times upstream. Here is one of the previous
> reports: https://lkml.org/lkml/2013/8/11/149
> 
> This series resolves the reported leaks and kmemleak is clean with these patches applied.
> 
> Changes from v1 as per Gong Chen's comments:
> 	* Use existing apei_resources_fini calls to do the cleanup
> 	* Update changelog in erst_init patch
> 
> Joshua Hunt (2):
>   ACPI, APEI: Fix leaked resources
>   ACPI, APEI, ERST: Fixed leaked resources in erst_init
> 
>  drivers/acpi/apei/apei-base.c |    6 ++++--
>  drivers/acpi/apei/erst.c      |    3 +++
>  2 files changed, 7 insertions(+), 2 deletions(-)

Tony, Boris, should I apply these?

Rafael

