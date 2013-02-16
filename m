From: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: linux-3.7.4: multiple thermal cpu throttling or cpu enable/disable
 kmemleaks
Date: Sat, 16 Feb 2013 17:37:09 +0100
Message-ID: <511FB5B5.50003@fold.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fold.natur.cuni.cz ([195.113.57.32]:54392 "HELO
	fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753521Ab3BPQhM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 Feb 2013 11:37:12 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bob Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

Hi,
  I am running 3.7.4 kernel and sometimes enable or disable one of my two physical cores.
I have disabled hyperthreading altogether in kernel. This is a dual-core i7 laptop processor.
I see the lists of kmemleak reported. It looks some are triggered when a core is being disabled,
some when it is being enabled.

Some are probably related to:

[929764.309917] SMP alternatives: lockdep: fixing up alternatives
[929764.309924] smpboot: Booting Node 0 Processor 1 APIC 0x2
[929764.325298] microcode: CPU1 updated to revision 0x28, date = 2012-04-24
[929764.532422] coretemp coretemp.0: TjMax is 100 degrees C
[929810.157687] r8169 0000:05:00.0 eth0: link down
[929810.158065] r8169 0000:05:00.0 eth0: link down
[929811.769364] r8169 0000:05:00.0 eth0: link up
[931461.574353] smpboot: CPU 1 is now offline
[933114.170104] kmemleak: 5 new suspected memory leaks (see /sys/kernel/debug/kmemleak)

[1555829.753514] SMP alternatives: lockdep: fixing up alternatives
[1555829.753518] smpboot: Booting Node 0 Processor 1 APIC 0x2
[1555829.773872] microcode: CPU1 updated to revision 0x28, date = 2012-04-24
[1555829.998056] coretemp coretemp.0: TjMax is 100 degrees C

[1818172.504595] CPU0: Core temperature above threshold, cpu clock throttled (total events = 87)
[1818172.504597] CPU1: Package temperature above threshold, cpu clock throttled (total events = 6140)
[1818172.504601] CPU0: Package temperature above threshold, cpu clock throttled (total events = 6140)
[1818172.505612] CPU0: Core temperature/speed normal
[1818172.505613] CPU1: Package temperature/speed normal
[1818172.505615] CPU0: Package temperature/speed normal
[1829262.359816] CPU1: Core temperature above threshold, cpu clock throttled (total events = 6053)
[1829262.359818] CPU0: Package temperature above threshold, cpu clock throttled (total events = 6146)
[1829262.359821] CPU1: Package temperature above threshold, cpu clock throttled (total events = 6146)
[1829262.360821] CPU1: Core temperature/speed normal
[1829262.360822] CPU0: Package temperature/speed normal
[1829262.360824] CPU1: Package temperature/speed normal

[1897630.149820] smpboot: CPU 1 is now offline
[1897987.037312] SMP alternatives: lockdep: fixing up alternatives
[1897987.037316] smpboot: Booting Node 0 Processor 1 APIC 0x2
[1897987.053809] microcode: CPU1 updated to revision 0x28, date = 2012-04-24
[1897987.311928] coretemp coretemp.0: TjMax is 100 degrees C
[1898649.802554] kmemleak: 5 new suspected memory leaks (see /sys/kernel/debug/kmemleak)


unreferenced object 0xffff88040cec8150 (size 32):
  comm "swapper/0", pid 1, jiffies 4294937512 (age 1908449.050s)
  hex dump (first 32 bytes):
    74 68 65 72 6d 61 6c 5f 74 68 72 6f 74 74 6c 65  thermal_throttle
    00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  .kkkkkkkkkkkkkk.
  backtrace:
    [<ffffffff815b4aad>] kmemleak_alloc+0x21/0x3e
    [<ffffffff81110352>] slab_post_alloc_hook+0x28/0x2a
    [<ffffffff81113fad>] __kmalloc_track_caller+0xf1/0x104
    [<ffffffff810f1202>] kstrdup+0x2c/0x44
    [<ffffffff8116a2fc>] sysfs_new_dirent+0x2e/0x107
    [<ffffffff8116a658>] create_dir+0x32/0xac
    [<ffffffff8116a8c5>] sysfs_create_subdir+0x1a/0x1c
    [<ffffffff8116befa>] internal_create_group+0x93/0x164
    [<ffffffff8116bfec>] sysfs_create_group+0xe/0x10
    [<ffffffff815cd65b>] thermal_throttle_add_dev+0x2e/0xa9
    [<ffffffff819c8e9c>] thermal_throttle_init_device+0x4f/0x9c
    [<ffffffff81000231>] do_one_initcall+0x7a/0x131
    [<ffffffff815b349b>] kernel_init+0x106/0x26d
    [<ffffffff815dd66c>] ret_from_fork+0x7c/0xb0
    [<ffffffffffffffff>] 0xffffffffffffffff
unreferenced object 0xffff88040bfa0930 (size 144):
  comm "swapper/0", pid 1, jiffies 4294937512 (age 1908449.050s)
  hex dump (first 32 bytes):
    03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff815b4aad>] kmemleak_alloc+0x21/0x3e
    [<ffffffff81110352>] slab_post_alloc_hook+0x28/0x2a
    [<ffffffff81112dc3>] kmem_cache_alloc+0xa7/0xb6
    [<ffffffff8116a31c>] sysfs_new_dirent+0x4e/0x107
    [<ffffffff8116a658>] create_dir+0x32/0xac
    [<ffffffff8116a8c5>] sysfs_create_subdir+0x1a/0x1c
    [<ffffffff8116befa>] internal_create_group+0x93/0x164
    [<ffffffff8116bfec>] sysfs_create_group+0xe/0x10
    [<ffffffff815cd65b>] thermal_throttle_add_dev+0x2e/0xa9
    [<ffffffff819c8e9c>] thermal_throttle_init_device+0x4f/0x9c
    [<ffffffff81000231>] do_one_initcall+0x7a/0x131
    [<ffffffff815b349b>] kernel_init+0x106/0x26d
    [<ffffffff815dd66c>] ret_from_fork+0x7c/0xb0
    [<ffffffffffffffff>] 0xffffffffffffffff
