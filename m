From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [ANNOUNCE] ACPI BIOS Guideline for Linux
Date: Sat, 30 Aug 2008 13:47:13 +0100
Message-ID: <20080830124713.GA5910@srcf.ucam.org>
References: <200807241732.23412.trenn@suse.de> <200808281416.57193.trenn@suse.de> <20080828122227.GA26285@srcf.ucam.org> <200808291729.53628.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44553 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbYH3MrV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Aug 2008 08:47:21 -0400
Content-Disposition: inline
In-Reply-To: <200808291729.53628.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Andi Kleen <ak@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Aug 29, 2008 at 05:29:52PM +0200, Thomas Renninger wrote:
> On Thursday 28 August 2008 14:22:29 Matthew Garrett wrote:
> > Little. But what advantage do we get in the same functionality being
> > implemented in an entirely custom way? Even less.
> It is all about documentation, right.
> WMI is complicating things by one needless and complicated layer.

Not really. It provides approximately no complexity for Linux drivers, 
and makes it easier for vendors to provide Windows support. WMI has not 
been the hard bit of the drivers I've written. I don't see any reason to 
ask vendors not to use it, as long as they're willing to document their 
implementation.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
