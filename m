From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH linux-acpi] Correct wakeup set error and append a new column PCI ID
Date: Wed, 2 Jan 2008 17:09:43 +0100
Message-ID: <20080102160943.GA17187@ucw.cz>
References: <1198738022.8950.3.camel@yangyi-dev.bj.intel.com> <1198744900.3640.4.camel@yangyi-dev.bj.intel.com> <1198916553.3806.2.camel@yangyi-dev.bj.intel.com> <20080101232011.GA2545@ucw.cz> <1199239440.3806.18.camel@yangyi-dev.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:33210 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759617AbYABQJw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jan 2008 11:09:52 -0500
Content-Disposition: inline
In-Reply-To: <1199239440.3806.18.camel@yangyi-dev.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yi Yang <yi.y.yang@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org, acpi-bugzilla@lists.sourceforge.net

On Wed 2008-01-02 10:03:59, Yi Yang wrote:
> On Wed, 2008-01-02 at 00:20 +0100, Pavel Machek wrote:
> > Hi!
> > 
> > > /proc/acpi/wakeup is also case-sensitive, case-insensitive is better.
> > 
> > Why?
> A user uses device bus id like 'C093' to enable or disable wakeup of the
> device, for example
> 
> echo "C093" > /proc/acpi/wakeup
> 
> but i think "c093" should also be ok. i.e.

Why do you think so? Unix is generally case-sensitive. I see ascii
text in .../wakeup. Maybe some bios vendor is crazy enough to have
wakeup devices called 'wake', 'Wake', 'wAke', 'waKe', 'wakE'?

> > Maybe this file should be left for compatibility and we should present
> > something reasonable in /sys? Can't you already get PCI ID from sysfs
> > node?
> PCI ID can be gotten from sysfs, but it is a unique identifier for a
> device, a user can get device name from /usr/share/hwdata/pci.ids in any
> dstribution by PCI ID, he/she is unnecessary to use bus number to get
> device name, bus number is platform-specific, but PCI ID is
> platform-independent.

If the same info can be gotten from 'sysfs node' field, new field
should not be added.


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
