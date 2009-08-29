From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/6] PM: Asynchronous resume of devices
Date: Sat, 29 Aug 2009 21:17:05 +0200
Message-ID: <200908292117.06049.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0908282146550.9540-100000@netrider.rowland.org> <200908291449.57667.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47193 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426AbZH2TQb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 29 Aug 2009 15:16:31 -0400
In-Reply-To: <200908291449.57667.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@infradead.org>, Zhang Rui <rui.zhang@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux PCI <linux-pci@vger.kernel.org>

On Saturday 29 August 2009, Rafael J. Wysocki wrote:
> On Saturday 29 August 2009, Alan Stern wrote:
...
> > Strictly speaking, a new thread should be started only when needed.  
> > That is, only when all the existing threads are busy running a 
> > callback.  It shouldn't be too hard to keep track of when that happens.
> 
> The async framework does that for us. :-)

So, when I said "async threads", I should have rather said "async functions",
because one async thread can execute multiple functions scheduled with
async_schedule().

Taking that into consideration, it all works like this.  When there's a new
async device to handle and there are no async threads available, a new thread
is started and it runs the async function that handles the device and
"opportunistically" searches dpm_list (once) for other device that are ready
for handling.  After this function has returned, the thread goes to sleep and
it only exits after being idle for 1 s.  In turn, when there's a new async
device to handle and there are async threads available, on of them gets the
async function to run.

I don't really think we can do much better than this in any other approach.

Thanks,
Rafael
