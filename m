From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [PATCH 2/3] USB/ACPI: Add usb port's acpi power control in the
 xhci PORT_POWER feature request process.
Date: Wed, 13 Jun 2012 13:53:29 -0700
Message-ID: <20120613205329.GA5597@xanatos>
References: <1339381474-17413-1-git-send-email-tianyu.lan@intel.com>
 <1339381474-17413-3-git-send-email-tianyu.lan@intel.com>
 <20120613193038.GA6312@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5914 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709Ab2FMUxb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Jun 2012 16:53:31 -0400
Content-Disposition: inline
In-Reply-To: <20120613193038.GA6312@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu

On Wed, Jun 13, 2012 at 12:30:38PM -0700, Greg KH wrote:
> On Mon, Jun 11, 2012 at 10:24:33AM +0800, Lan Tianyu wrote:
> > +
> > +			if (usb_acpi_power_manageable(hcd->self.root_hub,
> > +					wIndex + 1))
> 
> Why +1?  If you have to do this everywhere, then do it only in the
> function, so you can be 0 based properly.
> 
> Also, minor coding style nit, please rewrite as:
> 			if (usb_acpi_power_manageable(hcd->self.root_hub,
> 						      wIndex + 1))

This is an arbitrarily applied rule, and I don't follow it in the xHCI
driver.  The code indentation should be left at the default indentation
in the xHCI driver.  Let's keep the code style in the driver consistent,
please.

I don't understand why people want to move the trailing arguments to
align with the function parenthesis.  I can see that it might add to
readability for some people, but it's just more work on both the
developer's and maintainer's side.

Checkpatch will complain about mixed tabs and spaces, so that's more
work for me to edit my git pre-commit hook when the checkpatch error
stops git-am.  Plus the developer has to actually pause and think about
indentation, rather than letting their editor take care of it.

I'm not even sure when you would want the alignment rule applied.  In
all function calls with trailing arguments?  That seems really
excessive.

> Or even better yet, use a temp variable for the value returned and then
> check that, it's clearer and easier to read, right?

A temp variable would be fine until that function can just be
refactored.  The case statements should really just be broken out into
separate functions.

Sarah Sharp
