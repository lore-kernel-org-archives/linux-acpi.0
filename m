From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Enable A20 using KBC for some MSI laptops to fix S3 resume
Date: Wed, 24 Oct 2012 21:01:16 +0200
Message-ID: <450396555.xT2D53NWjT@vostro.rjw.lan>
References: <201210240847.52417.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201210240847.52417.linux@rainbow-software.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>, hpa@zytor.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 24 of October 2012 08:47:52 Ondrej Zary wrote:
> Some MSI laptop BIOSes are broken - INT 15h code uses port 92h to enable A20
> line but resume code assumes that KBC was used.
> The laptop will not resume from S3 otherwise but powers off after a while
> and then powers on again stuck with a blank screen.
> 
> Fix it by enabling A20 using KBC. Affected laptop list and DMI data are from
> bug reports at Ubuntu Launchpad.
> 
> Tested with EX600 and PR200.
> 
> Fixes https://bugzilla.kernel.org/show_bug.cgi?id=12878
> 
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>


> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -1349,6 +1349,20 @@ static int __init dmi_ignore_irq0_timer_override(const struct dmi_system_id *d)
>  }
>  
>  /*
> + * Enable A20 line using KBC even if it's already enabled using other method.
> + * This is needed for some MSI laptops to resume from S3.
> + */
> +static int __init a20_enable_kbc(const struct dmi_system_id *d)
> +{
> +	printk(KERN_NOTICE "%s detected: enabling A20 using KBC\n", d->ident);
> +	outb(0xd1, 0x64);	/* Command write */
> +	outb(0xdf, 0x60);	/* A20 on */
> +	outb(0xff, 0x64);	/* Null command, but UHCI wants it */
> +
> +	return 0;
> +}
> +
> +/*
>   * If your system is blacklisted here, but you find that acpi=force
>   * works for you, please contact linux-acpi@vger.kernel.org
>   */
> @@ -1423,6 +1437,60 @@ static struct dmi_system_id __initdata acpi_dmi_table[] = {
>  		     DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 360"),
>  		     },
>  	 },
> +	/*
> +	 * Some MSI laptop BIOSes are broken - INT 15h code uses port 92h to
> +	 * enable A20 line but resume code assumes that KBC was used.
> +	 * The laptop will not resume from S3 otherwise but powers off
> +	 * after a while and then powers on again stuck with a blank screen.
> +	 */
> +	{
> +	 .callback = a20_enable_kbc,
> +	 .ident = "MSI EX600 Laptop",
> +	 .matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International"),
> +		     DMI_MATCH(DMI_PRODUCT_NAME, "MSI Notebook EX600"),
> +		     },
> +	 },
> +	{
> +	 .callback = a20_enable_kbc,
> +	 .ident = "MSI EX700 Laptop",
> +	 .matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International"),
> +		     DMI_MATCH(DMI_PRODUCT_NAME, "EX700"),
> +		     },
> +	 },
> +	{
> +	 .callback = a20_enable_kbc,
> +	 .ident = "MSI GX700 Laptop",
> +	 .matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International"),
> +		     DMI_MATCH(DMI_PRODUCT_NAME, "GX700"),
> +		     },
> +	 },
> +	{
> +	 .callback = a20_enable_kbc,
> +	 .ident = "MSI VR201 Laptop",
> +	 .matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International"),
> +		     DMI_MATCH(DMI_PRODUCT_NAME, "MSI Notebook VR201"),
> +		     },
> +	 },
> +	{
> +	 .callback = a20_enable_kbc,
> +	 .ident = "MSI VR601 Laptop",
> +	 .matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International"),
> +		     DMI_MATCH(DMI_PRODUCT_NAME, "MSI Notebook VR601"),
> +		     },
> +	 },
> +	{
> +	 .callback = a20_enable_kbc,
> +	 .ident = "MSI PR200 Laptop",
> +	 .matches = {
> +		     DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International"),
> +		     DMI_MATCH(DMI_PRODUCT_NAME, "MSI Notebook PR200"),
> +		     },
> +	 },
>  	{}
>  };
>  
> 
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
