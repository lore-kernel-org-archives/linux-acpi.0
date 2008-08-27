From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: How can a patch be merged upstream?
Date: Thu, 28 Aug 2008 00:11:23 +0100
Message-ID: <200808280011.24839.carlos@strangeworlds.co.uk>
References: <5f6f8c5f0808250726h4649ddferff1be82c7d6203ba@mail.gmail.com> <1219712802.4116.32.camel@yakui_zhao.sh.intel.com> <20080827230939.GF26610@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:34100 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756478AbYH0XLh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Aug 2008 19:11:37 -0400
In-Reply-To: <20080827230939.GF26610@one.firstfloor.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Zhao Yakui <yakui.zhao@intel.com>, "Joshua C." <joshuacov@googlemail.com>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Thursday 28 August 2008 00:09:39 Andi Kleen wrote:
> > Linux can't work normally while Windows can work on such broken BIOS. Of
> > course the issue is related with the broken BIOS. The _REG object of EC
> > device is incorrect, which causes that EC device can't be initialized
> > correctly.
> > After this workaround patch is applied, Linux can also work. IMO this
> > workaround patch is reasonable.
>
> Can you please submit it with proper description?

It might also be worth CC'ing this patch (in its final form) to stable@.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
