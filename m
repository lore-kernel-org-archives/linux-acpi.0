From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2 0/4] introduce device async actions mechanism
Date: Mon, 3 Aug 2009 23:18:33 +0200
Message-ID: <200908032318.35070.rjw@sisk.pl>
References: <1248404514.2670.107.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43696 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751925AbZHCVSV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Aug 2009 17:18:21 -0400
In-Reply-To: <1248404514.2670.107.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Arjan van de Ven <arjan@linux.intel.com>, dtor@mail.ru

On Friday 24 July 2009, Zhang Rui wrote:
> Hi,

Hi,

> this is the patch set I made to speed up the device
> suspend/resume/shutdown process.
> 
> A new mechanism called Device Async Actions is introduced
> in this patch set.

Well, I'm not sure we'll need that.

> The basic idea is that,
> if the suspend/resume/shutdown process of a device group, including
> a root device and its child devices, are independent of other devices,
> we create an async domain for this device group,
> and make them suspend/resume/shutdown asynchronously.    

I don't really think this is the right approach.  IMO, we should rather try to
identify groups of devices for which the PM callbacks (forget about .shutdown()
for now) can be executed in parallel.  One such group is leaf devices, ie.
devices that have no children.  Of course, some of them will depend of the
other indirectly, so we should make it possible to declare (in the driver)
whether the device can be suspended/resumed asynchronously and use the
following logic (at the core level), in pseudo code:

if (has_no_children(dev) && asynchronous_suspend_resume_allowed(dev))
    async_resume(dev);
else
    resume(dev);

and analogously for suspend.  Then, we can easily use one async domain for all
of these devices.

Later, we can add async domains for devices that have children, but can be
suspended and woken up in parallel with each other.  IOW, I think the async
domains should span the levels rather than branches of the device tree.

Thanks,
Rafael
