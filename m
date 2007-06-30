From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC][PATCH -mm 0/9] PM: Update global suspend and hibernation operations framework
Date: Sun, 1 Jul 2007 00:22:22 +0100
Message-ID: <20070630232222.GA8100@flint.arm.linux.org.uk>
References: <200706302257.17556.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:35725 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbXF3XY4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 30 Jun 2007 19:24:56 -0400
Content-Disposition: inline
In-Reply-To: <200706302257.17556.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>, Paul Mackerras <paulus@samba.org>, Nigel Cunningham <nigel@nigel.suspend2.net>

On Sat, Jun 30, 2007 at 10:57:16PM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> This series of patches implements changes that are possible/necessary/desirable
> (IMO) after the introduction of the .set_target() method in 'struct pm_ops'
> (the patch that introduces it is in -mm,
> http://marc.info/?l=linux-mm-commits&m=118306698814722&w=2).

I suggest you have a look in:

 http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/arm:pxa2.diff

since there's some duplication and clashes between your patch set and mine.
I'm intending submitting the pxa2 branch when the next merge window opens.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
