From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [ANNOUNCE] ACPI BIOS Guideline for Linux
Date: Thu, 28 Aug 2008 11:56:16 +0100
Message-ID: <20080828105616.GA24515@srcf.ucam.org>
References: <200807241732.23412.trenn@suse.de> <200808272129.16131.carlos@strangeworlds.co.uk> <200808281141.30178.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34096 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbYH1K4U (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Aug 2008 06:56:20 -0400
Content-Disposition: inline
In-Reply-To: <200808281141.30178.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Andi Kleen <ak@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Aug 28, 2008 at 11:41:28AM +0200, Thomas Renninger wrote:
> On Wednesday 27 August 2008 22:29:15 Carlos Corbacho wrote:
> > Perhaps it would be more useful to suggest to vendors/ BIOS writers what
> > they should use here instead?
> 
> They can use their own devices.
> There is a section about if you provide your own device, document it, etc.:
> 
> 2 Vendor specific ACPI implementations
> ...
> 2. If new devices or functions are introduced, document how to use them. A
>    short specification or a request for comments (RFC) can form the basis of
>    a new standard which follows your needs.
> 
> 
> But yes, it could be pointed out clearer.
> I'll look closer at it when I touch it the next time.
> Text snippets/suggestions are also appreciated.

A documented WMI interface is easier to use than an entirely custom 
documented interface, and reduces the amount of work the vendor has to 
do in Windows. To be honest, I think it's the sort of thing we should be 
encouraging.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
