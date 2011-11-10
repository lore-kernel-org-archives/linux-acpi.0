From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] Re: Regression in 3.1 causes Xen to use wrong idle
 routine
Date: Thu, 10 Nov 2011 09:55:58 -0500
Message-ID: <20111110145558.GB7540@phenom.dumpdata.com>
References: <4EA7DFD1.9060608@canonical.com>
 <20111026133003.GA6654@phenom.dumpdata.com>
 <4EA80CF2.5040309@canonical.com>
 <20111026134843.GA31609@phenom.dumpdata.com>
 <4EA811BB.6010005@canonical.com>
 <20111109175853.GA16318@phenom.dumpdata.com>
 <4EBB8C42.8080604@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:58593 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933766Ab1KJO4L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Nov 2011 09:56:11 -0500
Content-Disposition: inline
In-Reply-To: <4EBB8C42.8080604@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Bader <stefan.bader@canonical.com>
Cc: len.brown@intel.com, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, Nov 10, 2011 at 09:33:06AM +0100, Stefan Bader wrote:
> On 09.11.2011 18:58, Konrad Rzeszutek Wilk wrote:
> > On Wed, Oct 26, 2011 at 03:57:15PM +0200, Stefan Bader wrote:
> >> On 26.10.2011 15:48, Konrad Rzeszutek Wilk wrote:
> >>>>> What about using the cpuidle_disabled() functionality and adhere to that?
> >>>>> As so:
> >>>>>
> >>> .. snip..
> >>>>
> >>>> >From reading over it, this should work. Though I would be interested to hear
> >>>> from the linux-acpi folks. Also to double check that calling pm_idle when
> >>>> cpuidle.off was specified really is what is intended.
> >>>
> >>> Oh yeah, definitly need the input from linux-acpi folks. And also to be actually
> >>> tested :-)
> >>
> >> I can volunteer to do the testing. But I am lazy enough to hold back a bit as
> >> someone may tell us this is completely the wrong way to fix it. :)
> > 
> > So the other option is to use 'idle=halt' on the Linux command line. That should
> > provide the workaround for the folks reporting this (is there a BZ for it?).
> > 
> Believe upstream bz is still down. Got the issue reported here, though:
> 
> http://bugs.launchpad.net/bugs/881076

Ok, added that to the patch description.
> 
> Hm, as a workaround probably. I guess it could be added when the test images are
> done. Unfortunately, when running your image in the cloud it is kind of hard to
> recover. Even more as you could have tested on an AMD based host.

Sadly my AMD boxes did not explode when I tested Len's patches :-(.
> 
> Wonder whether it would be an option to automatically mask the mwait capability
> off when running in paravirt mode...

We could, but why not strive to do it correctly first.
