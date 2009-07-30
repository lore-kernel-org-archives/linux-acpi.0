From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: bind workqueues to CPU 0 to avoid SMI corruption
Date: Thu, 30 Jul 2009 03:55:54 +0100
Message-ID: <20090730025554.GD26389@srcf.ucam.org>
References: <20090729215425.23674.80263.stgit@bob.kio> <20090730024300.GA30451@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:49150 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbZG3C4A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Jul 2009 22:56:00 -0400
Content-Disposition: inline
In-Reply-To: <20090730024300.GA30451@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Jul 30, 2009 at 10:43:00AM +0800, Shaohua Li wrote:
> On Thu, Jul 30, 2009 at 05:54:25AM +0800, Bjorn Helgaas wrote:
> > On some machines, a software-initiated SMI causes corruption unless the
> > SMI runs on CPU 0.  An SMI can be initiated by any AML, but typically it's
> > done in GPE-related methods that are run via workqueues, so we can avoid
> > the known corruption cases by binding the workqueues to CPU 0.
> > 
> > References:
> >     http://bugzilla.kernel.org/show_bug.cgi?id=13751
> >     https://bugs.launchpad.net/bugs/157171
> >     https://bugs.launchpad.net/bugs/157691
> Good job! Since any AML code can invoke a SMI, I wonder if all ACPICA should be
> limited to run on CPU 0?

If ACPI is a performance bottleneck then we have other problems, so I 
suspect that we could live with that. We'd probably want to be able to 
disable it at runtime for the small number of users who have 
"interesting" performance requirements, but falling on the side of 
safety over slightly reduced latency under some circumstances seems fair 
to me. It'd be interesting to see if this helps with any of the other 
SMI-related hangs we've seen.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
