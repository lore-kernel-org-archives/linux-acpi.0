From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Do not modify SCI_EN directly
Date: Tue, 30 Dec 2008 19:03:25 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812301903210.17126@localhost.localdomain>
References: <200812291919.07663.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-415918257-1230681806=:17126"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:61808 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbYLaADp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 30 Dec 2008 19:03:45 -0500
In-reply-to: <200812291919.07663.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-415918257-1230681806=:17126
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT

applied

-- Len Brown, Intel Open Source Technology Center

On Mon, 29 Dec 2008, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> According to the ACPI specification the SCI_EN flag is controlled by
> the hardware, which sets this flag to inform the kernel that ACPI is
> enabled.  For this reason, we shouldn't try to modify SCI_EN
> directly.  Also, we don't need to do it in irqrouter_resume(), since
> lower-level resume code takes care of enabling ACPI in case it hasn't
> been enabled by the BIOS before passing control to the kernel (which
> by the way is against the ACPI specification).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  drivers/acpi/pci_link.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> Index: linux-2.6/drivers/acpi/pci_link.c
> ===================================================================
> --- linux-2.6.orig/drivers/acpi/pci_link.c
> +++ linux-2.6/drivers/acpi/pci_link.c
> @@ -793,10 +793,6 @@ static int irqrouter_resume(struct sys_d
>  	struct list_head *node = NULL;
>  	struct acpi_pci_link *link = NULL;
>  
> -
> -	/* Make sure SCI is enabled again (Apple firmware bug?) */
> -	acpi_set_register(ACPI_BITREG_SCI_ENABLE, 1);
> -
>  	list_for_each(node, &acpi_link.entries) {
>  		link = list_entry(node, struct acpi_pci_link, node);
>  		if (!link) {
> --8323328-415918257-1230681806=:17126--
--8323328-415918257-1230681806=:17126--
