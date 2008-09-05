From: Holger Schurig <hs4233@mail.mn-solutions.de>
Subject: Re: ACPI (atlas_btns) locks my box for minutes
Date: Fri, 5 Sep 2008 09:34:36 +0200
Message-ID: <200809050934.36140.hs4233@mail.mn-solutions.de>
References: <200809041300.20141.hs4233@mail.mn-solutions.de> <alpine.LFD.1.10.0809041731160.3662@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx51.mymxserver.com ([85.199.173.110]:17766 "EHLO
	mx51.mymxserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbYIEHe5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Sep 2008 03:34:57 -0400
In-Reply-To: <alpine.LFD.1.10.0809041731160.3662@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Jaya Kumar <jayakumar.acpi@gmail.com>, Dmitry Torokhov <dtor@mail.ru>

>  and it does not happen if atlas_btns is not loaded)

Ok, the condition for the following e-mail is that atlas_btns.ko
hasn't been loaded.

The normal operation now is that I get for every key-press:

ACPI Error (evregion-0316): No handler for Region [ASI2] 
(de012190) [UserDefinedRegion] [20080321]
ACPI Error (exfldio-0290): Region UserDefinedRegion(81) has no 
handler [20080321]
ACPI Error (psparse-0530): Method parse/execution failed [\BNSV] 
(Node de011b58), AE_NOT_EXIST
ACPI Error (psparse-0530): Method parse/execution failed 
[\_GPE._E15] (Node de011d80), AE_NOT_EXIST
ACPI Exception (evgpe-0573): AE_NOT_EXIST, while evaluating GPE 
method [_E15] [20080321]

And for every key-release:

ACPI Error (evregion-0316): No handler for Region [ASI2] 
(de012190) [UserDefinedRegion] [20080321]
ACPI Error (exfldio-0290): Region UserDefinedRegion(81) has no 
handler [20080321]
ACPI Error (psparse-0530): Method parse/execution failed [\BNSV] 
(Node de011b58), AE_NOT_EXIST
ACPI Error (psparse-0530): Method parse/execution failed 
[\_GPE._E15] (Node de011d80), AE_NOT_EXIST
ACPI Exception (evgpe-0573): AE_NOT_EXIST, while evaluating GPE 
method [_E15] [20080321]



Second observation: then I press the ACPI buttons quickly, I can
also trigger a lock-down of the system. It takes some presses,
here I needed about 50 or 60 presses.



Now I got the system in a state where it virtually it doesn't
recover itself. Every 60 seconds or so I get some kernel output
lines. But I cannot SSH into it to get them, so I scribbled some
stuff from the screen.

The most common output that I get is similar to this (I ommitted 
registers and hex values):


BUG: soft lockup - CPU#0 stuck for 61s! [klogd:1953]
Modules linked in: wlan_wep wlan_scan_sta ath_rate_sample ath_pci 
wlan ath_hal(P)

Pid: 1953, comm: klogd Tained: P    (2.6.26.3 #15)
EIP: 0060:[<c01cc6f5>] EFLAGS: 00000286 CPU: 0
EIP is at acpi_os_release_lock+0x2/0x3
... lots of registers
? acpi_hw_register-read
? acpi_ev_sci_xrupt_handler
? acpi_irq
? handle_IRQ_event
? handle_level_irq
? do_IRQ
? common_interrupt
? __do_softirq
? do_softirq
? irq_exit
? do_IRQ
? common_interrupt
? pci_read_bridge_bases
====================================

Sometimes the top of the backtrace is this:

? acpi_ev_gpe_detect
? acpi_ev_sci_xrupt_handler
? acpi_irq
? handle_IRQ_event
? handle_level_irq
? do_IRQ
? common_interrupt
? __do_softirq
? do_softirq
? irq_exit
? do_IRQ
? common_interrupt
? pci_read_bridge_bases
====================================


Sometimes the EIP as well the the backtrace is different:

EIP is at acpi_os_read_port+0x27/0x41
....
? acpi_hw_register_read
? acpi_ev_fixed_event_detect
? acpi_ev_sci_xrupt
? acpi_irq
? handle_IRQ_event
? handle_level_irq
? do_IRQ
? common_interrupt
? __do_softirq
? do_softirq
? irq_exit
? do_IRQ
? common_interrupt
? pci_read_bridge_bases
====================================
