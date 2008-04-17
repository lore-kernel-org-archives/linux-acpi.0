From: Tino Keitel <tino.keitel@gmx.de>
Subject: Re: 2.6.25 regression: 60417f5976df breaks Thinkpad suspend
Date: Thu, 17 Apr 2008 13:17:31 +0200
Message-ID: <20080417111731.GB3602@dose.home.local>
References: <20080415115326.9915.qmail@science.horizon.com> <200804161937.25557.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eazy.amigager.de ([213.239.192.238]:44717 "EHLO
	eazy.amigager.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892AbYDQLRd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Apr 2008 07:17:33 -0400
Content-Disposition: inline
In-Reply-To: <200804161937.25557.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: George Spelvin <linux@horizon.com>, len.brown@intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, Apr 16, 2008 at 19:37:24 +0200, Rafael J. Wysocki wrote:

[...]

> This change has been reverted from the current Linus' tree, so please
> check
> if 2.6.25-rc9 (or a later git snapshot) works for you.

I tried suspend to RAM with the final 2.6.25 on a T20 (which should be
very similar) and it worked fine. I'll try to recheck with an affected
rc to verify that it was broken before.

Regards,
Tino
