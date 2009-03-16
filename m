From: Mattia Dongili <malattia@linux.it>
Subject: Re: The Garbled screen issue on Sony laptops with two graphics
	(Intel and Nvidia)
Date: Mon, 16 Mar 2009 20:28:51 +0900
Message-ID: <20090316112851.GB28025@kamineko.org>
References: <1236739527.2820.178.camel@rzhang-dt> <20090311024652.GA14493@srcf.ucam.org> <1236756550.2820.218.camel@rzhang-dt> <20090311130847.GC13101@kamineko.org> <20090316102423.GA16889@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:35595
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760653AbZCPL24 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2009 07:28:56 -0400
Content-Disposition: inline
In-Reply-To: <20090316102423.GA16889@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

On Mon, Mar 16, 2009 at 10:24:23AM +0000, Matthew Garrett wrote:
> On Wed, Mar 11, 2009 at 10:08:47PM +0900, Mattia Dongili wrote:
> 
> > - some models have different magic numbers for the _DSM invocation, from
> >   the DSDT I have available:
> > 	DSDT.sz.xxx.dsl (some uknown model)
> > 	DSDT.sz61mn-forXP.dsl
> > 	DSDT.tt11lnb.dsl
> > 	DSDT.z11vn.dsl
> > 	DSDT.z90s.dsl
> > 	VGN-SZ4XWNC-R0111N0.dsl
> >   and for what I can see, z and tt have the same magic numbers while the
> >   sz has different ones. So the code that calls _DSM will need to have
> >   some DMI switch to make sure we are calling it with the right
> >   parameters (for now supporting z and tt might be enough)
> 
> _DSM is "Device Specific Method". The magic numbers it requires are 
> interface descriptions. How many of these machines have nvidia-based 
> dual GPU architectures?

SZ and Z have dual GPUs (Intel onboard + NVidia), TT doesn't.

>                         Are the _DSM methods always attached to the 
> nvidia device?

As far as I can see the Z is the only one having it attached to the
nvidia device.
You can have a look at the DSDTs here:
http://www.kamineko.org/dsdt-vaio/

-- 
mattia
:wq!
