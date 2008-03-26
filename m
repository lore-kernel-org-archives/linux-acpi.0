From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/6] ACPI: fix Medion _PRT quirk (use "ISA_", not "ISA")
Date: Wed, 26 Mar 2008 22:20:23 +0100
Message-ID: <200803262220.23533.rjw@sisk.pl>
References: <1206508420-2755-1-git-send-email-lenb@kernel.org> <d8fcfa43c6f4d4371c17cdcae1770bef74899d73.1206508358.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41146 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757565AbYCZVUk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Mar 2008 17:20:40 -0400
In-Reply-To: <d8fcfa43c6f4d4371c17cdcae1770bef74899d73.1206508358.git.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>, Johann-Nikolaus Andreae <johann-nikolaus.andreae@nacs.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

On Wednesday, 26 of March 2008, Len Brown wrote:
> From: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> This fixes the builtin RTL8139 NIC on the Medion MD9580-F laptop.  The BIOS
> reports the interrupt routing incorrectly.  I recently added a quirk to work
> around this, and this patch fixes a typo in the quirk.
> 
> We pad every ACPI pathname component to four characters, so ".ISA." will never
> match anything.  We need ".ISA_." instead.
> 
> Thank you Johann-Nikolaus Andreae for patiently testing this patch.
> 
> See http://bugzilla.kernel.org/show_bug.cgi?id=4773

This seems to have been applied already:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=b97d4803400a4442b0e4ae14d0bd8e83994b9004
 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Cc: Johann-Nikolaus Andreae <johann-nikolaus.andreae@nacs.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
>  drivers/acpi/pci_irq.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
> index 7af414a..89022a7 100644
> --- a/drivers/acpi/pci_irq.c
> +++ b/drivers/acpi/pci_irq.c
> @@ -131,8 +131,8 @@ struct prt_quirk {
>   */
>  static struct prt_quirk prt_quirks[] = {
>  	{ medion_md9580, 0, 0, 9, 'A',
> -		"\\_SB_.PCI0.ISA.LNKA",
> -		"\\_SB_.PCI0.ISA.LNKB"},
> +		"\\_SB_.PCI0.ISA_.LNKA",
> +		"\\_SB_.PCI0.ISA_.LNKB"},
>  	{ dell_optiplex, 0, 0, 0xd, 'A',
>  		"\\_SB_.LNKB",
>  		"\\_SB_.LNKA"},

Thanks,
Rafael
