From: Niccolo Rigacci <linux-acpi@rigacci.org>
Subject: Understandig ACPI routing PCI IRQ
Date: Sun, 19 Nov 2006 17:12:21 +0100
Message-ID: <20061119161221.GC5208@rigacci.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from host50-109-static.38-88-b.business.telecomitalia.it ([88.38.109.50]:55507
	"EHLO paros.rigacci.org") by vger.kernel.org with ESMTP
	id S1756741AbWKSQMW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 19 Nov 2006 11:12:22 -0500
Received: from niccolo by paros.rigacci.org with local (Exim 4.63)
	(envelope-from <niccolo@rigacci.org>)
	id 1GlpHJ-0001Z7-4R
	for linux-acpi@vger.kernel.org; Sun, 19 Nov 2006 17:12:21 +0100
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi, I'm trying to write a little howto about IRQ on modern PCs.
 
I still have some obscure points, can someone help me 
understanding the following dmesg messages?

   ACPI: PCI Interrupt Link [LNK1] (IRQs *5 7 9 10 11 14 15)
   ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.

Is the label [APSI] coming from the BIOS? I see several labels in 
dmesg like LNK1, LUBA, LSID, APC1, ... what is the meaning?

What it the IRQs list? Are those the possible values to route 
that phisical link to?

Why some PCI interrupt links are assigned at the very begin of 
boot process, where others are first disabled and then enabled 
later?

   ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
   ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [APSI] -> GSI 23 (level, low) -> IRQ 185

In the above log entries, what does it means GSI?

I understand that in PCI slot 0e, there is a device 0, that uses 
the first slot interrupt line (INTA#), which is routed to the CPU 
IRQ 185. But what there is in the middle?

If someone knows detailed explanation of lspci and dmesg, give me 
a pointer.

Thank you very much.

-- 
Niccolo Rigacci
Firenze - Italy

Iraq, missione di pace: 47249 morti - www.iraqbodycount.net
