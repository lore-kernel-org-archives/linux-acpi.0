From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 17:50:38 +1000
Message-ID: <1208159438.6958.147.camel@pasglop>
References: <200804040111.15255.rjw@sisk.pl>
	 <200804140843.06088.oliver@neukum.org> <1208157816.6958.133.camel@pasglop>
	 <200804140937.09915.oliver@neukum.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:45844 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759846AbYDNHvT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Apr 2008 03:51:19 -0400
In-Reply-To: <200804140937.09915.oliver@neukum.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@crca.org.au>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>


On Mon, 2008-04-14 at 09:37 +0200, Oliver Neukum wrote:
> > Prepare() should be the right place to call request_firmware() and if
> > that is a problem because of bugs in some USB things, then those bugs
> > should be fixed.
> 
> This isn't a bug. USB simply needs to be able to register (and deregister)
> children to be fully operative. You cannot expect a subsystem to work
> while some core services are not available.

No, and that's why the subsystem in question needs to nicely defer the
operations that it cannot do immediately to until resume. Nothing new
here.

In the case of USB, there are plenty of ways it could be done, from
blocking in whatever ioctl is causing trouble, to putting to-be-added
objects in a list that gets processed later...

Ben.


