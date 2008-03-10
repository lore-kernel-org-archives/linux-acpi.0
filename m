From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH] PM: Separate suspend and hibernation callbacks
 (highest level) - updated
Date: Mon, 10 Mar 2008 14:54:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803101452580.5082-100000@iolanthe.rowland.org>
References: <200803101758.01826.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56835 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751522AbYCJSyx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Mar 2008 14:54:53 -0400
In-Reply-To: <200803101758.01826.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, David Brownell <david-b@pacbell.net>

On Mon, 10 Mar 2008, Rafael J. Wysocki wrote:

> Okay, I reworked the patch so that ->complete() is not called after a failing
> ->prepare() (even if that returns -EAGAIN).  For this purpose I had to rework
> dpm_suspend() quite heavily (once again).  Hopefully, I didn't break it.

> The updated patch is appended.

It all looks good.  The next step is testing...

Alan Stern

