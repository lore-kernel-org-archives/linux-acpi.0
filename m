From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and hibernation
 callbacks (rev. 8)
Date: Mon, 14 Apr 2008 10:51:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0804141049370.2236-100000@iolanthe.rowland.org>
References: <200804132147.03579.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:33035 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752148AbYDNOvf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Apr 2008 10:51:35 -0400
In-Reply-To: <200804132147.03579.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: benh@kernel.crashing.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Pavel Machek <pavel@ucw.cz>, Oliver Neukum <oliver@neukum.org>, Nigel Cunningham <ncunningham@crca.org.au>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>

On Sun, 13 Apr 2008, David Brownell wrote:

> I sort of agree.  Looking at it from a whole-system perspective,
> suspending needs to be able to chitchat with userspace ... and I
> don't think that can be done *before* writing to /sys/power/state
> in an acceptably generic/portable way.  (Briefly, applications
> need to have clean stopping points and be able to arrange system
> wakeup.  They may well have more work to do than most drivers.)

Pavel's recent work aside, the only way to initiate a system sleep is 
from userspace.  So it seems natural for all application notifications 
to be made by the initiating program, perhaps via dbus.

Alan Stern

