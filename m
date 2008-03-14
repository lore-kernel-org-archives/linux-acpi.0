From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] fix asus_hides_smbus_lpc_ich6() for resume
Date: Fri, 14 Mar 2008 22:03:33 +0100
Message-ID: <200803142203.33821.rjw@sisk.pl>
References: <1205466549.5127.2.camel@sli10-desk.sh.intel.com> <200803141537.50589.rjw@sisk.pl> <200803141015.51019.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57940 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752914AbYCNVEa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Mar 2008 17:04:30 -0400
In-Reply-To: <200803141015.51019.jbarnes@virtuousgeek.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, Shaohua Li <shaohua.li@intel.com>, Greg KH <gregkh@suse.de>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Friday, 14 of March 2008, Jesse Barnes wrote:
> On Friday, March 14, 2008 7:37 am Rafael J. Wysocki wrote:
> > On Friday, 14 of March 2008, Shaohua Li wrote:
> > > On Thu, 2008-03-13 at 21:44 -0700, Greg KH wrote:
> > > > On Fri, Mar 14, 2008 at 11:49:09AM +0800, Shaohua Li wrote:
> > > > > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > > > > index 9010f54..821ad02 100644
> > > > > --- a/include/linux/pci.h
> > > > > +++ b/include/linux/pci.h
> > > > > @@ -1016,6 +1016,8 @@ enum pci_fixup_pass {
> > > > >  	pci_fixup_final,	/* Final phase of device fixups */
> > > > >  	pci_fixup_enable,	/* pci_enable_device() time */
> > > > >  	pci_fixup_resume,	/* pci_enable_device() time */
> > > > > +	pci_fixup_suspend,
> > > > > +	pci_fixup_resume_later,
> > > >
> > > > Please document when these quirks are run.
> > >
> > > will do if you think the method is correct.
> > >
> > > > And why "_later"?  What's wrong with the normal resume time?
> > >
> > > pci_fixup_resume is called in pci_device_resume_earily(), which is
> > > called with interrupt disable, so I added a new one which is called at
> > > pci_device_resume(), this routine is called with interrupt enabled.
> >
> > Is the pci_fixup_resume thing used at all?  If it is, how can I check who
> > uses it?
> 
> Oh good catch, it looks like it's unused at this point (at least there's no 
> DECLARE_PCI_FIXUP_SUSPEND macro in pci.h), it was probably just put there for 
> completeness.

It seems to be used only in quirks.c .

I'd prefer to rename the existing one to pci_fixup_resume_noirq and define a
new one called pci_fixup_resume to be used by pci_device_resume().

Also, it would be worth checking if all of the existing resume quirks need to
be run with interrupts disabled.

Thanks,
Rafael
