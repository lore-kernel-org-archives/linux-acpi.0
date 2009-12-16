From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 5/5 -v2] acpi, apei, Document for APEI
Date: Wed, 16 Dec 2009 12:55:45 +0800
Message-ID: <1260939345.13378.14.camel@yhuang-dev.sh.intel.com>
References: <1260429424.15264.397.camel@yhuang-dev.sh.intel.com>
	 <200912110958.29319.bjorn.helgaas@hp.com>
	 <1260780295.12561.118.camel@yhuang-dev.sh.intel.com>
	 <alpine.LFD.2.00.0912152322110.6885@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:39035 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755187AbZLPEzs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Dec 2009 23:55:48 -0500
In-Reply-To: <alpine.LFD.2.00.0912152322110.6885@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <ak@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, 2009-12-16 at 12:32 +0800, Len Brown wrote: 
> On Mon, 14 Dec 2009, Huang Ying wrote:
> 
> > On Sat, 2009-12-12 at 00:58 +0800, Bjorn Helgaas wrote: 
> > > On Thursday 10 December 2009 12:17:04 am Huang Ying wrote:
> > > > Add document for APEI, including kernel parameters and EINJ debug file
> > > > sytem interface.
> > > 
> > > From a stylistic point of view, I think it's better if the
> > > documentation is added by the same patch that adds the functionality.
> > > Having them in separate patches means there's a point in time where
> > > the tree contains the functionality but not the documentation, or
> > > vice versa.
> > 
> > Sounds reasonable, I will change this.
> 
> I don't mind if the documentation preceeds or follows the code
> in a patch series.  Personally, I'd probably put it in its own
> patch like you did just as a lazy way to keep the patches small.
> Anybody looking at this code will be looking at the whole series
> and it isn't as if documentation is going to break bisect...
> 
> What I do mind from a patch submitting style point of view
> is to start a series with [PATCH 2/5 -v2].

Sorry, because of typo, the series start with [PATH 1/5 -v2], which
should be [PATCH 1/5 -v2].

> Please start with 0/5 explaining the difference between v1 and v2;
> and then number staring with 1, not 2; else at first glance,
> everybody thinks that the most important patch is missing...
> 
> That said, all this code is under its own config option,
> making it relatively low risk.  The question is if there
> would be a significant benefit to merging this code upstream
> while we know there is still going to be some significant
> movement in this area before it is fully baked...
> 
> (that would be another thing to describe in 0/5...)

OK. I will add 0/5 about difference between versions and why we need
this patchset. This patchset only provides basic support for APEI, some
important part such as ERST, HEST generic error source, BERT is still
missing because they are not finalized. But the code in this patchset
will not change significantly, further development will be incremental.

In this patchset, HEST table parsing code can be used by PCIE AER
initialization code to prevent touch PCIE root port in firmware first
mode. EINJ can be used to test some RAS related code such as MCE and
PCIE AER.

Best Regards,
Huang Ying


