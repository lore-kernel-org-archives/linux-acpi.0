From: Len Brown <lenb@kernel.org>
Subject: Re: x86_64-mm-always-use-physical-delivery-mode-on-8-cpus vs git-acpi
Date: Sat, 27 Jan 2007 04:29:57 -0500
Message-ID: <200701270429.57170.lenb@kernel.org>
References: <20070126172402.77a3edbc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51252 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbXA0Jb0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 27 Jan 2007 04:31:26 -0500
In-Reply-To: <20070126172402.77a3edbc.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, linux-acpi@vger.kernel.org

On Friday 26 January 2007 20:24, Andrew Morton wrote:
> 
> The new stuff which just landed in Len's tree caused a huge mess in
> arch/x86_64/kernel/genapic.c:clustered_apic_check() when applying
> ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt/patches/always-use-physical-delivery-mode-on-8-cpus
> on top of it.

The ACPI change this cleanup patch is conflicting with is quite small:

------------------------- arch/x86_64/kernel/genapic.c -------------------------
index b007433..0b3603a 100644
@@ -58,8 +58,8 @@ void __init clustered_apic_check(void)
 	 * Some x86_64 machines use physical APIC mode regardless of how many
 	 * procs/clusters are present (x86_64 ES7000 is an example).
 	 */
-	if (acpi_fadt.revision > FADT2_REVISION_ID)
-		if (acpi_fadt.force_apic_physical_destination_mode) {
+	if (acpi_gbl_FADT.header.revision > FADT2_REVISION_ID)
+		if (acpi_gbl_FADT.flags & ACPI_FADT_APIC_PHYSICAL) {
 			genapic = &apic_cluster;
 			goto print;
 		}
> In fact the ACPI change has trashed a fair slice of Andi's pending tree.
> 
> I think I'll revert to yesterday's git-acpi, let you guys sort it all out.

Send me a version of the always-use-physical-delivery-mode-on-8-cpus patch
that applies to Linus' tree (the one above doesn't), and I'll be happy to apply
the 2-line diff above to it.

-Len
