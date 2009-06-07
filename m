From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC][PATCH 0/2] PM: Rearrange core suspend code
Date: Sun, 7 Jun 2009 16:51:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org>
References: <200906070054.19207.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:42474 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754957AbZFGUvk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Jun 2009 16:51:40 -0400
In-Reply-To: <200906070054.19207.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sun, 7 Jun 2009, Rafael J. Wysocki wrote:

> Hi,
> 
> Here's something I wanted to do quite some time ago.
> 
> kernel/power/main.c becomes more and more difficult to maintain over time,
> since it contains both the suspend to RAM core code and some common PM code
> that is also used for hibernation.  For this reason [1/2] separates the suspend
> to RAM code from main.c and puts it into two new files (the test facility is,
> again, separated from the core code for clarity).
> 
> [2/2] renames kernel/power/disk.c to kernel/power/hibernate.c, because the role
> of this file is analogous to kernel/power/suspend.c (introduced by [1/2]).
> 
> Comments welcome.

Looks like a good idea to me.

Alan Stern

