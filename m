From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 13:23:00 +1000
Message-ID: <1208143380.6958.105.camel@pasglop>
References: <200804040111.15255.rjw@sisk.pl>
	 <200804140231.32245.rjw@sisk.pl> <1208134017.6958.94.camel@pasglop>
	 <200804140309.22057.rjw@sisk.pl>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:49772 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753080AbYDNDYC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Apr 2008 23:24:02 -0400
In-Reply-To: <200804140309.22057.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Oliver Neukum <oliver@neukum.org>, Nigel Cunningham <ncunningham@crca.org.au>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>


> To avoid breaking things (from the functional point of view) unnecessarily.
> 
> In short, I don't really see the difference between moving ->prepare() before
> the freezer and droppig the freezer, which I'm not going to do right now.

I believe the use of prepare for things like request_firmware etc... is
worth the effort of fixing the known breakage of not having the freezer
while preventing insertion of new devices (mostly USB). In fact, it
won't be such a big issue as the core should/will return an error from
attempting to add the device in that case.

Ben.


