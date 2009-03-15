From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 2.6.29 acpi regression: acpi_ex_extract_from_field -- div by
 zero
Date: Sun, 15 Mar 2009 10:49:41 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903151037210.3131@localhost.localdomain>
References: <49BCDCAA.8040309@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59245 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751189AbZCORyE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Mar 2009 13:54:04 -0400
In-Reply-To: <49BCDCAA.8040309@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, rjw@sisk.pl, Linux kernel mailing list <linux-kernel@vger.kernel.org>



On Sun, 15 Mar 2009, Jiri Slaby wrote:
> 
> sometimes, when booting up/resuming from disk, I get an oops[1].
> 
> obj_desc->common_field.access_bit_width is zero, but even after the loop.
> Division before the loop is apparently OK.
> 
> This is the case:
>         /* Mask off any extra bits in the last datum */
> 
>         buffer_tail_bits = obj_desc->common_field.bit_length %
>             obj_desc->common_field.access_bit_width;

Hmm. "bit_length" is zero too, according to the oops (it's in %eax).

Looks like the whole "obj_desc" is basically uninitialized. I have no idea 
why, and why it is apparently not reliable. ACPI is odd.

Does everything work if you just do something like the appended?

It's insane, but so is ACPI.

		Linus
---
 drivers/acpi/acpica/exfldio.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index ef58ac4..9297adb 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -698,6 +698,9 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 	}
 	ACPI_MEMSET(buffer, 0, buffer_length);
 
+	if (!obj_desc->common_field.bit_length)
+		return_ACPI_STATUS(AE_OK);
+
 	/* Compute the number of datums (access width data items) */
 
 	datum_count = ACPI_ROUND_UP_TO(obj_desc->common_field.bit_length,
