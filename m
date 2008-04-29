From: Greg KH <greg@kroah.com>
Subject: Re: PM: New suspend and hibernation callbacks for PCI bus type
Date: Tue, 29 Apr 2008 15:26:58 -0700
Message-ID: <20080429222658.GA5437@kroah.com>
References: <200804131534.52548.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:39523 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbYD3CBh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 22:01:37 -0400
Content-Disposition: inline
In-Reply-To: <200804131534.52548.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Oliver Neukum <oliver@neukum.org>, Nigel Cunningham <ncunningham@crca.org.au>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>

On Sun, Apr 13, 2008 at 03:34:51PM +0200, Rafael J. Wysocki wrote:
> 
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Implement new suspend and hibernation callbacks for the PCI bus type.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

Changes in Linus's tree broke merging this one really badly, so much so
that I can't see what should be done with a quick scan.

I'll drop this from my tree for now, can you regenerate it?

thanks,

greg k-h
