From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [Fwd: Re: long-term regression - Parallel Port broken?]
Date: Tue, 27 May 2008 17:11:36 -0600
Message-ID: <200805271711.37254.bjorn.helgaas@hp.com>
References: <1183030080.4249.172.camel@queen.suse.de> <Pine.LNX.4.64.0707292058040.6510@asgard.lang.hm> <200707300808.17934.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:13309 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbYE0XLi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 May 2008 19:11:38 -0400
In-Reply-To: <200707300808.17934.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: david@lang.hm
Cc: trenn@suse.de, linux-acpi <linux-acpi@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>

> On Sunday 29 July 2007 09:59:18 pm david@lang.hm wrote:
> > On Sun, 29 Jul 2007, Bjorn Helgaas wrote:
> > > This seems an awful lot like this bug report:
> > >  http://bugzilla.kernel.org/show_bug.cgi?id=5832
> > >
> > > Can you take a look at 5832, and maybe we can combine your problem
> > > with that one if you agree they look the same?
> > 
> > yes, it definantly looks like the same thing.

Hi David,

I think 2.6.25 + the patch here:
    http://marc.info/?l=linux-acpi&m=121190728701748&w=2

should fix the parallel port problem you saw.  If you have a
chance to confirm or disprove that, I'd appreciate hearing
about it.  I'm trying to get this change in for 2.6.26.

Thanks,
  Bjorn
