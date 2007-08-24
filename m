From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/2] ACPI: EC: Fall back to DSDT scan if ECDT is broken
Date: Fri, 24 Aug 2007 01:17:37 -0400
Message-ID: <200708240117.37913.lenb@kernel.org>
References: <46CAE65E.3000703@suse.de> <200708232337.57454.lenb@kernel.org> <46CE53A0.60701@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:49525 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752050AbXHXFRq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Aug 2007 01:17:46 -0400
In-Reply-To: <46CE53A0.60701@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thursday 23 August 2007 23:42, Alexey Starikovskiy wrote:
> Len Brown wrote:
> > On Tuesday 21 August 2007 09:22, Alexey Starikovskiy wrote:
> >   
> >> +            printk(KERN_ERR PREFIX "ECDT is broken\n");
> >>     
> >
> > I think this is
> > 1. guaranteed to happen
> >   
> No, it does not happen on machine with correct ECDT, e.g. my TP  is ok.

Let me clarify...
It is guaranteed to happen on _some_ system out in the field
that belongs to somebody who doesn't know what an ECDT is, yes?

> > 2. guaranteed to alarm users and be viewed as a regression.
> >   
> There is a message, that we are trying to get boot EC from just found
> ECDT. If it fails, we tell why.

It tells _you_ why, but the user hasn't a clue.
If it said something like

ACPI: ec: BIOS bug: mumble mumble abc is corrupt, ignoring it

then you'd learn what you want, the the user would
know what they need to know -- that Linux thinks their
BIOS has a bug, but is continuing on.  The user then
can check for a new BIOS if they like, but will
not send their distro mail about the "broken ECDT"
which they think might be related to the
Extra Critical Data Transfer feature that
if broken is surely important and worth reporting...

does this make sense?

thanks,
-Len

> >    They have no clue what an ECDT is, and this warning
> >    doesn't tell them what to do about it, if anything.
> >
> > -Len
> >   
> 
