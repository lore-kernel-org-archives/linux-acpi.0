From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH] hook acpi d-state to pnp suspend/resume
Date: Mon, 23 Jul 2007 13:43:09 +0800
Message-ID: <1185169389.2508.1.camel@sli10-conroe.sh.intel.com>
References: <1184897000.26022.17.camel@sli10-conroe.sh.intel.com>
	 <200707211238.03089.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52335 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753561AbXGWFsS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jul 2007 01:48:18 -0400
In-Reply-To: <200707211238.03089.david-b@pacbell.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Adam Belay <abelay@novell.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>

On Sat, 2007-07-21 at 12:38 -0700, David Brownell wrote:
> On Thursday 19 July 2007, Shaohua Li wrote:
> > 
> > applied after Rafel's 'PM: Update global suspend and hibernation
> > operations framework' patch set 
> > 
> > Hook acpi d-state to pnp suspend/resume.
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> 
> Looks about right, and I know the "punt to the PNP protocol
> handler" approach will make Dmitry happy (for input devices);
> it's very "hands-off".
> 
> How much has this been tested?  Have you verified that, for
> example, PS/2 keyboards and mice now pay proper attention
> to the driver model wakeup flags?
> 
> Unfortunately I don't have any system available for testing
> this patch.
Not too much. I tested in a laptop. This highly depends on BIOS.

Thanks,
Shaohua
