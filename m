From: Damien Wyart <damien.wyart@free.fr>
Subject: Re: ACPI power off regression in 2.6.23-rc8 (NOT in rc7)
Date: Tue, 25 Sep 2007 14:02:02 +0200
Message-ID: <20070925120202.GA5641@localhost.localdomain>
References: <20070925065109.GA3080@localhost.localdomain> <20070925092755.GA4553@localhost.localdomain> <20070925095855.GA4982@localhost.localdomain> <200709251345.11370.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:1163 "EHLO
	mallaury.nerim.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752092AbXIYMCG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Sep 2007 08:02:06 -0400
Content-Disposition: inline
In-Reply-To: <200709251345.11370.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Torsten Kaiser <just.for.lkml@googlemail.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Frans Pop <elendil@planet.nl>, linux-acpi@vger.kernel.org

> On the box that fails to power off, can you please test -rc8 with these two
> commits reverted:

> commit 5a50fe709d527f31169263e36601dd83446d5744
> ACPI: suspend: consolidate handling of Sx states addendum

> commit f216cc3748a3a22c2b99390fddcdafa0583791a2
> ACPI: suspend: consolidate handling of Sx states.

> and see if it works?

I had done these tests in the first place (see my first mail), so yes,
reverting makes the box power off fine.

Will test this evening the patch you pointed in your next message.

-- 
Damien Wyart
