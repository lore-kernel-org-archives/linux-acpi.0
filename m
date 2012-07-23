From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] ACPI button: remove hotkey suspend acpi proc event
Date: Mon, 23 Jul 2012 11:44:52 -0300
Message-ID: <20120723144452.GA3467@khazad-dum.debian.net>
References: <1342160002-13427-1-git-send-email-acelan.kao@canonical.com>
 <20120713064801.GA4910@srcf.ucam.org>
 <CAMz9Wg9gJvABAbtZNZSuywq=GgK4KaufB8ph405SmErLpO1y4g@mail.gmail.com>
 <20120713071355.GA5516@srcf.ucam.org>
 <20120713141248.GE7877@khazad-dum.debian.net>
 <CAMz9Wg-0Fzz8aeEqYpPRmVqDuFSTtOv=k7m6k1O0r7YB88zRuQ@mail.gmail.com>
 <20120723133452.GA21838@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39302 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753294Ab2GWOo4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2012 10:44:56 -0400
Content-Disposition: inline
In-Reply-To: <20120723133452.GA21838@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: AceLan Kao <acelan.kao@canonical.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Mon, 23 Jul 2012, Matthew Garrett wrote:
> On Mon, Jul 16, 2012 at 10:27:57AM +0800, AceLan Kao wrote:
> > So, I didn't get the point why we can just remove the event, we don't rely on it
> > to enter S3 now, and to take into account that it's deprecated since
> > 2007(fb804714),
> > I don't think we should do more workaround for this.
> 
> I've no objection to removing the event, I just want to know why we 
> don't also need a solution in the evdev path. Why is this not a problem 
> there?

Indeed.

And if it is related _directly_ to thinkpad-acpi, please state so.  Because
thinkpad-acpi does have legacy compatibility crap that can issue duplicated
events (same event over different paths: evdev, acpi procfs, acpi netlink)
but it is supposed to never do that unless actively configured to do so.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
