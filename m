From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH] Make current GPE changes to be consistent with ACPICA
 code base
Date: Wed, 07 Apr 2010 09:45:08 +0800
Message-ID: <1270604708.13547.1.camel@minggr.sh.intel.com>
References: <1270537259.3384.50.camel@minggr.sh.intel.com>
	 <201004062354.33838.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21135 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932237Ab0DGCDi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Apr 2010 22:03:38 -0400
In-Reply-To: <201004062354.33838.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

On Wed, 2010-04-07 at 05:54 +0800, Rafael J. Wysocki wrote:
> On Tuesday 06 April 2010, Lin Ming wrote:
> > Hi, Rafael
> > 
> > Bob has ported the major GPE changes into ACPICA code base.
> > http://git.moblin.org/cgit.cgi/acpica/commit/?id=45f0b38a921f3b2af7574d553a6c2e557d0567ed
> > 
> > But Bob's port and your original patch have some differences, so I made
> > below patch to make linux acpica code consistent with ACPICA code base.
> > 
> > I have build and tested it, would you please help to review?
> > If everything is OK, I'll include it in the next linux acpica update and
> > send it to Len.
> 
> While I'm generally fine with the code, it looks like the $subject patch includes
> the patches I sent earlier (slightly reworked):
> https://patchwork.kernel.org/patch/90471/
> https://patchwork.kernel.org/patch/86237/
> 
> I'll appreciate it if there's a notice in the changelog that the patch is based
> on them.

We ported your code to ACPICA code base.
I'll add the changelog to notice that.

> 
> Also, please add my sign-off to the final submission to indicate that some
> changes in the patch are in fact from me.

Sure.

Thanks,
Lin Ming

