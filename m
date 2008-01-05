From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Asus P1-AH2 won't suspend (regression)
Date: Sat, 5 Jan 2008 19:35:53 +0000
Message-ID: <20080105193552.GB24267@srcf.ucam.org>
References: <20080104144238.GA5176@zoy.org> <200801051926.33641.rjw@sisk.pl> <20080105185946.GA24267@srcf.ucam.org> <200801052030.30862.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:43677 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756364AbYAETgN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Jan 2008 14:36:13 -0500
Content-Disposition: inline
In-Reply-To: <200801052030.30862.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Michel Lespinasse <walken@zoy.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org

On Sat, Jan 05, 2008 at 08:30:30PM +0100, Rafael J. Wysocki wrote:

> Yes, but we have quite a lot of systems working with the current code, so
> I'd like to give them a chance to use the post-1.0 ordering (just in case).

If the vast majority of systems have never been vendor-tested with the 
alternative ordering, then I don't see what it buys us. We've a 
demonstrable case here of it causing a regression.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
