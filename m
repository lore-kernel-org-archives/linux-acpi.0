From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] [-mm] ACPI: use GFP_KERNEL instead of GFP_ATOMIC
Date: Thu, 16 Aug 2007 20:30:06 +0900
Message-ID: <20070816113006.GB30890@inferi.kami.home>
References: <1185922802.3993.4.camel@rzhang-asus.sh.intel.com> <200708152336.39762.lenb@kernel.org> <1187237178.5723.16.camel@rzhang-asus.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi15.ns.itscom.net ([219.110.2.185]:58092 "EHLO
	mtoichi15.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756965AbXHPLai (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Aug 2007 07:30:38 -0400
Content-Disposition: inline
In-Reply-To: <1187237178.5723.16.camel@rzhang-asus.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, rjw@sisk.pl

On Thu, Aug 16, 2007 at 12:06:18PM +0800, Zhang Rui wrote:
> On Thu, 2007-08-16 at 11:36 +0800, Len Brown wrote:
> > On Tuesday 31 July 2007 19:00, Zhang Rui wrote:
> > > Use GFP_KERNEL instead of GFP_ATOMIC.
> > >
> > > GFP_ATOMIC is still needed by the sonypi and sony-laptop driver.
> > 
> > Why?
> > Sony can't events from user-context like everybody else does?
> Mattia has the plan to do this. But it won't be finished recently.

Hopefully I'll be able to get some more spare time in the next week or
two.

-- 
mattia
:wq!
