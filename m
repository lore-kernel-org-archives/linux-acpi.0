From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [patch] ACPI: make debug command-line arguments work again
Date: Fri, 14 Nov 2008 12:28:38 -0700
Message-ID: <200811141228.38879.bjorn.helgaas@hp.com>
References: <200811131630.14781.bjorn.helgaas@hp.com> <200811141857.56181.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:40675 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbYKNT3I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Nov 2008 14:29:08 -0500
In-Reply-To: <200811141857.56181.trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>

On Friday 14 November 2008 10:57:55 am Thomas Renninger wrote:
> On Friday 14 November 2008 00:30:13 Bjorn Helgaas wrote:

> >  /* Debug switch - level and trace mask */
> > -u32 acpi_dbg_level = ACPI_DEBUG_DEFAULT;
> > +u32 acpi_dbg_level = ACPI_LV_INFO;
> This is acpica code.
> If this one is/can be touched, then we should modify
> ACPI_DEBUG_DEFAULT directly? (see patch in the end)

I don't have a strong opinion either way.  If Len doesn't want to
carry such a patch, I suggested that maybe the OSPM could supply
#defines for the default values.

> >  /* Debug switch - layer (component) mask */
> >
> > -u32 acpi_dbg_layer = ACPI_COMPONENT_DEFAULT | ACPI_ALL_DRIVERS;
> > +u32 acpi_dbg_layer = 0;
> IMO we should keep dbg_layer high and only lower the level.
> Like that you only have to fiddle with one param for general
> debugging (e.g. when requesting info in a bug report).

It's a trade-off between whether you want to debug the ACPI core
or drivers.  I made it so you only need one parameter (layer)
when debugging drivers, because that's what I've found most
useful.  The drivers only use ACPI_LV_INFO.

Turning on all the layers seems to generate a lot of unrelated
output, e.g., "info" messages from all over the CA, the core,
and drivers.  To me, that seems less useful than zeroing in on
a specific area.

> This is what should be in OpenSUSE for quite a while.
> init seems not to be used.
> 
> --- include/acpi/acoutput.h.bak	2008-11-14 18:53:33.000000000 +0100
> +++ include/acpi/acoutput.h	2008-11-14 18:53:48.000000000 +0100
> @@ -172,7 +172,7 @@
>  
>  /* Defaults for debug_level, debug and normal */
>  
> -#define ACPI_DEBUG_DEFAULT          (ACPI_LV_INIT | ACPI_LV_DEBUG_OBJECT)
> +#define ACPI_DEBUG_DEFAULT          (ACPI_LV_INIT)
>  #define ACPI_NORMAL_DEFAULT         (ACPI_LV_INIT | ACPI_LV_DEBUG_OBJECT)
>  #define ACPI_DEBUG_ALL              (ACPI_LV_AML_DISASSEMBLE | ACPI_LV_ALL_EXCEPTIONS | ACPI_LV_ALL)
>  
> 


