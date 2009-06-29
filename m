From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 0/9 v2] ACPI: remove .start() and .stop() methods
Date: Mon, 29 Jun 2009 14:32:36 -0600
Message-ID: <200906291432.36773.bjorn.helgaas@hp.com>
References: <20090622204016.32761.47464.stgit@bob.kio> <20090625110604.B02E.E1E9C6FF@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:21996 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbZF2UdJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Jun 2009 16:33:09 -0400
In-Reply-To: <20090625110604.B02E.E1E9C6FF@jp.fujitsu.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Wednesday 24 June 2009 8:09:07 pm Yasunori Goto wrote:
> > From: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > 
> > These patches remove several .start() methods (by folding them into
> > .add() methods) and a .stop() method (by folding it into .remove()).
> > There are no remaining .stop() methods, so I also removed it from
> > the driver_ops structure.
> > 
> > This simplifies the ACPI driver structure and will make it easier to
> > support hotplug in the Linux/ACPI core.
> > 
> > They also remove the KOBJ_ONLINE and KOBJ_OFFLINE events generated
> > by the processor driver for CPU hotplug events.  As far as I know,
> > these events are unused.
> > 
> > I don't have a way to test most of these changes, unfortunately, so
> > I'd welcome any feedback or testing reports.
> 
> Hi.
> 
> I could make a time to test this patch set.
> It works well on my box. :-)
> 
> Tested-by: Yasunori Goto <y-goto@jp.fujitsu.com>

Thanks a lot for testing these.  I appreciate it!

Bjorn
