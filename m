From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: BUG: 2.6.24-rc5-mm1 -
 pci-disable-decoding-during-sizing-of-bars.patch -- list_add corruption.
 prev->next should be next (dfe221f0), but was dfe22100. (prev=dfe221f0).
Date: Thu, 13 Dec 2007 22:15:53 -0800
Message-ID: <20071213221553.01f35d22.akpm@linux-foundation.org>
References: <a44ae5cd0712132200u759df830i24e6d277e27aecfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:58384 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754924AbXLNGQK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Dec 2007 01:16:10 -0500
In-Reply-To: <a44ae5cd0712132200u759df830i24e6d277e27aecfc@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Miles Lane <miles.lane@gmail.com>
Cc: linux-acpi@vger.kernel.org, rui.zhang@intel.com, "Brown, Len" <len.brown@intel.com>, Dmitry Torokhov <dtor@mail.ru>, Frank Seidel <fseidel@suse.de>

On Fri, 14 Dec 2007 01:00:19 -0500 "Miles Lane" <miles.lane@gmail.com> wrote:

> I first hit this BUG with straight 2.6.24-rc5-mm1, and then reproduced
> it with the pci-disable-decoding-during-sizing-of-bars patch removed.
> 
> hda_intel: azx_get_response timeout, switching to polling mode: last
> cmd=0x00bf000c
> lp: driver loaded but no devices found
> Adding 570268k swap on /dev/sda5.  Priority:-1 extents:1 across:570268k
> EXT3 FS on sda3, internal journal
> list_add corruption. prev->next should be next (dfe221f0), but was
> dfe22100. (prev=dfe221f0).
> BUG: using smp_processor_id() in preemptible [00000001] code: modprobe/3107
> caller is die+0x5d/0x1db
> Pid: 3107, comm: modprobe Not tainted 2.6.24-rc5-mm1 #24
>  [<c0108eb2>] show_trace_log_lvl+0x12/0x25
>  [<c0109659>] show_trace+0xd/0x10
>  [<c0109981>] dump_stack+0x57/0x5f
>  [<c02017f5>] debug_smp_processor_id+0x99/0xb0
>  [<c0109174>] die+0x5d/0x1db
>  [<c03cdf38>] do_trap+0x8a/0xa3
>  [<c0109509>] do_invalid_op+0x6c/0x76
>  [<c03cdd02>] error_code+0x72/0x78
>  [<f8a446c7>] acpi_video_bus_add+0x85b/0xbf4 [video]
>  [<c023b3cf>] acpi_device_probe+0x3e/0xdb
>  [<c02725cd>] driver_probe_device+0xaf/0x12a
>  [<c0272760>] __driver_attach+0x6c/0xa5
>  [<c0271b27>] bus_for_each_dev+0x3e/0x60
>  [<c0272455>] driver_attach+0x14/0x16
>  [<c0272279>] bus_add_driver+0xa9/0x1b0
>  [<c0272957>] driver_register+0x47/0xa3
>  [<c023b748>] acpi_bus_register_driver+0x3a/0x3c
>  [<f8a1d032>] acpi_video_init+0x32/0x51 [video]
>  [<c014eafb>] sys_init_module+0x142b/0x14f4
>  [<c0107cea>] sysenter_past_esp+0x6b/0xc1

The above is a silly debugging thing - it's a missed
raw_smp_processor_id().  Fix appended.

