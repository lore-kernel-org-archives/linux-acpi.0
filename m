From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: The Garbled screen issue on Sony laptops with two graphics (Intel and Nvidia)
Date: Mon, 16 Mar 2009 11:33:20 +0000
Message-ID: <20090316113320.GA18455@srcf.ucam.org>
References: <1236739527.2820.178.camel@rzhang-dt> <20090311024652.GA14493@srcf.ucam.org> <1236756550.2820.218.camel@rzhang-dt> <20090311130847.GC13101@kamineko.org> <20090316102423.GA16889@srcf.ucam.org> <20090316112851.GB28025@kamineko.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59287 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691AbZCPLd3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2009 07:33:29 -0400
Content-Disposition: inline
In-Reply-To: <20090316112851.GB28025@kamineko.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Mon, Mar 16, 2009 at 08:28:51PM +0900, Mattia Dongili wrote:
> On Mon, Mar 16, 2009 at 10:24:23AM +0000, Matthew Garrett wrote:
> > _DSM is "Device Specific Method". The magic numbers it requires are 
> > interface descriptions. How many of these machines have nvidia-based 
> > dual GPU architectures?
> 
> SZ and Z have dual GPUs (Intel onboard + NVidia), TT doesn't.

There's been two generations of dual GPU machines - ones that support 
runtime switching (whih I think is limited to the Z?) and ones that 
don't (the early SZs at least, probably all of them). The _DSM stuff 
we're interested in is for the runtime switching.

> >                         Are the _DSM methods always attached to the 
> > nvidia device?
> 
> As far as I can see the Z is the only one having it attached to the
> nvidia device.

In that case I think we're fine only worrying about that case. The 
interesting thing now is in whether this is Sony-specific or whether the 
same method is specified for other systems switching between the nvidia 
chipsets.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
