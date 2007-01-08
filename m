From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [PATCH 3/6] [-mm]: ACPI: duplicate ACPI sleep "alarm" attribute in	sysfs
Date: Mon, 8 Jan 2007 12:39:08 -0800
Message-ID: <200701081239.08687.david-b@pacbell.net>
References: <1168083318.5619.37.camel@localhost.localdomain> <200701071831.18186.david-b@pacbell.net> <20070108101026.GA14485@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:42771 "HELO
	smtp102.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S965304AbXAHUjO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Jan 2007 15:39:14 -0500
In-Reply-To: <20070108101026.GA14485@srcf.ucam.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: lenb@kernel.org, "linux-acpi@vger" <linux-acpi@vger.kernel.org>, linux-pm@lists.osdl.org, Zhang Rui <rui.zhang@intel.com>

> > The FADT also exposes whether the RTC can wake from S4.  You may have
> > noticed that my rtc-cmos patch #3 exported the relevant FADT info
> > to the RTC device using platform_data, but the S4 wake capability flag
> > isn't useful for anything on today's Linux.
> 
> Isn't useful in what way? It'd be helpful for userspace to know that now 
> that we're actually using S4 for swsusp, but I understand that it might 
> not fit into the current API terribly well.

In that current API there's no way to tell anything at all about the
target system state inside a driver's suspend() method.  So if there
were some characteristic of S4 (or S3 etc) that mattered to the driver
(it should test for the attribute, not S4/etc since S4 is ACPI-specific)
the driver couldn't do anything about it ... so as I said, not useful.

- Dave