>  =======================
> ------------[ cut here ]------------
> kernel BUG at lib/list_debug.c:33!
> invalid opcode: 0000 [#1] PREEMPT SMP
> last sysfs file: /sys/class/vc/vcsa6/dev
> Modules linked in: video backlight output dm_crypt sbp2 parport_pc lp
> parport arc4 ecb crypto_blkcipher cryptomgr snd_hda_intel
> crypto_algapi snd_pcm_oss snd_mixer_oss snd_pcm snd_seq_dummy
> snd_seq_oss pcmcia snd_seq_midi snd_rawmidi iwl3945 snd_seq_midi_event
> snd_seq sky2 mac80211 tifm_7xx1 snd_timer snd_seq_device tifm_core
> cfg80211 iTCO_wdt iTCO_vendor_support yenta_socket rsrc_nonstatic
> pcmcia_core snd watchdog_core soundcore watchdog_dev shpchp
> pci_hotplug snd_page_alloc ata_generic firewire_ohci piix
> firewire_core crc_itu_t ide_core
> 
> Pid: 3107, comm: modprobe Not tainted (2.6.24-rc5-mm1 #24)
> BUG: using smp_processor_id() in preemptible [00000001] code: modprobe/3107
> caller is __show_registers+0x8d/0x1af
> Pid: 3107, comm: modprobe Not tainted 2.6.24-rc5-mm1 #24
>  [<c0108eb2>] show_trace_log_lvl+0x12/0x25
>  [<c0109659>] show_trace+0xd/0x10
>  [<c0109981>] dump_stack+0x57/0x5f
>  [<c02017f5>] debug_smp_processor_id+0x99/0xb0
>  [<c0106358>] __show_registers+0x8d/0x1af
>  [<c0108f73>] show_registers+0x19/0x1bd
>  [<c010922e>] die+0x117/0x1db
>  [<c03cdf38>] do_trap+0x8a/0xa3
>  [<c0109509>] do_invalid_op+0x6c/0x76
>  [<c03cdd02>] error_code+0x72/0x78
>  [<f8a446c7>] acpi_video_bus_add+0x85b/0xbf4 [video]
>  [<c023b3cf>] acpi_device_probe+0x3e/0xdb
>  [<c02725cd>] driver_probe_device+0xaf/0x12a
>  [<c0272760>] __driver_attach+0x6c/0xa5
>  [<c0271b27>] bus_for_each_dev+0x3e/0x60
>  [<c0272455>] driver_attach+0x14/0x16
>  [<c0272279>] bus_add_driver+0xa9/0x1b0
>  [<c0272957>] driver_register+0x47/0xa3
>  [<c023b748>] acpi_bus_register_driver+0x3a/0x3c
>  [<f8a1d032>] acpi_video_init+0x32/0x51 [video]
>  [<c014eafb>] sys_init_module+0x142b/0x14f4
>  [<c0107cea>] sysenter_past_esp+0x6b/0xc1
>  =======================
> EIP: 0060:[<c0201893>] EFLAGS: 00010246 CPU: 0
> EIP is at __list_add+0x34/0x4a


Well, that's a list_head handling bug in drivers/acpi/video.c.

	list_add_tail(&data->entry, &video->video_device_list);

went bad..










From: Andrew Morton <akpm@linux-foundation.org>

We missed one:

BUG: using smp_processor_id() in preemptible [00000001] code: modprobe/3107
caller is die+0x5d/0x1db
Pid: 3107, comm: modprobe Not tainted 2.6.24-rc5-mm1 #24
 [<c0108eb2>] show_trace_log_lvl+0x12/0x25
 [<c0109659>] show_trace+0xd/0x10
 [<c0109981>] dump_stack+0x57/0x5f
 [<c02017f5>] debug_smp_processor_id+0x99/0xb0
 [<c0109174>] die+0x5d/0x1db
 [<c03cdf38>] do_trap+0x8a/0xa3
 [<c0109509>] do_invalid_op+0x6c/0x76
 [<c03cdd02>] error_code+0x72/0x78
 [<f8a446c7>] acpi_video_bus_add+0x85b/0xbf4 [video]
 [<c023b3cf>] acpi_device_probe+0x3e/0xdb

Convert the other debugging smp_processor_id() calls in there too - perhaps
they are also callable under conditions where preemption is thought to be
enabled.

"Miles Lane" <miles.lane@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/x86/kernel/traps_32.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -puN arch/x86/kernel/traps_32.c~a arch/x86/kernel/traps_32.c
--- a/arch/x86/kernel/traps_32.c~a
+++ a/arch/x86/kernel/traps_32.c
@@ -375,7 +375,7 @@ void die(const char * str, struct pt_reg
 		console_verbose();
 		__raw_spin_lock(&die.lock);
 		raw_local_save_flags(flags);
-		die.lock_owner = smp_processor_id();
+		die.lock_owner = raw_smp_processor_id();
 		die.lock_owner_depth = 0;
 		bust_spinlocks(1);
 	}
@@ -634,7 +634,7 @@ static __kprobes void
 mem_parity_error(unsigned char reason, struct pt_regs * regs)
 {
 	printk(KERN_EMERG "Uhhuh. NMI received for unknown reason %02x on "
-		"CPU %d.\n", reason, smp_processor_id());
+		"CPU %d.\n", reason, raw_smp_processor_id());
 	printk(KERN_EMERG "You have some hardware problem, likely on the PCI bus.\n");
 
 #if defined(CONFIG_EDAC)
@@ -682,7 +682,7 @@ unknown_nmi_error(unsigned char reason, 
 	}
 #endif
 	printk(KERN_EMERG "Uhhuh. NMI received for unknown reason %02x on "
-		"CPU %d.\n", reason, smp_processor_id());
+		"CPU %d.\n", reason, raw_smp_processor_id());
 	printk(KERN_EMERG "Do you have a strange power saving mode enabled?\n");
 	if (panic_on_unrecovered_nmi)
                 panic("NMI: Not continuing");
@@ -706,7 +706,7 @@ void __kprobes die_nmi(struct pt_regs *r
 	bust_spinlocks(1);
 	printk(KERN_EMERG "%s", msg);
 	printk(" on CPU%d, eip %08lx, registers:\n",
-		smp_processor_id(), regs->eip);
+		raw_smp_processor_id(), regs->eip);
 	show_registers(regs);
 	console_silent();
 	spin_unlock(&nmi_print_lock);
_

