From: Komuro <komurojun-mbn@nifty.com>
Subject: Re: Re: [RFC] Add lspnp support for sysfs
Date: Sat, 21 Jan 2006 19:00:12 +0900 (JST)
Message-ID: <5004686.116921137837612492.komurojun-mbn@nifty.com>
References: <20060120024731.GA27435@neo.rr.com>
 <200601131051.36906.bjorn.helgaas@hp.com>
	<200601191650.59642.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pxy2nd.nifty.com ([202.248.175.14]:60177 "HELO pxy2nd.nifty.com")
	by vger.kernel.org with SMTP id S1750772AbWAUKAP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Jan 2006 05:00:15 -0500
In-Reply-To: <20060120024731.GA27435@neo.rr.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-acpi@vger.kernel.org, linux-pcmcia@lists.infradead.org, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Len Brown <len.brown@intel.com>


Hello,

I want 'check_pnp_irq' api in the kernel pnp layer.
to avoid irq conflict between 16bit-pcmcia card
and on-board pnp-devices.

for example,
int check_pnp_irq(int irq)
  return  0 (unused)
         -1 (used)
         -2 (reserved)
 
Below is a known problems and limitations
in the pcmcia-cs README-2.4

>  The kernel PCMCIA package cannot be configured to use PnP BIOS calls
>  for resource management.  Recent kernels do have PnP BIOS support
>  but the "glue" hasn't been written.


Best Regards
Komuro

