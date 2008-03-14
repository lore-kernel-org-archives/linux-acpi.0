From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC] fix asus_hides_smbus_lpc_ich6() for resume
Date: Fri, 14 Mar 2008 15:34:34 +0100
Message-ID: <200803141534.35028.rjw@sisk.pl>
References: <1205466549.5127.2.camel@sli10-desk.sh.intel.com> <20080314044408.GB17961@suse.de> <20080314122601.GQ613@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55782 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753209AbYCNOff (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 14 Mar 2008 10:35:35 -0400
In-Reply-To: <20080314122601.GQ613@parisc-linux.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <gregkh@suse.de>, Shaohua Li <shaohua.li@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>, Len Brown <lenb@kernel.org>

On Friday, 14 of March 2008, Matthew Wilcox wrote:
> On Thu, Mar 13, 2008 at 09:44:08PM -0700, Greg KH wrote:
> > And why "_later"?  What's wrong with the normal resume time?
> 
> He said:
> > asus_hides_smbus_lpc_ich6() is called with interrupt disabled in resume
> > time, but ioremap_nocache() and iounmap() can't be called with interrupt
> > disabled. Below is my debug fix. If you have better fix, please speak.
> 
> Maybe _resume is run too early and could be run later when interrupts
> are enabled?

That's what Shaohua is trying to achieve, AFAICS.
