From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] fix asus_hides_smbus_lpc_ich6() for resume
Date: Fri, 14 Mar 2008 16:44:25 +0100
Message-ID: <200803141644.26412.rjw@sisk.pl>
References: <1205466549.5127.2.camel@sli10-desk.sh.intel.com> <200803141534.35028.rjw@sisk.pl> <20080314144300.GS613@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:56249 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755529AbYCNPpU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Mar 2008 11:45:20 -0400
In-Reply-To: <20080314144300.GS613@parisc-linux.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <gregkh@suse.de>, Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, Len Brown <lenb@kernel.org>

On Friday, 14 of March 2008, Matthew Wilcox wrote:
> On Fri, Mar 14, 2008 at 03:34:34PM +0100, Rafael J. Wysocki wrote:
> > On Friday, 14 of March 2008, Matthew Wilcox wrote:
> > > On Thu, Mar 13, 2008 at 09:44:08PM -0700, Greg KH wrote:
> > > > And why "_later"?  What's wrong with the normal resume time?
> > > 
> > > He said:
> > > > asus_hides_smbus_lpc_ich6() is called with interrupt disabled in resume
> > > > time, but ioremap_nocache() and iounmap() can't be called with interrupt
> > > > disabled. Below is my debug fix. If you have better fix, please speak.
> > > 
> > > Maybe _resume is run too early and could be run later when interrupts
> > > are enabled?
> > 
> > That's what Shaohua is trying to achieve, AFAICS.
> 
> Shaohua is adding an extra class of resume_later fixups and moving this
> one to it.  I'm saying that maybe resume fixups should all be run later.

Yes, I thought about that too.

> But I haven't looked at the dependencies here.  That may not be possible.
 
Well, I'm not sure how to find out (reliably) who uses it.
