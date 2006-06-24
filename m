From: akpm@osdl.org
Subject: - git-acpi-ia64-build-fix.patch removed from -mm tree
Date: Fri, 23 Jun 2006 22:09:13 -0700
Message-ID: <200606240509.k5O59DNV012605@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:58061 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932775AbWFXFJR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Jun 2006 01:09:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org, len.brown@intel.com, linux-acpi@vger.kernel.org, tony.luck@intel.com, mm-commits@vger.kernel.org


The patch titled

     git-acpi: ia64 build fix

has been removed from the -mm tree.  Its filename is

     git-acpi-ia64-build-fix.patch

This patch was dropped because it was merged into mainline or a subsystem tree

------------------------------------------------------
Subject: git-acpi: ia64 build fix
From: Andrew Morton <akpm@osdl.org>


arch/ia64/kernel/acpi.c: In function `acpi_parse_fadt':
arch/ia64/kernel/acpi.c:672: error: dereferencing pointer to incomplete type
arch/ia64/kernel/acpi.c:675: error: dereferencing pointer to incomplete type
arch/ia64/kernel/acpi.c:678: error: dereferencing pointer to incomplete type

Cc: "Brown, Len" <len.brown@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>
Cc: <linux-acpi@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ia64/kernel/acpi.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/ia64/kernel/acpi.c~git-acpi-ia64-build-fix arch/ia64/kernel/acpi.c
--- a/arch/ia64/kernel/acpi.c~git-acpi-ia64-build-fix
+++ a/arch/ia64/kernel/acpi.c
@@ -658,7 +658,7 @@ EXPORT_SYMBOL(acpi_unregister_gsi);
 static int __init acpi_parse_fadt(unsigned long phys_addr, unsigned long size)
 {
 	struct acpi_table_header *fadt_header;
-	struct fadt_descriptor_rev2 *fadt;
+	struct fadt_descriptor *fadt;
 
 	if (!phys_addr || !size)
 		return -EINVAL;
@@ -667,7 +667,7 @@ static int __init acpi_parse_fadt(unsign
 	if (fadt_header->revision != 3)
 		return -ENODEV;	/* Only deal with ACPI 2.0 FADT */
 
-	fadt = (struct fadt_descriptor_rev2 *)fadt_header;
+	fadt = (struct fadt_descriptor *)fadt_header;
 
 	if (!(fadt->iapc_boot_arch & BAF_8042_KEYBOARD_CONTROLLER))
 		acpi_kbd_controller_present = 0;
_

Patches currently in -mm which might be from akpm@osdl.org are

origin.patch
disable-debugging-version-of-write_lock.patch
acpi-update-asus_acpi-driver-registration-fix.patch
catch-notification-of-memory-add-event-of-acpi-via-container-driver-register-start-func-for-memory-device.patch
catch-notification-of-memory-add-event-of-acpi-via-container-driveravoid-redundant-call-add_memory.patch
remove-for_each_cpu.patch
sony_apci-resume.patch
git-agpgart.patch
kauditd_thread-warning-fix.patch
git-cifs.patch
git-dvb.patch
tea575x-tuner-build-fix.patch
git-dvb-versus-matroxfb.patch
git-dvb-printk-warning-fix.patch
i2c-801-64bit-resource-fix.patch
git-gfs2.patch
gfs2-get_sb_dev-fix.patch
git-input.patch
git-kbuild.patch
revert-sparc-build-breakage.patch
git-klibc.patch
git-klibc-fixup.patch
git-hdrcleanup-vs-git-klibc-on-ia64.patch
git-hdrcleanup-vs-git-klibc-on-ia64-2.patch
git-hdrinstall-fixup.patch
libata-reduce-timeouts.patch
libatah-needs-scatterlisth.patch
sata-is-bust-on-s390.patch
forcedeth-typecast-cleanup.patch
s2io-driver-irq-fix-tidy.patch
atm-mpcc-warning-fix.patch
git-pcmcia-fixup.patch
git-sas.patch
serial-8250-sysrq-deadlock-fix.patch
revert-gregkh-pci-pci-test-that-drivers-properly-call-pci_set_master.patch
64-bit-resources-lose-some-ifdefs.patch
clear-abnormal-poweroff-flag-on-via-southbridges-fix-resume-fix.patch
areca-raid-linux-scsi-driver.patch
git-scsi-target-fixup.patch
usb-move-linux-usb_input.h-to-linux-usb-input-fix.patch
ipaqc-timing-parameters-fix.patch
git-supertrak-fixup.patch
revert-x86_64-mm-twofish-cipher---x86_64-assembler.patch
revert-x86_64-mm-twofish-cipher---i586-assembler.patch
revert-x86_64-mm-twofish-cipher---priority-fix.patch
revert-x86_64-mm-twofish-cipher---split-out-common-c-code.patch
x86_64-mm-moving-phys_proc_id-and-cpu_core_id-to-cpuinfo_x86-warning-fix.patch
pgdat-allocation-for-new-node-add-export-kswapd-start-func-fix.patch
adix-tree-rcu-lockless-readside-update-tidy.patch
zoned-vm-counters-create-vmstatc-h-from-page_allocc-h-s390-fix.patch
zoned-vm-counters-create-vmstatc-h-from-page_allocc-h-fix.patch
zoned-vm-counters-basic-zvc-zoned-vm-counter-implementation-tidy.patch
zoned-vm-counters-convert-nr_mapped-to-per-zone-counter-fix.patch
zoned-vm-counters-remove-nr_file_mapped-from-scan-control-structure-fix.patch
zoned-vm-counters-conversion-of-nr_slab-to-per-zone-counter-fix.patch
zoned-vm-counters-conversion-of-nr_pagetables-to-per-zone-counter-fix.patch
zoned-vm-counters-conversion-of-nr_dirty-to-per-zone-counter-fix.patch
zoned-vm-counters-conversion-of-nr_writeback-to-per-zone-counter.patch
zoned-vm-counters-conversion-of-nr_writeback-to-per-zone-counter-fix.patch
zoned-vm-counters-conversion-of-nr_unstable-to-per-zone-counter-fix.patch
zoned-vm-counters-conversion-of-nr_bounce-to-per-zone-counter.patch
zoned-vm-counters-conversion-of-nr_bounce-to-per-zone-counter-fix.patch
zoned-vm-counters-remove-read_page_state.patch
acx1xx-wireless-driver.patch
tiacx-pci-build-fix.patch
tiacx-ia64-fix.patch
i386-moving-phys_proc_id-and-cpu_core_id-to-cpuinfo_x86-warning-fix.patch
cpu_relax-smpbootc-fix.patch
vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-tidy.patch
vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-arch_vma_name-fix.patch
vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-vs-x86_64-mm-reliable-stack-trace-support-i386.patch
vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-vs-x86_64-mm-reliable-stack-trace-support-i386-2.patch
vdso-randomize-the-i386-vdso-by-moving-it-into-a-vma-vs-x86_64-mm-reliable-stack-trace-support-i386-2-revert-maxmem-change.patch
rewritten-backlight-infrastructure-for-portable-apple-computers-fix.patch
deprecate-smbfs-in-favour-of-cifs.patch
ufs-printk-warning-fixes.patch
msnd-section-fix.patch
openpromfs-factorize-out-tidy.patch
add-driver-for-arm-amba-pl031-rtc-fix.patch
add-export_unused_symbol-and-export_unused_symbol_gpl-default.patch
kernel-sysc-cleanups-fix.patch
cpqarray-section-fix.patch
pdflush-handle-resume-wakeups.patch
schedule_on_each_cpu-reduce-kmalloc-size.patch
load_module-cleanup.patch
ax88796-parallel-port-driver-build-fix.patch
for_each_cpu_mask-warning-fix.patch
add-max6902-rtc-support-tidy.patch
add-v3020-rtc-support-tidy.patch
at91rm9200-rtc-driver-tidy.patch
readahead-backoff-on-i-o-error-tweaks.patch
cyclades-cleanup-cleanup.patch
fuse-add-control-filesystem-get_sb_single-fix.patch
fuse-add-control-filesystem-printk-fix.patch
kthread-update-loopc-to-use-kthread-fix.patch
kthread-convert-smbiod-tidy.patch
kthread-convert-stop_machine-into-a-kthread.patch
fix-bounds-check-in-vsnprintf-to-allow-for-a-0-size-and-tidy.patch
irda-usb-printk-fix.patch
reiserfs-on-demand-bitmap-loading-fix.patch
per-task-delay-accounting-proc-export-of-aggregated-block-i-o-delays-warning-fix.patch
add-via-hw-rng-driver-fix.patch
add-bcm43xx-hw-rng-support-locking-update.patch
hangcheck-remove-monotomic_clock-on-x86.patch
sched-fix-smt-nice-lock-contention-and-optimization-tidy.patch
swap_prefetch-vs-zoned-counters.patch
pi-futex-rt-mutex-tester-fix.patch
mark-address_space_operations-const-vs-ecryptfs-mmap-operations.patch
ecryptfs-alpha-build-fix.patch
ecryptfs-more-elegant-aes-key-size-manipulation-tidy.patch
ecryptfs-get_sb_dev-fix.patch
namespaces-add-nsproxy-dont-include-compileh.patch
namespaces-utsname-switch-to-using-uts-namespaces-alpha-fix.patch
namespaces-utsname-use-init_utsname-when-appropriate-cifs-update.patch
namespaces-utsname-implement-utsname-namespaces-export.patch
namespaces-utsname-implement-utsname-namespaces-dont-include-compileh.patch
namespaces-utsname-sysctl-hack-cleanup-2-fix.patch
ipc-namespace-core-fix.patch
task-watchers-task-watchers-tidy.patch
task-watchers-add-support-for-per-task-watchers-warning-fix.patch
readahead-sysctl-parameters-fix.patch
make-copy_from_user_inatomic-not-zero-the-tail-on-i386-vs-reiser4.patch
reiser4-hardirq-include-fix.patch
reiser4-run-truncate_inode_pages-in-reiser4_delete_inode.patch
reiser4-get_sb_dev-fix.patch
reiser4-vs-zoned-allocator.patch
ide_dma_speed-fixes-warning-fix.patch
ide_dma_speed-fixes-tidy.patch
hpt3xx-rework-rate-filtering-tidy.patch
hpt370-clean-up-dma-timeout-handling-cleanup.patch
savagefb-add-state-save-and_restore-hooks-tidy.patch
au1100fb-add-power-management-support-tidy.patch
vt-binding-add-sysfs-control-to-the-vt-layer-fix.patch
lib-add-idr_replace-tidy.patch
genirq-rename-desc-handler-to-desc-chip-power-fix.patch
genirq-rename-desc-handler-to-desc-chip-ia64-fix.patch
genirq-rename-desc-handler-to-desc-chip-ia64-fix-2.patch
genirq-rename-desc-handler-to-desc-chip-terminate_irqs-fix.patch
genirq-convert-the-i386-architecture-to-irq-chips-fix-2.patch
genirq-ia64-build-fix.patch
genirq-msi-simplify-msi-enable-and-disable-fix.patch
genirq-i386-irq-remove-the-msi-assumption-that-irq-==-vector-fix-tidies.patch
lock-validator-beautify-x86_64-stacktraces-fix.patch
lock-validator-beautify-x86_64-stacktraces-fix-4.patch
lock-validator-stacktrace-build-fix.patch
lock-validator-stacktrace-warning-fix.patch
lock-validator-irqtrace-core-powerpc-fix-1.patch
lock-validator-irqtrace-core-non-x86-fix.patch
lock-validator-irqtrace-core-non-x86-fix-2.patch
lock-validator-irqtrace-core-non-x86-fix-3.patch
lock-validator-add-per_cpu_offset-fix.patch
lock-validator-core-multichar-fix.patch
lock-validator-prove-rwsem-locking-correctness-fix.patch
lock-validator-prove-rwsem-locking-correctness-powerpc-fix.patch
lock-validator-special-locking-serial-fix.patch
lock-validator-special-locking-af_unix-undo-af_unix-_bh-locking-changes-and-split-lock-type-fix.patch
lock-validator-special-locking-sb-s_umount-fix.patch
lock-validator-enable-lock-validator-in-kconfig-not-yet.patch
lockdep-x86-only.patch
lockdep-really-x86-only.patch
lockdep-really-really-x86-only.patch
lockdep-hack-around-build-errors.patch
kgdb-core-lite-add-reboot-command.patch
kgdb-8250-fix.patch
nr_blockdev_pages-in_interrupt-warning.patch
device-suspend-debug.patch
revert-tty-buffering-comment-out-debug-code.patch
slab-leaks3-default-y.patch
x86-kmap_atomic-debugging.patch

