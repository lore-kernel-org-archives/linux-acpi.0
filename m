From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 01/10] ACPI: support acpi_device_ops .notify methods
Date: Thu, 2 Apr 2009 09:03:19 -0600
Message-ID: <200904020903.21140.bjorn.helgaas@hp.com>
References: <20090330174646.20905.18465.stgit@bob.kio> <20090330174813.20905.76536.stgit@bob.kio> <200904021556.32810.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:9612 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764105AbZDBPD2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Apr 2009 11:03:28 -0400
In-Reply-To: <200904021556.32810.trenn@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: kamezawa.hiroyu@jp.fujitsu.com, y-goto@jp.fujitsu.com, Len Brown <lenb@kernel.org>, Tony Vroon <tony@linx.net>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Carlos Corbacho <carlos@strangeworlds.co.uk>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Zhao Yakui <yakui.zhao@intel.com>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>, Venki Pallipadi <venkatesh.pallipadi@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg@redhat.com>

On Thursday 02 April 2009 07:56:28 am Thomas Renninger wrote:
> On Monday 30 March 2009 19:48:13 Bjorn Helgaas wrote:
> > This patch adds support for ACPI device driver .notify() methods.  If
> > such a method is present, Linux/ACPI installs a handler for device
> > notifications (but not for system notifications such as Bus Check,
> > Device Check, etc).  When a device notification occurs, Linux/ACPI
> > passes it on to the driver's .notify() method.
> I sent more or less the same some years ago.
> Thanks a lot for finally cleaning this up!

Hi Thomas,

Oh, sorry, I didn't know that, or I would have given you some credit :-)
In fact, if you have a URL, I'll add a pointer to the changelog.  I
always like to leave breadcrumbs to help future research.

> > Several drivers install their own handlers for system Bus Check and
> > Device Check notifications so they can support hot-plug.  This patch
> > doesn't affect that usage.
> Getting rid of these will be the tricky part.
> When I looked at it start/stop already was defined, but nobody used it.
> IMO start/stop is not needed and hotplug capable device drivers can
> handle things themselves in the relevant notify case.

I'd really like to get rid of the bus/device check notification stuff
in the drivers eventually.  IMHO, the core Linux/ACPI code should
field those notifications and just call the driver .add() and .remove()
methods as necessary.

But you're right, it's going to be quite tricky.  I'm looking at getting
rid of .start() right now, because that's a major complication.  The
biggest user looks like acpiphp, and that is going to be a mess to
straighten out.

> I remember these two guys helped me testing on memory hotplug.
> They only had a simulator, but might want to give the latest kernel a try if
> you come to clean up acpi_memhotplug.c:
> kamezawa.hiroyu@jp.fujitsu.com
> Yasunori Goto <y-goto@jp.fujitsu.com>
> 
> AFAIK, we also have memory hotplug capable machines somewhere, tell
> me if I shall test something.

Great, thanks for the pointers.  I have some HP boxes that should
support some of this hotplug if I can dig out the right tools to
kick things off.  It works on HP-UX, so we *ought* to be able to
play with it on Linux, too.

Bjorn
