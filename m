From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 08:47:02 +1000
Message-ID: <1208126822.6958.63.camel@pasglop>
References: <200804040111.15255.rjw@sisk.pl>
	 <200804132339.45280.rjw@sisk.pl> <1208124646.6958.61.camel@pasglop>
	 <200804140027.12161.rjw@sisk.pl>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:60225 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752367AbYDMWri (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Apr 2008 18:47:38 -0400
In-Reply-To: <200804140027.12161.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Oliver Neukum <oliver@neukum.org>, Nigel Cunningham <ncunningham@crca.org.au>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>


> Well, I'm not sure and I'm not going to introduce the change right now, after
> the paches have been included in -mm.
> 
> That would require quite some changes in the core code that I'd prefer to
> avoid for now.  We can do something like this in a separate patch series after
> the present one settles down a bit.

I disagree.

Doing it later would introduce yet another major semantic change.

I think we should get it right now. There's no hurry in pushing things
especially if they aren't quite right.

The ability for prepare() callbacks to sync with userland,
request_firmware, etc... is an important feature that's been needed for
some time imho.

Ben.


