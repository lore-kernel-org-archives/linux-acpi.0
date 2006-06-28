From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources
Date: Wed, 28 Jun 2006 09:02:48 +0800
Message-ID: <1151456568.21189.84.camel@sli10-desk.sh.intel.com>
References: <CFF307C98FEABE47A452B27C06B85BB6D8C7C7@hdsmsx411.amr.corp.intel.com>
	 <20060627000324.b9457fb4.akpm@osdl.org> <20060627073704.GD3438@neo.rr.com>
	 <1151393390.21189.59.camel@sli10-desk.sh.intel.com>
	 <1151409746.44a11e52e7002@imp8-g19.free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:24843 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932663AbWF1BHi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Jun 2006 21:07:38 -0400
In-Reply-To: <1151409746.44a11e52e7002@imp8-g19.free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: castet.matthieu@free.fr
Cc: Adam Belay <ambx1@neo.rr.com>, Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, bjorn.helgaas@hp.com, uwe.bugla@gmx.de

On Tue, 2006-06-27 at 14:02 +0200, castet.matthieu@free.fr wrote:
> Selon Shaohua Li <shaohua.li@intel.com>:
> 
> >
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c4bb6f5ad968540d7f9619565bacd18d7419b85f
> > Thanks and sorry I didn't find the issue before. We'd better blacklist
> > root bridge. I saw at lest one BIOS (IA64 box) didn't assign correct
> > producer/consumer flag to root bridge resources. Blacklist it is much
> > safer.
> 
> Is only PNP0A03 is producer type in __all__ ACPI possible devices ?
> If not we will have the same problem with others devices...
> 
> I don't think blacklist is the solution : pnpacpi should be able to handle all
> ressources types : we should complete the implementation instead of blacklist
> devices our implementation doesn't support.
> 
> If there are broken ACPI bios, there should be firmware update, a patched dsdt
> or a quirk, but no "quirk and no generic solution".
>From my understanding, if the device is really a PNP device its resource
should not be producer.
Or could we take this way, merge both patches (both patches are good to
me), which should be safer. Anyway, it doesn't make sense to export root
bridge to pnp layer to me.

Thanks,
Shaohua
