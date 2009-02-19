From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] ACPI: update Kconfig help texts (no functional changes)
Date: Thu, 19 Feb 2009 15:40:30 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0902191532090.16661@localhost.localdomain>
References: <20090219195548.20757.53184.stgit@bob.kio>
 <20090219195621.20757.83135.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:52860 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524AbZBSUkx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Feb 2009 15:40:53 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KFB00776YRLB8XP@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 19 Feb 2009 14:40:39 -0600 (CST)
In-reply-to: <20090219195621.20757.83135.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org


>  drivers/acpi/Kconfig |  148 +++++++++++++++++++++++++++++---------------------
>  1 files changed, 86 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 8a851d0..7a3f52c 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -11,9 +11,9 @@ menuconfig ACPI
>  	select PNP
>  	select CPU_IDLE
>  	default y
> -	---help---
> +	help
>  	  Advanced Configuration and Power Interface (ACPI) support for 
> -	  Linux requires an ACPI compliant platform (hardware/firmware),
> +	  Linux requires an ACPI-compliant platform (hardware/firmware),
>  	  and assumes the presence of OS-directed configuration and power
>  	  management (OSPM) software.  This option will enlarge your 
>  	  kernel by about 70K.
> @@ -23,20 +23,18 @@ menuconfig ACPI
>  	  the Plug-and-Play BIOS specification (PnP BIOS), the 
>  	  MultiProcessor Specification (MPS), and the Advanced Power 
>  	  Management (APM) specification.  If both ACPI and APM support 
> -	  are configured, whichever is loaded first shall be used.
> +	  are configured, ACPI is used.
>  
> -	  The ACPI SourceForge project contains the latest source code, 
> -	  documentation, tools, mailing list subscription, and other 
> -	  information.  This project is available at:
> -	  <http://sourceforge.net/projects/acpi>
> +	  The mailing list for ACPI in Linux is here:
> +	  <http://vger.kernel.org/vger-lists.html#linux-acpi>

per MAINTAINERS, the project home page is 
http://www.lesswatts.org/projects/acpi/

Probably sufficient to just point there...

>  	  Linux support for ACPI is based on Intel Corporation's ACPI
>  	  Component Architecture (ACPI CA).  For more information see:
>  	  <http://developer.intel.com/technology/iapc/acpi>

ACPICA's home page moved here:
http://acpica.org/

> -	  ACPI is an open industry specification co-developed by Compaq, 
> -	  Intel, Microsoft, Phoenix, and Toshiba.  The specification is 
> -	  available at:
> +	  ACPI is an open industry specification co-developed by
> +	  Hewlett-Packard, Intel, Microsoft, Phoenix, and Toshiba.
> +	  The specification is available at:
>  	  <http://www.acpi.info>
...

>  config ACPI_VIDEO
>  	tristate "Video"
> @@ -141,38 +149,48 @@ config ACPI_VIDEO
>  	depends on INPUT
>  	select THERMAL
>  	help
> -	  This driver implement the ACPI Extensions For Display Adapters
> +	  This driver implements the ACPI Extensions For Display Adapters
>  	  for integrated graphics devices on motherboard, as specified in
> -	  ACPI 2.0 Specification, Appendix B, allowing to perform some basic
> -	  control like defining the video POST device, retrieving EDID information
> -	  or to setup a video output, etc.
> -	  Note that this is an ref. implementation only.  It may or may not work
> -	  for your integrated video device.
> +	  ACPI 2.0 Specification, Appendix B.  This supports basic operations
> +	  such as defining the video POST device, retrieving EDID information,
> +	  and setting up a video output.
> +
> +	  Note that this is an reference implementation only.  It may not
> +	  work for your integrated video device.

we can probably strike the two lines above entirely.
It should work for everything that implements the spec,
and it is a bug if it does not.

> +
> +	  To compile this driver as a module, choose M here:
> +	  the module will be called video.
>  

thanks,
Len Brown, Intel Open Source Technology Center

