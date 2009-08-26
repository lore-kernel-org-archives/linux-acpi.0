From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 0/7] PM: Asynchronous suspend and resume (updated)
Date: Wed, 26 Aug 2009 17:44:20 +0200
Message-ID: <20090826154420.GD1338@ucw.cz>
References: <200908122218.13975.rjw@sisk.pl> <200908170215.21173.rjw@sisk.pl> <1250579793.5351.79.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754004AbZHZVoL@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1250579793.5351.79.camel@rzhang-dt>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Arjan van de Ven <arjan@linux.intel.com>, Greg KH <gregkh@suse.de>
List-Id: linux-acpi@vger.kernel.org



Hi!

> I still think that the child device should inherit its parent's
> async_suspend flag to do the asynchronous resume more efficiently.

I really think this should be opt-in. Even if seemingly simple cases
like usb devices... there's stuff like olpc where you have usb device
and sideband channel....

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
