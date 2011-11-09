From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] Re: Regression in 3.1 causes Xen to use wrong idle
 routine
Date: Wed, 9 Nov 2011 12:58:53 -0500
Message-ID: <20111109175853.GA16318@phenom.dumpdata.com>
References: <4EA7DFD1.9060608@canonical.com>
 <20111026133003.GA6654@phenom.dumpdata.com>
 <4EA80CF2.5040309@canonical.com>
 <20111026134843.GA31609@phenom.dumpdata.com>
 <4EA811BB.6010005@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:28515 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab1KIU1q (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Nov 2011 15:27:46 -0500
Content-Disposition: inline
In-Reply-To: <4EA811BB.6010005@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Bader <stefan.bader@canonical.com>
Cc: len.brown@intel.com, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Oct 26, 2011 at 03:57:15PM +0200, Stefan Bader wrote:
> On 26.10.2011 15:48, Konrad Rzeszutek Wilk wrote:
> >>> What about using the cpuidle_disabled() functionality and adhere to that?
> >>> As so:
> >>>
> > .. snip..
> >>
> >> >From reading over it, this should work. Though I would be interested to hear
> >> from the linux-acpi folks. Also to double check that calling pm_idle when
> >> cpuidle.off was specified really is what is intended.
> > 
> > Oh yeah, definitly need the input from linux-acpi folks. And also to be actually
> > tested :-)
> 
> I can volunteer to do the testing. But I am lazy enough to hold back a bit as
> someone may tell us this is completely the wrong way to fix it. :)

So the other option is to use 'idle=halt' on the Linux command line. That should
provide the workaround for the folks reporting this (is there a BZ for it?).

At least until a good solution is hammered out.