unreferenced object 0xffff88040bfa0888 (size 144):
  comm "swapper/0", pid 1, jiffies 4294937512 (age 1908449.050s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 f8 5b 91 81 ff ff ff ff  .........[......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff815b4aad>] kmemleak_alloc+0x21/0x3e
    [<ffffffff81110352>] slab_post_alloc_hook+0x28/0x2a
    [<ffffffff81112dc3>] kmem_cache_alloc+0xa7/0xb6
    [<ffffffff8116a31c>] sysfs_new_dirent+0x4e/0x107
    [<ffffffff81169938>] sysfs_add_file_mode+0x49/0xc7
    [<ffffffff811699c3>] sysfs_add_file+0xd/0xf
    [<ffffffff81169a07>] sysfs_add_file_to_group+0x42/0x57
    [<ffffffff815cd686>] thermal_throttle_add_dev+0x59/0xa9
    [<ffffffff819c8e9c>] thermal_throttle_init_device+0x4f/0x9c
    [<ffffffff81000231>] do_one_initcall+0x7a/0x131
    [<ffffffff815b349b>] kernel_init+0x106/0x26d
    [<ffffffff815dd66c>] ret_from_fork+0x7c/0xb0
    [<ffffffffffffffff>] 0xffffffffffffffff
unreferenced object 0xffff88040bfa0738 (size 144):
  comm "swapper/0", pid 1, jiffies 4294937512 (age 1908449.050s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 28 5c 91 81 ff ff ff ff  ........(\......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff815b4aad>] kmemleak_alloc+0x21/0x3e
    [<ffffffff81110352>] slab_post_alloc_hook+0x28/0x2a
    [<ffffffff81112dc3>] kmem_cache_alloc+0xa7/0xb6
    [<ffffffff8116a31c>] sysfs_new_dirent+0x4e/0x107
    [<ffffffff81169938>] sysfs_add_file_mode+0x49/0xc7
    [<ffffffff811699c3>] sysfs_add_file+0xd/0xf
    [<ffffffff81169a07>] sysfs_add_file_to_group+0x42/0x57
    [<ffffffff815cd6aa>] thermal_throttle_add_dev+0x7d/0xa9
    [<ffffffff819c8e9c>] thermal_throttle_init_device+0x4f/0x9c
    [<ffffffff81000231>] do_one_initcall+0x7a/0x131
    [<ffffffff815b349b>] kernel_init+0x106/0x26d
    [<ffffffff815dd66c>] ret_from_fork+0x7c/0xb0
    [<ffffffffffffffff>] 0xffffffffffffffff
unreferenced object 0xffff88040bfa07e0 (size 144):
  comm "swapper/0", pid 1, jiffies 4294937512 (age 1908449.050s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 58 5c 91 81 ff ff ff ff  ........X\......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff815b4aad>] kmemleak_alloc+0x21/0x3e
    [<ffffffff81110352>] slab_post_alloc_hook+0x28/0x2a
    [<ffffffff81112dc3>] kmem_cache_alloc+0xa7/0xb6
    [<ffffffff8116a31c>] sysfs_new_dirent+0x4e/0x107
    [<ffffffff81169938>] sysfs_add_file_mode+0x49/0xc7
    [<ffffffff811699c3>] sysfs_add_file+0xd/0xf
    [<ffffffff81169a07>] sysfs_add_file_to_group+0x42/0x57
    [<ffffffff815cd6ce>] thermal_throttle_add_dev+0xa1/0xa9
    [<ffffffff819c8e9c>] thermal_throttle_init_device+0x4f/0x9c
    [<ffffffff81000231>] do_one_initcall+0x7a/0x131
    [<ffffffff815b349b>] kernel_init+0x106/0x26d
    [<ffffffff815dd66c>] ret_from_fork+0x7c/0xb0
    [<ffffffffffffffff>] 0xffffffffffffffff
unreferenced object 0xffff8804058b17e0 (size 144):
  comm "bash", pid 4632, jiffies 4388053386 (age 977291.910s)
  hex dump (first 32 bytes):
    03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff815b4aad>] kmemleak_alloc+0x21/0x3e
    [<ffffffff81110352>] slab_post_alloc_hook+0x28/0x2a
    [<ffffffff81112dc3>] kmem_cache_alloc+0xa7/0xb6
    [<ffffffff8116a31c>] sysfs_new_dirent+0x4e/0x107
    [<ffffffff8116a658>] create_dir+0x32/0xac
    [<ffffffff8116a8c5>] sysfs_create_subdir+0x1a/0x1c
    [<ffffffff8116befa>] internal_create_group+0x93/0x164
    [<ffffffff8116bfec>] sysfs_create_group+0xe/0x10
    [<ffffffff815cd65b>] thermal_throttle_add_dev+0x2e/0xa9
    [<ffffffff815cd72b>] thermal_throttle_cpu_callback+0x55/0xc1
    [<ffffffff81094510>] notifier_call_chain+0x32/0x5e
    [<ffffffff8109455b>] __raw_notifier_call_chain+0x9/0xb
    [<ffffffff8107a4af>] __cpu_notify+0x1b/0x2d
    [<ffffffff815cf522>] _cpu_up+0x93/0x131
    [<ffffffff815cf60a>] cpu_up+0x4a/0x57
    [<ffffffff815b6097>] store_online+0x56/0x84
unreferenced object 0xffff8804058b1e70 (size 144):
  comm "bash", pid 4632, jiffies 4388053386 (age 977291.910s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 f8 5b 91 81 ff ff ff ff  .........[......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff815b4aad>] kmemleak_alloc+0x21/0x3e
    [<ffffffff81110352>] slab_post_alloc_hook+0x28/0x2a
    [<ffffffff81112dc3>] kmem_cache_alloc+0xa7/0xb6
    [<ffffffff8116a31c>] sysfs_new_dirent+0x4e/0x107
    [<ffffffff81169938>] sysfs_add_file_mode+0x49/0xc7
    [<ffffffff811699c3>] sysfs_add_file+0xd/0xf
    [<ffffffff81169a07>] sysfs_add_file_to_group+0x42/0x57
    [<ffffffff815cd686>] thermal_throttle_add_dev+0x59/0xa9
    [<ffffffff815cd72b>] thermal_throttle_cpu_callback+0x55/0xc1
    [<ffffffff81094510>] notifier_call_chain+0x32/0x5e
    [<ffffffff8109455b>] __raw_notifier_call_chain+0x9/0xb
    [<ffffffff8107a4af>] __cpu_notify+0x1b/0x2d
    [<ffffffff815cf522>] _cpu_up+0x93/0x131
    [<ffffffff815cf60a>] cpu_up+0x4a/0x57
    [<ffffffff815b6097>] store_online+0x56/0x84
    [<ffffffff81304137>] dev_attr_store+0x1b/0x1d
unreferenced object 0xffff8804058b1498 (size 144):
  comm "bash", pid 4632, jiffies 4388053386 (age 977291.910s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 28 5c 91 81 ff ff ff ff  ........(\......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff815b4aad>] kmemleak_alloc+0x21/0x3e
    [<ffffffff81110352>] slab_post_alloc_hook+0x28/0x2a
    [<ffffffff81112dc3>] kmem_cache_alloc+0xa7/0xb6
    [<ffffffff8116a31c>] sysfs_new_dirent+0x4e/0x107
    [<ffffffff81169938>] sysfs_add_file_mode+0x49/0xc7
    [<ffffffff811699c3>] sysfs_add_file+0xd/0xf
    [<ffffffff81169a07>] sysfs_add_file_to_group+0x42/0x57
    [<ffffffff815cd6aa>] thermal_throttle_add_dev+0x7d/0xa9
    [<ffffffff815cd72b>] thermal_throttle_cpu_callback+0x55/0xc1
    [<ffffffff81094510>] notifier_call_chain+0x32/0x5e
    [<ffffffff8109455b>] __raw_notifier_call_chain+0x9/0xb
    [<ffffffff8107a4af>] __cpu_notify+0x1b/0x2d
    [<ffffffff815cf522>] _cpu_up+0x93/0x131
    [<ffffffff815cf60a>] cpu_up+0x4a/0x57
    [<ffffffff815b6097>] store_online+0x56/0x84
    [<ffffffff81304137>] dev_attr_store+0x1b/0x1d
unreferenced object 0xffff8804058b1d20 (size 144):
  comm "bash", pid 4632, jiffies 4388053386 (age 977291.910s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 58 5c 91 81 ff ff ff ff  ........X\......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff815b4aad>] kmemleak_alloc+0x21/0x3e
    [<ffffffff81110352>] slab_post_alloc_hook+0x28/0x2a
    [<ffffffff81112dc3>] kmem_cache_alloc+0xa7/0xb6
    [<ffffffff8116a31c>] sysfs_new_dirent+0x4e/0x107
    [<ffffffff81169938>] sysfs_add_file_mode+0x49/0xc7
    [<ffffffff811699c3>] sysfs_add_file+0xd/0xf
    [<ffffffff81169a07>] sysfs_add_file_to_group+0x42/0x57
    [<ffffffff815cd6ce>] thermal_throttle_add_dev+0xa1/0xa9
    [<ffffffff815cd72b>] thermal_throttle_cpu_callback+0x55/0xc1
    [<ffffffff81094510>] notifier_call_chain+0x32/0x5e
    [<ffffffff8109455b>] __raw_notifier_call_chain+0x9/0xb
    [<ffffffff8107a4af>] __cpu_notify+0x1b/0x2d
    [<ffffffff815cf522>] _cpu_up+0x93/0x131
    [<ffffffff815cf60a>] cpu_up+0x4a/0x57
    [<ffffffff815b6097>] store_online+0x56/0x84
    [<ffffffff81304137>] dev_attr_store+0x1b/0x1d
unreferenced object 0xffff880391930380 (size 32):
  comm "bash", pid 4632, jiffies 4450753985 (age 350286.200s)
  hex dump (first 32 bytes):
    74 68 65 72 6d 61 6c 5f 74 68 72 6f 74 74 6c 65  thermal_throttle
    00 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  .kkkkkkkkkkkkkk.
  backtrace:
    [<ffffffff815b4aad>] kmemleak_alloc+0x21/0x3e
    [<ffffffff81110352>] slab_post_alloc_hook+0x28/0x2a
    [<ffffffff81113fad>] __kmalloc_track_caller+0xf1/0x104
    [<ffffffff810f1202>] kstrdup+0x2c/0x44
    [<ffffffff8116a2fc>] sysfs_new_dirent+0x2e/0x107
    [<ffffffff8116a658>] create_dir+0x32/0xac
    [<ffffffff8116a8c5>] sysfs_create_subdir+0x1a/0x1c
    [<ffffffff8116befa>] internal_create_group+0x93/0x164
    [<ffffffff8116bfec>] sysfs_create_group+0xe/0x10
    [<ffffffff815cd65b>] thermal_throttle_add_dev+0x2e/0xa9
    [<ffffffff815cd72b>] thermal_throttle_cpu_callback+0x55/0xc1
    [<ffffffff81094510>] notifier_call_chain+0x32/0x5e
    [<ffffffff8109455b>] __raw_notifier_call_chain+0x9/0xb
    [<ffffffff8107a4af>] __cpu_notify+0x1b/0x2d
    [<ffffffff815cf522>] _cpu_up+0x93/0x131
    [<ffffffff815cf60a>] cpu_up+0x4a/0x57
unreferenced object 0xffff88010b21a3f0 (size 144):
  comm "bash", pid 4632, jiffies 4450753985 (age 350286.200s)
  hex dump (first 32 bytes):
    03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff815b4aad>] kmemleak_alloc+0x21/0x3e
    [<ffffffff81110352>] slab_post_alloc_hook+0x28/0x2a
    [<ffffffff81112dc3>] kmem_cache_alloc+0xa7/0xb6
    [<ffffffff8116a31c>] sysfs_new_dirent+0x4e/0x107
    [<ffffffff8116a658>] create_dir+0x32/0xac
    [<ffffffff8116a8c5>] sysfs_create_subdir+0x1a/0x1c
    [<ffffffff8116befa>] internal_create_group+0x93/0x164
    [<ffffffff8116bfec>] sysfs_create_group+0xe/0x10
    [<ffffffff815cd65b>] thermal_throttle_add_dev+0x2e/0xa9
    [<ffffffff815cd72b>] thermal_throttle_cpu_callback+0x55/0xc1
    [<ffffffff81094510>] notifier_call_chain+0x32/0x5e
    [<ffffffff8109455b>] __raw_notifier_call_chain+0x9/0xb
    [<ffffffff8107a4af>] __cpu_notify+0x1b/0x2d
    [<ffffffff815cf522>] _cpu_up+0x93/0x131
    [<ffffffff815cf60a>] cpu_up+0x4a/0x57
    [<ffffffff815b6097>] store_online+0x56/0x84
unreferenced object 0xffff88010b21ad20 (size 144):
  comm "bash", pid 4632, jiffies 4450753985 (age 350286.250s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 f8 5b 91 81 ff ff ff ff  .........[......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff815b4aad>] kmemleak_alloc+0x21/0x3e
    [<ffffffff81110352>] slab_post_alloc_hook+0x28/0x2a
    [<ffffffff81112dc3>] kmem_cache_alloc+0xa7/0xb6
    [<ffffffff8116a31c>] sysfs_new_dirent+0x4e/0x107
    [<ffffffff81169938>] sysfs_add_file_mode+0x49/0xc7
    [<ffffffff811699c3>] sysfs_add_file+0xd/0xf
    [<ffffffff81169a07>] sysfs_add_file_to_group+0x42/0x57
    [<ffffffff815cd686>] thermal_throttle_add_dev+0x59/0xa9
    [<ffffffff815cd72b>] thermal_throttle_cpu_callback+0x55/0xc1
    [<ffffffff81094510>] notifier_call_chain+0x32/0x5e
    [<ffffffff8109455b>] __raw_notifier_call_chain+0x9/0xb
    [<ffffffff8107a4af>] __cpu_notify+0x1b/0x2d
    [<ffffffff815cf522>] _cpu_up+0x93/0x131
    [<ffffffff815cf60a>] cpu_up+0x4a/0x57
    [<ffffffff815b6097>] store_online+0x56/0x84
    [<ffffffff81304137>] dev_attr_store+0x1b/0x1d
unreferenced object 0xffff88010b21aa80 (size 144):
  comm "bash", pid 4632, jiffies 4450753985 (age 350286.250s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 28 5c 91 81 ff ff ff ff  ........(\......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff815b4aad>] kmemleak_alloc+0x21/0x3e
    [<ffffffff81110352>] slab_post_alloc_hook+0x28/0x2a
    [<ffffffff81112dc3>] kmem_cache_alloc+0xa7/0xb6
    [<ffffffff8116a31c>] sysfs_new_dirent+0x4e/0x107
    [<ffffffff81169938>] sysfs_add_file_mode+0x49/0xc7
    [<ffffffff811699c3>] sysfs_add_file+0xd/0xf
    [<ffffffff81169a07>] sysfs_add_file_to_group+0x42/0x57
    [<ffffffff815cd6aa>] thermal_throttle_add_dev+0x7d/0xa9
    [<ffffffff815cd72b>] thermal_throttle_cpu_callback+0x55/0xc1
    [<ffffffff81094510>] notifier_call_chain+0x32/0x5e
    [<ffffffff8109455b>] __raw_notifier_call_chain+0x9/0xb
    [<ffffffff8107a4af>] __cpu_notify+0x1b/0x2d
    [<ffffffff815cf522>] _cpu_up+0x93/0x131
    [<ffffffff815cf60a>] cpu_up+0x4a/0x57
    [<ffffffff815b6097>] store_online+0x56/0x84
    [<ffffffff81304137>] dev_attr_store+0x1b/0x1d
unreferenced object 0xffff88010b21ae70 (size 144):
  comm "bash", pid 4632, jiffies 4450753985 (age 350286.250s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 58 5c 91 81 ff ff ff ff  ........X\......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff815b4aad>] kmemleak_alloc+0x21/0x3e
    [<ffffffff81110352>] slab_post_alloc_hook+0x28/0x2a
    [<ffffffff81112dc3>] kmem_cache_alloc+0xa7/0xb6
    [<ffffffff8116a31c>] sysfs_new_dirent+0x4e/0x107
    [<ffffffff81169938>] sysfs_add_file_mode+0x49/0xc7
    [<ffffffff811699c3>] sysfs_add_file+0xd/0xf
    [<ffffffff81169a07>] sysfs_add_file_to_group+0x42/0x57
    [<ffffffff815cd6ce>] thermal_throttle_add_dev+0xa1/0xa9
    [<ffffffff815cd72b>] thermal_throttle_cpu_callback+0x55/0xc1
    [<ffffffff81094510>] notifier_call_chain+0x32/0x5e
    [<ffffffff8109455b>] __raw_notifier_call_chain+0x9/0xb
    [<ffffffff8107a4af>] __cpu_notify+0x1b/0x2d
    [<ffffffff815cf522>] _cpu_up+0x93/0x131
    [<ffffffff815cf60a>] cpu_up+0x4a/0x57
    [<ffffffff815b6097>] store_online+0x56/0x84
    [<ffffffff81304137>] dev_attr_store+0x1b/0x1d


Hope this helps,
Martin
