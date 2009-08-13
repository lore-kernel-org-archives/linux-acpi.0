From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH V2 0/4] introduce device async actions mechanism
Date: Thu, 13 Aug 2009 10:30:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0908131028370.2940-100000@iolanthe.rowland.org>
References: <200908122318.12145.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:45395 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752338AbZHMOav (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Aug 2009 10:30:51 -0400
In-Reply-To: <200908122318.12145.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, "dtor@mail.ru" <dtor@mail.ru>

On Wed, 12 Aug 2009, Rafael J. Wysocki wrote:

> On a second thought, though, would it be a good idea to add
> pm_runtime_get_noresume() / pm_runtime_put_sync() around the bus_for_each_drv()
> in device_attach()?  That would prevent us from resuming-suspending the device
> on each failing probe.

Good idea.  But don't remove the existing code in driver_probe_device.

Alan Stern

