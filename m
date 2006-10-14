From: Len Brown <len.brown@intel.com>
Subject: Re: [patch 03/12] ACPI: SCI interrupt source override
Date: Sat, 14 Oct 2006 04:07:37 -0400
Message-ID: <200610140407.37897.len.brown@intel.com>
References: <200610102120.k9ALKXcK024272@shell0.pdx.osdl.net>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:61383 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1160999AbWJNIFW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:05:22 -0400
In-Reply-To: <200610102120.k9ALKXcK024272@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@osdl.org
Cc: linux-acpi@vger.kernel.org, kimball.murray@gmail.com, ak@muc.de, david.bulkow@stratus.com, luming.yu@intel.com

Applied.

thanks,
-Len

On Tuesday 10 October 2006 17:20, akpm@osdl.org wrote:
> From: Kimball Murray <kimball.murray@gmail.com>
> 
> The Linux group at Stratus Technologies has come across an issue with SCI
> routing under ACPI.  We were bitten by this when we made an x86_64 platform
> whose BIOS provides an Interrupt Source Override for the SCI itself. 
> Apparently the override has no effect for the System Control Interrupt, and
> this appears to be because of the way the SCI is setup in the ACPI code. 
> It does not handle the case where busirq != gsi.
> 
> The code that sets up the SCI routing assumes that bus irq == global irq. 
> So there is simply no provision for telling it otherwise.  The attached
> patch provides this mechanism.
> 
> This patch provided by David Bulkow, was tested on an i386 platform, which
> does not use the SCI override, and also on an x86_64 platform which does
> use an override.
> 
> Signed-off-by: David Bulkow <david.bulkow@stratus.com>
> Cc: "Brown, Len" <len.brown@intel.com>
> Cc: "Yu, Luming" <luming.yu@intel.com>
> Cc: Andi Kleen <ak@muc.de>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  arch/i386/kernel/acpi/boot.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff -puN arch/i386/kernel/acpi/boot.c~acpi-sci-interrupt-source-override arch/i386/kernel/acpi/boot.c
> --- a/arch/i386/kernel/acpi/boot.c~acpi-sci-interrupt-source-override
> +++ a/arch/i386/kernel/acpi/boot.c
> @@ -332,7 +332,7 @@ acpi_parse_ioapic(acpi_table_entry_heade
>  /*
>   * Parse Interrupt Source Override for the ACPI SCI
>   */
> -static void acpi_sci_ioapic_setup(u32 gsi, u16 polarity, u16 trigger)
> +static void acpi_sci_ioapic_setup(u32 bus_irq, u32 gsi, u16 polarity, u16 trigger)
>  {
>  	if (trigger == 0)	/* compatible SCI trigger is level */
>  		trigger = 3;
> @@ -352,13 +352,13 @@ static void acpi_sci_ioapic_setup(u32 gs
>  	 * If GSI is < 16, this will update its flags,
>  	 * else it will create a new mp_irqs[] entry.
>  	 */
> -	mp_override_legacy_irq(gsi, polarity, trigger, gsi);
> +	mp_override_legacy_irq(bus_irq, polarity, trigger, gsi);
>  
>  	/*
>  	 * stash over-ride to indicate we've been here
>  	 * and for later update of acpi_fadt
>  	 */
> -	acpi_sci_override_gsi = gsi;
> +	acpi_sci_override_gsi = bus_irq;
>  	return;
>  }
>  
> @@ -376,7 +376,7 @@ acpi_parse_int_src_ovr(acpi_table_entry_
>  	acpi_table_print_madt_entry(header);
>  
>  	if (intsrc->bus_irq == acpi_fadt.sci_int) {
> -		acpi_sci_ioapic_setup(intsrc->global_irq,
> +		acpi_sci_ioapic_setup(intsrc->bus_irq, intsrc->global_irq,
>  				      intsrc->flags.polarity,
>  				      intsrc->flags.trigger);
>  		return 0;
> @@ -879,7 +879,7 @@ static int __init acpi_parse_madt_ioapic
>  	 * pretend we got one so we can set the SCI flags.
>  	 */
>  	if (!acpi_sci_override_gsi)
> -		acpi_sci_ioapic_setup(acpi_fadt.sci_int, 0, 0);
> +		acpi_sci_ioapic_setup(acpi_fadt.sci_int, acpi_fadt.sci_int, 0, 0);
>  
>  	/* Fill in identity legacy mapings where no override */
>  	mp_config_acpi_legacy_irqs();
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
