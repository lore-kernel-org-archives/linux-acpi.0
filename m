From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: How can a patch be merged upstream?
Date: Thu, 28 Aug 2008 09:18:56 +0800
Message-ID: <1219886336.4116.60.camel@yakui_zhao.sh.intel.com>
References: <5f6f8c5f0808250726h4649ddferff1be82c7d6203ba@mail.gmail.com>
	 <1219712802.4116.32.camel@yakui_zhao.sh.intel.com>
	 <20080827230939.GF26610@one.firstfloor.org>
	 <200808280011.24839.carlos@strangeworlds.co.uk>
	 <20080827233728.GH26610@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58408 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845AbYH1BDn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 27 Aug 2008 21:03:43 -0400
In-Reply-To: <20080827233728.GH26610@one.firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, "Joshua C." <joshuacov@googlemail.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Thu, 2008-08-28 at 01:37 +0200, Andi Kleen wrote:
> On Thu, Aug 28, 2008 at 12:11:23AM +0100, Carlos Corbacho wrote:
> > On Thursday 28 August 2008 00:09:39 Andi Kleen wrote:
> > > > Linux can't work normally while Windows can work on such broken BIOS. Of
> > > > course the issue is related with the broken BIOS. The _REG object of EC
> > > > device is incorrect, which causes that EC device can't be initialized
> > > > correctly.
> > > > After this workaround patch is applied, Linux can also work. IMO this
> > > > workaround patch is reasonable.
> > >
> > > Can you please submit it with proper description?
> > 
> > It might also be worth CC'ing this patch (in its final form) to stable@.
> 
> I don't think it's stable material because it doesn't fix a serious Linux
> bug.
This workaround patch is meaning for the broken BIOS with the incorrect
the definition of EC _REG object. And it won't break other normal
laptop.

Maybe that Linux can't work on such broken BIOS is caused by that the
check on Linux is stricter than windows.


> 
> -Andi

