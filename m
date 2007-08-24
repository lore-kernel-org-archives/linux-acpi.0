From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: don't send netlink events for those that go into input layer
Date: Thu, 23 Aug 2007 22:18:38 -0400
Message-ID: <200708232218.38568.lenb@kernel.org>
References: <1187803471.27227.7.camel@acpi-hp.sh.intel.com> <200708231430.16887.lenb@kernel.org> <20070823212255.GB17191@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50723 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932699AbXHXCSu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 23 Aug 2007 22:18:50 -0400
In-Reply-To: <20070823212255.GB17191@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, astarikovskiy@suse.de

On Thursday 23 August 2007 17:22, Henrique de Moraes Holschuh wrote:
> Hi Len!
> 
> On Thu, 23 Aug 2007, Len Brown wrote:
> 
> > I like it, Rui.
> > 
> > I think that upon this patch, we can start to deprecate acpi_bus_generate_event,
> > as every user of it is now handled by the input layer or netlink.
> > 
> > applied.
> 
> This calls for (good!) changes in thinkpad-acpi and some issues I had with
> exactly the same problem.
> 
> Len, to which tree is that change targeted?  I will have to target some
> thinkpad-acpi changes that depend on it.

Since Rui's patch is an incremental to netlink events,
which are new in 2.6.23, I'm going to request Rui's patch
for inclusion in 2.6.23.  I'm also going to include
"[PATCH] ACPI: Schedule /proc/acpi/event for removal"
with it.

They'll both be in the acpi-test tree upon my next push,
probably tonight.  maybe go to Linus as soon as tomorrow
since delay in the -rc3 timeframe would be folly.

thanks,
-Len

