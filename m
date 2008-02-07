From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 053/112] the generic thermal sysfs driver
Date: Thu, 7 Feb 2008 21:48:33 +0000
Message-ID: <20080207214833.GA4682@srcf.ucam.org>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com> <203d3d4aa482339b4816f131f713e1b8ee37f6dd.1202376824.git.len.brown@intel.com> <20080207200900.GA2082@srcf.ucam.org> <200802071638.43935.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:55249 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758654AbYBGVss (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 16:48:48 -0500
Content-Disposition: inline
In-Reply-To: <200802071638.43935.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Thomas Sujith <sujith.thomas@intel.com>

On Thu, Feb 07, 2008 at 04:38:43PM -0500, Len Brown wrote:
> On Thursday 07 February 2008 15:09, Matthew Garrett wrote:
> > There's still ongoing discussion about what the interface should look 
> > like (and I certainly agree that the difference in units between this 
> > class and hwmon should be a showstopper) - can we skip pushing this 
> > until those are resolved?
> 
> It is upstream now.
> 
> I'm hopeful that getting into -rc1 will poke us to get
> these issues resolved sooner than if we had kept the
> series out of tree.  I'm also hopeful that we'll have
> no major issues with it by 2.6.25.final.

Given that it'll end up defining ABI, if it's not sorted by final then 
we'll really need to pull it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
