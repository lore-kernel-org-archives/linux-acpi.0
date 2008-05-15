From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [linux-pm] Suspend, followed by immediate resume
Date: Thu, 15 May 2008 10:04:16 +0800
Message-ID: <1210817056.2929.14.camel@rzhang-crestline.sh.intel.com>
References: <20080501214437.0ae618c5@osprey.hogchain.net>
	 <20080514144253.GB6260@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:49891 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904AbYEOCEO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2008 22:04:14 -0400
In-Reply-To: <20080514144253.GB6260@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Jay Cliburn <jacliburn@bellsouth.net>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>


On Wed, 2008-05-14 at 16:42 +0200, Pavel Machek wrote:
> Hi!
> 
> > I'm trying to get wake-on-lan working on the network driver I maintain
> > (atl1), but I can't get my system to suspend to memory long enough to
> > test it.  Seems that my system suspends and immediately wakes up again
> > without any intervention on my part.  This is with kernel 2.6.25.1, but
> > I've always encountered this phenomenon, going back to 2.6.21 when the
> > driver was merged into mainline.  I've finally resolved to get to the
> > bottom of it, and I'm hoping linux-pm can help.
> > 
> > To suspend, I execute
> > 
> > echo mem > /sys/power/state
> > 
> > and the system actually suspends (as far as I can tell), but within a
> > few seconds it wakes up without any intervention on my part.  I've
> 
> Check /proc/acpi/wakeup?
Please try the patches here:
http://bugzilla.kernel.org/show_bug.cgi?id=10503#c5
http://bugzilla.kernel.org/show_bug.cgi?id=10503#c7

thanks,
rui



