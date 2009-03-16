From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: 2.6.29 acpi regression: acpi_ex_extract_from_field -- div by
 zero
Date: Mon, 16 Mar 2009 11:42:23 +0800
Message-ID: <1237174943.4193.37.camel@minggr.sh.intel.com>
References: <49BCDCAA.8040309@gmail.com>
	 <d3f22a0903152046m891dc0aq6ca01eed32a9eb32@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:37433 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751197AbZCPDvV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Mar 2009 23:51:21 -0400
In-Reply-To: <d3f22a0903152046m891dc0aq6ca01eed32a9eb32@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: jirislaby@gmail.com
Cc: robert.moore@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel <linux-kernel@vger.kernel.org>, torvalds@linux-foundation.org


> Hi,
> 
> sometimes, when booting up/resuming from disk, I get an oops[1].
> 
> obj_desc->common_field.access_bit_width is zero, but even after the
> loop. Division before the loop is apparently OK.

Would please try below debug patch to see which region filed is
accessed?

diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index ef58ac4..10ac0c8 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -683,6 +683,7 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 	u32 datum_count;
 	u32 field_datum_count;
 	u32 i;
+	struct acpi_buffer name_buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 
 	ACPI_FUNCTION_TRACE(ex_extract_from_field);
 
@@ -765,6 +766,20 @@ acpi_ex_extract_from_field(union acpi_operand_object *obj_desc,
 		    raw_datum >> obj_desc->common_field.start_field_bit_offset;
 	}
 
+	if (obj_desc->common_field.bit_length == 0 ||
+	    obj_desc->common_field.access_bit_width == 0) {
+		status = acpi_get_name(obj_desc->common_field.node,
+				ACPI_FULL_PATHNAME, &name_buffer);
+		if (ACPI_FAILURE(status)) {
+			printk(KERN_DEBUG "ACPI Debug: %s\n",
+				acpi_format_exception(status));
+		} else {
+			printk(KERN_DEBUG "ACPI Debug: field node path: %s\n",
+				(char *) name_buffer.pointer);
+			kfree(name_buffer.pointer);
+		}
+	}
+
 	/* Mask off any extra bits in the last datum */
 
 	buffer_tail_bits = obj_desc->common_field.bit_length %

---
Lin Ming

> 
> This is the case:
>        /* Mask off any extra bits in the last datum */
> 
>        buffer_tail_bits = obj_desc->common_field.bit_length %
>            obj_desc->common_field.access_bit_width;
> 
> .L39:
>        xorl    %edx, %edx      #
>        movzbl  37(%rbx), %esi  #
> <variable>.common_field.access_bit_width,
> <variable>.common_field.access_bit_width
>        movl    24(%rbx), %eax  # <variable>.common_field.bit_length,
> <variable>.common_field.bit_length
> --------------- here:
>        divl    %esi    # <variable>.common_field.access_bit_width
>        movl    %edx, %ecx      #, tmp121
>        testl   %edx, %edx      # tmp121
>        je      .L41    #,
> 
> [1] http://www.fi.muni.cz/~xslaby/sklad/panics/acpi_oops.png
> --


