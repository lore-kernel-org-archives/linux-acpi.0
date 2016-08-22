From: Dmitry Vyukov <dvyukov@google.com>
Subject: acpi: out-of-bounds access in acpi_ds_create_operand
Date: Sun, 21 Aug 2016 21:39:46 -0700
Message-ID: <CACT4Y+YbQqP5Xj0zJcUiRoO2BY-JD2VssWLPqLCd04Z+fS2cYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robert.moore@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, LKML <linux-kernel@vger.kernel.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>
List-Id: linux-acpi@vger.kernel.org

Hello,

I am booting a kernel with CONFIG_UBSAN and during boot I see the
following error message:

================================================================================
UBSAN: Undefined behaviour in drivers/acpi/acpica/dsutils.c:641:16
index -1 is out of range for type 'acpi_operand_object *[9]'
CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.8.0-rc2+ #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
 0000000000000000 ffff88006bcd7308 ffffffff81db32c0 0000000041b58ab3
 ffffffff83e0a194 ffffffff81db31c0 ffff88006bcd7330 ffff88006bcd72d0
 0000000000000000 ffffffff85181560 0000000000000001 ffff88006bcd7398
Call Trace:
 [<     inline     >] __dump_stack lib/dump_stack.c:15
 [<ffffffff81db32c0>] dump_stack+0x100/0x180 lib/dump_stack.c:51
 [<ffffffff81e643f0>] ubsan_epilogue+0x12/0x8f lib/ubsan.c:164
 [<ffffffff81e65673>] __ubsan_handle_out_of_bounds+0x164/0x19c lib/ubsan.c:382
 [<ffffffff81f8e007>] acpi_ds_create_operand+0x6d9/0x7fa
drivers/acpi/acpica/dsutils.c:641
 [<ffffffff81f8e41a>] acpi_ds_create_operands+0x2f2/0x37c
drivers/acpi/acpica/dsutils.c:751
 [<ffffffff81f8fc49>] acpi_ds_exec_end_op+0x941/0xed4
drivers/acpi/acpica/dswexec.c:529
 [<ffffffff81fce3f4>] acpi_ps_parse_loop+0x156a/0x1620
drivers/acpi/acpica/psloop.c:609
 [<ffffffff81fd137a>] acpi_ps_parse_aml+0x266/0x83a
drivers/acpi/acpica/psparse.c:508
 [<ffffffff81fd34e2>] acpi_ps_execute_method+0x58c/0x5fb
drivers/acpi/acpica/psxface.c:221
 [<ffffffff81fbeed8>] acpi_ns_evaluate+0x706/0x91f
drivers/acpi/acpica/nseval.c:238
 [<ffffffff81fc8ad5>] acpi_evaluate_object+0x3dd/0x7e7
drivers/acpi/acpica/nsxfeval.c:366
 [<     inline     >] map_mat_entry drivers/acpi/processor_core.c:173
 [<ffffffff81f6b17d>] acpi_get_phys_id+0xbb/0x5be
drivers/acpi/processor_core.c:204
 [<ffffffff81f6b885>] acpi_get_cpuid+0x25/0x33 drivers/acpi/processor_core.c:261
 [<     inline     >] processor_physically_present
drivers/acpi/processor_pdc.c:53
 [<ffffffff869402c4>] early_init_pdc+0x156/0x198
drivers/acpi/processor_pdc.c:161
 [<ffffffff81fc8538>] acpi_ns_walk_namespace+0x216/0x38f
drivers/acpi/acpica/nswalk.c:270
 [<ffffffff81fc909e>] acpi_walk_namespace+0xb5/0xef
drivers/acpi/acpica/nsxfeval.c:618
 [<ffffffff8694033b>] acpi_early_processor_set_pdc+0x35/0x4f
drivers/acpi/processor_pdc.c:199
 [<     inline     >] acpi_bus_init drivers/acpi/bus.c:1116
 [<ffffffff8693ea58>] acpi_init+0x339/0x61e drivers/acpi/bus.c:1182
 [<ffffffff81000586>] do_one_initcall+0xb6/0x2b0 init/main.c:778
 [<     inline     >] do_initcall_level init/main.c:843
 [<     inline     >] do_initcalls init/main.c:851
 [<     inline     >] do_basic_setup init/main.c:869
 [<ffffffff868ad23e>] kernel_init_freeable+0x5d5/0x69c init/main.c:1016
 [<ffffffff837496d3>] kernel_init+0x13/0x1b0 init/main.c:942
 [<ffffffff8376056f>] ret_from_fork+0x1f/0x40 arch/x86/entry/entry_64.S:393
================================================================================


I am on 6040e57658eee6eb1315a26119101ca832d1f854 (Aug 19).
Config is defconfig+kvmconfig + the following configs (but that's
probably irrelevant):

CONFIG_KCOV=y
CONFIG_KCOV_INSTRUMENT_ALL=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_INFO=y
CONFIG_KALLSYMS=y
CONFIG_KASAN=y
CONFIG_KASAN_INLINE=y
CONFIG_UBSAN=y
CONFIG_UBSAN_SANITIZE_ALL=y
CONFIG_DEBUG_KMEMLEAK=y
CONFIG_PROVE_RCU=y
CONFIG_DEBUG_STRICT_USER_COPY_CHECKS=y
CONFIG_LOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HUNG_TASK_PANIC=y
CONFIG_DETECT_HUNG_TASK=y
CONFIG_WQ_WATCHDOG=y
CONFIG_PROVE_LOCKING=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_DEBUG_LIST=y
CONFIG_DEBUG_PI_LIST=y

I boot kernel as:
$ qemu-system-x86_64 -m 2048 -net nic -net user -display none -serial
stdio -no-reboot -enable-kvm -smp 2 -kernel arch/x86/boot/bzImage
-append "console=ttyS0 root=/dev/sda debug earlyprintk=serial
slub_debug=UZ rootfstype=9p root=/dev/root
rootflags=trans=virtio,version=9p2000.L,cache=loose
init=/init-syzkaller.sh" -fsdev
local,id=fsdev0,path=/,security_model=none -device
virtio-9p-pci,fsdev=fsdev0,mount_tag=/dev/root
