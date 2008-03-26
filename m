From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/3] PM: Introduce new top level suspend and hibernation callbacks (rev. 4)
Date: Thu, 27 Mar 2008 00:59:13 +0100
Message-ID: <200803270059.14417.rjw@sisk.pl>
References: <200803262353.30566.rjw@sisk.pl> <200803270003.51570.rjw@sisk.pl> <47EADBD0.6040400@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41982 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754626AbYCZX7e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Mar 2008 19:59:34 -0400
In-Reply-To: <47EADBD0.6040400@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg KH <greg@kroah.com>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Oliver Neukum <oliver@neukum.org>

On Thursday, 27 of March 2008, Alexey Starikovskiy wrote:
> Rafael J. Wysocki wrote:
> > This is the 4th revision of the patch.
> > + * struct pm_noirq_ops - device PM callbacks executed with interrupts disabled
> > + *
> > + * The following callbacks included in 'struct pm_noirq_ops' are executed with
> > + * the nonboot CPUs switched off and with interrupts disabled on the only
> > + * functional CPU.  They also are executed with the PM core list of devices
> > + * locked, so they must NOT unregister any devices.
> > + *
> > + * @suspend_noirq: Complete the operations of ->suspend() by carrying out any
> > + *	actions required for suspending the device that need interrupts to be
> > + *	disabled
> IMHO, no need to add _noirq in both struct and struct members.
> pm_noirq->suspend_noirq does not look good...

I added the _noirq part to the names of the callbacks, since otherwise the
second struct looks confusingly similar to the first one.

I also could have put the _noirq callbacks into the first struct, but that
would have been wasteful, since device types and device classes don't
use them.  Also, the majority of bus types won't use them and the vast majority
of drivers won't use them as well.

Thanks,
Rafael
