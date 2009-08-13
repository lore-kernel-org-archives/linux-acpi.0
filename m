From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Thu, 13 Aug 2009 14:39:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908131435490.8368-100000@iolanthe.rowland.org>
References: <200908132028.53094.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:53839 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752165AbZHMSjU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Aug 2009 14:39:20 -0400
In-Reply-To: <200908132028.53094.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>

On Thu, 13 Aug 2009, Rafael J. Wysocki wrote:

> > If the set of pm_connection objects is reasonably small then the
> > master_hook and slave_hook aren't needed; you can just read through the
> > entire list.  Leaving out parent-child connections, which we already
> > know, would help shrink the set.
> 
> Do you mean a global list for the entire system?  I'm not sure if that wouldn't
> hurt performance (please note that it also affects runtime PM).

It doesn't have to affect runtime PM.  That is, for runtime PM we can 
make the bus subsystems responsible for enforcing the dependencies.

> We could use counters of "suspended slaves" and "active masters" to optimize
> things, but still updating these counters could take time (one has to find all
> devices dependent on given one and update a counter for each of them).

The problem with counters is that devices can be removed in the middle 
of a suspend or resume.  That would mess up the counter values.

Alan Stern

