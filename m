From: Holger Macht <hmacht@suse.de>
Subject: Re: [patch 2/3] acpi: Add a docked sysfs file to the dock driver.
Date: Thu, 14 Dec 2006 08:16:31 +0100
Message-ID: <20061214071631.GA6575@homac2.gate.uni-erlangen.de>
References: <20061204224037.713257809@localhost.localdomain> <20061204144958.207e58e2.kristen.c.accardi@intel.com> <20061209115957.GA5254@homac2> <20061211120508.2f2704ac.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:56324 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033AbWLNHaH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Dec 2006 02:30:07 -0500
Content-Disposition: inline
In-Reply-To: <20061211120508.2f2704ac.kristen.c.accardi@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Brandon Philips <brandon@ifup.org>

On Mon 11. Dec - 12:05:08, Kristen Carlson Accardi wrote:
> On Sat, 9 Dec 2006 12:59:58 +0100
> Holger Macht <hmacht@suse.de> wrote:
> 
> > Well, I like to have them ;-)
> 
> Ok - how is this?

Looks good to me, thanks!

> Send a uevent to indicate a device change whenever we dock or
> undock, so that userspace may now check the dock status via 
> sysfs.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

Signed-off-by: Holger Macht <hmacht@suse.de>

Regards,
	Holger
