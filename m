From: David Hinds <dhinds@sonic.net>
Subject: Re: Re: [RFC] Add lspnp support for sysfs
Date: Sun, 22 Jan 2006 11:23:06 -0800
Message-ID: <20060122192306.GA20797@sonic.net>
References: <20060120024731.GA27435@neo.rr.com> <200601131051.36906.bjorn.helgaas@hp.com> <200601191650.59642.bjorn.helgaas@hp.com> <5004686.116921137837612492.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from b.mail.sonic.net ([64.142.19.5]:48053 "EHLO b.mail.sonic.net")
	by vger.kernel.org with ESMTP id S1750801AbWAVTYC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jan 2006 14:24:02 -0500
Content-Disposition: inline
In-Reply-To: <5004686.116921137837612492.komurojun-mbn@nifty.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Komuro <komurojun-mbn@nifty.com>
Cc: Adam Belay <ambx1@neo.rr.com>, Len Brown <len.brown@intel.com>, linux-pcmcia@lists.infradead.org, linux-acpi@vger.kernel.org, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>

On Sat, Jan 21, 2006 at 07:00:12PM +0900, Komuro wrote:
> 
> I want 'check_pnp_irq' api in the kernel pnp layer.
> to avoid irq conflict between 16bit-pcmcia card
> and on-board pnp-devices.
> 
> for example,
> int check_pnp_irq(int irq)
>   return  0 (unused)
>          -1 (used)
>          -2 (reserved)
>  
> Below is a known problems and limitations
> in the pcmcia-cs README-2.4
> 
> >  The kernel PCMCIA package cannot be configured to use PnP BIOS calls
> >  for resource management.  Recent kernels do have PnP BIOS support
> >  but the "glue" hasn't been written.

The correct way to fix this would be to have the PnP layer reserve all
resources defined by the PnP BIOS.

-- Dave
