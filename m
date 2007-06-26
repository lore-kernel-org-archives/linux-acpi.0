From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC/RFT][PATCH -mm 1/4] PM: Introduce set_target method in pm_ops
Date: Tue, 26 Jun 2007 10:19:58 -0700
Message-ID: <200706261019.59712.david-b@pacbell.net>
References: <200706242239.05678.rjw@sisk.pl> <1182806886.6644.4.camel@johannes.berg> <200706261141.35071.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:45362 "HELO
	smtp109.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757435AbXFZRT6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Jun 2007 13:19:58 -0400
In-Reply-To: <200706261141.35071.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>, Alan Stern <stern@rowland.harvard.edu>, Pavel Machek <pavel@ucw.cz>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>, Shaohua Li <shaohua.li@intel.com>, Igor Stoppa <igor.stoppa@nokia.com>

On Tuesday 26 June 2007, Rafael J. Wysocki wrote:

> Alternatively, I could write that the argument passed to .enter() etc. is
> guaranteed to be the same as the one passed to .set_target(), but I didn't want
> to say that. :-)

Why not?  So long as enter() takes an argument, that seems
to me exactly what it should guarantee.  Although that 
argument should vanish; any platform that differentiates
what it does based on that parameter can just be required
to provide a set_target() method.

- Dave
