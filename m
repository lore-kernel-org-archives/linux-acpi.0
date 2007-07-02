From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC][PATCH -mm 0/9] PM: Update global suspend and hibernation operations framework
Date: Mon, 2 Jul 2007 15:36:32 +0100
Message-ID: <20070702143632.GC32096@flint.arm.linux.org.uk>
References: <200706302257.17556.rjw@sisk.pl> <200707012128.41742.david-b@pacbell.net> <200707021628.27139.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:42066 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759828AbXGBOkq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Jul 2007 10:40:46 -0400
Content-Disposition: inline
In-Reply-To: <200707021628.27139.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: David Brownell <david-b@pacbell.net>, pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>, Paul Mackerras <paulus@samba.org>, Nigel Cunningham <nigel@nigel.suspend2.net>

On Mon, Jul 02, 2007 at 04:28:25PM +0200, Rafael J. Wysocki wrote:
> BTW, Russell, is there any chance that your patchest will be in -mm before
> it's merged?  My patches will go through -mm anyway ...

If akpm picks up the devel branch from the ARM tree (which I believe he
does) he'll get the PXA stuff with that next time around.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
