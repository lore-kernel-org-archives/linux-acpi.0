From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [RFT v2 24/48] m68k, irq: Prepare for killing the first parameter 'irq' of irq_flow_handler_t
Date: Thu,  4 Jun 2015 12:13:34 +0800
Message-ID: <1433391238-19471-25-git-send-email-jiang.liu@linux.intel.com>
References: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:35986 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753043AbbFDEPz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Jun 2015 00:15:55 -0400
In-Reply-To: <1433391238-19471-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Randy Dunlap <rdunlap@infradead.org>, Yinghai Lu <yinghai@kernel.org>, Borislav Petkov <bp@alien8.de>, Joshua Thompson <funaho@jurai.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-m68k@lists.linux-m68k.org

Change irq flow handler to prepare for killing the first parameter 'irq'
of irq_flow_handler_t.

Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
---
 arch/m68k/mac/psc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/mac/psc.c b/arch/m68k/mac/psc.c
index 835fa04511c8..ea7651a7908b 100644
--- a/arch/m68k/mac/psc.c
+++ b/arch/m68k/mac/psc.c
@@ -113,8 +113,9 @@ void __init psc_init(void)
  * PSC interrupt handler. It's a lot like the VIA interrupt handler.
  */
 
-static void psc_irq(unsigned int irq, struct irq_desc *desc)
+static void psc_irq(unsigned int __irq, struct irq_desc *desc)
 {
+	unsigned int irq = irq_desc_get_irq(desc);
 	unsigned int offset = (unsigned int)irq_desc_get_handler_data(desc);
 	int pIFR	= pIFRbase + offset;
 	int pIER	= pIERbase + offset;
-- 
1.7.10.4

