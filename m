From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 0/9] PM: Update global suspend and hibernation operations framework
Date: Wed, 11 Jul 2007 12:53:34 +0200
Message-ID: <20070711105334.GH7091@elf.ucw.cz>
References: <200706302257.17556.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:51290 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755169AbXGKKxe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Jul 2007 06:53:34 -0400
Content-Disposition: inline
In-Reply-To: <200706302257.17556.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>, Paul Mackerras <paulus@samba.org>, Russell King <rmk@arm.linux.org.uk>, Nigel Cunningham <nigel@nigel.suspend2.net>

Hi!


> This series of patches implements changes that are possible/necessary/desirable
> (IMO) after the introduction of the .set_target() method in 'struct pm_ops'
> (the patch that introduces it is in -mm,
> http://marc.info/?l=linux-mm-commits&m=118306698814722&w=2).

(I think this series is already in -mm, right?)

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
