From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm 3/4] PM: Rename struct pm_ops and related things
Date: Mon, 25 Jun 2007 21:34:54 +0200
Message-ID: <20070625193454.GC2008@elf.ucw.cz>
References: <200706242239.05678.rjw@sisk.pl> <200706242242.47573.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48362 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752566AbXFYTfH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Jun 2007 15:35:07 -0400
Content-Disposition: inline
In-Reply-To: <200706242242.47573.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>

On Sun 2007-06-24 22:42:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> The name of 'struct pm_ops' suggests that it is related to the power management
> in general, but in fact it is only related to suspend.  Moreover, its name
> should indicate what this structure is used for, so it seems reasonable to
> change it to 'struct platform_suspend_operations'.  In that case, the name of
> the global variable of this type used by the PM core and the names of related
> functions should be changed accordingly.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
