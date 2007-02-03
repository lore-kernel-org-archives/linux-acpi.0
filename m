From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: HP Compaq nc6320 - Booting on battery power causes softlock
Date: Sat, 03 Feb 2007 15:10:46 +0000
Message-ID: <1170515446.6252.16.camel@localhost>
References: <1169002596.29755.5.camel@localhost>
	 <3877989d0701161904u6ef2b931t99b79d92dd974f2a@mail.gmail.com>
	 <1170514965.6252.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:39082 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946037AbXBCPK4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Feb 2007 10:10:56 -0500
In-Reply-To: <1170514965.6252.13.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luming Yu <luming.yu@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Sat, 2007-02-03 at 15:02 +0000, Peter Clifton wrote:
> [ loading ipw3945 module via modprobe ]
> ...
> [ Detects ]
> [ Prints module copyright ]
> ACPI: PCI Interrupt 0000:08:00.00[A] -> GSI16 (level,low) -> IRQ 169
> ipw3945: Detected .... 3945ABG ....
> BUG: Soft lockup ... CPU#0
> 
> <c01481cf> softlockup_tick+0x9f/0xf0   <c012bee1> update_process_times
> +0x31/0x80
> 
> <c0114d13> smp_apic_timer_interrupt+0x53/0x60   <c010413c>
> apic_timer_interrupt+0x1c/0x30
> 
> <f8a240f7> ipw_bg_alive_start+0x67/0xa0 [ipw3945]   <c0132702>
> run_workqueue+0x72/0xf0
> 
> <f8a24090> ipw_bg_alive_start+0x0/0xa0 [ipw3945]   <c01331d0>
> worker_thread+0x0/0x140
> 
> <c0135f8b> kthread+0xab/0xe0   <c0135ee0> ktherad+0x0/0e0
> 
> <c0101005> kernel_thread_helper+0x5/0x10
> 
> 
> Hope that helps cast some light on the problem..

Never-mind.. looks like it has been discovered elsewhere..

http://bughost.org/bugzilla/show_bug.cgi?id=1096

I'm not sure why it only happens on battery though.

Thanks for your help.

Peter Clifton


