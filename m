From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [ACPI] Re: [PATCH] PNPACPI: fix types when decoding ACPI	resources
 [resend]
Date: Sun, 28 Aug 2005 19:40:59 +0200
Message-ID: <4311F72B.2010106@free.fr>
References: <200508020955.54844.bjorn.helgaas@hp.com>	 <1123030861.2937.4.camel@linux-hp.sh.intel.com>	 <200508030920.13450.bjorn.helgaas@hp.com>  <42F1343B.70707@free.fr> <1123116712.2929.8.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750710AbVH1Rkr@vger.kernel.org>
In-Reply-To: <1123116712.2929.8.camel@linux-hp.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, acpi-devel@lists.sourceforge.net, Adam Belay <ambx1@neo.rr.com>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi,

Shaohua Li wrote:
> On Wed, 2005-08-03 at 23:16 +0200, matthieu castet wrote:
> 
>>There are drivers/acpi/motherboard.c that done some stuff already handle 
>>by pnp/system.c.
> 
> Yes, it should be disabled if pnpacpi is enabled. 
But even if pnpacpi is disabled, pnp/system.c sould work with pnpbios.
> The only concern is
> motherboard.c also request some ACPI resources, which might not declaim
> in ACPI motherboard device, but it's completely BIOS dependent. We might
> could try remove it at -mm tree to see if it breaks any system later.
> 
> 
Ok,
may be we should split in 2 modules : the one that request some ACPI 
resources and the other that use PNP resource.
>>PS : I saw in acpi ols paper that you plan once all dupe acpi drivers 
>>will be removed to register again the pnp device in acpi layer. Do you 
>>plan to add more check and for example add only device that have a CRS 
>>in pnp layer ?
> 
> For detecting PNP device? it's worthy trying.
> 

I will send a patch for that.

Matthieu
