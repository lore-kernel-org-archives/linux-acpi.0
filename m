From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI: disable the ACPI backlight control on laptops with buggy _BCL methods
Date: Fri, 9 Jan 2009 01:55:17 +0000
Message-ID: <20090109015517.GA23621@srcf.ucam.org>
References: <1231383496.20746.44.camel@rzhang-dt> <20090108033250.GA2550@srcf.ucam.org> <1231396321.20746.79.camel@rzhang-dt> <20090108124342.GA10458@srcf.ucam.org> <1231463618.20746.93.camel@rzhang-dt> <20090109011809.GA23213@srcf.ucam.org> <1231466025.20746.107.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:47820 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbZAIBzY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Jan 2009 20:55:24 -0500
Content-Disposition: inline
In-Reply-To: <1231466025.20746.107.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "trenn@suse.de" <trenn@suse.de>

On Fri, Jan 09, 2009 at 09:53:45AM +0800, Zhang Rui wrote:

> > If the value returned is less than the smallest value in the _BLC block, 
> > then it's an index. This heuristic will never break a standards 
> > compliant system, but (to the best of my knowledge) will work with any 
> > of these systems that we're currently aware of.
> > 
> well, this does work, but a little bit ugly...
> The ACPI backlight control on boxes with such _BCL/_BCM/_BQC methods
> implemented surely doesn't work before.
> so IMO disabling it again is not that bad. :)

We don't know how widespread this behaviour is. If Vista can cope with 
it then we're likely to see machines that depend on it, so just hoping 
that we can always punt it to a platform driver doesn't sound like the 
best plan. If stock Vista is unable to deal with it then that's a 
definite argument in favour of leaving it up to platform drivers.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
