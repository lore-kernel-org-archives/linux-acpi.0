From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Rationalise ACPI backlight implementation
Date: Sat, 26 Jan 2008 22:00:45 -0800
Message-ID: <20080126220045.b93db7c9.akpm@linux-foundation.org>
References: <20071226020325.GA21099@srcf.ucam.org>
	<200801241644.49114.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:34247 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751006AbYA0GBL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 Jan 2008 01:01:11 -0500
In-Reply-To: <200801241644.49114.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

> On Thu, 24 Jan 2008 16:44:48 -0500 Len Brown <lenb@kernel.org> wrote:
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
> 
> so my concern is that if we change what "10" means, somebody like akpm
> with an existing script gets grumpy.

It takes more than that to make me grumpy.  I've been very grumpy lately.

- Create a new /sys node with a new name which has the new semantics.

- Deprecate the old /sys entry by emitting an angry printk when someone
  uses it.

- Wait 12 months

- Kill the old one.

