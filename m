From: Len Brown <lenb@kernel.org>
Subject: Re: [patch] ACPI: make debug command-line arguments work again
Date: Fri, 19 Dec 2008 00:00:24 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812182358320.6312@localhost.localdomain>
References: <200811131630.14781.bjorn.helgaas@hp.com>
 <200811141857.56181.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:60814 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbYLSFA3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Dec 2008 00:00:29 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KC300JB2XWP0D84@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 18 Dec 2008 23:00:26 -0600 (CST)
In-reply-to: <200811141857.56181.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-acpi@vger.kernel.org, Randy Dunlap <rdunlap@xenotime.net>


> >  /* Debug switch - level and trace mask */
> > -u32 acpi_dbg_level = ACPI_DEBUG_DEFAULT;
> > +u32 acpi_dbg_level = ACPI_LV_INFO;

> This is acpica code.
> If this one is/can be touched, then we should modify
> ACPI_DEBUG_DEFAULT directly? (see patch in the end)
> 
> >
> >  /* Debug switch - layer (component) mask */
> >
> > -u32 acpi_dbg_layer = ACPI_COMPONENT_DEFAULT | ACPI_ALL_DRIVERS;
> > +u32 acpi_dbg_layer = 0;
> IMO we should keep dbg_layer high and only lower the level.
> Like that you only have to fiddle with one param for general
> debugging (e.g. when requesting info in a bug report).
> 
> This is what should be in OpenSUSE for quite a while.
> init seems not to be used.

Actually, ACPI_DB_INIT _is_ used -- it is what prints
out those annoying dots...

I'll be happy to see it off by default.

thanks,
-- Len Brown, Intel Open Source Technology Center

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

