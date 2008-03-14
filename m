From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFC] fix asus_hides_smbus_lpc_ich6() for resume
Date: Fri, 14 Mar 2008 10:14:06 -0700
Message-ID: <200803141014.07423.jbarnes@virtuousgeek.org>
References: <1205466549.5127.2.camel@sli10-desk.sh.intel.com> <20080314144300.GS613@parisc-linux.org> <200803141644.26412.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-121.bluehost.com ([67.222.38.21]:43865 "HELO
	outbound-mail-121.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750959AbYCNROW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Mar 2008 13:14:22 -0400
In-Reply-To: <200803141644.26412.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@atrey.karlin.mff.cuni.cz
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Matthew Wilcox <matthew@wil.cx>, Greg KH <gregkh@suse.de>, Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Friday, March 14, 2008 8:44 am Rafael J. Wysocki wrote:
> On Friday, 14 of March 2008, Matthew Wilcox wrote:
> > On Fri, Mar 14, 2008 at 03:34:34PM +0100, Rafael J. Wysocki wrote:
> > > On Friday, 14 of March 2008, Matthew Wilcox wrote:
> > > > On Thu, Mar 13, 2008 at 09:44:08PM -0700, Greg KH wrote:
> > > > > And why "_later"?  What's wrong with the normal resume time?
> > > >
> > > > He said:
> > > > > asus_hides_smbus_lpc_ich6() is called with interrupt disabled in
> > > > > resume time, but ioremap_nocache() and iounmap() can't be called
> > > > > with interrupt disabled. Below is my debug fix. If you have better
> > > > > fix, please speak.
> > > >
> > > > Maybe _resume is run too early and could be run later when interrupts
> > > > are enabled?
> > >
> > > That's what Shaohua is trying to achieve, AFAICS.
> >
> > Shaohua is adding an extra class of resume_later fixups and moving this
> > one to it.  I'm saying that maybe resume fixups should all be run later.
>
> Yes, I thought about that too.
>
> > But I haven't looked at the dependencies here.  That may not be possible.
>
> Well, I'm not sure how to find out (reliably) who uses it.

Seems a little risky, there are quite a few resume fixups (looks like at least 
18 unique routines) but it might be ok as long as someone was willing to 
audit them all for irq enable safety...

Jesse
