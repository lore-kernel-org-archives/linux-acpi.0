From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm 2/4] PM: Move definition of struct pm_ops to suspend.h
Date: Mon, 25 Jun 2007 21:33:27 +0200
Message-ID: <20070625193327.GB2008@elf.ucw.cz>
References: <200706242239.05678.rjw@sisk.pl> <200706242241.39283.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48353 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752273AbXFYTdk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Jun 2007 15:33:40 -0400
Content-Disposition: inline
In-Reply-To: <200706242241.39283.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>

On Sun 2007-06-24 22:41:38, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Move the definition of 'struct pm_ops' and related functions from <linux/pm.h>
> to <linux/suspend.h> .
> 
> There are, at least, the following reasons to do that:
> * 'struct pm_ops' is specifically related to suspend and not to the power
>   management in general.
> * As long as 'struct pm_ops' is defined in <linux/pm.h>, any modification of it
>   causes the entire kernel to be recompiled, which is unnecessary and annoying.
> * Some suspend-related features are already defined in <linux/suspend.h>, so it
>   is logical to move the definition of 'struct pm_ops' into there.
> * 'struct hibernation_ops', being the hibernation-related counterpart of
>   'struct pm_ops', is defined in <linux/suspend.h> .
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
