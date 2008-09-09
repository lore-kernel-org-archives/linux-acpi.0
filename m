From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC 1/5] devcore introduce wakeup_event callback
Date: Tue, 9 Sep 2008 10:22:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0809091019190.2486-100000@iolanthe.rowland.org>
References: <200809091345.31785.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:39133 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753239AbYIIOWm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Sep 2008 10:22:42 -0400
In-Reply-To: <200809091345.31785.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, David Brownell <david-b@pacbell.net>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 9 Sep 2008, Rafael J. Wysocki wrote:

> Still, I'm not sure if we need the method at the device core level at all.
> 
> The suspend/resume callbacks are needed at the device core level, because the
> _core_ initiates the operation (suspend, resume etc.), but in this case the
> operation will be initiated in a core-independent way (for example, by an
> interrupt handler in case of the PCI Express native PME).

Not only the wakeup (resume) operation, but also the original suspend 
operation.

> Surely, we'll need such a callback on the PCI core level that may have to
> invoke the device driver to handle wake-up after identifying the device that
> caused the event to happen.

Absolutely.  This could involve calling the normal PCI resume method or 
it could involve a new method.  Presumably it will mirror whatever 
means we choose for implementing runtime suspend (e.g., a pair of new 
methods).

Alan Stern

