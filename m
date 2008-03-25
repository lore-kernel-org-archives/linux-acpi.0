From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and hibernation
 callbacks (rev. 3)
Date: Tue, 25 Mar 2008 11:12:30 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803251111260.4838-100000@iolanthe.rowland.org>
References: <200803242318.21052.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:37782 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754670AbYCYPMa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Mar 2008 11:12:30 -0400
In-Reply-To: <200803242318.21052.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Mon, 24 Mar 2008, Rafael J. Wysocki wrote:

> The patch below should address all of your comments above.  It also seems to
> work.
> 
> If it looks good to you, please let me know and I'll repost it in a new thread
> along with the platform and PCI patches adapted to it.

I don't see anything else to change.  ACK.

Alan Stern

