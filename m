From: Thomas Renninger <trenn@suse.de>
Subject: Re: fan problem on new mainboard
Date: Thu, 16 Aug 2007 15:08:20 +0200
Message-ID: <1187269700.8780.771.camel@queen.suse.de>
References: <20070809085429.GA22070@semistable.com>
	 <1186653689.6830.37.camel@rzhang-asus.sh.intel.com>
	 <20070811151325.GA17406@semistable.com>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:57704 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758069AbXHPNIY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Aug 2007 09:08:24 -0400
In-Reply-To: <20070811151325.GA17406@semistable.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Lemmen <robertle@semistable.com>
Cc: linux-acpi@vger.kernel.org

On Sat, 2007-08-11 at 17:13 +0200, Robert Lemmen wrote:
> On Thu, Aug 09, 2007 at 06:01:29PM +0800, Zhang Rui wrote:
> > Hi, Robert,
> > Please attach the full _dmesg_ output as well as the acpidump.
> 
> sorry for the delay, the list seems to eat mails with lareg attachemnts,
> therefore you can find the files here:
> 
> http://www.semistable.com/files/dmesg
> http://www.semistable.com/files/acpidump
> 
> (perhaps) interestingly acpidump also said (on stderr):
> Wrong checksum for generic table!
> 
> as a reminder because it took so long: the problem is that i have
> nothing in /proc/acpi/thermal_zone or proc/acpi//fan, and my cpu fan is
> spinning like crazy even though my cpu is ice cold

Your ACPI DSDT table does not show any thermal/fan control code.
So you won't be able to do much through ACPI.
Have you already searched for a BIOS update?
If you still have problems, maybe you find something in the BIOS
configuration...

   Thomas

