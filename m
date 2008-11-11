From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RESEND] [PATCH 2/3] Introduce acpi_root_table=rsdt boot param and dmi list to force rsdt
Date: Tue, 11 Nov 2008 00:58:56 +0000
Message-ID: <20081111005856.GA10535@srcf.ucam.org>
References: <200810192350.57993.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56823 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbYKKA7F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Nov 2008 19:59:05 -0500
Content-Disposition: inline
In-Reply-To: <200810192350.57993.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, me@markdoughty.co.uk, linux-thinkpad <linux-thinkpad@linux-thinkpad.org>, "devel@acpica.org" <devel@acpica.org>

I've now had confirmation from multiple sources that Vista still uses 
the 32-bit addresses for the GPE blocks. We're actually seeing the same 
bug on some currently shipping machines, so again I'm going to suggest 
that the blacklist model isn't going to scale and we should just behave 
like Windows. How about this patch instead? It does some sanity 
checking, so I doubt that there's any way it could break a legitimate 
system. I've left IA64 as-is because it seems more likely that there'd 
be a requirement for 64-bit setups there.

Signed-off-by: Matthew Garrett <mjg@redhat.com>

---

Are there even any ACPI platforms where a system io address can be 
greater than 32 bits? It's limited to 16 bits on x86, so I *really* 
don't think this is going to break anything. The FADTs I've checked from 
Thinkpads all seem to have valid 32-bit addresses even using the one 
obtained from the XSDT.

diff --git a/drivers/acpi/events/evgpeblk.c b/drivers/acpi/events/evgpeblk.c
index 73c058e..eed35d7 100644
--- a/drivers/acpi/events/evgpeblk.c
+++ b/drivers/acpi/events/evgpeblk.c
@@ -1107,6 +1107,32 @@ acpi_status acpi_ev_gpe_initialize(void)
 	 */
 
 	/*
+	 * The ACPI specification says that we should use the 64-bit
+	 * address offset for the GPE blocks if it exists. However,
+	 * Windows uses the legacy address. Various vendors have left
+	 * incorrect values in the 64-bit field, which then causes
+	 * problems later. Since the vast majority of machines have
+	 * never been tested with an OS that uses the 64-bit value by
+	 * default, we should behave like Windows and ignore the spec
+	 * by only using the 64-bit address if it contains something
+	 * that can't be represented in the legacy field. Since system
+	 * io space is only 16 bits on x86, this should be entirely
+	 * safe.
+	 */
+
+#ifdef CONFIG_X86
+	if (acpi_gbl_FADT.gpe0_block &&
+	    acpi_gbl_FADT.xgpe0_block.space_id == ACPI_ADR_SPACE_SYSTEM_IO)
+		acpi_gbl_FADT.xgpe0_block.address =
+			(u64)acpi_gbl_FADT.gpe0_block;
+
+	if (acpi_gbl_FADT.gpe1_block &&
+	    acpi_gbl_FADT.xgpe1_block.space_id == ACPI_ADR_SPACE_SYSTEM_IO)
+		acpi_gbl_FADT.xgpe1_block.address =
+			(u64)acpi_gbl_FADT.gpe1_block;
+#endif
+
+	/*
 	 * Determine the maximum GPE number for this machine.
 	 *
 	 * Note: both GPE0 and GPE1 are optional, and either can exist without

-- 
Matthew Garrett | mjg59@srcf.ucam.org
