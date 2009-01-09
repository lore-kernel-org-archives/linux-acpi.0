From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] : ACPI : Use RSDT instead of XSDT by adding boot option of "acpi=rsdt"
Date: Fri, 9 Jan 2009 12:34:16 +0000
Message-ID: <20090109123416.GA31003@srcf.ucam.org>
References: <20081031184233.8588.42241.stgit@thinkpad> <200901091154.43606.trenn@suse.de> <alpine.LFD.2.00.0901090556360.4091@localhost.localdomain> <200901091316.16334.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52012 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752801AbZAIMeX (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 07:34:23 -0500
Content-Disposition: inline
In-Reply-To: <200901091316.16334.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, "Linux-acpi@vger.kernel.org" <Linux-acpi@vger.kernel.org>, me@markdoughty.co.uk, ibm-acpi-devel@lists.sourceforge.net

On Fri, Jan 09, 2009 at 01:16:15PM +0100, Thomas Renninger wrote:

> IMO this cannot generally be done, because chances are high that machines
> which do not support Windows likely will break.
> Chances are high that a machine which does not support Windows uses 64 bit
> addresses and leaves the 32 bit ones uninitialized, a spec valid configuration 
> which will then break.

Bear in mind that the values in the 32-bit entries are *io port* 
addresses, not physical memory addresses. There's only 16 bits of io 
ports, so the probability of the 64-bit values being programmed 
correctly and the 32-bit ones containing a valid but not-working set is 
tiny. If you know of any machines that behave this way, I'd be 
impressed - and it'll be far easier to dmi whitelist them than the other 
way around.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
