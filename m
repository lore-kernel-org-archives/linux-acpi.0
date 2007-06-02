From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 6/6] Remove Dell Optiplex GX240 from the ACPI blacklist
Date: Sat, 2 Jun 2007 00:41:08 -0400
Message-ID: <200706020041.08323.lenb@kernel.org>
References: <200705232112.l4NLCUrC032160@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33285 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570AbXFBElR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Jun 2007 00:41:17 -0400
In-Reply-To: <200705232112.l4NLCUrC032160@shell0.pdx.osdl.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, tarrqt@yahoo.com

Applied.

thanks,
-len

On Wednesday 23 May 2007 17:12, akpm@linux-foundation.org wrote:
> From: Tear <tarrqt@yahoo.com>
> 
> I have a Dell Optiplex GX240 and when I boot Linux, ACPI gets set up by only
> acpi=ht.  dmesg shows the following line:
> 
>    DELL GX240 detected: force use of acpi=ht
> 
> Everything seemed to be fine.  However, I discovered that everything is not
> fine.  The USB controller works so slowly that copying a few (uncached) 1
> megabyte large photos from a USB-enabled digital camera takes many minutes
> instead of a couple of seconds.
> 
> I am using Linux 2.6.21.1 on a Debian 4.0 ("Etch") system.
> 
> I thought that this might be related to ACPI.  So I tried to boot with _only_
> "acpi=force" appended to the kernel command line.  Voila, the USB controller
> started to work at full speed and copying photos from my digital camera took
> only seconds.
> 
> I tested the system with "acpi=force" and could not find anything which did
> not work.  So, can we please remove Dell Optiplex GX240 from the blacklist in
> 
> ..../arch/i386/kernel/acpi/boot.c
> 
> ?  The attached patch does just that: It removes Dell Optiplex GX240 from the
> ACPI blacklist.
> 
> I thought that this might be related to interrupts and APIC as well.  (Note
> that this is APIC, not ACPI.) I tried booting with _only_ "noapic" and
> "nolapic" appended to the command line.  Again, the USB controller started to
> work at full speed.
> 
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/i386/kernel/acpi/boot.c |    8 --------
>  1 files changed, 8 deletions(-)
> 
> diff -puN arch/i386/kernel/acpi/boot.c~remove-dell-optiplex-gx240-from-the-acpi-blacklist arch/i386/kernel/acpi/boot.c
> --- a/arch/i386/kernel/acpi/boot.c~remove-dell-optiplex-gx240-from-the-acpi-blacklist
> +++ a/arch/i386/kernel/acpi/boot.c
> @@ -971,14 +971,6 @@ static struct dmi_system_id __initdata a
>  	 },
>  	{
>  	 .callback = force_acpi_ht,
> -	 .ident = "DELL GX240",
> -	 .matches = {
> -		     DMI_MATCH(DMI_BOARD_VENDOR, "Dell Computer Corporation"),
> -		     DMI_MATCH(DMI_BOARD_NAME, "OptiPlex GX240"),
> -		     },
> -	 },
> -	{
> -	 .callback = force_acpi_ht,
>  	 .ident = "HP VISUALIZE NT Workstation",
>  	 .matches = {
>  		     DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
