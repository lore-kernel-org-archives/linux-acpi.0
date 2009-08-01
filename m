From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: bind workqueues to CPU 0 to avoid SMI corruption
Date: Sat, 1 Aug 2009 13:01:33 +0200
Message-ID: <200908011301.34111.rjw@sisk.pl>
References: <20090729215425.23674.80263.stgit@bob.kio> <1248915599.2670.151.camel@rzhang-dt> <200907311647.39902.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34363 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbZHALA6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 1 Aug 2009 07:00:58 -0400
In-Reply-To: <200907311647.39902.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Saturday 01 August 2009, Bjorn Helgaas wrote:
> On Wednesday 29 July 2009 06:59:59 pm Zhang Rui wrote:
> > On Thu, 2009-07-30 at 05:54 +0800, Bjorn Helgaas wrote:
> > > On some machines, a software-initiated SMI causes corruption unless the
> > > SMI runs on CPU 0.  An SMI can be initiated by any AML, but typically it's
> > > done in GPE-related methods that are run via workqueues, so we can avoid
> > > the known corruption cases by binding the workqueues to CPU 0.
> > > 
> > > References:
> > >     http://bugzilla.kernel.org/show_bug.cgi?id=13751
> > >     https://bugs.launchpad.net/bugs/157171
> > >     https://bugs.launchpad.net/bugs/157691
> > > 
> > > Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > 
> > Acked-by: Zhang Rui <rui.zhang@intel.com>
> 
> In addition to the reports above, I think it's likely this patch
> will fix the problems reported below:
> 
>   http://bugzilla.kernel.org/show_bug.cgi?id=13412
>   http://bugzilla.kernel.org/show_bug.cgi?id=11259
>   http://bugzilla.kernel.org/show_bug.cgi?id=12328
>   http://bugzilla.kernel.org/show_bug.cgi?id=12106
> 
> I think we should consider this patch for 2.6.31.
> 
> (Rafael, 13751 is on your "2.6.29 -> 2.6.30" regression list.
> I actually think it's been around much longer than that, but
> there seem to be many things that affect whether it manifests.)

I've dropped it from the list, thanks.

Best,
Rafael
