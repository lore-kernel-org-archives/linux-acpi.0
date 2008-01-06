From: Michel Lespinasse <walken@zoy.org>
Subject: Re: Asus P1-AH2 won't suspend (regression)
Date: Sat, 5 Jan 2008 21:51:41 -0800
Message-ID: <20080106055141.GA20938@zoy.org>
References: <20080104144238.GA5176@zoy.org> <200801051926.33641.rjw@sisk.pl> <20080105185946.GA24267@srcf.ucam.org> <200801052030.30862.rjw@sisk.pl> <20080105193552.GB24267@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from server.lespinasse.org ([64.142.28.226]:33539 "EHLO
	server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbYAFFvm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Jan 2008 00:51:42 -0500
Content-Disposition: inline
In-Reply-To: <20080105193552.GB24267@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org

On Sat, Jan 05, 2008 at 07:35:53PM +0000, Matthew Garrett wrote:
> On Sat, Jan 05, 2008 at 08:30:30PM +0100, Rafael J. Wysocki wrote:
> 
> > Yes, but we have quite a lot of systems working with the current code, so
> > I'd like to give them a chance to use the post-1.0 ordering (just in case).
> 
> If the vast majority of systems have never been vendor-tested with the 
> alternative ordering, then I don't see what it buys us. We've a 
> demonstrable case here of it causing a regression.

I think having a runtime (or config) option will be great. As to what the
default should be, I don't have a strong opinion but I must caution that
a lot of people have reported issues with suspend/resume on this hardware,
including some that mention running windows, so I'm worried about making
a decision based only on this hardware - it looks like it's not been
tested much on windows either :/

As an example of many other people complaining about suspend I can cite:
http://www.newegg.com/Product/ProductReview.aspx?Item=N82E16856110057

-- 
Michel Lespinasse
