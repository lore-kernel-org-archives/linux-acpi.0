From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [Fwd: Re: long-term regression - Parallel Port broken?]
Date: Fri, 13 Jun 2008 11:45:13 -0600
Message-ID: <200806131145.13774.bjorn.helgaas@hp.com>
References: <1183030080.4249.172.camel@queen.suse.de> <200805271711.37254.bjorn.helgaas@hp.com> <alpine.DEB.1.10.0805280217510.2373@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:40630 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbYFMRpi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Jun 2008 13:45:38 -0400
In-Reply-To: <alpine.DEB.1.10.0805280217510.2373@asgard.lang.hm>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: david@lang.hm
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>

On Wednesday 28 May 2008 03:19:05 am david@lang.hm wrote:
> On Tue, 27 May 2008, Bjorn Helgaas wrote:
> 
> >> On Sunday 29 July 2007 09:59:18 pm david@lang.hm wrote:
> >>> On Sun, 29 Jul 2007, Bjorn Helgaas wrote:
> >>>> This seems an awful lot like this bug report:
> >>>>  http://bugzilla.kernel.org/show_bug.cgi?id=5832
> >>>>
> >>>> Can you take a look at 5832, and maybe we can combine your problem
> >>>> with that one if you agree they look the same?
> >>>
> >>> yes, it definantly looks like the same thing.
> >
> > Hi David,
> >
> > I think 2.6.25 + the patch here:
> >    http://marc.info/?l=linux-acpi&m=121190728701748&w=2
> >
> > should fix the parallel port problem you saw.  If you have a
> > chance to confirm or disprove that, I'd appreciate hearing
> > about it.  I'm trying to get this change in for 2.6.26.
> 
> I'll see what I can do. I've moved twice since running into this and at 
> the moment the printer is hooked to a network dongle, I'll move it to the 
> server and try a couple tests, probably not before thursday though.

This patch is in 2.6.26-rc6, so I'll assume this problem is fixed
unless I hear otherwise.

Bjorn
