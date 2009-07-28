From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 03/12] SFI: document boot param "sfi=off"
Date: Tue, 28 Jul 2009 15:52:00 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0907281548150.16740@localhost.localdomain>
References: <1247026438-20891-1-git-send-email-lenb@kernel.org>
 <57dac60d76c191e3bd72f186833fac01e4c5f8f1.1247025117.git.len.brown@intel.com>
 <200907281324.03237.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41556 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751307AbZG1Tw1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Jul 2009 15:52:27 -0400
In-reply-to: <200907281324.03237.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: x86@kernel.org, sfi-devel@simplefirmware.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Feng Tang <feng.tang@intel.com>

> On Tuesday 07 July 2009 10:13:49 pm Len Brown wrote:
> > From: Feng Tang <feng.tang@intel.com>
> > 
> > "sfi=off" is analogous to "acpi=off"
> > 
> > In practice, "sfi=off" isn't likely to be very useful, for
> > 1. SFI is used only when ACPI is not available
> > 2. Today's SFI systems are not legacy PC-compatible
> > 
> > ie. "sfi=off" on an ACPI-platform is a NO-OP,
> > and "sfi=off" on an SFI-platform will likely result in boot failure.
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > Signed-off-by: Len Brown <len.brown@intel.com>
> > ---
> >  Documentation/kernel-parameters.txt |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> 
> I think the documentation update should be part of the patch
> that changes the functionality, so the doc always matches the
> code.

True.
I was somewhat lazy when i generated this patch series
from as single patch, and split mainly in groups of files.

Re: sfi=off
I'm actually going to delete this one --
perhaps adding it later when/if it does something useful.

thanks,
-Len Brown, Intel Open Source Technology Center


