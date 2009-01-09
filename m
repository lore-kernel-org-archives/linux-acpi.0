From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: disable the ACPI backlight control on laptops
	with buggy _BCL methods
Date: Fri, 09 Jan 2009 09:53:45 +0800
Message-ID: <1231466025.20746.107.camel@rzhang-dt>
References: <1231383496.20746.44.camel@rzhang-dt>
	 <20090108033250.GA2550@srcf.ucam.org> <1231396321.20746.79.camel@rzhang-dt>
	 <20090108124342.GA10458@srcf.ucam.org>
	 <1231463618.20746.93.camel@rzhang-dt>
	 <20090109011809.GA23213@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:20524 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbZAIBwj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Jan 2009 20:52:39 -0500
In-Reply-To: <20090109011809.GA23213@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "trenn@suse.de" <trenn@suse.de>

On Fri, 2009-01-09 at 09:18 +0800, Matthew Garrett wrote:
> On Fri, Jan 09, 2009 at 09:13:38AM +0800, Zhang Rui wrote:
> 
> > 
> > _BQC returns 3 when the actual backlight level is 0x50.
> > We only know that the value returned by _BQC is invalid but we never
> > know the value is an index until we see the _AML code.
> 
> If the value returned is less than the smallest value in the _BLC block, 
> then it's an index. This heuristic will never break a standards 
> compliant system, but (to the best of my knowledge) will work with any 
> of these systems that we're currently aware of.
> 
well, this does work, but a little bit ugly...
The ACPI backlight control on boxes with such _BCL/_BCM/_BQC methods
implemented surely doesn't work before.
so IMO disabling it again is not that bad. :)

thanks,
rui

