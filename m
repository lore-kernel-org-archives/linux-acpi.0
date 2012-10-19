From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Do not touch legacy irq in Hardware Reduced ACPI mode
Date: Fri, 19 Oct 2012 13:16:58 -0400
Message-ID: <CAJvTdKnhe+Yn6uzNnDu=-w9f244a5xBieAjnLPUWGMf2iHN0MA@mail.gmail.com>
References: <1348537036.10877.186.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44675 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194Ab2JSRQ7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Oct 2012 13:16:59 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so984200iea.19
        for <linux-acpi@vger.kernel.org>; Fri, 19 Oct 2012 10:16:58 -0700 (PDT)
In-Reply-To: <1348537036.10877.186.camel@rui.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

> @@ -481,6 +481,9 @@ int __init acpi_irq_penalty_init(void)
>         struct acpi_pci_link *link;
>         int i;
>
> +       /* No irq penalty in Hardware Reduced Mode */
> +       if (acpi_gbl_reduced_hardware)
> +               return 0;
>         /*
>          * Update penalties to facilitate IRQ balancing.
>          */

Although there is no PIC in hw-reduced mode,
and even though "PCI Interrupt Link Devices" are typically
used to describe PIC interrupts in IOAPIC mode,
I think that Links may still be used in straight IOAPIC mode --
at least in theory.

So it isn't clear that we can categorically disable Link support
in HW-reduced mode.

thanks,
Len Brown, Intel Open Source Technology Center
