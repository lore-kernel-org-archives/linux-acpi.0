From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Rationalise ACPI backlight implementation
Date: Sun, 27 Jan 2008 02:06:07 +0000
Message-ID: <20080127020607.GA10173@srcf.ucam.org>
References: <20071226020325.GA21099@srcf.ucam.org> <200801241644.49114.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:52785 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbYA0CGS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 26 Jan 2008 21:06:18 -0500
Content-Disposition: inline
In-Reply-To: <200801241644.49114.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Jan 24, 2008 at 04:44:48PM -0500, Len Brown wrote:
> On Tuesday 25 December 2007 21:03, Matthew Garrett wrote:
> > The sysfs backlight class provides no mechanism for querying the 
> > acceptable brightness for a backlight. The ACPI spec states that values 
> > are only valid if they are reported as available by the firmware. Since 
> > we can't provide that information to userspace, instead collapse the 
> > range to the number of actual values that can be set.
> > 
> > Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>
> 
> I wish we did this in the first place.
> But doing it now is an API change -- since
> with the old way 100 always meant 100% brightness, yes?

Yes.

> so my concern is that if we change what "10" means, somebody like akpm
> with an existing script gets grumpy.

I don't buy that argument. Assuming that the values will always result 
in an identical brightness is making incorrect assumptions about the 
API. For example, consider the case where a bug means that only half the 
hardware's available brightness levels are exposed. Fixing that bug 
would change the meaning of the numbers, but it's not an API change in 
any real way. Anyone using the backlight class should check the 
maximum_brightness field before deciding what range of values to use.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
