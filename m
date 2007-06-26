From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm 6/8] PM: Rework struct platform_suspend_operations
Date: Tue, 26 Jun 2007 10:52:22 +0200
Message-ID: <20070626085222.GB4594@elf.ucw.cz>
References: <200706242239.05678.rjw@sisk.pl> <200706260039.17530.rjw@sisk.pl> <200706260049.40457.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:53697 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756751AbXFZWZ6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Jun 2007 18:25:58 -0400
Content-Disposition: inline
In-Reply-To: <200706260049.40457.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, David Brownell <david-b@pacbell.net>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Johannes Berg <johannes@sipsolutions.net>, Igor Stoppa <igor.stoppa@nokia.com>

Hi!

> There is no reason why the .prepare() and .finish() methods in 'struct
> platform_suspend_operations' should take any arguments, since architectures
> don't use these methods' argument in any practically meaningful way (ie. either
> the target system sleep state is conveyed to the platform by .set_target(), or
> there is only one suspend state supported and it is indicated to the PM core by
> .valid(), or .prepare() and .finish() aren't defined at all).  There also is
> no reason why .finish() should return any result.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK. (Maybe you should not in changelog that this changes absolutely
no behaviour; it is not immediately obvious).

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
