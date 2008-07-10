From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH -mm 1/8] PM: Add new PM_EVENT codes for runtime power
	transitions
Date: Thu, 10 Jul 2008 13:34:08 +0200
Message-ID: <20080710113408.GA15412@elf.ucw.cz>
References: <200807100152.17755.rjw@sisk.pl> <200807100155.34153.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44403 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201AbYGJPDb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jul 2008 11:03:31 -0400
Content-Disposition: inline
In-Reply-To: <200807100155.34153.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>

On Thu 2008-07-10 01:55:33, Rafael J. Wysocki wrote:
> From: Alan Stern <stern@rowland.harvard.edu>
> Subject: PM: Add new PM_EVENT codes for runtime power transitions
> 
> This patch (as1112) adds some new PM_EVENT_* codes for use by kernel
> subsystems.  They describe runtime power-state transitions of the sort
> already implemented by the USB subsystem.
> 
> Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
