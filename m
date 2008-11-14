From: Thomas Renninger <trenn@suse.de>
Subject: Re: [patch] ACPI: make debug command-line arguments work again
Date: Fri, 14 Nov 2008 18:57:55 +0100
Message-ID: <200811141857.56181.trenn@suse.de>
References: <200811131630.14781.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:35799 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753412AbYKNR56 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Nov 2008 12:57:58 -0500
In-Reply-To: <200811131630.14781.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>

On Friday 14 November 2008 00:30:13 Bjorn Helgaas wrote:
> I stupidly tried to set the default ACPI debug level in acpi_early_init(),
> but that's after command-line arguments are parsed, so any user-supplied
> arguments were overwritten.
>
> This changes the default initialization, so command-line arguments
> work again.
>
> This sets the default level to "info", which is what all the ACPI
> drivers use.  So to enable messages from drivers, you only have to
> supply the "layer" (a.k.a. "component").  For non-"info" ACPI core
> and ACPI interpreter messages, you have to supply both level and
> layer masks, as before.
>
> This should go in 2.6.28; otherwise there'll be no way to turn on
> ACPI debugging.
>
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
>
> diff --git a/Documentation/kernel-parameters.txt
> b/Documentation/kernel-parameters.txt index c600c4f..95eeb9f 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -220,14 +220,17 @@ and is between 256 and 4096 characters. It is defined
> in the file Bits in debug_level correspond to a level in
>  			ACPI_DEBUG_PRINT statements, e.g.,
>  			    ACPI_DEBUG_PRINT((ACPI_DB_INFO, ...
> -			See Documentation/acpi/debug.txt for more information
> -			about debug layers and levels.
> +			The debug_level mask defaults to "info".  See
> +			Documentation/acpi/debug.txt for more information about
> +			debug layers and levels.
>
> +			Enable processor driver info messages:
> +			    acpi.debug_layer=0x20000000
> +			Enable PCI/PCI interrupt routing info messages:
> +			    acpi.debug_layer=0x400000
>  			Enable AML "Debug" output, i.e., stores to the Debug
>  			object while interpreting AML:
>  			    acpi.debug_layer=0xffffffff acpi.debug_level=0x2
> -			Enable PCI/PCI interrupt routing info messages:
> -			    acpi.debug_layer=0x400000 acpi.debug_level=0x4
>  			Enable all messages related to ACPI hardware:
>  			    acpi.debug_layer=0x2 acpi.debug_level=0xffffffff
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 7edf6d9..765fd1c 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -688,14 +688,6 @@ void __init acpi_early_init(void)
>  	if (acpi_disabled)
>  		return;
>
> -	/*
> -	 * ACPI CA initializes acpi_dbg_level to non-zero, which means
> -	 * we get debug output merely by turning on CONFIG_ACPI_DEBUG.
> -	 * Turn it off so we don't get output unless the user specifies
> -	 * acpi.debug_level.
> -	 */
> -	acpi_dbg_level = 0;
> -
>  	printk(KERN_INFO PREFIX "Core revision %08x\n", ACPI_CA_VERSION);
>
>  	/* enable workarounds, unless strict ACPI spec. compliance */
> diff --git a/drivers/acpi/utilities/utglobal.c
> b/drivers/acpi/utilities/utglobal.c index 670551b..37da826 100644
> --- a/drivers/acpi/utilities/utglobal.c
> +++ b/drivers/acpi/utilities/utglobal.c
> @@ -60,11 +60,11 @@ ACPI_EXPORT_SYMBOL(acpi_gbl_FADT)
>   * are already set when the debugger is entered.
>   */
>  /* Debug switch - level and trace mask */
> -u32 acpi_dbg_level = ACPI_DEBUG_DEFAULT;
> +u32 acpi_dbg_level = ACPI_LV_INFO;
This is acpica code.
If this one is/can be touched, then we should modify
ACPI_DEBUG_DEFAULT directly? (see patch in the end)

>
>  /* Debug switch - layer (component) mask */
>
> -u32 acpi_dbg_layer = ACPI_COMPONENT_DEFAULT | ACPI_ALL_DRIVERS;
> +u32 acpi_dbg_layer = 0;
IMO we should keep dbg_layer high and only lower the level.
Like that you only have to fiddle with one param for general
debugging (e.g. when requesting info in a bug report).

This is what should be in OpenSUSE for quite a while.
init seems not to be used.

--- include/acpi/acoutput.h.bak	2008-11-14 18:53:33.000000000 +0100
+++ include/acpi/acoutput.h	2008-11-14 18:53:48.000000000 +0100
@@ -172,7 +172,7 @@
 
 /* Defaults for debug_level, debug and normal */
 
-#define ACPI_DEBUG_DEFAULT          (ACPI_LV_INIT | ACPI_LV_DEBUG_OBJECT)
+#define ACPI_DEBUG_DEFAULT          (ACPI_LV_INIT)
 #define ACPI_NORMAL_DEFAULT         (ACPI_LV_INIT | ACPI_LV_DEBUG_OBJECT)
 #define ACPI_DEBUG_ALL              (ACPI_LV_AML_DISASSEMBLE | ACPI_LV_ALL_EXCEPTIONS | ACPI_LV_ALL)
 
