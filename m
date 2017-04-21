From: Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH] acpi, nfit: fix the memory error check in nfit_handle_mce
Date: Fri, 21 Apr 2017 14:54:10 -0600
Message-ID: <20170421205410.GD10645@omniknight.lm.intel.com>
References: <20170420221818.23522-1-vishal.l.verma@intel.com>
 <CAPcyv4ijU2V-4WOPysL12ByOovAXDO=Mci1D4wNDFqxRjdvT2w@mail.gmail.com>
 <1492804517.2738.25.camel@intel.com>
 <3908561D78D1C84285E8C5FCA982C28F6127653B@ORSMSX114.amr.corp.intel.com>
 <20170421203551.GC10645@omniknight.lm.intel.com>
 <20170421205050.GA17595@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:59061 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161400AbdDUUzc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Apr 2017 16:55:32 -0400
Content-Disposition: inline
In-Reply-To: <20170421205050.GA17595@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Williams, Dan J" <dan.j.williams@intel.com>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 04/21, Luck, Tony wrote:
> On Fri, Apr 21, 2017 at 02:35:51PM -0600, Vishal Verma wrote:
> > On 04/21, Luck, Tony wrote:
> > > Needs extra parentheses to make it right. Vishal, sorry I led you astray.
> > > 
> > > 	if (!((mce->status & 0xef80) == BIT(7)))
> > 
> > Is this still right though? Anything AND'ed with 0xef80 will never equal
> > BIT(7) which is simply 01000000 binary (the lowest byte of the left hand
> > side is '0')
> 
> I think so ... here it is in binary
> 
> ef80 = 1110 1111 1000 0000
> BIT7 = 0000 0000 1000 0000
> 
> so the "&" will zap bits {6:0} and bit {12}  [and everything not part
> of the MCACOD field].
> 
> If mce->status had some bit above BIT(7) set, it won't be zapped, so we
> won't match the exact value BIT(7).

Ah, you're right, I was off by one, taking BIT(7) to mean 0100 0000

> 
> -Tony
