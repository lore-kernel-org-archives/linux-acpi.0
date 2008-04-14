From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 12:55:22 +0200
Message-ID: <20080414105522.GA4716@ucw.cz>
References: <200804040111.15255.rjw@sisk.pl> <200804132339.45280.rjw@sisk.pl> <1208124646.6958.61.camel@pasglop> <200804140027.12161.rjw@sisk.pl> <1208126822.6958.63.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2987 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751618AbYDNKza (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Apr 2008 06:55:30 -0400
Content-Disposition: inline
In-Reply-To: <1208126822.6958.63.camel@pasglop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Oliver Neukum <oliver@neukum.org>, Nigel Cunningham <ncunningham@crca.org.au>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>

On Mon 2008-04-14 08:47:02, Benjamin Herrenschmidt wrote:
> 
> > Well, I'm not sure and I'm not going to introduce the change right now, after
> > the paches have been included in -mm.
> > 
> > That would require quite some changes in the core code that I'd prefer to
> > avoid for now.  We can do something like this in a separate patch series after
> > the present one settles down a bit.
> 
> I disagree.
> 
> Doing it later would introduce yet another major semantic change.

'allow load_firmware from prepare that was not allowed before' is not 'major'.

If you feel strongly about that, please prepare patch at the top of
Rafael's and we can discuss it.

But it really should be separate patch.
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
