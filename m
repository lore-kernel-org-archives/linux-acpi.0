From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: ACPI (atlas_btns) locks my box for minutes
Date: Fri, 5 Sep 2008 09:53:43 +0200
Message-ID: <200809050953.43734.hs4233@mail.mn-solutions.de>
References: <200809041300.20141.hs4233@mail.mn-solutions.de> <alpine.LFD.1.10.0809041731160.3662@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx51.mymxserver.com ([85.199.173.110]:61503 "EHLO
	mx51.mymxserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbYIEHyI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Sep 2008 03:54:08 -0400
In-Reply-To: <alpine.LFD.1.10.0809041731160.3662@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Jaya Kumar <jayakumar.acpi@gmail.com>, Dmitry Torokhov <dtor@mail.ru>

And one more dmesg output. This time the device recovers, so I
here is the real-output, nothing scribbled down. I have no clue why all the traces look soooo different. Maybe we deal with more
than just one problem ...


ACPI Error (psparse-0530): Method parse/execution failed [\_GPE._E15] (Node de011d80), AE_NOT_EXIST
ACPI Exception (evgpe-0573): AE_NOT_EXIST, while evaluating GPE method [_E15] [20080321]
Execute Method: [\_GPE._E15] (Node de011d80)
Execute Method: [\_GPE._E15] (Node de011d80)
Execute Method: [\_GPE._E15] (Node de011d80)
Execute Method: [\_GPE._E15] (Node de011d80)
ACPI Error (evregion-0316): No handler for Region [ASI2] (de012190) [UserDefinedRegion] [20080321]
ACPI Error (exfldio-0290): Region UserDefinedRegion(81) has no handler [20080321]
ACPI Error (psparse-0530): Method parse/execution failed [\BNSV] (Node de011b58), AE_NOT_EXIST
ACPI Error (psparse-0530): Method parse/execution failed [\_GPE._E15] (Node de011d80), AE_NOT_EXIST
ACPI Exception (evgpe-0573): AE_NOT_EXIST, while evaluating GPE method [_E15] [20080321]
Execute Method: [\_GPE._E15] (Node de011d80)
ACPI Error (evregion-0316): No handler for Region [ASI2] (de012190) [UserDefinedRegion] [20080321]
ACPI Error (exfldio-0290): Region UserDefinedRegion(81) has no handler [20080321]
ACPI Error (psparse-0530): Method parse/execution failed [\BNSV] (Node de011b58), AE_NOT_EXIST
ACPI Error (psparse-0530): Method parse/execution failed [\_GPE._E15] (Node de011d80), AE_NOT_EXIST
ACPI Exception (evgpe-0573): AE_NOT_EXIST, while evaluating GPE method [_E15] [20080321]
irq 9: nobody cared (try booting with the "irqpoll" option)
Pid: 0, comm: swapper Tainted: P          2.6.26.3 #16
 [<c012f063>] __report_bad_irq+0x24/0x69
 [<c012f06a>] __report_bad_irq+0x2b/0x69
 [<c012f257>] note_interrupt+0x1af/0x1e4
 [<c01cbc97>] acpi_irq+0xb/0x1c
 [<c012e983>] handle_IRQ_event+0x1a/0x3f
 [<c012f917>] handle_level_irq+0x63/0x84
 [<c01046d0>] do_IRQ+0x4b/0x60
 [<c010320f>] common_interrupt+0x23/0x28
 [<c0118f03>] __do_softirq+0x2c/0x75
 [<c0118f6e>] do_softirq+0x22/0x26
 [<c01191ea>] irq_exit+0x25/0x53
 [<c01046d5>] do_IRQ+0x50/0x60
 [<c010320f>] common_interrupt+0x23/0x28
 [<c01f8458>] acpi_idle_enter_simple+0x16d/0x1d9
 [<c0264bd2>] cpuidle_idle_call+0x49/0x77
 [<c0264b89>] cpuidle_idle_call+0x0/0x77
 [<c010176c>] cpu_idle+0x48/0x61
 =======================
handlers:
[<c01cbc8c>] (acpi_irq+0x0/0x1c)
Disabling IRQ #9
Execute Method: [\_GPE._E15] (Node de011d80)
BUG: soft lockup - CPU#0 stuck for 140s! [kacpid:63]
Modules linked in: wlan_wep wlan_scan_sta ath_rate_sample ath_pci wlan ath_hal(P)

Pid: 63, comm: kacpid Tainted: P          (2.6.26.3 #16)
EIP: 0060:[<c01162e0>] EFLAGS: 00000286 CPU: 0
EIP is at vprintk+0x24d/0x257
EAX: c038c818 EBX: 00000000 ECX: 00000046 EDX: c038c814
ESI: c034e40a EDI: c03eb361 EBP: 00000001 ESP: de0edeb4
 DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068
CR0: 8005003b CR2: b7f960cc CR3: 1e3ed000 CR4: 00000090
DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
DR6: ffff0ff0 DR7: 00000400
 [<c0111129>] ? wakeup_preempt_entity+0x31/0x49
 [<c0113c1e>] ? check_preempt_wakeup+0x7f/0x93
 [<c01ebf1e>] ? acpi_ut_status_exit+0x48/0x56
 [<c01162fe>] ? printk+0x14/0x18
 [<c01162fe>] ? printk+0x14/0x18
 [<c01cc7fa>] ? acpi_os_vprintf+0x1d/0x20
 [<c01cc810>] ? acpi_os_printf+0x13/0x15
 [<c01e4f7e>] ? acpi_ns_dump_pathname+0x66/0x88
 [<c01e3924>] ? acpi_ns_evaluate+0x124/0x20c
 [<c01d6821>] ? acpi_ev_asynch_execute_gpe_method+0xee/0x144
 [<c01cc2e5>] ? acpi_os_execute_deferred+0x0/0x25
 [<c01cc302>] ? acpi_os_execute_deferred+0x1d/0x25
 [<c011fd8b>] ? run_workqueue+0x63/0xca
 [<c01202a3>] ? worker_thread+0x0/0x7e
 [<c0120317>] ? worker_thread+0x74/0x7e
 [<c0122284>] ? autoremove_wake_function+0x0/0x2d
 [<c0122133>] ? kthread+0x36/0x5b
 [<c01220fd>] ? kthread+0x0/0x5b
 [<c010337f>] ? kernel_thread_helper+0x7/0x10
 =======================

... and here the system was responsible again. That, is, except
for ACPI. Another button press didn't do anything, not even
locking up the system again :-/  But I could SSH into the device,
hurray :-)
