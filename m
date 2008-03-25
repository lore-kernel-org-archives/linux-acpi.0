From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Introduce new top level suspend and hibernation callbacks (rev. 3)
Date: Tue, 25 Mar 2008 21:39:05 +0100
Message-ID: <200803252139.06591.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0803251111260.4838-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34662 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154AbYCYUjL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Mar 2008 16:39:11 -0400
In-Reply-To: <Pine.LNX.4.44L0.0803251111260.4838-100000@iolanthe.rowland.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Tuesday, 25 of March 2008, Alan Stern wrote:
> On Mon, 24 Mar 2008, Rafael J. Wysocki wrote:
> 
> > The patch below should address all of your comments above.  It also seems to
> > work.
> > 
> > If it looks good to you, please let me know and I'll repost it in a new thread
> > along with the platform and PCI patches adapted to it.
> 
> I don't see anything else to change.  ACK.

Thanks.

I'd like to fix the problem with dpm_list_mtx vs the disabling of interrupts
you pointed out in the other message, though.

Rafael
