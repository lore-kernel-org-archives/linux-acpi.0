From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Buggy BIOS on the HP TX2500-series
Date: Thu, 9 Oct 2008 02:11:50 +0100
Message-ID: <20081009011150.GA7496@srcf.ucam.org>
References: <331496.52627.qm@web23007.mail.ird.yahoo.com> <20081008192641.GA1932@srcf.ucam.org> <1223513955.2735.28.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:39630 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754107AbYJIBL6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Oct 2008 21:11:58 -0400
Content-Disposition: inline
In-Reply-To: <1223513955.2735.28.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Gandalf Kristensen <gandkri@yahoo.no>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, "Lin, Ming M" <ming.m.lin@intel.com>

On Thu, Oct 09, 2008 at 08:59:15AM +0800, Zhang Rui wrote:
> On Wed, 2008-10-08 at 12:26 -0700, Matthew Garrett wrote:
> > A patch went into the kernel earlier this year to ignore critical trip
> > points that were below 0.
> well, I think this patch is wrong.
> a critical trip point below 0 Celsius doesn't mean it's invalid.

I think it's pretty clear that a critical trip point below 0 celsius 
means that the critical trip point is invalid, though I agree that 
ignoring the entire thermal zone as a result is somewhat unfortunate.

> windows can work well on this laptop.
> please look at:
> http://bugzilla.kernel.org/show_bug.cgi?id=10686#c13
> IMO, we need to fix the ACPICA code first of all.
> 
> Ming, what do you think of the patch in comment #15 and #16?

We could quibble over the technical correctness of this approach, but it 
seems to behave in exactly the same way - ie, Linux will ignore the 
thermal zone? The existing code seems fine, other than the fact that a 
bad _CRT will result everything failing. I think we'd be better off just 
losing the return -ENODEV there and try to use as much of the thermal 
information as we can.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
