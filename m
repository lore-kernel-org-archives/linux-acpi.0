From: emisca <emisca.ml@gmail.com>
Subject: Re: [0/5] remove ACPI motherboard driver, use PNP system driver instead (take 2)
Date: Fri, 19 Jan 2007 16:37:39 +0100
Message-ID: <414cba4e0701190737j110b33aau25789808767953fa@mail.gmail.com>
References: <200701181636.45590.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:26220 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932156AbXASPhl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jan 2007 10:37:41 -0500
Received: by ug-out-1314.google.com with SMTP id 44so482674uga
        for <linux-acpi@vger.kernel.org>; Fri, 19 Jan 2007 07:37:40 -0800 (PST)
In-Reply-To: <200701181636.45590.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Adam Belay <ambx1@neo.rr.com>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>

I have posted some days ago, some problems on resume from suspend to
disk on my motherboard (asus p5ld2 se) related to acpi pnp. The serial
didn't worked after resume. Using pnpacpi=off it worked.
Now using this patch what will be the behaviour?

Bye

2007/1/19, Bjorn Helgaas <bjorn.helgaas@hp.com>:
> The ACPI motherboard driver is mostly redundant with the PNP system
> driver.  This series moves the little bit of ACPI-specific stuff out
> of the motherboard driver into acpi/osl.c, adds a little bit to the
> PNP system driver so it covers all the remaining functionality of
> the ACPI driver, and removes the ACPI driver.
>
> Thanks for the comments on the previous version.  This set of patches:
>
>   - Makes acpi_reserve_resources() a device_initcall(), so the FADT
>     resources will be reserved after the pnp/system driver claims its
>     resources.  This lets us reserve a motherboard region larger than
>     the FADT describes without conflicts.
>
>   - Adds CONFIG_PNPACPI=y to the i386/defconfig patch.  This is needed
>     for the pnp/system driver to find its devices.
>
> Len asked about the CONFIG_PNP=n, CONFIG_ACPI=y case.  In this case,
> we won't have a pnp/system driver to claim motherboard resources.  But
> we already have this situation with other devices.  My IR device
> responds to ioports 0x100-0x10f and my ECP parallel port responds to
> ioports 0x778-0x77a.  If those drivers aren't loaded (or if they
> aren't smart enough to claim all the resources), the resources just
> aren't claimed.
>
> So I think a better solution for this problem would be to make the
> PNP core reserve all the regions for every active device, similar to
> what PCI does.
>
> Bjorn
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
