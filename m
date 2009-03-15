From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: 2.6.29 acpi regression: acpi_ex_extract_from_field -- div by
 zero
Date: Sun, 15 Mar 2009 12:08:10 -0700
Message-ID: <4911F71203A09E4D9981D27F9D83085814F8A39D@orsmsx503.amr.corp.intel.com>
References: <49BCDCAA.8040309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:27406 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754450AbZCOTIO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Mar 2009 15:08:14 -0400
In-Reply-To: <49BCDCAA.8040309@gmail.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>, Len Brown <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>

Can you please send or post the acpidump for the machine? Thanks.

>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Jiri Slaby
>Sent: Sunday, March 15, 2009 3:47 AM
>To: Len Brown
>Cc: linux-acpi@vger.kernel.org; rjw@sisk.pl; Linux kernel mailing list;
>torvalds@linux-foundation.org
>Subject: 2.6.29 acpi regression: acpi_ex_extract_from_field -- div by zero
>
>Hi,
>
>sometimes, when booting up/resuming from disk, I get an oops[1].
>
>obj_desc->common_field.access_bit_width is zero, but even after the
>loop. Division before the loop is apparently OK.
>
>This is the case:
>         /* Mask off any extra bits in the last datum */
>
>         buffer_tail_bits = obj_desc->common_field.bit_length %
>             obj_desc->common_field.access_bit_width;
>
>.L39:
>         xorl    %edx, %edx      #
>         movzbl  37(%rbx), %esi  #
><variable>.common_field.access_bit_width,
><variable>.common_field.access_bit_width
>         movl    24(%rbx), %eax  # <variable>.common_field.bit_length,
><variable>.common_field.bit_length
>--------------- here:
>         divl    %esi    # <variable>.common_field.access_bit_width
>         movl    %edx, %ecx      #, tmp121
>         testl   %edx, %edx      # tmp121
>         je      .L41    #,
>
>[1] http://www.fi.muni.cz/~xslaby/sklad/panics/acpi_oops.png
>--
>To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
