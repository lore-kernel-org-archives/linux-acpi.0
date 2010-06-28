From: Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 1/1] ACPI: pci_irq, add PRT_ quirk for IBM Bartolo
Date: Sun, 27 Jun 2010 18:14:29 -0600
Message-ID: <4C27E965.80508@gmail.com>
References: <1277673679-21458-1-git-send-email-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:36971 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab0F1AOc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Jun 2010 20:14:32 -0400
In-Reply-To: <1277673679-21458-1-git-send-email-jslaby@suse.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: lenb@kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Jesse Barnes <jbarnes@virtuousgeek.org>

On 06/27/2010 03:21 PM, Jiri Slaby wrote:
> On IBM Bartolo machines, cards in 00:09.0 are defunct (if use
> interrupts). DSDT says that this slot (with function 0, i.e. pin A) is
> routed to \_SB_.PCI0.PIB_.LNKB. But it's not, it's wired to LNKC, so
> interrupts are misrouted. Add a quirk for this to workaround the
> issue.

That seems a rather serious DSDT flaw. Do devices in that slot work in 
Windows?

>
> This error was reported in suse bugzilla at:
> https://bugzilla.novell.com/show_bug.cgi?id=595683

Apparently that bugzilla requires a login to even view the bug, seems 
bizarre to me..

>
> Signed-off-by: Jiri Slaby<jslaby@suse.cz>
> Cc: Len Brown<lenb@kernel.org>
> Cc: Jesse Barnes<jbarnes@virtuousgeek.org>
> ---
>   drivers/acpi/pci_irq.c |   15 +++++++++++++++
>   1 files changed, 15 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index e4804fb..8e054a4 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -125,6 +125,18 @@ static const struct dmi_system_id hp_t5710[] = {
>   	{ }
>   };
>
> +/* https://bugzilla.novell.com/show_bug.cgi?id=595683 */
> +static const struct dmi_system_id ibm_bartolo[] = {
> +	{
> +		.ident = "IBM Bartolo",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "IBM CORPORATION"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "4810320"),
> +		},
> +	},
> +	{ }
> +};
> +
>   struct prt_quirk {
>   	const struct dmi_system_id *system;
>   	unsigned int		segment;
> @@ -152,6 +164,9 @@ static const struct prt_quirk prt_quirks[] = {
>   	{ hp_t5710, 0, 0, 1, PCI_INTX_PIN('A'),
>   		"\\_SB_.PCI0.LNK1",
>   		"\\_SB_.PCI0.LNK3"},
> +	{ ibm_bartolo, 0, 0, 9, PCI_INTX_PIN('A'),
> +		"\\_SB_.PCI0.PIB_.LNKB",
> +		"\\_SB_.PCI0.PIB_.LNKC"},
>   };
>
>   static void do_prt_fixups(struct acpi_prt_entry *entry,

