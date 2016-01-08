From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI, PCI, irq: remove redundant check for null string pointer
Date: Fri, 08 Jan 2016 01:45:32 +0100
Message-ID: <1690153.ze76fKGfdG@vostro.rjw.lan>
References: <1451991431-8342-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:48382 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753885AbcAHAOs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2016 19:14:48 -0500
In-Reply-To: <1451991431-8342-1-git-send-email-colin.king@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, January 05, 2016 10:57:11 AM Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> source is decleared as a 4 byte char array in struct acpi_pci_routing_table
> so !prt->source is a redundant null string pointer check. Detected with
> smatch:
> 
> drivers/acpi/pci_irq.c:134 do_prt_fixups() warn: this array is probably
>   non-NULL. 'prt->source'
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thanks!

> ---
>  drivers/acpi/pci_irq.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index c933675..d30184c 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -131,9 +131,6 @@ static void do_prt_fixups(struct acpi_prt_entry *entry,
>  		quirk = &prt_quirks[i];
>  
>  		/* All current quirks involve link devices, not GSIs */
> -		if (!prt->source)
> -			continue;
> -
>  		if (dmi_check_system(quirk->system) &&
>  		    entry->id.segment == quirk->segment &&
>  		    entry->id.bus == quirk->bus &&
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
