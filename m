From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: pnpacpi: reduce printk severity for "pnpacpi: exceeded the max
	number of ..."
Date: Thu, 17 Apr 2008 10:09:39 -0700
Message-ID: <20080417170939.GD17220@sequoia.sous-sol.org>
References: <20080417010122.148289106@sous-sol.org> <20080417010359.629397865@sous-sol.org> <20080417152405.GB14206@tull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sous-sol.org ([216.99.217.87]:48755 "EHLO sous-sol.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760507AbYDQRMg (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Thu, 17 Apr 2008 13:12:36 -0400
Content-Disposition: inline
In-Reply-To: <20080417152405.GB14206@tull.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nick Andrew <nick@nick-andrew.net>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org, stable@kernel.org, Linux-acpi@vger.kernel.org, Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Michael Krufky <mkrufky@linuxtv.org>, Chuck Ebbert <cebbert@redhat.com>, Domenico Andreoli <cavokz@gmail.com>, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>

* Nick Andrew (nick@nick-andrew.net) wrote:
> On Wed, Apr 16, 2008 at 06:02:20PM -0700, Chris Wright wrote:
> > -		printk(KERN_ERR "pnpacpi: exceeded the max number of IRQ "
> > +		printk(KERN_WARNING "pnpacpi: exceeded the max number of IRQ "
> >  				"resources: %d \n", PNP_MAX_IRQ);
> 
> This is a good time to delete that whitespace before the newline
> in this hunk plus the two following. Unless you're going to go to
> dynamic memory allocation for these arrays in a month and wipe
> out all this code.

Not for -stable...maybe upstream, send Len a patch.
