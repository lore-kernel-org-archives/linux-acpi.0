From: Len Brown <lenb@kernel.org>
Subject: Re: [KJ] [PATCH] drivers/acpi: sizeof/sizeof array size calculations replaced with ARRAY_SIZE
Date: Wed, 30 May 2007 15:25:05 -0400
Message-ID: <200705301525.05905.lenb@kernel.org>
References: <200705261239.27485.lists-receive@programmierforen.de> <46581C06.7000005@student.ltu.se> <200705261558.24912.lists-receive@programmierforen.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43873 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752660AbXE3TZX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 May 2007 15:25:23 -0400
In-Reply-To: <200705261558.24912.lists-receive@programmierforen.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Drebes <lists-receive@programmierforen.de>
Cc: Richard Knutsson <ricknu-0@student.ltu.se>, kernel-janitors@lists.osdl.org, linux-acpi@vger.kernel.org

 
> > Any reason to not just replace ACPI_RSD_TABLE_SIZE with ARRAY_SIZE?

Probably because ARRAY_SIZE doesn't exist in ACPICA, which is
where this code comes from...

When we change syntax in ACPICA files in Linux to make it more "beautiful",
then it creates more work for me -- as forever on, that syntax difference
must be manually compared to upstream ACPICA and Linux -- and that syntax
difference causes upstream patches to no longer apply and require
hand merging.

If you can license your patches to ACPICA files (drivers/acpi/*/*)
back to Intel to re-distribute under _both_ licenses at the top
of the file, then I'll be happy to apply them.
Otherwise, I'm really not excited about creating work
for no functional benefit.

thanks,
-Len
