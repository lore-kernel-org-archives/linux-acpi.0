From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 7 Dec 2009 14:26:43 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912071426100.3560@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912071716080.15701-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:47447 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757744AbZLGW0m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2009 17:26:42 -0500
In-Reply-To: <Pine.LNX.4.44L0.0912071716080.15701-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>



On Mon, 7 Dec 2009, Alan Stern wrote:
> 
> There's no need to suspend the individual devices when the whole system 
> is going down.  They will automatically suspend when the controller 
> stops sending out SOF packets, which occurs when the root hub is 
> suspended.  The USB spec describes this, grandiosely, as a "global 
> suspend".

Ahh, but the sync vs async would then still matter on resume. No?

		Linus
