From: Florian Zumbiehl <florz@florz.de>
Subject: BUG: scheduling while atomic in acpi_idle_enter_bm
Date: Tue, 22 Dec 2009 03:20:41 +0100
Message-ID: <20091222022041.GA9172@florz.florz.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rain.florz.de ([62.216.164.86]:34619 "EHLO
	rain.florz.dyndns.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751155AbZLVCUo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Dec 2009 21:20:44 -0500
Received: from florz.florz.dyndns.org ([192.168.0.121])
	by rain.florz.dyndns.org with esmtp (Exim 4.63)
	(envelope-from <florz@florz.de>)
	id 1NMuMc-0005hx-4s
	for linux-acpi@vger.kernel.org; Tue, 22 Dec 2009 03:20:42 +0100
Received: from florz by florz.florz.dyndns.org with local (Exim 4.69)
	(envelope-from <florz@florz.de>)
	id 1NMuMb-0002Rp-VI
	for linux-acpi@vger.kernel.org; Tue, 22 Dec 2009 03:20:41 +0100
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I just got this BUG which I don't know how to reproduce or actually
anything much more than that this appeared on my console:

| [ 5370.392297] BUG: scheduling while atomic: swapper/0/0x10000100
| [ 5370.392440] Modules linked in: ppp_deflate zlib_deflate bsd_comp ppp_async ppp_generic slhc nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 x_tables nf_conntrack arc4 ecb rtl8187 mac80211 cfg80211 eeprom_93cx6 ircomm_tty ircomm ipv6 loop thinkpad_acpi backlight snd_cs46xx mousedev led_class pcmcia snd_rawmidi nsc_ircc snd_ac97_codec nvram battery ac ac97_bus irda snd_pcm parport_pc snd_timer parport crc_ccitt serio_raw processor snd button yenta_socket soundcore psmouse rsrc_nonstatic evdev intel_agp snd_page_alloc pcmcia_core agpgart aes_i586 aes_generic dm_crypt dm_snapshot dm_mod uhci_hcd usbcore nls_base e100 mii thermal fan thermal_sys hwmon xts gf128mul [last unloaded: ipt_MASQUERADE]
| [ 5370.393226]
| [ 5370.393226] Pid: 0, comm: swapper Not tainted (2.6.32 #20) 264784G
| [ 5370.393226] EIP: 0060:[<d88ed16f>] EFLAGS: 00000282 CPU: 0
| [ 5370.393226] EIP is at acpi_idle_enter_simple+0xe6/0x11a [processor]
| [ 5370.393226] EAX: c12a3f94 EBX: 0000000a ECX: 00000000 EDX: 000004e2
| [ 5370.393226] ESI: 00000000 EDI: 00000003 EBP: 00000000 ESP: c12a3f94
| [ 5370.393226]  DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
| [ 5370.393226] CR0: 8005003b CR2: b7704f20 CR3: 16173000 CR4: 000006d0
| [ 5370.393226] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
| [ 5370.393226] DR6: ffff0ff0 DR7: 00000400
| [ 5370.393226] Call Trace:
| [ 5370.393226]  [<d88ecf3a>] ? acpi_idle_enter_bm+0xc0/0x20f [processor]
| [ 5370.393226]  [<c119207b>] ? cpuidle_idle_call+0x7b/0xd0
| [ 5370.393226]  [<c1001f3c>] ? cpu_idle+0x3c/0x60
| [ 5370.393226]  [<c12d473d>] ? start_kernel+0x277/0x2d8
| [ 5370.393226]  [<c12d42b0>] ? unknown_bootoption+0x0/0x1c7

I thought you might be interested ...

Florian
