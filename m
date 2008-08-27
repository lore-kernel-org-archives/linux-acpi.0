From: Andi Kleen <andi@firstfloor.org>
Subject: Re: How can a patch be merged upstream?
Date: Thu, 28 Aug 2008 01:37:28 +0200
Message-ID: <20080827233728.GH26610@one.firstfloor.org>
References: <5f6f8c5f0808250726h4649ddferff1be82c7d6203ba@mail.gmail.com> <1219712802.4116.32.camel@yakui_zhao.sh.intel.com> <20080827230939.GF26610@one.firstfloor.org> <200808280011.24839.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:34732 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756676AbYH0Xey (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2008 19:34:54 -0400
Content-Disposition: inline
In-Reply-To: <200808280011.24839.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Andi Kleen <andi@firstfloor.org>, Zhao Yakui <yakui.zhao@intel.com>, "Joshua C." <joshuacov@googlemail.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Thu, Aug 28, 2008 at 12:11:23AM +0100, Carlos Corbacho wrote:
> On Thursday 28 August 2008 00:09:39 Andi Kleen wrote:
> > > Linux can't work normally while Windows can work on such broken BIOS. Of
> > > course the issue is related with the broken BIOS. The _REG object of EC
> > > device is incorrect, which causes that EC device can't be initialized
> > > correctly.
> > > After this workaround patch is applied, Linux can also work. IMO this
> > > workaround patch is reasonable.
> >
> > Can you please submit it with proper description?
> 
> It might also be worth CC'ing this patch (in its final form) to stable@.

I don't think it's stable material because it doesn't fix a serious Linux
bug.

-Andi
