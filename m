From: Yi Yang <yi.y.yang@intel.com>
Subject: Re: [PATCH linux-acpi] Correct wakeup set error and append a new
	column PCI ID
Date: Thu, 03 Jan 2008 10:11:25 +0800
Message-ID: <1199326285.3806.45.camel@yangyi-dev.bj.intel.com>
References: <1198738022.8950.3.camel@yangyi-dev.bj.intel.com>
	 <1198744900.3640.4.camel@yangyi-dev.bj.intel.com>
	 <1198916553.3806.2.camel@yangyi-dev.bj.intel.com>
	 <20080101232011.GA2545@ucw.cz>
	 <1199239440.3806.18.camel@yangyi-dev.bj.intel.com>
	 <20080102160943.GA17187@ucw.cz>
Reply-To: yi.y.yang@intel.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57737 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753943AbYACCOB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 Jan 2008 21:14:01 -0500
In-Reply-To: <20080102160943.GA17187@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org, acpi-bugzilla@lists.sourceforge.net

On Wed, 2008-01-02 at 17:09 +0100, Pavel Machek wrote:
> On Wed 2008-01-02 10:03:59, Yi Yang wrote:
> > On Wed, 2008-01-02 at 00:20 +0100, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > /proc/acpi/wakeup is also case-sensitive, case-insensitive is better.
> > > 
> > > Why?
> > A user uses device bus id like 'C093' to enable or disable wakeup of the
> > device, for example
> > 
> > echo "C093" > /proc/acpi/wakeup
> > 
> > but i think "c093" should also be ok. i.e.
> 
> Why do you think so? Unix is generally case-sensitive. I see ascii
> text in .../wakeup. Maybe some bios vendor is crazy enough to have
> wakeup devices called 'wake', 'Wake', 'wAke', 'waKe', 'wakE'?
Of course, when you cat/proc/acpi/wakeup, you get "wake", but when you
want to enable or disable wakeup of the device "wake", you can

echo "wAke" > /proc/acpi/wakeup

or

echo "wake" > /proc/acpi/wakeup

Don't you think it is reasonable? This is just for user's convenience.

> 
> > > Maybe this file should be left for compatibility and we should present
> > > something reasonable in /sys? Can't you already get PCI ID from sysfs
> > > node?
> > PCI ID can be gotten from sysfs, but it is a unique identifier for a
> > device, a user can get device name from /usr/share/hwdata/pci.ids in any
> > dstribution by PCI ID, he/she is unnecessary to use bus number to get
> > device name, bus number is platform-specific, but PCI ID is
> > platform-independent.
> 
> If the same info can be gotten from 'sysfs node' field, new field
> should not be added.
> 
> 

