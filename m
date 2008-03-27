From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: acpi_ps_execute_method OOPS (Re: some minor issues with 2.6.25-rc6-git7-default)
Date: Thu, 27 Mar 2008 22:08:52 +0100
Message-ID: <200803272208.53274.rjw@sisk.pl>
References: <215112960@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:47231 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752775AbYC0VJE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Mar 2008 17:09:04 -0400
In-Reply-To: <215112960@web.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devzero@web.de
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

On Thursday, 27 of March 2008, devzero@web.de wrote:
> > On Tuesday 25 March 2008, devzero@web.de wrote:
> > ...
> > > this one looks more serious (happened with modprobe -r ac),
> > > because kernel has problems afterwards (cannot load/anload any other module afterwards) 
> > 
> > any idea when this started happening?
> > Any chance you can snag the output from acpidump
> > and attach it to a sighting here?:
> > http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
> > 
> > thanks,
> > -Len
> 
> i searched into this and found that it only happens after modprobe netsc520 ;modprobe -r netsc520.
> so maybe this is no acpi problem at all but corruption (sort of?) introduced by netsc520 module !?

What CPU/chipset is this?

Rafael
