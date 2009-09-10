From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 6/9] PM: Add a switch for disabling/enabling asynchronous suspend/resume
Date: Thu, 10 Sep 2009 22:15:23 +0200
Message-ID: <200909102215.23403.rjw@sisk.pl>
References: <200909100127.11252.rjw@sisk.pl> <200909102056.39903.rjw@sisk.pl> <20090910185901.GB23356@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:40424 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753108AbZIJUO2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Sep 2009 16:14:28 -0400
In-Reply-To: <20090910185901.GB23356@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>

On Thursday 10 September 2009, Pavel Machek wrote:
> On Thu 2009-09-10 20:56:39, Rafael J. Wysocki wrote:
> > On Thursday 10 September 2009, Pavel Machek wrote:
> > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > > 
> > > > Add sysfs attribute kernel/power/pm_async allowing the user space to
> > > > disable and enable async suspend/resume of devices.
> > > 
> > > for bisect reasons, should this go before 5?
> > 
> > It is set to "enabled" by default, so it shouldn't change bisection results.
> 
> Well, 5 enables it, 6 makes it configurable. So if you need async
> disabled for a bisect, hitting commit between 5 and 6 will enable it
> for you...

OK, I'll move the patch before the [4/9].

Thanks,
Rafael
