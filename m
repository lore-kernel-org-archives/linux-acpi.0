From: Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: [PATCH 8/25] msi: Simplify the msi irq limit policy.
Date: Tue, 20 Jun 2006 18:28:38 -0700
Message-ID: <20060620182838.E10402@unix-os.sc.intel.com>
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com> <11508425183073-git-send-email-ebiederm@xmission.com> <11508425191381-git-send-email-ebiederm@xmission.com> <11508425192220-git-send-email-ebiederm@xmission.com> <11508425191063-git-send-email-ebiederm@xmission.com> <1150842520235-git-send-email-ebiederm@xmission.com> <11508425201406-git-send-email-ebiederm@xmission.com> <1150842520775-git-send-email-ebiederm@xmission.com> <11508425213394-git-send-email-ebiederm@xmission.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:5987 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932451AbWFUBgi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jun 2006 21:36:38 -0400
Content-Disposition: inline
In-Reply-To: <11508425213394-git-send-email-ebiederm@xmission.com>; from ebiederm@xmission.com on Tue, Jun 20, 2006 at 04:28:21PM -0600
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, discuss@x86-64.org, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>, Natalie Protasevich <Natalie.Protasevich@UNISYS.com>, Len Brown <len.brown@intel.com>, Kimball Murray <kimball.murray@gmail.com>, Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>, Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>, Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>, "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>, Mark Maule <maule@sgi.com>, Jesper Juhl <jesper.juhl@gmail.com>, Shaohua Li <shaohua.li@intel.com>, Matthew Wilcox <matthew@wil.cx>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>

On Tue, Jun 20, 2006 at 04:28:21PM -0600, Eric W. Biederman wrote:
> Currently we attempt to predict how many irqs we will be
> able to allocate with msi using pci_vector_resources and some
> complicated accounting, and then we only allow each device
> as many irqs as we think are available on average.
> 
> Only the s2io driver even takes advantage of this feature
> all other drivers have a fixed number of irqs they need and
> bail if they can't get them.
> 
> pci_vector_resources is inaccurate if anyone ever frees an irq.
> The whole implmentation is racy.  The current irq limit policy
> does not appear to make sense with current drivers.  So I have
> simplified things.  We can revisit this we we need a more sophisticated
> policy.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>  arch/i386/pci/irq.c |   30 -----------------------------
>  arch/ia64/pci/pci.c |    9 ---------
>  drivers/pci/msi.c   |   53 ++++++++-------------------------------------------
>  drivers/pci/msi.h   |   11 -----------
>  4 files changed, 8 insertions(+), 95 deletions(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 40499c0..772f5b6 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
>  
> @@ -542,11 +540,6 @@ void pci_scan_msi_device(struct pci_dev 
>  {
>  	if (!dev)
>  		return;
> -
> -   	if (pci_find_capability(dev, PCI_CAP_ID_MSIX) > 0)
> -		nr_msix_devices++;
> -	else if (pci_find_capability(dev, PCI_CAP_ID_MSI) > 0)
> -		nr_reserved_vectors++;
>  }
Actually, why not just eliminate this function and the
corresponding call from probe.c? It does nothing useful with all
the vector tracking gone from generic MSI code.

Rajesh
