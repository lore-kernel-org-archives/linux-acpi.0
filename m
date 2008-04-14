From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 09:37:07 +0200
Message-ID: <200804140937.09915.oliver@neukum.org>
References: <200804040111.15255.rjw@sisk.pl> <200804140843.06088.oliver@neukum.org> <1208157816.6958.133.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:54274 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611AbYDNHhl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Apr 2008 03:37:41 -0400
In-Reply-To: <1208157816.6958.133.camel@pasglop>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: benh@kernel.crashing.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@crca.org.au>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>

Am Montag, 14. April 2008 09:23:36 schrieb Benjamin Herrenschmidt:
> 
> On Mon, 2008-04-14 at 08:43 +0200, Oliver Neukum wrote:

> > If you want to request firmware in a PM callback, which makes a
> > certain
> > sense, as we should move to a comprehensive API, if we change the API
> > at all, we need a model with 3 callbacks.
> 
> No. At this pace, we'll find reasons to have 98213674 callbacks and will
> still not be happy.
> 
> Prepare() should be the right place to call request_firmware() and if
> that is a problem because of bugs in some USB things, then those bugs
> should be fixed.

This isn't a bug. USB simply needs to be able to register (and deregister)
children to be fully operative. You cannot expect a subsystem to work
while some core services are not available.

	Regards
		Oliver


