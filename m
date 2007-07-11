From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [linux-pm] Re: Hibernate after alarm wakes from STR
Date: Wed, 11 Jul 2007 01:45:50 +0100
Message-ID: <20070711004549.GA30249@srcf.ucam.org>
References: <20070330235759.GC4252@cosmic.amd.com> <200707101245.31449.nigel@nigel.suspend2.net> <200707100951.04193.david-b@pacbell.net> <200707110816.42114.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:40574 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbXGKAqV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jul 2007 20:46:21 -0400
Content-Disposition: inline
In-Reply-To: <200707110816.42114.nigel@nigel.suspend2.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nigel@suspend2.net
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.linux-foundation.org, Marcelo Tosatti <marcelo@kvack.org>, linux-acpi@vger.kernel.org, Richard Hughes <hughsient@gmail.com>, rtc-linux@googlegroups.com

On Wed, Jul 11, 2007 at 08:16:40AM +1000, Nigel Cunningham wrote:
> Yeah, the bit I consider to be ugly is opening the files from within the 
> kernel, but it seemed to be necessary in order to provide the functionality 
> without having to rely on userspace or do some sort of messy work to figure 
> out how to access the lid button and so on.

How are you going to shift into suspend to disk without going via 
userspace? It's quite plausible that people will want different 
configuration at that point (or, realistically, need a different set of 
workarounds...)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
