From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI, APEI, Add APEI _OSC support
Date: Fri, 17 Jun 2011 02:42:13 +0100
Message-ID: <20110617014213.GA30826@srcf.ucam.org>
References: <20110614145246.GA17469@srcf.ucam.org>
 <4DF82CBC.5070400@intel.com>
 <20110615121703.GA8638@srcf.ucam.org>
 <4DF950EB.7050400@intel.com>
 <20110616013812.GA32494@srcf.ucam.org>
 <4DF962AE.60204@intel.com>
 <20110616015736.GA32533@srcf.ucam.org>
 <4DFAA665.8070305@intel.com>
 <20110617013442.GA30708@srcf.ucam.org>
 <4DFAB081.6050800@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50649 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547Ab1FQBmY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Jun 2011 21:42:24 -0400
Content-Disposition: inline
In-Reply-To: <4DFAB081.6050800@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Fri, Jun 17, 2011 at 09:40:17AM +0800, Huang Ying wrote:
> On 06/17/2011 09:34 AM, Matthew Garrett wrote:
> > If the kernel has been configured with support for the feature then I 
> > think we ought to be able to assume that the kernel will support it at 
> > runtime.
> 
> There may be error during driver initialization.  That is what I am
> concerned.

That's true of any _OSC functionality.

> >> So I think we can do that in 2 steps.  At first, we just enable WHEA
> >> UUID, because that is easier to do.  Then we find a way to implement
> >> "APEI bit" in generic _OSC call.  Do you think that is a good idea?
> > 
> > I'm fine with that, providing that GHES isn't disabled purely because 
> > the WHEA UUID call wasn't successful.
> 
> Because we have not added the code to make generic _OSC call with "APEI
> bit" now, so if WHEA UUID call failed, we have no firmware first mode
> enabled.  So I think it is safe to disable GHES if WHEA UUID call
> failed.  But in another hand, keeping GHES has no harm too.  So I am OK
> to keep GHES if WHEA UUID call failed.

I see your point. But this does need to be fixed in the long run.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
