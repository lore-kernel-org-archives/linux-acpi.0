From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 0/3] PM: Asynchronous suspend and resume
Date: Wed, 12 Aug 2009 17:12:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908121702520.23954-100000@iolanthe.rowland.org>
References: <200908122218.13975.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:48506 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750979AbZHLVMJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Aug 2009 17:12:09 -0400
In-Reply-To: <200908122218.13975.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>

On Wed, 12 Aug 2009, Rafael J. Wysocki wrote:

> Hi,
> 
> The following patches introduce a mechanism allowing us to execute device
> drivers' suspend and resume callbacks asynchronously during system sleep
> transitions, such as suspend to RAM.  The idea is explained in the [1/1] patch
> message.
> 
> Comments welcome.

I get the idea.  Not bad.  Have you tried it in a serious way?  For 
example, turning on the async_suspend flag for every device?

In one way it isn't as efficient as it could be.  You fire off a bunch
of async threads and then make many of them wait for parent or child
devices.  They could be doing useful work instead.

It would be interesting to invent a way of representing explicitly the 
non-tree dependencies -- assuming there aren't too many of them!  (I 
can just hear the TI guys hollering about power and timer domains...)

Alan Stern

