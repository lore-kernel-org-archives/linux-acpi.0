From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [RFC] fix asus_hides_smbus_lpc_ich6() for resume
Date: Fri, 14 Mar 2008 15:50:45 +0800
Message-ID: <1205481045.16349.1.camel@sli10-desk.sh.intel.com>
References: <1205466549.5127.2.camel@sli10-desk.sh.intel.com>
	 <20080314044408.GB17961@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6247 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753192AbYCNHwI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Mar 2008 03:52:08 -0400
In-Reply-To: <20080314044408.GB17961@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>


On Thu, 2008-03-13 at 21:44 -0700, Greg KH wrote:
> On Fri, Mar 14, 2008 at 11:49:09AM +0800, Shaohua Li wrote:
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 9010f54..821ad02 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1016,6 +1016,8 @@ enum pci_fixup_pass {
> >  	pci_fixup_final,	/* Final phase of device fixups */
> >  	pci_fixup_enable,	/* pci_enable_device() time */
> >  	pci_fixup_resume,	/* pci_enable_device() time */
> > +	pci_fixup_suspend,
> > +	pci_fixup_resume_later,
> 
> Please document when these quirks are run.
will do if you think the method is correct.

> And why "_later"?  What's wrong with the normal resume time?
pci_fixup_resume is called in pci_device_resume_earily(), which is
called with interrupt disable, so I added a new one which is called at
pci_device_resume(), this routine is called with interrupt enabled.

Thanks,
Shaohua

