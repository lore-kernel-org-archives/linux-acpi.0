From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI, APEI, Add APEI _OSC support
Date: Wed, 15 Jun 2011 13:17:03 +0100
Message-ID: <20110615121703.GA8638@srcf.ucam.org>
References: <1306303538-30524-1-git-send-email-ying.huang@intel.com>
 <20110614145246.GA17469@srcf.ucam.org>
 <4DF82CBC.5070400@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44354 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab1FOMRS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Jun 2011 08:17:18 -0400
Content-Disposition: inline
In-Reply-To: <4DF82CBC.5070400@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Jun 15, 2011 at 11:53:32AM +0800, Huang Ying wrote:
> Hi, Matthew,
> On 06/14/2011 10:52 PM, Matthew Garrett wrote:
> > And then tear down GHES. This seems wrong. A platform could predicate 
> > APEI functionality on the ACPI spec APEI indication (which we currently 
> > don't pass) without implementing WHEA, but with this patch we'd refuse 
> > to enable GHES support? We should probably try both the standard method 
> > and the WHEA method and only disable GHES if both fail.
> 
> You means the "APEI Support" bit for standard UUID?  Do you know which
> machine uses this bit?  I can write the code, but I have no machine to
> test it.

I have access to a Dell system that uses this.

> BTW, it is better for us to enable APEI firmware first mode (that is,
> what is enabled by evaluating the WHEA UUID) after GHES reporting is
> ready (that is, after GHES module is successfully loaded).  That is
> later than current ACPI _OSC evaluation with standard UUID.  Is it
> possible to evaluate _OSC with standard UUID twice?  So that we can
> enable APEI firmware first mode later.

Urgh. One machine I've looked at enables APEI if the WHEA _OSC call is 
made, and then clears a flag if any other _OSC call is made. In that 
specific case it doesn't seem to matter (the flag never actually gets 
checked in any of the other codepaths), but it seems that the intention 
is for the generic call to be made and the WHEA one to be made after 
that.

> > (Also, are there any other sideeffects of indicating that we support 
> > WHEA?)
> 
> After evaluating _OSC with this UUID, firmware will produce error record
> to OS, otherwise only unknown NMI.

Ok, that sounds fine.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
