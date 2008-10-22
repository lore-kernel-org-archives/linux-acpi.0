From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 3/5] pci wakeup handler
Date: Wed, 22 Oct 2008 14:01:52 +0200
Message-ID: <200810221401.53211.rjw@sisk.pl>
References: <20080911063037.698427944@sli10-desk.sh.intel.com> <200810192150.41305.rjw@sisk.pl> <20081022053444.GC15271@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59146 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751195AbYJVL5K (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Oct 2008 07:57:10 -0400
In-Reply-To: <20081022053444.GC15271@sli10-desk.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>, "david-b@pacbell.net" <david-b@pacbell.net>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>

On Wednesday, 22 of October 2008, Shaohua Li wrote:
> On Mon, Oct 20, 2008 at 03:50:40AM +0800, Rafael J. Wysocki wrote:
> > On Thursday, 11 of September 2008, Shaohua Li wrote:
> > > pci subsystem wakeup handler.
> > 
> > Perhaps add a bit more explanation here - what is introduced, why and why this
> > particular way.
> I'll add a kernel doc in later post.
> 
> > > +static bool pci_handle_one_wakeup_event(struct pci_dev *pdev)
> > > +{
> > 
> > I don't really like that being a boolean function.  I'd make it return 0 on
> > success and error code on failure.
> Oh, in my previous post, somebody like a boolean and then you like an int
> in the mail list. Either is ok to me, but I'd like to have a reason
> instead of a 'like' or 'unlike'.

That was probably me, but in a different context. ;-)

Use 'bool' for functions that are intended as boolean, eg.
'system_entering_hibernation()' will return 'true' if the system is entering
hibernation at the moment and 'false' otherwise, but for functions like
pci_handle_one_wakeup_event() the standard it to return 0 on success, so IMO
we should follow the standard.

HTH
