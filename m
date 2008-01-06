From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PM: Acquire device locks on suspend
Date: Sun, 6 Jan 2008 17:11:50 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801061710140.19222-100000@netrider.rowland.org>
References: <200801062005.12097.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:2348 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754768AbYAFWLv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Jan 2008 17:11:51 -0500
In-Reply-To: <200801062005.12097.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Sun, 6 Jan 2008, Rafael J. Wysocki wrote:

> On Sunday, 6 of January 2008, Alan Stern wrote:

> Still, shouldn't we fail the removal of the device apart from giving the
> warning?

We can't.  device_del() can't fail -- it returns void.  Besides, how 
can a driver hope to deal with an unregistration failure?

Alan Stern

