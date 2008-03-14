From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [RFC] fix asus_hides_smbus_lpc_ich6() for resume
Date: Fri, 14 Mar 2008 08:43:01 -0600
Message-ID: <20080314144300.GS613@parisc-linux.org>
References: <1205466549.5127.2.camel@sli10-desk.sh.intel.com> <20080314044408.GB17961@suse.de> <20080314122601.GQ613@parisc-linux.org> <200803141534.35028.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:37442 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639AbYCNOnR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Mar 2008 10:43:17 -0400
Content-Disposition: inline
In-Reply-To: <200803141534.35028.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, Len Brown <lenb@kernel.org>

On Fri, Mar 14, 2008 at 03:34:34PM +0100, Rafael J. Wysocki wrote:
> On Friday, 14 of March 2008, Matthew Wilcox wrote:
> > On Thu, Mar 13, 2008 at 09:44:08PM -0700, Greg KH wrote:
> > > And why "_later"?  What's wrong with the normal resume time?
> > 
> > He said:
> > > asus_hides_smbus_lpc_ich6() is called with interrupt disabled in resume
> > > time, but ioremap_nocache() and iounmap() can't be called with interrupt
> > > disabled. Below is my debug fix. If you have better fix, please speak.
> > 
> > Maybe _resume is run too early and could be run later when interrupts
> > are enabled?
> 
> That's what Shaohua is trying to achieve, AFAICS.

Shaohua is adding an extra class of resume_later fixups and moving this
one to it.  I'm saying that maybe resume fixups should all be run later.

But I haven't looked at the dependencies here.  That may not be possible.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
