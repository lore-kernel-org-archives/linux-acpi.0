From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI button: remove hotkey suspend acpi proc event
Date: Fri, 13 Jul 2012 11:12:48 -0300
Message-ID: <20120713141248.GE7877@khazad-dum.debian.net>
References: <1342160002-13427-1-git-send-email-acelan.kao@canonical.com>
 <20120713064801.GA4910@srcf.ucam.org>
 <CAMz9Wg9gJvABAbtZNZSuywq=GgK4KaufB8ph405SmErLpO1y4g@mail.gmail.com>
 <20120713071355.GA5516@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54560 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751838Ab2GMOMw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Jul 2012 10:12:52 -0400
Content-Disposition: inline
In-Reply-To: <20120713071355.GA5516@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: AceLan Kao <acelan.kao@canonical.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Fri, 13 Jul 2012, Matthew Garrett wrote:
> On Fri, Jul 13, 2012 at 03:07:38PM +0800, AceLan Kao wrote:
> > There are many different events to inform the system concurrently,
> > evdev is just one of them.
> > I'm not sure which one trigger the system to suspend while pressing
> > the suspend hotkey, but
> > the following suspends are triggered by acpi proc event.
> 
> I'm fine with killing the procfs interface (it's deprecated anyway, I 
> think?) but I'm a little worried about this only handling one case. Is 
> userspace guaranteed to ignore any further events that were delivered 
> over the input layer.

No.  Some firmware (thinkpads) even used to latch state and refuse to
reissue sleep buttom events for a while...

Is there any reason why we cannot do the same?  Entering S3/S4 is a
really good time to flush the contents of any input device and acpi
[userspace] event queues at first glance...

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
