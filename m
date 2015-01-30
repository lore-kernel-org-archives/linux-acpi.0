From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: remove pointless checks for NULL pointer
Date: Fri, 30 Jan 2015 01:05:59 +0100
Message-ID: <1613407.rgHC8rj35c@vostro.rjw.lan>
References: <20141224201648.GA15251@gnote>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52786 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752349AbbA2XnL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Jan 2015 18:43:11 -0500
In-Reply-To: <20141224201648.GA15251@gnote>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eugene Korenevsky <ekorenevsky@gmail.com>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Wednesday, December 24, 2014 11:16:48 PM Eugene Korenevsky wrote:
> A trivial fix. No need to check `p` for NULL.
> `resource` pointer is valid therefore `p` is also valid.
> 
> Signed-off-by: Eugene Korenevsky <ekorenevsky@gmail.com>

Queued up for 3.20, thanks!

> ---
>  drivers/acpi/pci_link.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index cfd7581..6379186 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -111,7 +111,7 @@ static acpi_status acpi_pci_link_check_possible(struct acpi_resource *resource,
>  	case ACPI_RESOURCE_TYPE_IRQ:
>  		{
>  			struct acpi_resource_irq *p = &resource->data.irq;
> -			if (!p || !p->interrupt_count) {
> +			if (!p->interrupt_count) {
>  				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  						  "Blank _PRS IRQ resource\n"));
>  				return AE_OK;
> @@ -137,7 +137,7 @@ static acpi_status acpi_pci_link_check_possible(struct acpi_resource *resource,
>  		{
>  			struct acpi_resource_extended_irq *p =
>  			    &resource->data.extended_irq;
> -			if (!p || !p->interrupt_count) {
> +			if (!p->interrupt_count) {
>  				printk(KERN_WARNING PREFIX
>  					      "Blank _PRS EXT IRQ resource\n");
>  				return AE_OK;
> @@ -198,7 +198,7 @@ static acpi_status acpi_pci_link_check_current(struct acpi_resource *resource,
>  	case ACPI_RESOURCE_TYPE_IRQ:
>  		{
>  			struct acpi_resource_irq *p = &resource->data.irq;
> -			if (!p || !p->interrupt_count) {
> +			if (!p->interrupt_count) {
>  				/*
>  				 * IRQ descriptors may have no IRQ# bits set,
>  				 * particularly those those w/ _STA disabled
> @@ -214,7 +214,7 @@ static acpi_status acpi_pci_link_check_current(struct acpi_resource *resource,
>  		{
>  			struct acpi_resource_extended_irq *p =
>  			    &resource->data.extended_irq;
> -			if (!p || !p->interrupt_count) {
> +			if (!p->interrupt_count) {
>  				/*
>  				 * extended IRQ descriptors must
>  				 * return at least 1 IRQ
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
