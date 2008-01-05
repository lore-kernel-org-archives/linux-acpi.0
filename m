From: Michel Lespinasse <walken@zoy.org>
Subject: Re: Asus P1-AH2 won't suspend (regression)
Date: Fri, 4 Jan 2008 23:20:22 -0800
Message-ID: <20080105072022.GA16376@zoy.org>
References: <20080104144238.GA5176@zoy.org> <200801041756.33733.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from server.lespinasse.org ([64.142.28.226]:59754 "EHLO
	server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbYAEHUW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jan 2008 02:20:22 -0500
Content-Disposition: inline
In-Reply-To: <200801041756.33733.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org

On Fri, Jan 04, 2008 at 05:56:33PM +0100, Rafael J. Wysocki wrote:
> Please try the patch series from:
> http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.24-rc6/patches/
> on top of 2.6.24-rc6 (patches 28-34 are relevant in particular) and
> see if that helps.

No luck. The system still does not suspend after applying the patch set.
Still stuck at the same place, "Suspending console(s)"...
