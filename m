From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 2.6.28-rc7 acpi error messages
Date: Fri, 5 Dec 2008 16:37:52 +0000
Message-ID: <20081205163752.GA26710@srcf.ucam.org>
References: <E92FAF79A8BBC642A36EEE3AA7F152D82A17260164@GVW1089EXB.americas.hpqcorp.net> <4911F71203A09E4D9981D27F9D8308580DD52E96@orsmsx503.amr.corp.intel.com> <20081203230332.GA26733@srcf.ucam.org> <4911F71203A09E4D9981D27F9D8308580DD52F0F@orsmsx503.amr.corp.intel.com> <20081203233557.GA27180@srcf.ucam.org> <4911F71203A09E4D9981D27F9D8308580DD53280@orsmsx503.amr.corp.intel.com> <E92FAF79A8BBC642A36EEE3AA7F152D82A172606EE@GVW1089EXB.americas.hpqcorp.net> <4911F71203A09E4D9981D27F9D8308580DD53927@orsmsx503.amr.corp.intel.com> <4911F71203A09E4D9981D27F9D8308580DD53D0B@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54602 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbYLEQiD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Dec 2008 11:38:03 -0500
Content-Disposition: inline
In-Reply-To: <4911F71203A09E4D9981D27F9D8308580DD53D0B@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "Koornstra, Reinoud" <koornstra@hp.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>, "Zhao, Yakui" <yakui.zhao@intel.com>

On Fri, Dec 05, 2008 at 08:32:11AM -0800, Moore, Robert wrote:
> So, it looks like there are two possible solutions for this machine:
> 
> 1) Use the RSDT instead of the XSDT and automatically get the "correct" FADT with no 64-bit register definitions.
> 
> 2) Use the XSDT as is done today, but use the 32-bit values instead of the 64-bit values in the extended FADT.

I think (2) is the correct answer here. If the 64-bit values use an 
address space other than system io, we probably want to use the 64-bit 
values, so we'll need to parse those addresses anyway. I've sent a patch 
that does this to linux-acpi last week - here's another copy.

commit acdf192e7427366b01fe37704fe95b205490dad2
Author: Matthew Garrett <mjg@redhat.com>
Date:   Mon Dec 1 10:54:05 2008 +0000

    Use 32-bit FADT values on X86
    
    The ACPI specification says that we should use the 64-bit address offsets
    contained within the FADT if they exist. However, Windows uses the legacy
    address. Various vendors have left incorrect values in the 64-bit field
    which then causes problems later. Since the vast majority of machines have
    never been tested with an OS that uses the 64-bit value by default, we should
    behave like Windows and ignore the spec by only using the 64-bit address if
    it contains something that can't be represented in the legacy field. Since
    system io space is only 16 bits on x86, this should be entirely safe.
    
    Signed-off-by: Matthew Garrett <mjg@redhat.com>

diff --git a/drivers/acpi/tables/tbfadt.c b/drivers/acpi/tables/tbfadt.c
index 2817158..89a3c82 100644
--- a/drivers/acpi/tables/tbfadt.c
+++ b/drivers/acpi/tables/tbfadt.c
@@ -320,9 +320,30 @@ static void acpi_tb_convert_fadt(void)
 		    ACPI_ADD_PTR(struct acpi_generic_address, &acpi_gbl_FADT,
 				 fadt_info_table[i].target);
 
-		/* Expand only if the X target is null */
-
-		if (!target->address) {
+		/*
+		 * The ACPI specification says that we should use the
+		 * 64-bit address offsets if they exists. However,
+		 * Windows uses the legacy address. Various vendors
+		 * have left incorrect values in the 64-bit field,
+		 * which then causes problems later. Since the vast
+		 * majority of machines have never been tested with an
+		 * OS that uses the 64-bit value by default, we should
+		 * behave like Windows and ignore the spec by only
+		 * using the 64-bit address if it contains something
+		 * that can't be represented in the legacy
+		 * field. Since system io space is only 16 bits on
+		 * x86, this should be entirely safe. We also extend
+		 * the 32-bit value into the 64-bit one if no 64-bit
+		 * address is provided.
+		 */
+
+		if (!target->address
+#ifdef CONFIG_X86
+		    || (target->space_id == ACPI_ADR_SPACE_SYSTEM_IO &&
+			*ACPI_ADD_PTR(u32, &acpi_gbl_FADT,
+				      fadt_info_table[i].source))
+#endif
+			) {
 			acpi_tb_init_generic_address(target,
 						     *ACPI_ADD_PTR(u8,
 								   &acpi_gbl_FADT,

-- 
Matthew Garrett | mjg59@srcf.ucam.org
