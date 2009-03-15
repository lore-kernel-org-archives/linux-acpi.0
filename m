From: Jiri Slaby <jirislaby@gmail.com>
Subject: 2.6.29 acpi regression: acpi_ex_extract_from_field -- div by zero
Date: Sun, 15 Mar 2009 11:47:06 +0100
Message-ID: <49BCDCAA.8040309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f176.google.com ([209.85.220.176]:59478 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbZCOKrN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Mar 2009 06:47:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, rjw@sisk.pl, Linux kernel mailing list <linux-kernel@vger.kernel.org>, torvalds@linux-foundation.org

Hi,

sometimes, when booting up/resuming from disk, I get an oops[1].

obj_desc->common_field.access_bit_width is zero, but even after the 
loop. Division before the loop is apparently OK.

This is the case:
         /* Mask off any extra bits in the last datum */

         buffer_tail_bits = obj_desc->common_field.bit_length %
             obj_desc->common_field.access_bit_width;

.L39:
         xorl    %edx, %edx      #
         movzbl  37(%rbx), %esi  # 
<variable>.common_field.access_bit_width, 
<variable>.common_field.access_bit_width
         movl    24(%rbx), %eax  # <variable>.common_field.bit_length, 
<variable>.common_field.bit_length
--------------- here:
         divl    %esi    # <variable>.common_field.access_bit_width
         movl    %edx, %ecx      #, tmp121
         testl   %edx, %edx      # tmp121
         je      .L41    #,

[1] http://www.fi.muni.cz/~xslaby/sklad/panics/acpi_oops.png
