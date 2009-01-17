From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ACPI related kernel panic when booting 2.6.29-rc2
Date: Sun, 18 Jan 2009 01:50:08 +0300
Message-ID: <497260A0.6030401@gmail.com>
References: <497243D5.8000708@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:49521 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755225AbZAQWuH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Jan 2009 17:50:07 -0500
Received: by bwz14 with SMTP id 14so6592182bwz.13
        for <linux-acpi@vger.kernel.org>; Sat, 17 Jan 2009 14:50:05 -0800 (PST)
In-Reply-To: <497243D5.8000708@aon.at>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Klotz <peter.klotz@aon.at>
Cc: linux-acpi@vger.kernel.org

please use the patch from Tero Roponen.

This patch fixes the crash I experienced in 2.6.29-rc2.
Tested on ASUS M50vm.

Signed-off-by: Tero Roponen <tero.roponen@gmail.com>

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index a2b82c9..5c2f5d3 100644
--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -982,7 +982,7 @@ int __init acpi_ec_ecdt_probe(void)
 		saved_ec = kmalloc(sizeof(struct acpi_ec), GFP_KERNEL);
 		if (!saved_ec)
 			return -ENOMEM;
-		memcpy(&saved_ec, boot_ec, sizeof(saved_ec));
+		memcpy(saved_ec, boot_ec, sizeof(*saved_ec));
 	/* fall through */
 	}
 	/* This workaround is needed only on some broken machines,


sorry for screw up...
Alex

Peter Klotz wrote:
> On bootup of 2.6.29-rc2 a kernel panic in acpi_ns_get_parent_node occurs.
>
> This is the backtrace (written down from the screen, maybe incomplete):
>
> acpi_ev_execute_reg_methods
> acpi_install_address_space_handler
> acpi_ec_space_handler
> acpi_init
> ec_install_handlers
> acpi_ec_ecdt_probe
> acpi_init
> fbmem_init
> _stext
> register_irq_proc
> proc_pident_readdir
> kernel_init
> child_rip
> kernel_init
> child_rip
>
> RIP [...] acpi_ns_get_parent_node
>
> I can provide a screenshot (270kB) if this information is insufficient.
>
> The system booted with 2.6.29-rc1 so a recent change must be the cause 
> of this panic.
>
> The system is an Asus B50A laptop running an x86_64 kernel.
>
> Maybe this problem is related to these messages I was seeing in 
> bootups of previous kernels:
>
> [    0.176398] ACPI Error (nsaccess-0434): ACPI path has too many 
> parent prefixes (^) - reached beyond root node [20080926]
>
> Regards, Peter.
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

