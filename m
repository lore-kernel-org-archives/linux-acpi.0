From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][PATCH 6/9] PCI ACPI: Introduce acpi_pm_device_sleep_wake
 function
Date: Thu, 26 Jun 2008 16:38:41 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0806261636430.5244-100000@iolanthe.rowland.org>
References: <200806262231.35375.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:52433 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753977AbYFZUin (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Jun 2008 16:38:43 -0400
In-Reply-To: <200806262231.35375.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhao Yakui <yakui.zhao@intel.com>, Zhang Rui <rui.zhang@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>

On Thu, 26 Jun 2008, Rafael J. Wysocki wrote:

> > > Do you think the core should clear PME# status automatically in that case?
> > 
> > Yes.
> 
> Okay, but that will require us to add the clearing of PME# to the PCI
> resume/restore callbacks.  Perfectly doable, but I'd prefer to do that on top
> of the $subject patch.

That's fine.  I wasn't trying to criticize your new patches, just point
out that overall they are moving in the same direction as this other
work that was done last year.

Alan Stern

