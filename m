From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: acpi.sourceforge.net DSDT collection - Get acpidumps for research
Date: Sat, 19 Apr 2008 00:06:01 +0100
Message-ID: <20080418230601.GA10935@srcf.ucam.org>
References: <1208540512.31815.74.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mjg.x.mythic-beasts.com ([93.93.128.6]:40406 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbYDRXGS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Apr 2008 19:06:18 -0400
Content-Disposition: inline
In-Reply-To: <1208540512.31815.74.camel@linux-2bdv.site>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Yu, Ling L" <ling.l.yu@intel.com>, Len Brown <lenb@kernel.org>, tytso@MIT.EDU

On Fri, Apr 18, 2008 at 07:41:52PM +0200, Thomas Renninger wrote:

> For vendors who want and will provide osi Vista SPX BIOS updates and
> also want to reliably support Linux, they have to compile
> osi="Linux Distribution I support" to return true into their Linux
> kernels.

Providing OSI only makes sense if we can commit to providing a stable 
interface. We can't make that commitment, so it makes no sense to 
provide it. If Suse are willing to make that commitment within a 
release, then go for it - but do bear in mind that it may restrict the 
bug fixes you can make.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
