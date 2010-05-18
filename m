From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH] ACPI: Ignore the upper bits of SystemIO addresses
Date: Tue, 18 May 2010 11:50:34 -0700
Message-ID: <4911F71203A09E4D9981D27F9D830858707F6E46@orsmsx503.amr.corp.intel.com>
References: <1274206035-10571-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7832 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753902Ab0ERSuk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 May 2010 14:50:40 -0400
In-Reply-To: <1274206035-10571-1-git-send-email-mjg@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "lenb@kernel.org" <lenb@kernel.org>

Ok, will backport to ACPICA.
Thanks,
Bob


>-----Original Message-----
>From: Matthew Garrett [mailto:mjg@redhat.com]
>Sent: Tuesday, May 18, 2010 11:07 AM
>To: linux-acpi@vger.kernel.org
>Cc: Moore, Robert; lenb@kernel.org; Matthew Garrett
>Subject: [PATCH] ACPI: Ignore the upper bits of SystemIO addresses
>
>Various machines (https://bugzilla.redhat.com/show_bug.cgi?id=585756 for
>instance) contain SystemIO spaces with addresses > 16 bits. acpica throws
>an error for this, while Windows silently ignores the upper 16 bits and
>carries on happily. Implement the latter behaviour for bug compatibility.
>
>Signed-off-by: Matthew Garrett <mjg@redhat.com>
>---
> drivers/acpi/acpica/hwvalid.c |   17 ++++++++---------
> 1 files changed, 8 insertions(+), 9 deletions(-)
>
>diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
>index e26c17d..ddfb4f1 100644
>--- a/drivers/acpi/acpica/hwvalid.c
>+++ b/drivers/acpi/acpica/hwvalid.c
>@@ -146,15 +146,6 @@ acpi_hw_validate_io_request(acpi_io_address address,
>u32 bit_width)
> 								      last_address),
> 			  byte_width));
>
>-	/* Maximum 16-bit address in I/O space */
>-
>-	if (last_address > ACPI_UINT16_MAX) {
>-		ACPI_ERROR((AE_INFO,
>-			    "Illegal I/O port address/length above 64K: 0x%p/%X",
>-			    ACPI_CAST_PTR(void, address), byte_width));
>-		return_ACPI_STATUS(AE_LIMIT);
>-	}
>-
> 	/* Exit if requested address is not within the protected port table
>*/
>
> 	if (address > acpi_protected_ports[ACPI_PORT_INFO_ENTRIES - 1].end) {
>@@ -222,6 +213,10 @@ acpi_status acpi_hw_read_port(acpi_io_address address,
>u32 *value, u32 width)
> 	u32 one_byte;
> 	u32 i;
>
>+	/* Windows only uses the lower 16 bits of an address. Emulate that */
>+
>+	address &= 0xffff;
>+
> 	/* Validate the entire request and perform the I/O */
>
> 	status = acpi_hw_validate_io_request(address, width);
>@@ -279,6 +274,10 @@ acpi_status acpi_hw_write_port(acpi_io_address
>address, u32 value, u32 width)
> 	acpi_status status;
> 	u32 i;
>
>+	/* Windows only uses the lower 16 bits of an address. Emulate that */
>+
>+	address &= 0xffff;
>+
> 	/* Validate the entire request and perform the I/O */
>
> 	status = acpi_hw_validate_io_request(address, width);
>--
>1.7.0.1

