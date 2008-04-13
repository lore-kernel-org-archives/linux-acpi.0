From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 09:49:08 +1000
Message-ID: <1208130548.6958.74.camel@pasglop>
References: <Pine.LNX.4.44L0.0804131916420.3060-100000@netrider.rowland.org>
	 <200804140133.23781.rjw@sisk.pl>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:40772 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753091AbYDMXus (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Apr 2008 19:50:48 -0400
In-Reply-To: <200804140133.23781.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Alan Stern <stern@rowland.harvard.edu>, Nigel Cunningham <ncunningham@crca.org.au>, Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Oliver Neukum <oliver@neukum.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>


On Mon, 2008-04-14 at 01:33 +0200, Rafael J. Wysocki wrote:
> 
> Plus in my opinion, while with ->prepare() after the freezer it's
> possible
> to write ->prepare() and ->suspend() that will work just fine when we
> remove
> the freezer, with ->prepare() before the freezer it would be hard to
> do that,
> unless ->prepare() was trivial.

And removing a good half of the usage scenario where prepare is useful..

Ben.


