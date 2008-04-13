From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 08:10:46 +1000
Message-ID: <1208124646.6958.61.camel@pasglop>
References: <200804040111.15255.rjw@sisk.pl>
	 <200804131533.03150.rjw@sisk.pl> <1208120711.6958.52.camel@pasglop>
	 <200804132339.45280.rjw@sisk.pl>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:44905 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392AbYDMWLa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 13 Apr 2008 18:11:30 -0400
In-Reply-To: <200804132339.45280.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Oliver Neukum <oliver@neukum.org>, Nigel Cunningham <ncunningham@crca.org.au>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>


> > I don't see the point... On the contrary, prepare() is the pefect place
> > to implement handshaking with userspace for drivers that need to do so,
> > such as the DRM.
> 
> This _comment_ reflects the current situation, which is that we freeze tasks
> before a suspend.  When it's no longer necessary to do that, I'll be happy to
> change this comment.  For now, however, that's not the case.

Can't we run the freezer after prepare() instead ?

Ben.


