From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ACPI: Add sysfs interface for acpi device wakeup
Date: Sun, 13 Jan 2008 18:16:11 +0000
Message-ID: <20080113181611.GB4435@ucw.cz>
References: <1198738022.8950.3.camel@yangyi-dev.bj.intel.com> <1199688961.3551.19.camel@yangyi-dev.bj.intel.com> <1199917306.9596.3.camel@yangyi-dev.bj.intel.com> <200801100943.08780.maximlevitsky@gmail.com> <1199923176.3827.13.camel@yangyi-dev.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1172 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750695AbYANOhL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jan 2008 09:37:11 -0500
Content-Disposition: inline
In-Reply-To: <1199923176.3827.13.camel@yangyi-dev.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yi Yang <yi.y.yang@intel.com>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org, acpi-bugzilla@lists.sourceforge.net


> [yangyi@yangyi-dev ~]$ cat /proc/acpi/wakeup 
> Device  S-state   Status   Sysfs node           PCI ID
> SLPB      S4    *enabled   
> P32       S4     disabled  pci:0000:00:1e.0     0x244e
> UAR1      S4     disabled  pnp:00:09            0x0000

This should tell you how bad is placing PCI ID into generic file.

NAK.
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
